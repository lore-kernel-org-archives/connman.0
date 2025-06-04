Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC81FC7D9
	for <connman@lists.linux.dev>; Wed,  4 Jun 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072092; cv=none; b=ViAzJ/Ag6BQQqh35FPTytHJDo9pPQ6qCW/dAadolKDL1mWaG9OKpfdmEQlrJEwb2cwAOaQCCkkfJ9JZixIUOfkAucAvr8mbT6wjRkadWV8lPmyoKPdYi3Dgj5N6HMNgJ7Sx/bT8k/ky0UyW7O1crY8xUGhdmj9pHQ341lH3WEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072092; c=relaxed/simple;
	bh=3bRkRRM3jDmTOdbPguOFw24jDiJKBKEGxkjOFVIBNMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZkD1K5UIrBexJ6lE6n13vh7C8SSmxu9cYBjqcv+ouEumJFSOJSvXf7E+QxWgYPRmv1ldiijVCDiN+ZzO9bJaAvXtUZFMF7L6CN5Ah5iqu/kxHVAB0EWuMxa8rkLc/ybpFhTuMAwuxycjxr5J8of82DKWF48U8iWQBoAS8X3qhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHWI/Q2V; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHWI/Q2V"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c27166ab3so167014a34.1
        for <connman@lists.linux.dev>; Wed, 04 Jun 2025 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749072089; x=1749676889; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4L8m++yPeUz6PhGeDtATIlfyZMz2ZyIeAvIRGv43XM=;
        b=lHWI/Q2ViE0qLmuhlSm4Q5vU6+OWTmNGU8S/r/K9krjHKE3i+/lXVrkCeH1ItA96EA
         saceSbPH9hr867hTeCQVfKY5SWglExXgToAZ7WYC2rYho0OkyqswIW1Z9BkbcyUYsbQJ
         ku6/jL/VQSARYKajmBPsb5qDgaxPLFPzCc6AkuxtoRACa4+s4kXBlBneEuTFmsemwPV1
         TyROa9oCyXIiMR4o/1H62jqLWkZ1BSptYWrbe1GbtoFhqx0Fv240+OoTxUz3rcX8UIuk
         AavNZ7BQ3mLePk8f6wJRcsh0EHgbTfnGtNwBU5O5obFenEWI27yZfeSzy8Dzi7OJoQHz
         JqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749072089; x=1749676889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4L8m++yPeUz6PhGeDtATIlfyZMz2ZyIeAvIRGv43XM=;
        b=cWd3irF5UZe8wl/PncVS1X5UjYhrIoVuIuQnRqOoJhekhEv6GZSn1ue0zKNtcm30E9
         Hw/pxwXwIOkva+BB2zLCKd/pwAxlWBH1YO3sUG3ekF3q+TuLGuGjAQyUmokV0O9efs0x
         Y7y/T1zOjHs+PbmpziZ+MTbB941rK/kfg24eiDSLgYJX17PbBzN4En8KdN5Zt+28uurL
         zksI2QUi+FMRKXldC3yzA0vs/BjTOiCdU60GcXNg8uPR8OySwEnStYKpa7KryDm3UCTi
         n/CMLmry7DWoD9dsQAbiDFT9PqyfQc3aSoDCzSBRFQ3YNnw7Jg7U95keJvvKWN9rc8ZT
         SPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX02YMuYaD6bSBaFRZLMRFJ1OVrGtscjjvHF2/Ion7+jBcYVZB1uoedULbqWMBZn1X8/6f7P5mF@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/t3ERs55L+SjSynRLE+jcM72p1Qqew1Y1gYfenGcVOm+xDh4c
	N40E6X7w+0Slri2NvPq708PjfWck5JLzRqeuksVlEXqHPMozyjJjiK3s
