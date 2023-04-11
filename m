Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A128EF
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 07:39:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90C81DB195;
	Tue, 11 Apr 2023 09:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681198778; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=G1WhvpN4Pmw8CUCHfARF/eKv4O4pOn6JNA5yXBfFjBk=;
	b=EgYQDT+HEDM2hlvXQC8Ice1GR4Yu3IBMfcLccSv4daRa1M0nKiQQCB85ID5NpeWdBfICxz
	BrdcFWmR2jINfPJ4eoyTSbEZpngi42BJA6b99Rvy6e9gpGi30b7QCQQE+7GuR0Ok97ACQE
	oaQJtqiw4L/KOGIailhHK0/PEsKOtM0sGJ1pY7Q9i/aYmQFzRkhL972xzCGb1Ldiuvh4uF
	Qa3msGLGeGm3Jj2vCrvioMWL1/l9NcWjMX0fFfScTm+rCaAWlytZtc+619qy9MV7jvt8M1
	UZWIbXxE0P+CgvabllZKmggJyi+6OvrgMHE5FJnZDow40YxflPMPiHQUHMwLIA==
Date: Tue, 11 Apr 2023 09:39:37 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] timeserver: Purge timeserver list after reset
Message-ID: <20230411073937.6zjfhwohybrjw2ix@beryllium.lan>
References: <MRZP264MB15443305B59D37C1180795F993929@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB15443305B59D37C1180795F993929@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Apr 03, 2023 at 03:02:18PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> When reset, the timeserver list needs to be purged from whole
> timesever history, in order to only contain the up-to-date values.

Patch applied.

Thanks,
Daniel
