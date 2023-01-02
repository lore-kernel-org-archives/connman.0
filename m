Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34F7C
	for <connman@lists.linux.dev>; Mon,  2 Jan 2023 08:46:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D60ADB121;
	Mon,  2 Jan 2023 09:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1672649196; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RCvebn3IVJJttdncRhEDFemAoWsn0UkCZe3a3E+gQQo=;
	b=DfbCWTtx3H+DTV+AInTkgq6kxetKf+LHQcjIAkM61jZ/KEOBN6dCx1nkDbskLIs/kHdJMo
	fqiaj3FgwmKIUjqss8MupHacSH9PL707INLAYZjK6dr04WLQUWOElbvklrJE+IuaoNS7lo
	PHVBX94ed7acpB+iz00mPMgkHGZqbGcNignkJ4Kz/MGimzWscrC1PCJ0aHxZkytRMI6zDc
	mXQF78h7G1FXHaXsCfvOgRlxjpva0BTvGTRPhB0bC6xyWDfi2+2RKMrEXDCGM/pXaFsj9U
	/ffS5wfFBaBWhJcv0qa3I4CiLv53GGa6fsYoNyWgjR+EVTzFugFt8uPKpcQxGw==
Date: Mon, 2 Jan 2023 09:46:35 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: Connman Request for feature
Message-ID: <20230102084635.74a7xgmwmvbxiodn@beryllium.lan>
References: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG17S_N_+HCCRVcOaExzCfV2N8VL4r6gvOSwhk6Aa21PavsWaQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, Dec 28, 2022 at 07:52:06AM -0600, KeithG wrote:
> Would it be possible to allow connman to scan for wifi networks when
> iwd has been put in ap mode?

As far I can tell, the only thing which prevents the call to iwd to do a scan
is:

static int cm_device_scan(struct connman_device *device,
				struct connman_device_scan_params *params)
{
	struct iwd_device *iwdd = connman_device_get_data(device);
	struct iwd_station *iwds;

	if (strcmp(iwdd->mode, "station"))
		return -EINVAL;

You could drop the test in which mode the device is in and ConnMan
should forward the scan request.
