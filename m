Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7AF30D1E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id BDF83CECEB;
	Tue,  7 Nov 2023 17:03:22 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Introduce the 'OnlineCheckIntervalStyle' setting.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CE90C22D-1AE5-4CE7-A1F0-4E854997064A@nuovations.com>
Date: Tue, 7 Nov 2023 17:03:12 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBF1FB82-3A05-4ABC-BAF1-99FF508EAFE4@holtmann.org>
References: <B2ACEFEE-39AE-4828-BD03-170E9993749A@nuovations.com>
 <CE90C22D-1AE5-4CE7-A1F0-4E854997064A@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This introduces the 'OnlineCheckIntervalStyle' setting which is the
> style or mathematical series function used to compute the actual
> time, in seconds, between two "ready" to "online" HTTP-based Internet
> reachability checks. The value of which may be either "geometric" or
> "fibonacci" with a default value of "geometric".
>=20
> The "geometric" style (which is a formalization of the existing,
> default series calculation) or function simply takes the square of the
> online check interval. For example, at a check interval of 6, the
> time, in seconds, is 36 (6^2) seconds.
>=20
> The "fibonacci" style or function takes the value of the Fibonacci
> sequence at the online check interval. For example, at a check =
interval
> of 6, the time, in seconds, is 8 seconds.
>=20
> The "fibonacci" series and style is more aggressive in check rate up =
to 12
> steps (its equivalence point with "geometric" at 144 seconds) than
> "geometric" but backs off far more aggresively past that point =
reaching
> an hour at interval 19 which "geometric" does not reach until interval
> 60.
>=20
> As the "EnableOnlineToReadyTransition" is refined and further =
developed,
> the "fibonacci" style will allow for faster service failover and =
recovery
> times for transient failures while backing off more aggressively for =
longer
> duration outages where metered services like Cellular may be more =
sensitive
> to a less aggresive backoff like "geometric".
> ---
> README                |  18 +++++--
> doc/connman.conf.5.in |  21 ++++++++
> src/main.c            |  35 +++++++++++++
> src/main.conf         |  21 ++++++++
> src/service.c         | 116 ++++++++++++++++++++++++++++++++++++++----
> 5 files changed, 198 insertions(+), 13 deletions(-)

this patch sadly doesn=E2=80=99t apply. Also it might be good to split =
documentation update from code update.

Regards

Marcel

