Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B097B
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 08:24:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8394B5D33B;
	Mon, 21 Feb 2022 09:24:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645431884; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=D1qAIRjG5qAwLN+Brg9O57sXW3q99xXw3Kue+uEcTRw=;
	b=I0ofzZpHhSt6J1/s9RQfBk6ayePgsn4IGTHZ4Nf1CcO/Up9Kme2n0zCGH2AeMp49krWblN
	FlF15ImdDofqiMDMNeX4NkJI60Q/DVEHiyUi779wkFcCOLHdEesnxVpGoBaYm0+NzotL8q
	e9zNmfHDa/FnCQPOtl7mYJlF/U+dvt9TpC73gSf5pjBr68vvlQF1ccZZWw7hBi4KWcgAKA
	xdgjuCPVzjjZ9YvSFTIYd+9RZx4bRbKf+ZJzgx4ba5F0I+JK68NhkqWMPnbG6e6GToX7bD
	466B0aWiA0/h49cjOqIArC3+hALS06jybqCmQvoCX8lm1+VqSnaizi4WU0rPVQ==
Date: Mon, 21 Feb 2022 09:24:44 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH v2] iwd: Use same signal strength calculation as
 wpa_supplicant
Message-ID: <20220221082444.54hdra5mnkpjkmb3@beryllium.lan>
References: <20220215101940.598839-1-net147@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215101940.598839-1-net147@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On Tue, Feb 15, 2022 at 09:19:40PM +1100, Jonathan Liu wrote:
> Fixes the signal strength reported by connman being lower when using iwd
> compared to wpa_supplicant.
> 
> In the wifi plugin for wpa_supplicant, the signal strength is calculated
> as follows:
> strength = 120 + g_supplicant_network_get_signal(supplicant_network);
> if (strength > 100)
>     strength = 100;
> 
> The g_supplicant_network_get_signal() function returns the signal
> strength in dBm. This means the signal strength calculation in connman
> for wpa_supplicant treats -20 dBm or higher as 100% signal strength.
> 
> The iwd plugin is changed to use the same calculation but as iwd returns
> returns the signal strength as 100 * dBm, it needs to be divided by 100
> to get the same dBm value as wpa_supplicant.

Patch applied.

Thanks,
Daniel
