Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC013FC4
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:37:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0F635E3FE;
	Sun, 29 Aug 2021 21:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630265849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UBRuE8nXNfBweMMRzIhJuLhZ1irs1NpsLORnZQBKeYQ=;
	b=wrIugRdQfDh1rgKvHjOwhrdH0nmWcIcXC6Mqj2yrEsZ/xXiatClg37JiG/ZRab2tAZw5Rz
	DtT6cWWEP2frTx2oQ5nj07ggqVAukqKrscetDNk+V2j6y8ljBwzvrciPLiVv0T40FxjJO6
	pbrrGvNY/FW90KLOaw2xqGIVPtxp7ZZnqLBwiebPj1yRK+WEPPopq18+TXYFbsL55PDj/5
	9XatqxXlLYfhdljG23eN2wHQdrmaQQ49JBJRXj/qyUcqD2Aphf/02y+Y5NxvlAMJW46VBR
	ZOV3AExjSpwo8wzG682TLw+cANZ8tMoL5kCboJP1frzy8NpJvPoXo7nRp2iZjQ==
Date: Sun, 29 Aug 2021 21:37:29 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?0KHRgtGA0LDRhdC40ZrQsCDQoNCw0LTQuNGb?= <contact@strahinja.org>
Cc: connman <connman@lists.linux.dev>
Subject: Re: [PATCH] Respect EnableOnlineCheck globally
Message-ID: <20210829193729.txyzcqfavmyeaq2n@beryllium.lan>
References: <20210828171657.2qxolbym36hdiuhu@prancingpony>
 <20210828173427.7ctqrpj2w2ldrkla@prancingpony>
 <20210829175411.u7gfenrvleehvp7v@beryllium.lan>
 <20210829193230.rmpb6ks3ocim5c62@prancingpony>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210829193230.rmpb6ks3ocim5c62@prancingpony>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Aug 29, 2021 at 09:32:30PM +0200, Страхиња Радић wrote:
> On 21/08/29 07:54, Daniel Wagner wrote:
> > This was the only place I found where we call
> > __connman_service_wispr_start() without the EnableOnlineCheck test.
> 
> There's one more place, src/service.c:3728-3734 (set_property function).

Good catch! I think we should introduce a helper function for this
instead opqen coding the check 3 times.
