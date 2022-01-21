Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6929CA
	for <connman@lists.linux.dev>; Fri, 21 Jan 2022 07:47:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 084D55CFAA;
	Fri, 21 Jan 2022 08:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1642751261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gv1YAxrz+Cj4KIXkhgk0hhHf3GKdFPjEVoee5b3a0GQ=;
	b=eyJEZeUzM40lDg3GidMvUOpPbc/gwRVzrJcc9WrejrZgBa4C6myQHozhZP6W3qNffL6Sml
	BmJntJRccqi4zqBrlgMv9B6XbEL/5n6cgbUjwoOX8TsIKp9sRMpE6D3g1Wwqcbnqrl9shN
	eHqLqy7rmU22ITdaFdUFFcvnnIi08siT4hQMJUEIX48KsICAzs/5VFyPXtug9rMTj5mre2
	KRcjS1hDwNEcZNq6y/TDfMccitbPtVj0PL9lzje3+ff0K0z4BI6rjHSGkJoOLy1U+G3dSI
	Zcf152MrqkT6RC+NlpdBYgl06ZKt5djnwfm1kVw3sWpxjcNA2KSh+AnPdPuDEg==
Date: Fri, 21 Jan 2022 08:47:40 +0100
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] iwd: Always disconnect connection completely
Message-ID: <20220121074740.axzlpaj55xtzeg5s@beryllium.lan>
References: <20220119133927.1245607-1-Emmanuel.VAUTRIN@cpexterne.org>
 <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB15449D2CB5CB2656550C629A93599@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Jan 19, 2022 at 01:43:34PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Before being able to connect to a new network, finish disconnecting
> the old connection. The network can change while the
> cm_network_disconnect_cb is scheduled.
> 
> Commit 024309a9e04a ("wifi: Reset disconnecting status of any network")
> Commit 795883e98eba ("wifi: Check valid network in disconnect callback")
> Commit dd86f09107e8 ("wifi: Always disconnect connection completely")

plugins/iwd.c:254:6: error: no previous declaration for ‘abort_pending_network’ [-Werror=missing-declarations]
  254 | void abort_pending_network(struct iwd_device *iwdd,
      |      ^~~~~~~~~~~~~~~~~~~~~
