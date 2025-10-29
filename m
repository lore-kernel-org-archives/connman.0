Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACE17B50F
	for <connman@lists.linux.dev>; Wed, 29 Oct 2025 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702034; cv=none; b=FjgSoshfWz3+sXePTxv7adoV8GSq0pil7bMODBoM63a6MK4l7Dxca5AB9Ycg28FEl2jlVpPdi2jd7HRwmTTkOnJTEmmZRTz/7PIn1izjr5PmC+e9vFsa0lOJR84/oTG/MxbWqBbjzBQbi0EHAOTIvfka8Y1Mnay5bnt5u/XW/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702034; c=relaxed/simple;
	bh=Snt9iiqV/DqaGmha4397gt4ZCrZdbTlZdNPZAryhFTo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eZJhe1ROOkCLlKZSZRzGO1BDUZW03bGU15JPTUTLHEY36AJSuTvP8nQOjyEgKeB8KRWqzKfADHPUHkBptVjnrZ62wt0LFeNpiNDuUKIiKrO0IKKAckUUbqNVwLWbWGc3YAlAf0joK2MXH+MrkT86+hNjQDIGxLLSx4L0pMzuNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFSEUnuR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFSEUnuR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429a0d1c31aso324061f8f.1
        for <connman@lists.linux.dev>; Tue, 28 Oct 2025 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761702031; x=1762306831; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVMujuHBw8eyVKKXsm3GxGQPYSr8jMdNb+iCj3ogKRU=;
        b=lFSEUnuRWVyeNcd63LLJ7xG8cX3mqb8t+/9YKdSlw5oZXcm+CO82jh86YxDJilh+Iy
         Ct76AR/BJ99ta9IwaAx3dKaXFCaKnAglJsyn2A48cB3gl3yv8jXzcmCVbTTyUbhG6bXq
         bLAXqKCb8cKc5cfH7EHcoKpKtvkIW+yG3NmQd9rdLfQCYCvyCDOW+amYtBHrgs2FRCom
         hyTtM+MLryD8BIPAwG0GQJNvnXfskmmX+t2QwmR3HK8Gqre2sQ80NhtDYq/ACaZYfsPM
         UsdrDGts/jLo2oI5DoZl1g8MlMXPREz8sEn70QGLGQ6mRu2n6/+4I/gQ4qc8GEUPSo7b
         bWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761702031; x=1762306831;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVMujuHBw8eyVKKXsm3GxGQPYSr8jMdNb+iCj3ogKRU=;
        b=sA0yKNiiuihoaVkiudbdVMhxZwriP4SAljgFfD4d6XAIlDQT0xOp03KkE2FahvidaP
         XdwugmGKcGov1Q1jcNF3H0AfD8oaNPBWj0ppGhs75SWN4I9/SU4/X4PoHMQmoDwPsYd4
         EEx5ikYL5LBMeTbrMzRU+/yFx2BDnXF0ZIsuUDOIny+srftcnr/cMGOkd/w8GUD5+ne+
         3xwF22OfYBnqWbMF9jVw7uR22xyqZ8q7LaJAlbqlUJ64JE/3CjOAm5DcydaTNWtoggha
         8th9eagNQXd+9DQtfEjtxoW6HTCmFIa2RsRQeEb2qGpEheBA702//bXkvfJzaPBFBnTo
         Fk/A==
X-Gm-Message-State: AOJu0YyQeiR0G/n4BK17P4d7rFDTjuNhUjzZ3qbv3cBmUfh0ELmGWvzK
	DadjNZop4S5Lyt68q1SsPR9PKGEV6CyOdA257ppTGFAqptxemBrpXWyH
X-Gm-Gg: ASbGnctOIoigHqIUZvRYevPKMiSHCZ8beV1jjXYPx3h7BYjpjR0x91A+vI0PVQht3Ym
	0YORq/QRZiTNGgC0uDMD5kjb7LnsTnBZgtmtoq+67sdSRMZ7TXt1MomzgnPqYZskFRMrs9cRaWk
	mAw+hbp7eS7SpMfX3w1pG0vjtdrbDEhYfa5nwG9BASxBfBvUJPAv4873aGUqRMhNqijzVZw+cZD
	Zn2OAyz65vY29yLnYFlDBCd3K0ZcODVWOgrYvLpCyDdTFaxNpBrOA1xdjnPh81i53Bwvw+Br2tl
	Tz3ODVseRXn2FbHupI0BIQrwPrRjR2PBflyIkRX/jvgMt70KYcpbUhhbCFii0bz3RgR7DxaeiaH
	wN/rMbQeKfAtwgev47zOVrkYV4z9zzR1x6o1sLo8iMkVXGXuG3r35EQih20TiVO5hrQaRxACn2t
	mcFzZYPstDDIYmuadaNT2bPpTICnRSKanLVhA=
X-Google-Smtp-Source: AGHT+IHFQjmkCKeLCsSFil3ROnwjwf1ScoM3C/T2zSga2Gi7LjAXXa0yBjq8JfzHrYUgx1q/GwuDAA==
X-Received: by 2002:a05:6000:613:b0:425:86da:325f with SMTP id ffacd0b85a97d-429aeb10d64mr970132f8f.27.1761702031314;
        Tue, 28 Oct 2025 18:40:31 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e2e06sm23478071f8f.46.2025.10.28.18.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 18:40:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 00/42] VPN association state, dual IP support and WG
 fixes
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Date: Wed, 29 Oct 2025 05:40:18 +0400
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <7493D021-C582-4AF6-8A8F-679FBF4E8876@gmail.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.700.81)

> On 13 Aug 2025, at 7:01=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> This patch set (1) adds the association state also for the VPNs, (2) =
implements
> dual IP support for VPNs and (3) contains fixes for Wireguard address,
> especially for FQDN handling. This is a combination of all three =
improvements
> for the sake of testing them together.

[snip]

Patch 21/42 #includes both inet.h and arpa/inet.h; the former results in =
a
compile error. This change resolves it:

diff --git a/src/shared/util.h b/src/shared/util.h
index baaca31e..30630f93 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -25,7 +25,6 @@
   #include <glib.h>
 #include <stdbool.h>
-#include <inet.h>
 #include <arpa/inet.h>
   typedef void (*util_debug_func_t)(const char *str, void *user_data);

With that nit solved I was running the series for several months with
no issues. However the latest ConnMan release now gives me connection
problems and although patches still compile I had to revert them. I=E2=80=99=
ve
not yet had time to bisect and find the breaking change.

Christian

