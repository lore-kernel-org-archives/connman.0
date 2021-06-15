Received: from metanate.com (dougal.metanate.com [90.155.101.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810972
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
	:Content-Description; bh=7eZjVmpy5qNA3fXhyHOqFwKTUJw9m7bUU3HEW1lE3Q0=; b=4pi5
	siAevrbg1r7Pd8/2TKQ2vp6k+7v97KMNlWsmnlMvwYaJBj3ttUgrOgdFDtikkl48zl/WHza7F6nU3
	UOaDOYd7Z6WsMQRojzT65ifa7vf/yHoe+rJJrbPTFhMr5RrTAFhwSVUtT1ScfquaelVf/UN6aKsNJ
	BvbfRSnXGcB1xybXgYY4YwT5aL1dqTydeiyCz3VuQ8GYosGA9Nyh7YFhfZbd7L/GRpa8C78S+opxU
	rb0MRtDFx82ROcZ7dq0Eh8LjFVt+l5rmYGYxOKbf036R1e5reqPL7oxaNGtShq3drpLCO0Y8+7uvD
	LMfzWImGAxDRSuTV3CDYYYM9E8vBaQ==;
Received: from [81.174.171.191] (helo=donbot)
	by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <john@metanate.com>)
	id 1lt6wl-0006JE-29; Tue, 15 Jun 2021 12:09:31 +0100
Date: Tue, 15 Jun 2021 12:09:30 +0100
From: John Keeping <john@metanate.com>
To: Daniel Wagner <wagi@monom.org>, "VAUTRIN Emmanuel (Canal Plus
 Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] service: Complete only after user connection retries
Message-ID: <20210615120930.2970caef.john@metanate.com>
In-Reply-To: <20210327124254.iorhou27y3u4pwih@beryllium.lan>
References: <PR1PR02MB4794EB6ADA4A23AA374EE58493909@PR1PR02MB4794.eurprd02.prod.outlook.com>
	<20210327124254.iorhou27y3u4pwih@beryllium.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES

Hi,

On Sat, 27 Mar 2021 13:42:54 +0100
Daniel Wagner <wagi@monom.org> wrote:
> On Thu, Mar 11, 2021 at 01:04:11PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > When a user connection fails, let the report_error_cb manage
> > exclusively service update, after all retries.  
> 
> Patch applied.

This patch seems to have totally broken connection attempts where the
wrong passphrase is entered:

        connmanctl> connect wifi_b0f1ecffb46f_7073475462456b44_managed_psk
        Agent RequestInput wifi_b0f1ecffb46f_7073475462456b44_managed_psk
          Passphrase = [ Type=psk, Requirement=mandatory ]
        Passphrase? wrong-passphrase
        Agent ReportError wifi_b0f1ecffb46f_7073475462456b44_managed_psk
          invalid-key
        Agent request cancelled by ConnMan
        connmanctl> connect wifi_b0f1ecffb46f_7073475462456b44_managed_psk
        Error /net/connman/service/wifi_b0f1ecffb46f_7073475462456b44_managed_psk: In progress

This happens because service->pending is never cleared because
service_cleared() is bypassed in this hunk:

@@ -6064,6 +6065,7 @@ static int service_indicate_state(struct connman_service *service)
                                                report_error_cb,
                                                get_dbus_sender(service),
                                                NULL);
+                       goto notifier;
                }
                service_complete(service);
                break;

It looks like something is missing because reporting the error only
after all retries makes sense, but after this patch the original connect
request doesn't get a response at all and any future attempt to connect
fails.

I'm not familiar enough with the code flow to suggest a follow-up
change, but does the above explanation make sense?  Is there an easy way
to ensure that the pending state is cleared and we reply to the original
message?


Thanks,
John
