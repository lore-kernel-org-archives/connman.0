Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA03FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 07:03:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7B975E30A;
	Mon,  4 Oct 2021 09:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633330996; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WT3zhy+p/+5jpTlt2TwuLoVTNCrQiJMZ/HihLpTfrZ8=;
	b=wo/vxpiBOtszPp3VmAqIDFpI4xNFAnnuuFSc32hCox1wgk3QxQYMebiwq5EHTgXmY+HGDZ
	Yqu2soZdGlTGl94Jn74P8awK5mFjG2ylKhcEw3F3QrpxcIkvyB6UOiCDWGwU46w2X6ZxsD
	mPCOzmZ6O9Bitra/9fwEgt92WpmzQflMcPgLV1f5f4jtUIjvSHRWO7m9PJe/0d2a1+T7Gu
	+27ZWJGjg++GT/DBkqGq89Y1vcBIKu+C3xrwxJHq4kCoObnYPrG75jdCl1C+hESm1Xjap8
	MvMQyyEuSF17co9iczI+fkQ4qUbkEsh30Y+vU3XwUrWAAa5i06f7Po7NS5BBqA==
Date: Mon, 4 Oct 2021 09:03:14 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH 2/3] iwd: Connection of hidden networks
Message-ID: <20211004070314.ehj6a5wjkhexu4xb@beryllium.lan>
References: <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB1544676D5E67A464DCECB27493AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

Hi Emmanuel,

On Fri, Oct 01, 2021 at 03:27:06PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Implementation of hidden networks connection.
> +static void update_signal_strength(struct iwd_station *iwds);
> +static void cm_hidden_network_connect_cb(DBusMessage *message, void *user_data)
> +{
> +	struct hidden_params *hidden = user_data;
> +	struct iwd_network *iwdn = NULL;
> +	struct iwd_station *iwds;
> +	const char *dbus_error;
> +
> +	if (!hidden)
> +		return;
> +
> +	iwds = g_hash_table_lookup(stations, hidden->station_path);
> +	if (!iwds)
> +		return;
> +
> +	iwds->hidden = NULL;

I assume iwds->hidden is supposed to NULL, right? If it's not there is
bug? If this is the case it might be better to add a check and
warn/error.

I skimmed through the rest of the patch. Most looks straight forward,
but I have to say the hidden network feature always screws up the code
base. Thought this is not your fault, it's the stupid spec.

Thanks,
Daniel

