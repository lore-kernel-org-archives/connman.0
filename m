Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA678612D
	for <connman@lists.linux.dev>; Sat, 21 Oct 2023 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQyf8IP7"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-507c50b7c36so2770199e87.3
        for <connman@lists.linux.dev>; Sat, 21 Oct 2023 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697922734; x=1698527534; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6xP03/48J2Tt5LtZ5yPdPSmy1xQumdiyUaWYkNdqH0=;
        b=RQyf8IP7PM2gtxmgh/CmyNFryOSJ1JmcPD+xycntqoV6eiyCD+776oPj18Q6fjbrhp
         YSPyyM47uXsHrmWeBZhHlKGwJUh53cGsZwy2XNJuB2bV4/wpaTm3QxcrcL6NS3mv++oY
         iKMTV/zBdc4drdl788wPIJHLqWNzc5rwKmTq/CYmU67EQe5b4oHakNrExClSbSw3AwMc
         /bh5R+xjA9Bd9d5umIbQh+UFu13HiWrf1PpEphAADEZ2HWx50l7i1SDhCTOova5nXNvC
         FWQTXlb/QTryyXrFcmCLgKkeWFOrJLEC/iK2fRZK4ItUv/GNkYK/2ws/HycyUnzGKWUD
         6k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697922734; x=1698527534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6xP03/48J2Tt5LtZ5yPdPSmy1xQumdiyUaWYkNdqH0=;
        b=gbqJKn9K0p+WuIc6blG8vElTZr1u5yPgeVkRXjAGxrHXbbMYU/3DAbyDyVEt67KKWE
         LMxFbnjX0ibp44DemCLSNIPLjO6dxDA1hb2Ce5OI2OvY5gh4PLZuRaGdH/XnFHltnRxX
         UpWhHq9uZ7MrGhrGwrYt+piSB8NkEFUr++Ywx7XUk9Blp4ZzWOw3DwLyxe9GAEcuO/Sx
         O2NC1aPvPYo5kgke6kXLEd0fNrTq2WfMKwrNHYykc236TmqqZzCeBSjTUaRcKZkZjxDA
         QkBx7a2RbJnP3dYPXA7kmdhdjoINfwpDjxgaxcnWNaxBIsnHgyatJV2NQj9LzoTi0PUG
         iVXg==
X-Gm-Message-State: AOJu0Yy6GetU04A4N4NkLXn9PLIG3m/xTrHce4YsDHOaVEGzX5w+yf6R
	0q+ljIfq9SU28ZMJfM/wau6sdWnTtBw=
X-Google-Smtp-Source: AGHT+IHIAH9GIoL90Wz+iCr9mtDj32AJdKGciRWhMQWKS8Bg8ezvEBh3sr5fHfffAq86e166Nr1puw==
X-Received: by 2002:a19:f008:0:b0:507:aaa9:b080 with SMTP id p8-20020a19f008000000b00507aaa9b080mr3548722lfc.33.1697922733540;
        Sat, 21 Oct 2023 14:12:13 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id eo25-20020a056512481900b005057184ae62sm995503lfb.96.2023.10.21.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 14:12:12 -0700 (PDT)
Date: Sat, 21 Oct 2023 23:16:17 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Const-qualify 'gchar *' arguments in ipconfig
 getters/setters.
Message-ID: <76tyzxqeyzrdkrrt37mf5xtlnw4rbrtimrufxwvurtc3bvihhe@hzaqernblw2f>
References: <F9F0D72A-3FF6-4045-B847-EA891BC4E0A8@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gq4ntqyngcqtfcts"
Content-Disposition: inline
In-Reply-To: <F9F0D72A-3FF6-4045-B847-EA891BC4E0A8@nuovations.com>


--gq4ntqyngcqtfcts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 20, 2023 at 01:25:14PM -0700, Grant Erickson wrote:
> Const-qualify the 'gchar *' arguments in ipconfig getter/setter
> functions to make it clear to the compiler, static analyzers,
> and human readers that there are no mutation side effects with
> such arguments.
> ---

Hi Grant,

When there are several patches that depends on each other, please
consider to send them as a patch series.

Otherwise a single patch won't apply before you have applied all other
patches in order.

You may generate a series of patches with `git format-patch`. E.g.

git format-patch -4

Will generate a series for the commits HEAD~4..HEAD.


Cheers,
Marcus Folkesson

--gq4ntqyngcqtfcts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmU0P5wACgkQiIBOb1ld
UjIMCRAArAPVsj5h0NdzmosgWTcn++jXK+Nid/8x2XovLcRDYxc6OlhkzKlTBGKK
cyqI1s7UDofvs2QbOFf/QvhrzQBekGqKuQ4dwv5m1/wWhKpSnY5+8HrJGefMPKLE
pDByIZE9/+evB1byHxVTZvMtYZ8hLUlSfoat9x28KdD8LtlPTm8vLh67ZCTPf4xz
MjwQs/EjT5JXc8TolmHVvqWLImpD0NkLXdAqwnWKMDHaNBZw4WwlMqFsyZM5MV1J
PZgrvth5djSs0BUPO2899D77pNJXy2PxNJ0rr//qk/d2cnkpzbuEXt8rWh3fpsmJ
orcyZUK6ts9GLg490z+fIZTglXSypZwWz84L4dFnuuUJX5NFzJsjMc2L6hMnxkKf
wn7eoOdklZvLDrXzLZ/LsVu2k625A12hhnBjrYwvPZEDcRowAKOoBRVr1R9pi6F5
spHJotnZDb8xsFgTcAxMxjSVAPRfSfnWxcZ6XK6V4WNRa0q4j3i6giYostZkf9uJ
jXiTylYxR93Ygw+Ta+1J17MeWY9AX9IcEF5InXhk9EsckLQ5iH0PF3+A95fGjXQ4
ueSXT42NSAEna4RNmvHiFmU/m9x2+IAj9s/Yl95GvjzmkYiwJ7oYRzlpmzJiX42c
iq4sxpSy9EC9FKKDsWzzeoMefUSvdRSjIoxsAzhgRFnAir3zRss=
=oZrn
-----END PGP SIGNATURE-----

--gq4ntqyngcqtfcts--