X-Gm-Gg: ASbGncs+MtuxaxN3K2Jb88Eint55F7gkfAaDDoJnTtLjpHWfGIeMFV8MOGA1vi2anZF
	Ftq6WiWsOafd2u265uVMPjMYQCkB26xovb7VwwySJRQ70tqwuZona1ArerGFcclaJVPdYzjAa3g
	yj8YAIW+V3c+EMzA68SIi/fOHnL25BerIkZjh82mi74APzjLTBv6NXPmky4Ndu9yCHlJebZ7vZj
	tJo3U2fnii7W84ujf7JPrSihhrRGw4cxtBhBc32NvsdW8pgAyoNRiaSz/xXw/YjMsQIltesJbEA
	gck+4nnhgLlPqj0I4JATEXQv1nTKnhEaOLhk4wMey+ofvhz6uxUkS166vq3WrMJyaMYQa5/7Jmw
	V0rw8rHzbmg5BtRU6x1f35nCcBVQ=
X-Google-Smtp-Source: AGHT+IGehXE3nNHwyoaSHBaN4WuNNuwGh4QKHO6+uKbqCIKZFV0K0pHpnjNS8Z1N0qPGQwTf86EwCQ==
X-Received: by 2002:a05:6830:498b:b0:72b:a5e0:f76 with SMTP id 46e09a7af769-73869c18e49mr3462460a34.4.1749072089036;
        Wed, 04 Jun 2025 14:21:29 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-735af82d2d0sm2385614a34.9.2025.06.04.14.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 14:21:28 -0700 (PDT)
Message-ID: <8bcaedcf-a539-40db-9943-fcfa708501c3@gmail.com>
Date: Wed, 4 Jun 2025 16:21:27 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] connman : Handle empty passphrase setting in
 wifi/tethering
To: Shailesh Rathod/LGSI GPOS Dev <shailesh.rathod@lge.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Cc: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
References: <SE1P216MB2647E4A28FE116C4D93FF7B5F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <SE1P216MB2647E4A28FE116C4D93FF7B5F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shailesh,

On 6/2/25 1:47 AM, Shailesh Rathod/LGSI GPOS Dev wrote:
> From: Shailesh Rathod<shailesh.rathod@lge.com>
> Date: Mon, 21 Apr 2025 18:38:01 +0900
> 
> Handle empty passphrase setting in wifi/tethering/setState
> 
> While setting WiFi tethering only cases for PSK enabled
> network was handled. Add case to allow empty password for Open SSID too
> For certain application enabling softap without PSK is required.

This patch (at least the whitespace) looks like it is being mangled by your mail 
server?  I can't apply it:

[denkenz@archdev connman]$ git am 
~/Downloads/connman-Handle-empty-passphrase-setting-in-wifi-tethering.patch
Applying: connman : Handle empty passphrase setting in wifi/tethering
error: corrupt patch at line 10

See for yourself here: 
https://patchwork.kernel.org/project/connman/patch/SE1P216MB2647E4A28FE116C4D93FF7B5F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM/

> 
> Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>

ConnMan doesn't use Signed-off-by tags, so please leave these out in the future.

> ---
>   src/technology.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/src/technology.c b/src/technology.c
> index 719c680..1bcd184 100644
> --- a/src/technology.c
> +++ b/src/technology.c
> @@ -1045,8 +1045,16 @@ static DBusMessage *set_property(DBusConnection *conn,
>          if (technology->type != CONNMAN_SERVICE_TYPE_WIFI)
>              return __connman_error_not_supported(msg);
> 
> -       err = __connman_service_check_passphrase(CONNMAN_SERVICE_SECURITY_PSK,
> -                           str);
> +       /* Allow empty passphrases for setting up an AP with open
> +        * security type */
> +       if (strlen(str) == 0) {
> +           g_free(technology->tethering_passphrase);
> +           technology->tethering_passphrase = NULL;
> +       }
> +       else

Please refer to the Linux Coding Style guidelines.  Should be '} else'

> +           err = __connman_service_check_passphrase(CONNMAN_SERVICE_SECURITY_PSK,
> +                           str);
> +
>          if (err < 0)

The compiler should complain here since err might not be initialized in all 
cases (in the strlen(str) == 0 case).

>              return __connman_error_passphrase_required(msg);
> 

Regards,
-Denis
