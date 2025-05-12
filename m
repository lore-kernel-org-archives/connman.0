Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D8298C27
	for <connman@lists.linux.dev>; Mon, 12 May 2025 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077699; cv=none; b=Tut73NZLjfejqSVTaLuX0zAjP/oi4a3RViTdhtjtBOF3WKy16gMgKfz70yKov3EzYI2TozTk1HwuCZ4fP64QbxRbDH8oQP+PlOcG68SneV+zIBrQJzMljIAu8ps0bZZlZDrbRadxf31fdWwEPU6cP4fLPoEFQEDWBVljZ4v8pF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077699; c=relaxed/simple;
	bh=pqUDsAn5OPu4gLoGrfor/ERghibZIctB7uOUzVDBlnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaLZDRe5OllnJCTBTb5UaMQ/WcIraQH4KZViuuKGYpEpxxHJJrpANFcUqXgs6xZr1zsYl8ZkwZi1xfw65FHMvMYwRoSgbdZD+RLeTE8iKuHWxKrhDBZs7Nu+w30bGgcanh8VV0bx/MIeMspcUvZwxdzejdHSNfBJ3Nv8YQf4afg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8rjLGbp; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8rjLGbp"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2dfb991cb45so989526fac.0
        for <connman@lists.linux.dev>; Mon, 12 May 2025 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747077697; x=1747682497; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60fl0hfJ7T7KDWFRNPDi9smOR1gkJcLiU8z1mCZFwwU=;
        b=S8rjLGbpFoMrUavWw3fVvLe4WE6Z/kMElnxuMvpnKb5Iu8QbQipN/bUVIwz0CUCWo9
         RBURXgrZu/nMBuwtpS36hpNQTeuZWgNrFPzeZJrTy8Y2kVwNZiDpDcPbbrGjc4msMyrx
         yYcowMw3/ycf3fJXzOTFluMTFDWJRyv+/vAjRFfeywmOWRyJNy9hWUUukkrSvM8zI7q9
         Qe7v7IC7TI+ptRlto1Z6LkeGZMjnRjwaQ3w/O2SYQvPSEeFey/NCzsoiULUgIlQkK2GR
         vtIWfC1rSkV5oZXfELQc0oKhmxNYNn8Gf9vKiv7W6kjndnIM0FTFbr69KowpHi4SrRrA
         zPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077697; x=1747682497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60fl0hfJ7T7KDWFRNPDi9smOR1gkJcLiU8z1mCZFwwU=;
        b=UnnXIqlfbrbPhuGPEmX1+HuYhLyDcQrH1GghmZg9C52DJlYwboJMeIj38+kwDSKo0i
         hGqxLFLZJg8ERzIF0/h7PiJFrj8gfILhRJ1x+oxGFjCJ7/nNIjtAvbBIbiAF5qBx/+4J
         tTWT9SFfuJ5E0XpJWvYge79R0JOzg7yivWZQ/Lq4+SbgWFR0uoUaYqpZptGOK+i19VBn
         wVIwJHKN4AeOfMWiyLGwuuICpidRORWXa+NwAV5o+CArcemL7BH52nQNfrzUq+8FB8Et
         XHtdyk2FtzLBOQeWDmQP5traw6oYJ48SDIVWKOJcl98rIuGhO7gGrm1eDmkAwOknBp0O
         Jwsw==
X-Forwarded-Encrypted: i=1; AJvYcCXdkDzDsKyEWEZ1olm3v5RF7w59pB7yqVzgqahT1x3I5/n2wi6nDJVxd3Yr6EqMMby/nB1mLSQt@lists.linux.dev
X-Gm-Message-State: AOJu0YwZogpLYwTMFy1NeTou7N+XAHdMBsVMPKO7SxfgE+pdyglvj3R8
	KHTW0YVgo+zxOJI2VUlL/NdGrW8gpbLB7sasJ0U8I25Ku2PgRMLj
