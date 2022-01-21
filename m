Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF592CA7
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 07:46:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C8195CF5E;
	Fri, 21 Jan 2022 08:46:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642751180; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EgYiFKCEA5gTuVPLbDhIcZ2JpzYbz4YDAzoDUCgm5x4=;
	b=MtAlQ23CCACoMdqYWHdfm/sHowiD4CcDyyNR72389HmBOlc4Y/Uviv8Qqe7xbXdUd967tJ
	UhKMwL4RjSDePZlYQEhEuN4JoO7J876+7FXKIcXRFjoj2Hv2+UF01adVZHiMin9M/aIje2
	zkjcYIjO/QKOZEfzmhKlY/ccsCErTsawRLDc1mcT+N65NO2idGxx8P6zpz8jyQbCJ/X/bJ
	9XqzANCz/7nXyiot1dw2doqvgCOLtmk5/S7tHUbl7ymQP1XUfbTyprwJIf3zxe+D3xwj/t
	yiXFJ/jtPbg7AZzbUrHvTwphPGlC6gtWVZSaoFKPUCFtu4wdSsMowE1GFc0eTQ==
Date: Fri, 21 Jan 2022 08:46:18 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH v2] service: Fix native connection with wrong passphrase
Message-ID: <20220121074618.i4cdc7g5do3r3w56@beryllium.lan>
References: <20220118130957.1205100-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB1544390370DD2A30AB8F3F8993589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB1544390370DD2A30AB8F3F8993589@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanual,

On Tue, Jan 18, 2022 at 01:13:36PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> When a native connection fails with a wrong passphrase, the user still
> needs to be informed, via the agent.
> However, in this case, the associated service is automatically
> disconnected, canceling the pending agent requests.
> The invalid key error shall be reported before this cancellation.
> 
> Commit b9a0a039ccc5 ("service: Report errors to user in native mode")
> ---
>  src/service.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/src/service.c b/src/service.c
> index 9141b85dbe9c..e6da814afe49 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -6023,6 +6023,15 @@ static int service_indicate_state(struct connman_service *service)
>                  break;
>  
>          case CONNMAN_SERVICE_STATE_IDLE:
> +               if ((old_state == CONNMAN_SERVICE_STATE_FAILURE &&
> +       service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_NATIVE &&
> +       service->error == CONNMAN_SERVICE_ERROR_INVALID_KEY)) {
> +                       __connman_service_clear_error(service);
> +                       service_complete(service);
> +                       service_list_sort();
> +                       __connman_connection_update_gateway();
> +               }

service_list_sort() and __connman_connection_update_gateway() are
already called after the switch. This seems to be redundant.

Daniel
