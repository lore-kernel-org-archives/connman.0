Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC62D264
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id 43074CECD8;
	Sat, 23 Dec 2023 13:22:52 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v3 00/60] Complete 'continuous' Online Check Mode
 Implementation.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
Date: Sat, 23 Dec 2023 13:22:42 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <81F7E5E9-9028-46FD-9967-A3B755271079@holtmann.org>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This completes the implementation of 'EnableOnlineToReadyTransition'
> begun by Emmanuel Vautrin with commit f0bd0e8fe578 ("service: Add
> online to ready transition feature").
>=20
> When asserted along with 'EnableOnlineCheck',
> 'EnableOnlineToReadyTransition' effects what can be thought of as a
> "continuous" online check mode, which is different from the "one-shot"
> online check mode when 'EnableOnlineToReadyTransition' is not asserted
> but 'EnableOnlineCheck' is. Effectively, these two Booleans encode
> three online check modes:
>=20
>    1. None (!EnableOnlineCheck)
>    2. One-shot (EnableOnlineCheck && !EnableOnlineToReadyTransition)
>    3. Continuous (EnableOnlineCheck && EnableOnlineToReadyTransition)
>=20
> With this change, these three modes are formalized and introduced as a
> new 'OnlineCheckMode' configuration setting which is intended to
> eventually deprecate 'EnableOnlineCheck' (long-term) and
> 'EnableOnlineToReadyTransition' (short-term, as it never made it
> beyond the EXPERIMENTAL designation).
>=20
> In "none" mode, as has been the case historically, there are no
> "online" HTTP-based Internet reachability checks. Any connected
> service and the manager state will terminate at the "ready" state and
> will not progress to "online".
>=20
> In "one-shot" mode, as has been the case historically, there is a
> single, one-shot "online" HTTP-based Internet reachability check for
> the default service. When the check succeeds, the associated service
> and the manager state will terminate at the "online" state. When the
> check fails, subsequent checks will be rescheduled according to
> "OnlineCheckIntervalStyle", "OnlineCheckInitialInterval", and
> "OnlineCheckMaxInterval" and will continue indefinitely until one
> succeeds or until the service is disconnected.
>=20
> In "continuous" mode, which is finalized with this change, there are
> ongoing "online" HTTP-based Internet reachability check for the
> default service. As with "one-shot" mode, when the first check
> succeeds, the associated service and the manager state will terminate
> at the "online" state. Thereafter, subsequent checks will be scheduled
> according to "OnlineCheckIntervalStyle" and
> "OnlineCheckMaxInterval". When the check fails, subsequent checks will
> be rescheduled according to "OnlineCheckIntervalStyle",
> "OnlineCheckInitialInterval", and "OnlineCheckMaxInterval". This is
> largely unchanged. However, what is new with this change is that when
> and if "OnlineCheckFailuresThreshold" is met, the service and manager
> state will be demoted to "ready" and the service will have its "Error"
> property set to "online-check-failed" while subsequent checks will
> continue. In the interim, if available, another service may be
> promoted to the default service and online checks will be initiated
> for it. When and if, for the demoted service,
> "OnlineCheckSuccessesThreshold" is met, the service "Error" property
> will be cleared and the service state promoted to "online",
> potentially causing it to become the default service again.
>=20
> Grant Erickson (60):
>  service: Change return type of '__connman_service_wispr_start'.
>  service: Sanity check the 'type' param in
>    '__connman_service_wispr_start'.
>  service: Rename 'online_check_enabled_check'.
>  service: Change return type of 'start_online_check'.
>  service: Change return type of 'start_wispr_if_connected'.
>  service: Introduce and use online check 'active' state.
>  service: Document 'online_check_state' 'active' member.
>  service: Document 'online_check_is_active'.
>  service: Document 'online_check_active_set_value'.
>  service: Document 'online_check_active_{clear,set}'.
>  service: Rename 'start_wispr_if_connected'.
>  service: Refactor 'start_online_check_if_connected'.
>  service: Document 'start_online_check_if_connected_with_type'.
>  service: Add an explicit conditional for IPv6 in
>    'reschedule_online_check'.
>  session: Add service identifier to 'DBG' in four functions.
>  service: Add online check failure service error enumeration and
>    string.
>  doc/service: Document online check failure service error.
>  service: Introduce and use online check 'failures/successes' state.
>  service: Document 'online_check_state' 'failures/successes' members.
>  main: Introduce the 'OnlineCheck{Failures,Successes}Threshold'
>    settings.
>  doc: Document the 'OnlineCheck{Failures,Successes}Threshold' =
settings.
>  service: Add per-service online check failure threshold state.
>  service: Document 'connman_service'
>    'online_check_failures_met_threshold' member.
>  service: Document 'connman_service' 'online_check_state_ipv{4,6}'
>    members.
>  service: Move 'set_error' forward declaration earlier in the source.
>  service: Capture IP configuration state by value rather than by
>    pointer.
>  service: Complete 'continuous' online check mode implementation.
>  service: Document 'online_check_failures_threshold_was_met'.
>  service: Document =
'online_check_failures_threshold_was_met_set_value'.
>  service: Document
>    'online_check_failures_threshold_was_met_{set,clear}'.
>  service: Document 'online_check_counter_reset'.
>  service: Document 'online_check_{failures,successes}_reset'.
>  service: Document 'online_check_state_reset'.
>  service: Document 'online_check_counters_log'.
>  service: Document 'online_check_counter_threshold_is_met'.
>  service: Document 'is_online_check_failure_threshold_met_predicate'.
>  service: Document 'online_check_failures_threshold_is_met'.
>  service: Document 'is_online_check_success_threshold_met_predicate'.
>  service: Document 'online_check_successes_threshold_is_met'.
>  service: Document 'online_check_counter_increment_and_log'.
>  service: Document 'online_check_log_success'.
>  service: Document
>    =
'continuous_online_check_log_{counter,failures,successes}_threshold_met'.
>  service: Document 'handle_{continuous,oneshot}_online_check_success'.
>  service: Document 'online_check_log_failure'.
>  service: Document 'handle_{continuous,oneshot}_online_check_failure'.
>  service: Add @sa documentation references.
>  service: Document the internals of 'service_compare'.
>  service: Document interval assignment in
>    '__connman_service_wispr_start'.
>  service: Document 'downgrade_connected_services'.
>  service: Document 'service_schedule_changed'.
>  service: Document 'service_route_changed'.
>  service: Add function parameter to 'default_changed' and
>    'service_list_sort'.
>  service: Add @sa documentation reference to 'current_default'.
>  service: Add 'DBG' to 'downgrade_connected_services'.
>  main/service: Introduce 'OnlineCheckMode' setting.
>  service: Leverage 'OnlineCheckMode' setting.
>  doc: Document the 'OnlineCheckMode' setting.
>  main: Add comments tags for online check-related settings.
>  main: Consolidate logging of online check-related settings.
>  main: Add deprecation warnings for 'EnableOnlineCheck' and
>    'EnableOnlineToReadyTransition'.
>=20
> README                |   91 +-
> doc/connman.conf.5.in |   85 +-
> doc/service-api.txt   |    3 +-
> include/service.h     |   26 +-
> src/connman.h         |   18 +-
> src/main.c            |  177 +++-
> src/main.conf         |  122 ++-
> src/service.c         | 2133 ++++++++++++++++++++++++++++++++++++-----
> 8 files changed, 2356 insertions(+), 299 deletions(-)

all SIXTY (60 ;) patches have been applied.

Regards

Marcel