X-Gm-Gg: ASbGnctPCAdzz0vGEptDgjw+todBi8VPTyn3xAcGhgx/X/+Wq1JsgN8rd6MdwT7KeM2
	xFX+rtC8oWDE1t8/S+UbMQdb6o26b6ST5YiB32vGReBq2P3mSOCpTt+aMDSBbsK57ZuyujVHoH8
	LeAqseMPBdS1Io7INWqcKRSKivqkNHPdqcIKbRIGRQqk45WTB4gVHfSKWPc9RoS2xhmlfX+jah/
	R0yPEE+nvZi6l97xwKkmDugQ9Bp+ulqdSZ3uRvdCZFKL9zbHOv2jjVVgl46yteNjWfMz+oJDyes
	OnZ6wOO11wLH2a73ZeznfA4+UWP5vv4T4RYkTDlZ24evbNHZImvSxLA9L1O88N1tXNZZcZFsRfl
	GLtoWDHAZFR2P3q9C
X-Google-Smtp-Source: AGHT+IHXouoZBU6tyLpahS3woytjihSMb3MeJLtV6P7oGdw0JYBLAt0ugW12Z4bdeAzg5HCgjoj0WQ==
X-Received: by 2002:a05:6870:1792:b0:2c8:361a:da77 with SMTP id 586e51a60fabf-2dba4530009mr8257847fac.26.1747077696603;
        Mon, 12 May 2025 12:21:36 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba0b7ea6csm1979846fac.44.2025.05.12.12.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 12:21:36 -0700 (PDT)
Message-ID: <95264365-13b3-47bf-8443-078aab4082d6@gmail.com>
Date: Mon, 12 May 2025 14:21:34 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gsupplicant: MFP optional for WPA2-Personal
To: Michael Trimarchi <michael@amarulasolutions.com>, connman@lists.linux.dev
Cc: linux-amarula@amarulasolutions.com,
 "Dembianny, Sven (GDE-EDSD5)" <sven.dembianny@bshg.com>
References: <20250512085223.411606-1-michael@amarulasolutions.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20250512085223.411606-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 5/12/25 3:52 AM, Michael Trimarchi wrote:
> From: "Dembianny, Sven (GDE-EDSD5)" <sven.dembianny@bshg.com>
> 
> Previous MFP support was restricted to WPA3, however it is also possible
> to set MFP to mandatory on APs with WPA2.

Yes, assuming your device supports it.  But I'm not quite sure how this 
description corresponds to the actual patch?  It looks like the intent is to 
always set ieee80211w=1 (MFP Capable set, MFP Required not set) which enables 
the use of MFP by wpa_supplicant even on WPA2 networks.

> 
> wpa_supplicant config:
> 
> * WPA2-Personal: key_mgmt="WPA-PSK-SHA256" ; iee80211w=1
> 
> It is important that the default value of MFPC bit is 1 on the final-commercial
> version of the device. It is a mandatory WFA requirement.

Which 'device'?  I think you may be referring to something specific to your use 
case here.

> ---
>   gsupplicant/supplicant.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index f3be9e7b..2ebfa2c6 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -4955,6 +4955,7 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
>   		add_network_security_ciphers(dict, ssid);
>   		break;
>   	case G_SUPPLICANT_SECURITY_PSK:
> +		ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
>   		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) {

doc/coding-style.txt item M1

>   			if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK) {
>   				/*
> @@ -4962,15 +4963,16 @@ static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *ssid)
>   				 * WPA2-Personal (PSK) and WPA3-Personal (SAE)
>   				 */
>   				key_mgmt = "SAE WPA-PSK";
> -				ieee80211w = G_SUPPLICANT_MFP_OPTIONAL;
>   			} else {
>   				key_mgmt = "SAE";
>   				ieee80211w = G_SUPPLICANT_MFP_REQUIRED;
>   			}
> -			add_network_ieee80211w(dict, ssid, ieee80211w);
> +		} else if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK_256) {
> +			key_mgmt = "WPA-PSK-SHA256";

This part seems to be unrelated to the commit description and has nothing to do 
with MFP?  Also, you might also want to enable SHA256 in WPA3 Transition mode?

>   		} else {
>   			key_mgmt = "WPA-PSK";
>   		}
> +		add_network_ieee80211w(dict, ssid, ieee80211w);

Ditto item M1.

>   		add_network_security_psk(dict, ssid);
>   		add_network_security_ciphers(dict, ssid);
>   		add_network_security_proto(dict, ssid);

Regards,
-Denis
