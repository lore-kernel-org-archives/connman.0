Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3938C9
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 07:47:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 857595CD41;
	Mon,  7 Mar 2022 08:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646639271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+WZR+CTuw+JJmp8vlSuiGxQMQJ0AOqwlbSU9hciM9lk=;
	b=UI/rzrTVerSu70uAJchUQ//OQvpoSip25lsuMyVpnTbrXtFNeCKCzDtNPvw5INHehuZX0J
	oslnAuifP36WHBh6j6uZF4EbXY/SIxUDxTbItChWDKOlDWdNBXa2FPUmn9JZjw7aJIr3ca
	ZKlJbQH7DyVBK89FZEaYofCAKI8ufyq5lq95tt9ygphbMWBYhpNs4miiHyCP9ZgQ7rDo0E
	OATY5gB2IBXG+6K/TdsfWewxFFGfxecWPACY5WcpzcCNAb8FFmDyr0XQMEuSGTxfyNY50b
	BgYLr9W1DlwZ0+9vP8+8bXH6s45p00xtuAlyBpmYdX1MApVd7MGskT0S5t2QNw==
Date: Mon, 7 Mar 2022 08:47:49 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: request for feature
Message-ID: <20220307074525.qgd45mmbjgt4bru6@beryllium.lan>
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
 <20220304091104.g5lbeu55z4oubyej@beryllium.lan>
 <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
 <CAG17S_N34PXuAdcpMRKhNXo4Cmz89f8JaJa__GFEXrxO+FgsgQ@mail.gmail.com>
 <20220304154136.wmifwaqdergdqkjo@carbon.lan>
 <CAG17S_MqkGhwBxJsQDC0BhhOB2f3vQbjxo+mrdKGN-9FG6d41w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_MqkGhwBxJsQDC0BhhOB2f3vQbjxo+mrdKGN-9FG6d41w@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Mar 04, 2022 at 09:48:20PM -0600, KeithG wrote:
> # connmanctl scan wifi
> Error /net/connman/technology/wifi: Not supported

This might be some checks in the core which prevents the
scan.... debugging session ahead...
