Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23D70
	for <connman@lists.linux.dev>; Mon, 28 Jun 2021 07:58:44 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id AC24950051C;
	Mon, 28 Jun 2021 09:58:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 7968D500143;
	Mon, 28 Jun 2021 09:58:36 +0200 (CEST)
Date: Mon, 28 Jun 2021 09:58:35 +0200
From: Daniel Wagner <wagi@monom.org>
To: John Keeping <john@metanate.com>
Cc: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>,
	connman@lists.linux.dev
Subject: Re: [PATCH] service: Complete only after user connection retries
Message-ID: <20210628075835.dvlm6bnrzmknr56i@beryllium.lan>
References: <PR1PR02MB4794EB6ADA4A23AA374EE58493909@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210327124254.iorhou27y3u4pwih@beryllium.lan>
 <20210615120930.2970caef.john@metanate.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615120930.2970caef.john@metanate.com>

Hi John,

Sorry for the long delay.

On Tue, Jun 15, 2021 at 12:09:30PM +0100, John Keeping wrote:
> Hi,
> 
> On Sat, 27 Mar 2021 13:42:54 +0100
> Daniel Wagner <wagi@monom.org> wrote:
> > On Thu, Mar 11, 2021 at 01:04:11PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > > When a user connection fails, let the report_error_cb manage
> > > exclusively service update, after all retries.  
> > 
> > Patch applied.
> 
> This patch seems to have totally broken connection attempts where the
> wrong passphrase is entered:
> 
>         connmanctl> connect wifi_b0f1ecffb46f_7073475462456b44_managed_psk
>         Agent RequestInput wifi_b0f1ecffb46f_7073475462456b44_managed_psk
>           Passphrase = [ Type=psk, Requirement=mandatory ]
>         Passphrase? wrong-passphrase
>         Agent ReportError wifi_b0f1ecffb46f_7073475462456b44_managed_psk
>           invalid-key
>         Agent request cancelled by ConnMan
>         connmanctl> connect wifi_b0f1ecffb46f_7073475462456b44_managed_psk
>         Error /net/connman/service/wifi_b0f1ecffb46f_7073475462456b44_managed_psk: In progress
> 
> This happens because service->pending is never cleared because
> service_cleared() is bypassed in this hunk:
> 
> @@ -6064,6 +6065,7 @@ static int service_indicate_state(struct connman_service *service)
>                                                 report_error_cb,
>                                                 get_dbus_sender(service),
>                                                 NULL);
> +                       goto notifier;
>                 }
>                 service_complete(service);
>                 break;
> 
> It looks like something is missing because reporting the error only
> after all retries makes sense, but after this patch the original connect
> request doesn't get a response at all and any future attempt to connect
> fails.
> 
> I'm not familiar enough with the code flow to suggest a follow-up
> change, but does the above explanation make sense?  Is there an easy way
> to ensure that the pending state is cleared and we reply to the original
> message?

I've tried to reproduce it. With iwd, we never go this path as iwd tells
us invalid key directly from the connect attempt.

In case of wpa_supplicant we go through this path, meaning
report_error_cb gets called with either retry=1 or retry=0:

connmanctl> connect wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? asdf
Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  invalid-key
connmanctl> Retry (yes/no)? yes
Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? asdf
Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  invalid-key
connmanctl> Retry (yes/no)? no
Error /net/connman/service/wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk: Input/output error
connmanctl> connect wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? asdf
Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  invalid-key
connmanctl> Retry (yes/no)? yes
Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? asdf
Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  invalid-key
connmanctl> Retry (yes/no)? yes
Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
  Passphrase = [ Type=psk, Requirement=mandatory ]
Passphrase? correct-password
Connected wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk


So the only way I can see why the pending message is not released is a
missing call to report_error_cb() or the final call is
report_error_cb(retry=1).

Could you try to add some debug printfs and report back?

Thanks,
Daniel
