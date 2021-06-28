Received: from metanate.com (dougal.metanate.com [90.155.101.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915170
	for <connman@lists.linux.dev>; Mon, 28 Jun 2021 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
	:Content-Description; bh=PLhfyYTSzHIVyGlm3vQCAvSml/0HKOWFerNzbDFUV0s=; b=Afps
	Gr2n66vBT9xTbpbVfqFXN2NWrZWUPDGQJ5cvIcIJ3b8D0Vqdtshdu1OxeU/z1Ba16QDC5TGces5Qc
	paN8/rzK8J0nUig6B6wlTmijjF3fFLvOqpj9fcoB/ScDtfKmgz6dGCBrRbpicI4s5HgivuyAbHVsa
	jggVF1usxOHiJiMg8SNkvPvF9sy+XsLMdTAPL1LiYTpAykeoWmThZY8SJ7MhLQUJtRRb7Ltk8O2PK
	tqbWriRQ4IiM6i71AkrjcGRm0q6TfNbSE61XYR6sPmpty3cfN9Dpsee6Y7qFZVzhhmQmpiMj2A8KX
	GuTycWN8wamhGsBkOVLZTRsDfCJY2g==;
Received: from [81.174.171.191] (helo=donbot)
	by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <john@metanate.com>)
	id 1lxso2-0002km-1a; Mon, 28 Jun 2021 16:04:14 +0100
Date: Mon, 28 Jun 2021 16:04:13 +0100
From: John Keeping <john@metanate.com>
To: Daniel Wagner <wagi@monom.org>
Cc: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
 <Emmanuel.VAUTRIN@cpexterne.org>, connman@lists.linux.dev
Subject: Re: [PATCH] service: Complete only after user connection retries
Message-ID: <20210628160413.416f51e4.john@metanate.com>
In-Reply-To: <20210628075835.dvlm6bnrzmknr56i@beryllium.lan>
References: <PR1PR02MB4794EB6ADA4A23AA374EE58493909@PR1PR02MB4794.eurprd02.prod.outlook.com>
	<20210327124254.iorhou27y3u4pwih@beryllium.lan>
	<20210615120930.2970caef.john@metanate.com>
	<20210628075835.dvlm6bnrzmknr56i@beryllium.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES

Hi Daniel,

On Mon, 28 Jun 2021 09:58:35 +0200
Daniel Wagner <wagi@monom.org> wrote:

> Sorry for the long delay.
> 
> On Tue, Jun 15, 2021 at 12:09:30PM +0100, John Keeping wrote:
> > Hi,
> > 
> > On Sat, 27 Mar 2021 13:42:54 +0100
> > Daniel Wagner <wagi@monom.org> wrote:  
> > > On Thu, Mar 11, 2021 at 01:04:11PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:  
> > > > When a user connection fails, let the report_error_cb manage
> > > > exclusively service update, after all retries.    
> > > 
> > > Patch applied.  
> > 
> > This patch seems to have totally broken connection attempts where the
> > wrong passphrase is entered:
> >   
> >         connmanctl> connect wifi_b0f1ecffb46f_7073475462456b44_managed_psk  
> >         Agent RequestInput wifi_b0f1ecffb46f_7073475462456b44_managed_psk
> >           Passphrase = [ Type=psk, Requirement=mandatory ]
> >         Passphrase? wrong-passphrase
> >         Agent ReportError wifi_b0f1ecffb46f_7073475462456b44_managed_psk
> >           invalid-key
> >         Agent request cancelled by ConnMan  
> >         connmanctl> connect wifi_b0f1ecffb46f_7073475462456b44_managed_psk  
> >         Error /net/connman/service/wifi_b0f1ecffb46f_7073475462456b44_managed_psk: In progress
> > 
> > This happens because service->pending is never cleared because
> > service_cleared() is bypassed in this hunk:
> > 
> > @@ -6064,6 +6065,7 @@ static int service_indicate_state(struct connman_service *service)
> >                                                 report_error_cb,
> >                                                 get_dbus_sender(service),
> >                                                 NULL);
> > +                       goto notifier;
> >                 }
> >                 service_complete(service);
> >                 break;
> > 
> > It looks like something is missing because reporting the error only
> > after all retries makes sense, but after this patch the original connect
> > request doesn't get a response at all and any future attempt to connect
> > fails.
> > 
> > I'm not familiar enough with the code flow to suggest a follow-up
> > change, but does the above explanation make sense?  Is there an easy way
> > to ensure that the pending state is cleared and we reply to the original
> > message?  
> 
> I've tried to reproduce it. With iwd, we never go this path as iwd tells
> us invalid key directly from the connect attempt.
> 
> In case of wpa_supplicant we go through this path, meaning
> report_error_cb gets called with either retry=1 or retry=0:
> 
> connmanctl> connect wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk  
> Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   Passphrase = [ Type=psk, Requirement=mandatory ]
> Passphrase? asdf
> Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   invalid-key
> connmanctl> Retry (yes/no)? yes  
> Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   Passphrase = [ Type=psk, Requirement=mandatory ]
> Passphrase? asdf
> Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   invalid-key
> connmanctl> Retry (yes/no)? no  
> Error /net/connman/service/wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk: Input/output error
> connmanctl> connect wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk  
> Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   Passphrase = [ Type=psk, Requirement=mandatory ]
> Passphrase? asdf
> Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   invalid-key
> connmanctl> Retry (yes/no)? yes  
> Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   Passphrase = [ Type=psk, Requirement=mandatory ]
> Passphrase? asdf
> Agent ReportError wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   invalid-key
> connmanctl> Retry (yes/no)? yes  
> Agent RequestInput wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
>   Passphrase = [ Type=psk, Requirement=mandatory ]
> Passphrase? correct-password
> Connected wifi_001e58ab5802_6f776c2073747265746368696e672074696d65_managed_psk
> 
> 
> So the only way I can see why the pending message is not released is a
> missing call to report_error_cb() or the final call is
> report_error_cb(retry=1).
> 
> Could you try to add some debug printfs and report back?

It looks like the length of the invalid passphrase matters here.  If I
use a short passphrase like you have above then I reproduce that
behaviour, but if the wrong passphrase has at least 8 characters then it
enters the failure state.

I think __connman_service_check_passphrase() is rejecting the short
passphrase so it never even gets to wpa_supplicant.

In the failing case, I don't get the chance to choose to retry.  Instead
the output looks like:

	Passphrase? asdfgghjgj
	Agent ReportError wifi_b0f1ecffb46f_7073475462456b44_managed_psk
	  invalid-key
	Agent request cancelled by ConnMan
	Retry (yes/no)? connmanctl>

where the new prompt appears instantly.  Inspecting the DBus traffic, I
see that connman calls Agent.ReportError and then immediately calls
Agent.Cancel (the timestamp is less than a millisecond later, although
there is a call to fi.w1.fpa_supplicant1.Interface.Disconnect in
between).

I added extra logging in report_error_cb() and can confirm that this is
never called when this happens.


Regards,
John
