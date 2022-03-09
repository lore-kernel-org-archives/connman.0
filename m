Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E615BD
	for <connman@lists.linux.dev>; Wed,  9 Mar 2022 07:48:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2803B5CD01;
	Wed,  9 Mar 2022 08:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646812119; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oiqUIKueFp67wCVeZkOl4iHppyoRNIv/MV50RMzTiEo=;
	b=fj7abbrBxseWM1Tn+vGTN9qo2RpanjNBkhljVUz3J44qO36RqdXeX8S+tkX5UjlnXVm2Zq
	/JJv0xaGmHI9/FAmkvDXjNpIVssINci1MbW4UkLZSq+1ljVgypul8M68uZx3MDQjYec6aa
	oUwxI7IYAnppbWRVZ3fdPf9n+Gr+y0YYXuoo1V1s+WyRWRNRyThMepV8a5tKAV3vPrC8yV
	yegMpHrmNhEYWUliUwqpp5/VmfG8PXV1FvibaVBUQYZaW88Q6SfGWkkARKTcpoorZjKlFa
	0VcffQ6WfJksfadGD58GRLj+I5AX8F1r0Gfp+cFH2KuDt2lxR5Xmfi1MOGkwwA==
Date: Wed, 9 Mar 2022 08:48:38 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] iwd: Add scan support in access point mode
Message-ID: <20220309074838.jbshxixcues4bqxx@carbon.lan>
References: <20220307090321.27204-1-wagi@monom.org>
 <CAG17S_MqNzp1n8qHmWkLS918uSUYdEqWS-CHrHMg6uC0Xr-auw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_MqNzp1n8qHmWkLS918uSUYdEqWS-CHrHMg6uC0Xr-auw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Mar 08, 2022 at 04:37:47PM -0600, KeithG wrote:
> I tried this patch and still do not get the Pi to scan from connman. I
> get this error after I first made sure that iwd was connected and
> could scan for networks.
> 
> # connmanctl scan wifi

I am pretty confident this works, so it's likely a configuration issue.

> Error /net/connman/technology/wifi: Did not receive a reply. Possible
> causes include: the remote application did not send a reply, the
> message bus security policy blocked the reply, the reply timeout
> expired, or the network connection was broken.

If you enable the log for the iwd plugin you should see that the scan is
triggered. Maybe no response was received, D-Bus policy?
