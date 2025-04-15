Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6A20C492
	for <connman@lists.linux.dev>; Tue, 15 Apr 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733090; cv=none; b=IRERZ7mngpJB4ZjK6JZzOOSqbVxCVUFi+KATx1YqPIh9hPJyut2UAY4xiru3WCwWIOJeTDXkPBdCVNmBx1egBKanVwcz+JR4Mj9GBVsjPFXvX4cbpydEGY8B5qy7WFszCWL4cPLeJNSd3yc6/WPrcHhantXayIyq011IOBT7vR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733090; c=relaxed/simple;
	bh=PXwlzMwIrjBphs/sSXtx4q1yrzFgI0nZFgOPrsQu0Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFq/pvA6qKky8KqYdPKcBii2cW44tbyV7o5UpqglBwPq7yVTyrbgdskII8gHjTYWNy2bOfQ1zyiWvf49jzl93xPaebUo0DfbQ419ZGsQkIvGNWL40lVGwOQip4VI1yiIcX45yFTHjLnYgBWOtNlMT1IYd6bI8GWe+a4pBYPUDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGJjmF0V; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGJjmF0V"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c3b863b8eso3521178a34.2
        for <connman@lists.linux.dev>; Tue, 15 Apr 2025 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744733088; x=1745337888; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kn8RvvCjA0iY/rzXULJba+7sL8rfbnvwKqfbHB4S/Ew=;
        b=IGJjmF0VEQK+rRBDWOPhIWJ6QTuwh5PiDSkUSfdAAe0Qs9Gg1Ql8eaxxcf+1NbRQec
         MYR9Ol5z3AF+Iqtum41zJve/2P+pl3LcHYhaUE+4UXFfEcz85IU5T3rNz3fkZqBGMeYi
         MPd+2cAdvfqmwsoGDzYPSn04f7/ev4wi6SR6JCF9+J29OaXkojrLzG5XfQA0CDzB8hC3
         py5kv33JEbtP9CCD2KKOwsMAjk39VEH+61Ro0oSLGH6rwwU/VQjJyA2B7oK2hhYAww9J
         tW+jsROI0ihkJKSZcsr709f92jSJxrWCZ5cYT+aYPsGdOD/ZlaHwQlQ99+l8821a8OaN
         vDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744733088; x=1745337888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kn8RvvCjA0iY/rzXULJba+7sL8rfbnvwKqfbHB4S/Ew=;
        b=UbCVK1rB3X4RzmORMgey4mfsCbfDFrOkLoTgYBezNIFolMKLNZkf9PBdfpu7WuEawL
         mJcsXTmNLCGBmnPHxGPhuzC08USjxDU3jF0ObwwdtRVWXRSRGOdymtpGJJwhdwvW007M
         AE2jlTykWx8+62emO5ozLekEihibEQPI5V4y7goHtAUqdiFATQXz5nXtOFim3twRrR2d
         nibz6bCUWyDJKPauQRB4y8Zbnlo9FHSZo/oG4VeoWY+PvBkCB/CFMjyjmRGbOVoy5jsa
         2jXL32mxmHkahX7kzIbAVJ60Xo4aJCdT88XnRZvJzqcQSmgsqDRseN9FngJm5B3LD5z5
         m3Ng==
X-Gm-Message-State: AOJu0YyVIX3evUst0k99w+CtkuygXDZ198Fg1MgHXaeFu/D2y1SuMwhb
	+nTPeRLm5tb7UihsdIGu0hkFoAgZI7MnrpouWBAKYUWp4/D0pFzC
X-Gm-Gg: ASbGncviy4qMR257M9DQEIN29iWGfn+PXTBwog31l0YQVZM+5eq1E237ULKD1nGsCM7
	VgksskOxVJeqAQTyzijwuacu4lCHoEvmk5NDawDdXHPeqObDWFx0U6BUrlNVKRq1w0jbMjBqoMh
	TfHAItH7qpiVRpIaZZB7S/ZhAvIQrs3FMc3RTJgp+dl7t7mOl+YPr62SRz4IlekJrSao2/RXu79
	kf1Hv6TCqiUEAUM1McsiyhOveSA4Ok1blXQ6OVICXfn0W4BKosnLRQLryTM1BZxZfbBwdbmJUP2
	9GG9E4hEy7QAW3eD1QnqkvWNUsCWfKGdBhkL59TpKPQ9udVTK+QJRQ1E1WbaLk8AJrErCX44v6e
	9q/e4oQ==
X-Google-Smtp-Source: AGHT+IGN3BMhjgJaic+OAmdj+GsNSsz+4E/nFSNSoNBDw7NXIG0WGkuY2l6N0AgLDplWPe6+F+s/CA==
X-Received: by 2002:a05:6830:6787:b0:72b:a06b:dd71 with SMTP id 46e09a7af769-72e862e30c3mr10951177a34.5.1744733087967;
        Tue, 15 Apr 2025 09:04:47 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-72e73d715fesm2409485a34.27.2025.04.15.09.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 09:04:47 -0700 (PDT)
Message-ID: <3b1ccf02-2b2c-4229-8ad5-ae0d4c03ced2@gmail.com>
Date: Tue, 15 Apr 2025 11:04:46 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Add association state for VPNs
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Cc: connman@lists.linux.dev
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
 <00708344-6372-45AF-BA3E-AA45DC298373@gmail.com>
 <1f1eb2d9-87bb-4474-9b49-fa219310bca9@jolla.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1f1eb2d9-87bb-4474-9b49-fa219310bca9@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jussi,

 >
> Denis: The testing of WireGuard changes was done with these changes as well, 
> should I resend these patches? I'll try to find time today/tomorrow to check if 
> they still apply, and if not, I'll send v2.

If you've added/changed anything since the original submission, then go ahead 
and resend.

Regards,
-Denis
