Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32512CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:41:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AEA85CD76;
	Sun, 19 Dec 2021 18:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639935662; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EXNDih5UF5NRNhA+SKOvsWRoayjdkaz/SqFJghAYHHA=;
	b=zN2e3ewVnj0bLhhJn1p/GW3T00yOy/CGvZehlyk71leQimXwHVzpOPf6DJMAiIyo2fiEbX
	hbmM1U4a68MK/6bcIG3fs1SACUQvDonYcMEROZVaRyD6MLjxtqa0LFVtYbr9Rat9Vftaur
	lCMUiFBK61D/GVv6gOi91MNcOmG3QxId3aDLA4+mWzsyBmQHLn2B8MsmhoI/ouY9Umzwnc
	oTuO9Ftw4g8KTCR6NwA4JhowRlDHbq0wGNhgWOlYu8do5ga1cVD2O7szdHvWixihzXy/0s
	ZcDuEZwqzpI0t2WEHb5u+F8s6k8NuLYc6zzayFqsNwjOohCujchTX+YABpf/lQ==
Date: Sun, 19 Dec 2021 18:40:59 +0100
From: Daniel Wagner <wagi@monom.org>
To: Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
Cc: connman@lists.linux.dev,
	Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: Re: [PATCH] service: Fix native connection with wrong passphrase
Message-ID: <20211219174059.c62hjgjym6frrnln@beryllium.lan>
References: <20211216102249.502964-1-Emmanuel.VAUTRIN@cpexterne.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216102249.502964-1-Emmanuel.VAUTRIN@cpexterne.org>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Thu, Dec 16, 2021 at 11:22:49AM +0100, Emmanuel VAUTRIN wrote:
> When a native connection fails with a wrong passphrase, the user still
> needs to be informed, via the agent.
> However, in this case, the associated service is automatically
> disconnected, canceling the pending agent requests.
> The invalid key error shall be reported before this cancellation.
> 
> Commit b9a0a039ccc5 ("service: Report errors to user in native mode")
> ---
>  src/service.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/src/service.c b/src/service.c
> index 9141b85dbe9c..202816ae8980 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -6023,6 +6023,11 @@ static int service_indicate_state(struct connman_service *service)
>  		break;
>  
>  	case CONNMAN_SERVICE_STATE_IDLE:
> +		if (old_state == CONNMAN_SERVICE_STATE_FAILURE && 
> +	service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_NATIVE &&
> +	service->error == CONNMAN_SERVICE_ERROR_INVALID_KEY)
> +		report_error_cb(service, false, NULL);

There is whitespace damaged and a pretty idention. I was about to fix
this, but stopped because the 'report_error_cb()' doesn't make sense
with the commit message. If you want to properly report you need

			connman_agent_report_error(service, service->path,
						error2string(service->error),
						report_error_cb,
						get_dbus_sender(service),
						NULL);

IMO. report_error_cb() doesn't do any agent stuff.

Daniel
