Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4628EF
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:40:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D682DB00F;
	Tue, 11 Apr 2023 09:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198853; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/hvMBHBVF0PmbGDPpBuWg1oJ0IiwMq/mBvgCkNKkBL8=;
	b=hTcymdpxhBUZSgehxnhCH8MVmP819MAMRjh1iy5O9e9j0sUk+eScbujNyt+NnkbYFg8TUS
	2TRJ+zNEXC678//77/o6LETaa7c/YdTQKF6nBiwfBdWLUBpiBlUrLAsacsXhda5lcCcoZR
	g2PA08gjHU5rh88lFrhv+2+wWa8O14jwAur5kHRy1PeJ862DeED+oQUonrZ7hNoJHUbwFO
	b7/Pk4/5By5MDO0J5GRYaXbzNMROasGwCO+nYE8RHmEGWuWLe2hzP4PkUWVRA7XCkH4pUY
	n1aoXseZ3cLuRYLFH2Zcr94kMVPE7P0VMjsRucYz3mQTXJRKivl1Ocs5KmaAQw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Jonathan Liu <net147@gmail.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] ntp: Fix timeserver typo in warning when ntp_data is not NULL
Date: Tue, 11 Apr 2023 09:40:50 +0200
Message-Id: <168119884409.12976.12791747631118233803.b4-ty@monom.org>
In-Reply-To: <20230401235111.107463-1-net147@gmail.com>
References: <20230401235111.107463-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On Sun, 02 Apr 2023 09:51:11 +1000, Jonathan Liu wrote:
> The value of the timeserver variable is incorrectly referred to
> as timerserver. Change it to timeserver to be consistent.
> 

Applied, thanks!

[1/1] ntp: Fix timeserver typo in warning when ntp_data is not NULL
      commit: 219232eaa63aaf750843856c2895ff1fe9479473

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
