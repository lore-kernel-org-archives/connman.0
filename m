Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC515443A
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 15:42:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC80A5E024;
	Sun, 28 Aug 2022 17:42:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661701349; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=skJwOFrjQPrvLyKgi1Uoj4+XbmZ5nsvV06XdWolT7nk=;
	b=f+tVJra2GucikVg+VH+N8rXJGt7PbUgabhXnHiaz1DQLRRlX8p1UWIqbFcR1vz1UWK27By
	J1OQd+etasJOngJnm7H98ZRFlapEvbVfLIXpqmLdsnTR2iGDitbXA0JoA8Toh8HtTwNQSO
	55V0U59bZjSLt46PtEhkuxOlxEEAqz3tBBSvW6eBOTGkpUD3ORGt1qOcuH5bee+3W98G65
	hQghC7iHTrXbL1ub1tBhyxcCqwE28lIdqYEXa1DjXDpwpjRlEmsd60iobI+M4ywwsF9eG/
	IL6LAvYpED99spkfW6j/ytCmCNz2JHAngqTaLGQak6cJxdHDrD0FmX2dNAEPtQ==
Date: Sun, 28 Aug 2022 17:42:29 +0200
From: Daniel Wagner <wagi@monom.org>
To: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Cc: connman@lists.linux.dev
Subject: Re: connman HEAD regression
Message-ID: <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 28, 2022 at 04:55:35PM +0200, i.Dark_Templar wrote:
> Unfortunately this patch didn't fix issue for me.

Thanks for the quick test. Could you provide me the debug logs from
ConnMan?
