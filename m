Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EA631595
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 68A74CECEB;
	Tue,  7 Nov 2023 16:06:08 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] config: Don't warn on `global` section when loading
 config
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20230916200115.956547-1-brainbomb@gmail.com>
Date: Tue, 7 Nov 2023 16:05:57 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <2600918A-1C4C-4E63-AE00-9431821FB3D7@holtmann.org>
References: <20230916200115.956547-1-brainbomb@gmail.com>
To: Marcus Nilsson <brainbomb@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Marcus,

> Since the `global` section is supported and already validated in
> load_config(), skip over it without issuing the warning about it being
> ignored.
> ---
> src/config.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied.

Regards

Marcel

