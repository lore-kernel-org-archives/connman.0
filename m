Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BD72
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 17:37:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09C0860B92;
	Mon, 30 Aug 2021 19:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630345030; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KOwByEUTKsH03Epi9V1efyfRYyadzkk5KDwjLQV4A4o=;
	b=AqToNm8x2W3hY0ePgfUrGzGW/+FRpoEHTFvnSoYPAAEP6di6QcSl0tI3pHZSnB1qyHe/8p
	OHP5plk25k1YQD5Hl7Ya445fGTofL+e7JzSyKwnwGotd3uKk9MUIzZI1sPZW61dQooVoIF
	1TgfI7tw+fTjCQLuEjtY+lkQMapqSfbg6H0SPegy1/N74rFbKqDd5NIL1I+7Y3Xd5nCgQn
	vYT01/ONo+AxXTbKHfJfvkNBLDYXXs5iSZbMteDVGFaZ4DICdrABkDvjrYup/HDhqqf7AJ
	H3kAKKW8vhG3gQeepDCnHBvwzh2SlwV4+z8ZkcjvlbhBNQzK17QZUtgIiIKg6Q==
Date: Mon, 30 Aug 2021 19:37:08 +0200
From: Daniel Wagner <wagi@monom.org>
To: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] make possible to use alternative auth group with 2nd
 password
Message-ID: <20210830173708.2stx3xqeolx6bhk6@beryllium.lan>
References: <1666033.JRX4bv1jlI@latitudemachine>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1666033.JRX4bv1jlI@latitudemachine>
X-Last-TLS-Session-Version: TLSv1.3

Hi Lukáš,

On Wed, Aug 04, 2021 at 06:39:39PM +0200, Lukáš Karas wrote:
> Some servers are configured with multiple authentication groups.
> OpenConnect request just authentication entries that are valid
> for specific group (process_auth_form method). So, authentication
> group have to setup first, and new form have to be requested then.
> 
> Some authentication groups may require secondary password.
> For example one-time password from Google Authenticator app.

I've updated the patch slightly (whitespace fixes, reordering,
indention, etc) and applied it. Nothing terrible dangerous.

Could you also send a patch updating the documentation?

  doc/vpn-agent-api.txt

Thanks,
Daniel
