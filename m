Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BCF72
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 17:54:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C392C5E30B;
	Sun, 29 Aug 2021 19:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630259654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c9LVCbDWWkDxD/mvdteWXuWnsdHBr7IRp/na0guMu5I=;
	b=ck1/P2TsROeHuLgVFkENZRJD45vJCAIe04tz2mN3d0GlNKMgq47tUNGnpEdTZ6JMihjs86
	7zY3lkWLeWQGTpwnyKLsJ9i8zqcq/DUi49RwmGd65HKHy5W0g9eaEJKEOU1R1b4ccIQKL2
	8L8bQD5URh9bZ+/QBzO3QQihkvcXf8UOR6a4MvJA01WQYqgBDeiCa9zVdbxUe5NvRrH2Ie
	MDq6g35PkPDVSbmOsiEpuW5aTgslmrM0XS50Hrk0dK5wI+1++EUQq2l11QiFrWE+txo/6r
	ZCdhRyCr+C+ap/UBug8Tww4CnJ8WzPYj/o0IK2CTMQzGZNmOvD4vUiRTSdS9gQ==
Date: Sun, 29 Aug 2021 19:54:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
Cc: connman <connman@lists.linux.dev>
Subject: Re: [PATCH] Respect EnableOnlineCheck globally
Message-ID: <20210829175411.u7gfenrvleehvp7v@beryllium.lan>
References: <20210828171657.2qxolbym36hdiuhu@prancingpony>
 <20210828173427.7ctqrpj2w2ldrkla@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210828173427.7ctqrpj2w2ldrkla@prancingpony>
X-Last-TLS-Session-Version: TLSv1.3

Hi Страхиња,

On Sat, Aug 28, 2021 at 07:34:27PM +0200, Страхиња Радић wrote:
> On 21/08/28 07:16, Страхиња Радић wrote:
> > +	if (connman_setting_get_bool("EnableOnlineCheck")) {
> 
> This should read
> 
> +       if (!connman_setting_get_bool("EnableOnlineCheck")) {
> 
> sorry. I'm sending the modified patch with this email.
> 
> ---
>  src/wispr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/src/wispr.c b/src/wispr.c
> index c63dc819..7b52914e 100644
> --- a/src/wispr.c
> +++ b/src/wispr.c
> @@ -916,6 +916,11 @@ static int wispr_portal_detect(struct
> connman_wispr_portal_context *wp_context)
>                 wp_context->status_url = STATUS_URL_IPV6;
>         }
> 
> +       /* Respect EnableOnlineCheck globally */
> +       if (!connman_setting_get_bool("EnableOnlineCheck")) {
> +               wp_context->status_url = "localhost";
> +       }
> +

This looks like the wrong place to break the online check. We should not
start the online check state machine at all. What about something like:

diff --git a/src/service.c b/src/service.c
index eb74a85d6e32..d04933070c61 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1618,15 +1618,18 @@ static void default_changed(void)
 				connman_setting_get_bool("AllowDomainnameUpdates"))
 			__connman_utsname_set_domainname(service->domainname);
 
-		if (__connman_service_is_connected_state(service,
+		if (connman_setting_get_bool("EnableOnlineCheck")) {
+
+			if (__connman_service_is_connected_state(service,
 						CONNMAN_IPCONFIG_TYPE_IPV4))
-			__connman_service_wispr_start(service,
-						CONNMAN_IPCONFIG_TYPE_IPV4);
+				__connman_service_wispr_start(service,
+							CONNMAN_IPCONFIG_TYPE_IPV4);
 
-		if (__connman_service_is_connected_state(service,
+			if (__connman_service_is_connected_state(service,
 						CONNMAN_IPCONFIG_TYPE_IPV6))
-			__connman_service_wispr_start(service,
-						CONNMAN_IPCONFIG_TYPE_IPV6);
+				__connman_service_wispr_start(service,
+							CONNMAN_IPCONFIG_TYPE_IPV6);
+		}
 
 		/*
 		 * Connect VPN automatically when new default service


This was the only place I found where we call
__connman_service_wispr_start() without the EnableOnlineCheck test.

Could you give this patch a spin?

Daniel
