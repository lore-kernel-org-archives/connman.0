Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C7818C15
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d29b7.dip0.t-ipconnect.de [91.61.41.183])
	by mail.holtmann.org (Postfix) with ESMTPSA id C8C5CCECC3;
	Fri, 15 Dec 2023 09:52:45 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 0/2] service: Both Cancel and Stop Online Checks where
 Appropriate
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231215021653.2156275-1-gerickson@nuovations.com>
Date: Fri, 15 Dec 2023 09:52:35 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <ABF35AE4-777D-4A9D-9618-0587B567DDE8@holtmann.org>
References: <20231215021653.2156275-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This both cancels, via 'cancel_online_check', and stops, via
> '__connman_wispr_stop' online checks on service disconnect or
> free. The former terminates any in-flight or recurring check activity
> in "service.c" and the latter terminates the same in "wispr.c".
> 
> Failure to cancel as well as stop can lead to a use-after-free fault
> in one-shot or continuous online check mode when a latent online check
> reschedule timer fires after the service has been disconnected or
> deallocated.
> 
> To support these cancelations with a single 'cancel_online_check'
> function call, support is added for passing
> 'CONNMAN_IPCONFIG_TYPE_ALL' to 'cancel_online_check' as the IP
> configuration type parameter.
> 
> Grant Erickson (2):
>  service: Add support for 'CONNMAN_IPCONFIG_TYPE_ALL' to
>    'cancel_online_check'.
>  service: Both cancel and stop online checks where appropriate.
> 
> src/service.c | 43 +++++++++++++++++++++++++++++++++----------
> 1 file changed, 33 insertions(+), 10 deletions(-)

both patches have been applied.

Regards

Marcel

