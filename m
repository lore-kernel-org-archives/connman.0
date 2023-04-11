Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AB2F2D
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:40:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0518DE3E3;
	Tue, 11 Apr 2023 09:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198856; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y7JzcDR2Xks5+xDlwmjPH/6p53DXdQPZ4HU9XDBMFvg=;
	b=UdmBrH1LGG0UHSuahfAqeSozbraL3R6BqYbbuR+8I/RYG5nn65pFAJA470Ly5Uul2h3O3A
	Ay9zaNzfR6I0QkCPizcN39A8extbVlXOeUwToiMFarAtvMqyQNs0Hu53IZq21troe9l4fc
	dQy8zgx92YuBH7DZTqXMTKjjlPYAqjniiyyvYMfGbaC1vtSr+Sxo5BZlYoiX+nl9hsaUcH
	ceVF3FrpH5jNgb8Q/l4pZqhp24y2BocFVXVebZM8M5RUD0D4tQCclEdWCmJontgjAbuG3S
	iS4QmylYKnVQm6NP0moGus9gopm9CVgELHhvCYpucGTF5hc0gU8fCEXetRigdg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev,
	"Oskar Roesler (bionade24)" <o.roesler@oscloud.info>
Cc: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] doc: Update connman(8) manpage on the --nodnsproxy option.
Date: Tue, 11 Apr 2023 09:40:52 +0200
Message-Id: <168119884408.12976.12407544431007926371.b4-ty@monom.org>
In-Reply-To: <20230221002009.253059-1-o.roesler@oscloud.info>
References: <20230221002009.253059-1-o.roesler@oscloud.info>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3


On Tue, 21 Feb 2023 01:20:10 +0100, Oskar Roesler (bionade24) wrote:
> The --nodnsproxy option documentation left out that ConnMan will fall
> back to creating a resolv.conf on startup. This gets fixed by this.
> 

Applied, thanks!

[1/1] doc: Update connman(8) manpage on the --nodnsproxy option.
      commit: 9cf2cc3844e486a81c5c118de4bcbde3489e097a

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
