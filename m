Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55134A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 17:18:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B0555D404;
	Sun, 27 Feb 2022 18:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645982299; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TQA5h82QsOi57ogO5bmFEgCwTX5GDPI+orTG5VLIOiE=;
	b=o0KAeiPsDfDHeSealST84ceHZzQEdM6pRIa/jFo8Qg8koLmdYxAIvo1xcmKl64u9Qo0w9i
	gp4CH/hK9rCsk75mzKrz3EOkUicAo3CcGFijSKIW+uF5ro2fMR+TgBDM8iQhkR55GECZQB
	rjyQSoNcZr0nA71+sXG/6usIdv9wGlGsRrjCTZ5nrfzffIC7Ie9YzNXjwTGNppEfiuL1wO
	jAdyTT4JOnG0Fdzbpsvhs014V6Bgi9kBXcMDi23bpadKxElccWDzc+azrit5y5QM5jAmYL
	e7JuwOAqyXb9Neb+Aq3H+kcKjQzyim5g3l9zXdRyPMX10G84YFE2QQLTyLPOtg==
From: Daniel Wagner <wagi@monom.org>
To: Daniel Wagner <wagi@monom.org>,
	connman@lists.linux.dev
Cc: daniel antoine <univac55@gmail.com>
Subject: Re: [PATCH] main: Set default online check URL also when no config provided
Date: Sun, 27 Feb 2022 18:18:17 +0100
Message-Id: <164598228862.1233.12680005743478517305.b4-ty@monom.org>
In-Reply-To: <20220227171549.32664-1-wagi@monom.org>
References: <20220227171549.32664-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 27 Feb 2022 18:15:49 +0100, Daniel Wagner wrote:
> We need to set the default URL also when no config exist.
> 
> Reported by: Daniel Antoine <univac55@gmail.com>
> 
> 

Applied, thanks!

[1/1] main: Set default online check URL also when no config provided
      commit: d48584aa8bed06f9b728579ea64deb8d30b03b86

Best regards,
-- 
Daniel Wagner <wagi@monom.org>
