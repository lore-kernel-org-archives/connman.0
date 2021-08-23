Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB23FC6
	for <connman@lists.linux.dev>; Mon, 23 Aug 2021 08:03:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7604960D89;
	Mon, 23 Aug 2021 10:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1629705785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3h3fVFzZuN+pnsCmWfRgFbdPkD5OwIMgvapHSK4ejKU=;
	b=lbQqtPE/K5b3h5SJfdot5qyn2cP0ZbOGBffZHRYStqyusudS8DxVn8GmL38Vz2xrdTCBUb
	J1M4l0we9zXiMPUg1VHbeg8+0YXpa8ZzGEeQPaWiJNH3yu+CYVLG45YnehMYkiJBXEnnrG
	ohmLr8+xHQLWGOdZxb8BDFHvbM1wNYdVa7HtjKjMLYOJL9Src0P23eeNQQpjN2PXfWwyZ4
	tJj0r4Hvo1boyR5j6cCrQXP66k/jyKXzYj71Fs8SMIMs/cdFw8ToxdnhxUvhksOauYnc14
	a8VqYKyRkImvQ5l8GvNBWgU965XNLld022Z+eilhIt75x7Nza0xwp0DJXmhAyw==
Date: Mon, 23 Aug 2021 10:03:04 +0200
From: Daniel Wagner <wagi@monom.org>
To: mds@gmx.at
Cc: connman@lists.linux.dev
Subject: Re: Status of connman in Debian
Message-ID: <20210823080304.ggegcggzalnc7v2g@carbon.lan>
References: <090f3e3b-0499-84e5-0e95-286ed160702e@gmx.at>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090f3e3b-0499-84e5-0e95-286ed160702e@gmx.at>
X-Last-TLS-Session-Version: TLSv1.3

Hi Robert,

On Sat, Aug 21, 2021 at 01:21:22PM +0200, mds@gmx.at wrote:
> I really like connamn, but I also really like Debian and connman in Debian is rather outdated.
> Are there any plans to future support connman in Debian, or will it slowly die in Debian?

Sad to hear this. Well, someone needs to step up and take care of the
packaging in Debian. I don't think it is a lot of work (slow release
cadence and bug reports tend to hit upstream anyway). Please if you care
and have the know how to update Debian packages give it a go. I would
really appreciate it.

Daniel
