Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542F2CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 17:29:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 515795CD17;
	Sun, 19 Dec 2021 18:29:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1639934977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/csnl/J8ZozV0ZmPnM5dsQ2CUSMTUqTfFEqWfHg31Cw=;
	b=WkTIMpwBsekzGhzY1HJcMUCox4coEbhTSH2IuBYLeXLaNmORGFLFk4H6XHTbAPRTcxqA1A
	nbMDmFpd8SB8lJ9+CvDBQgqtiTns6ONLc3IMpXwccNdMQYAS0bmQhhLgk2Phvw0CvC7nF7
	bWfck7BDEVoMSREXJ1Cm+7LmYrUxqj3aQMNEk3ByiE7Nbcbh0Q+6DwWXNmD53kkIl3TsRK
	1XqnIcf1dvKqIEFPqgff3LcD5n1Q/mOry/VUqJar7E1rzz/BlewiNX/rqNwhdI/zCDNKvx
	ehWb3VvTvpEfOSzdqzySPgEkHhgQpUOwu+cUmTFmylQLpNXudIVuyPWqyipFDw==
From: Daniel Wagner <wagi@monom.org>
To: Michael Trimarchi <michael@amarulasolutions.com>,
	connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] Add ObjectManager interface to connman
Date: Sun, 19 Dec 2021 18:29:33 +0100
Message-Id: <163993495649.30269.6706559418970537083.b4-ty@monom.org>
In-Reply-To: <20211211135028.11355-1-michael@amarulasolutions.com>
References: <20211211135028.11355-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Sat, 11 Dec 2021 13:50:28 +0000, Michael Trimarchi wrote:
> ObjectManager let us to understand if the connman interface
> is up before use it. InterfacesAdded and InterfacesRemoved
> signals will then be emitted.
> 
> int main()
> {
>     auto connection = sdbus::createSystemBusConnection();
> 
> [...]

Applied, thanks!

[1/1] Add ObjectManager interface to connman
      commit: 8122063b3ccc62563f91a2cc04899baecf0d66fd

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
