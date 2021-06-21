Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47471
	for <connman@lists.linux.dev>; Mon, 21 Jun 2021 07:00:48 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id DA39550064D;
	Mon, 21 Jun 2021 09:00:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 9F62E5002C0;
	Mon, 21 Jun 2021 09:00:40 +0200 (CEST)
Date: Mon, 21 Jun 2021 09:00:40 +0200
From: Daniel Wagner <wagi@monom.org>
To: Santtu Lakkala <santtu.lakkala@jolla.com>
Cc: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>,
	=?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>,
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] replace strncopy by memcpy
Message-ID: <20210621070040.npcfzpmr37buaa7p@beryllium.lan>
References: <PR1PR02MB4794D05CFF3F4C689F28ECC0930D9@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <18824313-c5d2-cc30-dcbf-006a82c5ff75@jolla.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18824313-c5d2-cc30-dcbf-006a82c5ff75@jolla.com>

Hi,

On Fri, Jun 18, 2021 at 08:53:25PM +0300, Santtu Lakkala wrote:
> On 18.6.2021 15.38, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> > Thank you for your patch, but, even if I have not checked the
> > related sources, I really doubt about your fix. Maybe it will not
> > be a problem, due to the following check:
> > if ((uptr + ulen) > uncomp_end)
> >   			goto out;
> > 
> > > memcpy is equivalent to strncpy here as pointed by Santtu.
> > Please be careful, no more warning does not always imply that
> > the problem has been fixed. The warning has only disappear here
> > because you have replaced the call to strncpy by another one.
> > memcpy and  strncpy are not equivalent.
> > strncpy is dedicated to string processing, and enables to avoid not
> > null terminated strings, when the string length is equal to the destination
> > buffer size.
> > The good fix is just to replace, in the strncpy call,  ulen by  ulen -1 or
> > strlen(name).
> > If you really want to propose a patch, please refer to the commits
> > (sources code + commit message) I mentioned
> > (90f0e412569b327d8b25b834623b814f1fddbd19
> > & 3dbcc963a66d43e4ac51c97de4fe116ec72eb9f6),
> > it will be a better approach.
> 
> This is a different warning, this warning is about using strlen(src) as
> strncpy() length argument. I see a few possible fixes to acknowledge the
> warning:
>  1) replace strncpy with memcpy (as done in this patch, no change in
> behavior, only theoretically slightly more performant)
>  2) replace strncpy with strcpy (available space is already checked)
>  3) replace strncpy length argument with available buffer space (would
> unnecessarily zero the buffer to the end)
>  4) change the whole paradigm, and do something like:
>     uptr += snprintf(uptr, uncomp_end - uptr, "%s", name);
>     if (uptr >= uncomp_end)
>         goto out;
>  5) do 4 with strlcpy, but we don't have that

I've applied the patch. While option 4) is probably a bit nicer to read,
the rest of the function uses memcpy. So let's use memcpy for the first
operation as well at least for the time being.

If someone wants to rewrite the dnsproxy code to be more robust please
give it a go. We had at least 3 CVE in dnsproxy and I woulnd't be
surprised if there are more sever bugs hidden.

Thanks a lot!
Daniel
