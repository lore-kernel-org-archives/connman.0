Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586FC7C
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 15:41:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC7AC5CD07;
	Fri,  4 Mar 2022 16:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646408497; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=VKQauW2Rkbyfx+xE3L1VVXRCiqUB1cbAb7KMLTTECAA=;
	b=w829dcSxfdEe9XVkrV2gLcM4Zmifjgxwtk8t4AcxLZTGEcOw8iZNfasdBHIoGj6pPE1wVH
	ng0tiGDH+8uqElEOPZsmoeWRDvzQx5zkulQdzkt/kk26OFsWqG/LfsHL9jj9aRDk++b3kk
	BG5XLkif+ILDGh+v40t85EDtAkDLqEgA8kBCbiTrNo9A5KWZZqlfqk+Z2w2BWOBleiIK5a
	A6Yo5Xp16laEj0MjJCwi+SWsW0JEExlFE2gRW+EyKKqgJZg4+qle1d3ExRPPOtmpizsuIO
	f7xNftbFhZ8pCSaYcYGZ67pDMULaDVebZUqtnNXrbZY0yoYuWubGu0/9MBxeag==
Date: Fri, 4 Mar 2022 16:41:36 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: request for feature
Message-ID: <20220304154136.wmifwaqdergdqkjo@carbon.lan>
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
 <20220304091104.g5lbeu55z4oubyej@beryllium.lan>
 <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
 <CAG17S_N34PXuAdcpMRKhNXo4Cmz89f8JaJa__GFEXrxO+FgsgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_N34PXuAdcpMRKhNXo4Cmz89f8JaJa__GFEXrxO+FgsgQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Mar 04, 2022 at 09:22:29AM -0600, KeithG wrote:
> Made those 2 edits, built a package and will test it tonight.

I'll try to give it a go as well.
