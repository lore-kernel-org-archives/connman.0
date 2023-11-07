Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B12D02E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 10C48CECEE;
	Tue,  7 Nov 2023 19:49:51 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v3] Introduce the 'OnlineCheckIntervalStyle' setting.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5A79151A-070B-46B9-961C-702935C21900@nuovations.com>
Date: Tue, 7 Nov 2023 19:49:40 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <EDF55E74-FC9B-4973-A12F-63A9BE05D825@holtmann.org>
References: <B2ACEFEE-39AE-4828-BD03-170E9993749A@nuovations.com>
 <5A79151A-070B-46B9-961C-702935C21900@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This introduces the 'OnlineCheckIntervalStyle' setting which is the
> style or mathematical series function used to compute the actual
> time, in seconds, between two "ready" to "online" HTTP-based Internet
> reachability checks. The value of which may be either "geometric" or
> "fibonacci" with a default value of "geometric".
> 
> The "geometric" style (which is a formalization of the existing,
> default series calculation) or function simply takes the square of the
> online check interval. For example, at a check interval of 6, the
> time, in seconds, is 36 (6^2) seconds.
> 
> The "fibonacci" style or function takes the value of the Fibonacci
> sequence at the online check interval. For example, at a check interval
> of 6, the time, in seconds, is 8 seconds.
> 
> The "fibonacci" series and style is more aggressive in check rate up to 12
> steps (its equivalence point with "geometric" at 144 seconds) than
> "geometric" but backs off far more aggressively past that point reaching
> an hour at interval 19 which "geometric" does not reach until interval
> 60.
> 
> As the "EnableOnlineToReadyTransition" is refined and further developed,
> the "fibonacci" style will allow for faster service failover and recovery
> times for transient failures while backing off more aggressively for longer
> duration outages where metered services like Cellular may be more sensitive
> to a less aggresive backoff like "geometric".
> ---
> README                |  18 +++++--
> doc/connman.conf.5.in |  21 ++++++++
> src/main.c            |  33 ++++++++++++
> src/main.conf         |  21 ++++++++
> src/service.c         | 115 ++++++++++++++++++++++++++++++++++++++----
> 5 files changed, 195 insertions(+), 13 deletions(-)

patch has been applied.

Regards

Marcel

