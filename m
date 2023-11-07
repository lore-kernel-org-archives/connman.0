Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3623158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id DBF80CECEE;
	Tue,  7 Nov 2023 20:10:32 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH v2] Close three '__connman_wisp_start' failure closure
 holes.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5B470B03-18A6-494A-B6F6-B2CE614A1A7E@nuovations.com>
Date: Tue, 7 Nov 2023 20:10:27 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <F49C9B00-7F11-41EE-9E32-8BB626ACBFD8@holtmann.org>
References: <6669EDB7-4146-4974-8354-27A259DDF2CB@nuovations.com>
 <5B470B03-18A6-494A-B6F6-B2CE614A1A7E@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

There are currently three failure holes in which a request to
> '__connman_wispr_start' is not properly closed.
> 
>  1. If 'g_web_request_get' fails to generate a successful gweb request
>     and returns a request identifier of zero (0) in
>     'wispr_portal_request_portal'.
> 
>  2. If the service proxy is set to CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN.
>     This can happen in 'proxy_callback' if WISPr is started and the
>     service proxy method is set latently or is never set at all.
> 
>  3. If 'wispr_portal_detect' returns non-zero error status in
>     '__connman_wispr_start'.
> ---
> src/wispr.c | 19 +++++++++++++++++--
> 1 file changed, 17 insertions(+), 2 deletions(-)

patch has been applied.

Regards

Marcel

