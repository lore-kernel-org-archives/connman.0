Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795E2C82
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 07:03:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E5C55E306
	for <connman@lists.linux.dev>; Fri, 15 Oct 2021 09:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634281395;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=gISx5/W0hTNO/KKyRlvWs1lYIW9PacZdi9EQCC0TF7A=;
	b=gBQnZXA9qxApSJXFxfIdSY8Aphp8vDtc6p5Uzi9+zsknVG+3QNFF8MS3DIW3UWiSgyZdKQ
	z8FgSmYo8eMwh6dB6WAcDUv5bV1k/UsTOvg1sVp1o/Vg5kelJynNNazC/a7UaH6ESBBvFU
	cR2QNCdYlhABs8IxFdwflu7hESZE0qCKWk6aNbVtqr2biwoxYNXihNIYtCK76nbT3ay3wE
	pFoG3K5eNVaqJc1kRjAuQB/XWHfMW/r2AD1/5L6aNylX80U3IGAL0yL17sSN5NiFX3cu6L
	6PLUoMczOtGOtBieyr8f1CjsYU5iohPFte88nP+u0tLUDArvDLzGmqW52uhPbA==
Date: Fri, 15 Oct 2021 09:03:14 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH v1 0/3] Fixup clang error messages
Message-ID: <20211015070314.zwyr5vvlpiu6ihp7@beryllium.lan>
References: <20211012070648.28947-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012070648.28947-1-wagi@monom.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Oct 12, 2021 at 09:06:45AM +0200, Daniel Wagner wrote:
> Based on Emmanuel's patches[1] I tried to get clang to compile
> ConnMan.  -Wcast-align seems a bit too much for clang so I disabled it
> for clang.  The rest are couple of fallouts. Nothing serious. Though I
> was not able to reproduce the maybe-unitialized warnings.

Patches applied
