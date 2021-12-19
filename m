Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058112CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:49:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA53A5CDA0;
	Sun, 19 Dec 2021 18:49:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639936144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O/eCCIBVlCUTezXPvG25r27wioAqTPyYGDR/iOcLqL0=;
	b=YrIblvgfDchhVe/9naOGkoq5pR5TVYFPcs4892MQQbn+YAUSJSYMIEoR+oAHbX7Fir4LXH
	pkc3PkxG6ETsjX9sebfh0OHlCVkCIGPu9ajiduOoCqGIrK5gLbUduf5jGlTgBBlqwE7lrv
	6Eqr1Q1BOwebH1fy2YBpcVpSeDpoS1AFO9ekP8biWsG/eapyNDhOXlx84w0G7MKD7+sMH1
	C5VK1zkaNtWOqAQ9S5EiXL32WpGIaqgdbqZYtCBLgzJoDfOA8jqsasvugcTOAZyQVA/0Bh
	gdrIzMeshEmG+927eTdt9HSPq6Lo8XuutxBOjckmH/D6Eo/PNbnweupknxEUVg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	Christian Taedcke <christian.taedcke@lemonbeat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] ipconfig: Do not enable/disable ipv6 for all ifs
Date: Sun, 19 Dec 2021 18:49:02 +0100
Message-Id: <163993613448.32043.4737927088344398634.b4-ty@monom.org>
In-Reply-To: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
References: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 22 Nov 2021 14:03:46 +0100, Christian Taedcke wrote:
> If the interface name could not be determined (e.g. because the usb
> device was unplugged and removed from the system), do not disable ipv6
> for all devices.
> 

Applied, thanks!

[1/1] ipconfig: Do not enable/disable ipv6 for all ifs
      commit: 53732ed09689736e6a06c48cfc0435a1e3eb1aa2

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
