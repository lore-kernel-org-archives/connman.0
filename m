Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B58A33
	for <connman@lists.linux.dev>; Fri,  4 Mar 2022 09:13:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E22615D4B1;
	Fri,  4 Mar 2022 10:13:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1646385181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7AZULs3voyCtJ4uUjZtSl98uYj4icVS3Yx5hAB816lA=;
	b=MGUnNbau2S4JYuJfYNBHrcVyx52OA/3E7PBUFiaNiGkM7maUqSJj9M0Tk/GiiBCKhHOUOP
	pVXXiAMBG+ArK7DaD+TEjRTe42xyWLLsCh6+l82sKsEitE97+Yr1fYpabnalXYI3blVfYT
	E3SGNIUqcGdQRjFJsfeyUCjdNqgPU2htRb/X2WJyW8IaxC7bVfeamxteEamTzav7WqCnPV
	4wqthyM4nQ8KXCSOmfnYxwU2wVCGF5mHFajkKheAigRrl0SSidALPZA2hUnyEDxSThrk8e
	4fDHICtjy21EynobjcrDNCeGZYBNvxukyzgMNyaTYgswTdt1/lBoCd7tIJdpIQ==
Date: Fri, 4 Mar 2022 10:13:00 +0100
From: Daniel Wagner <wagi@monom.org>
To: KeithG <ys3al35l@gmail.com>
Cc: connman@lists.linux.dev
Subject: Re: request for feature
Message-ID: <20220304091300.y3a5cu7xqupinwx6@beryllium.lan>
References: <CAG17S_M09AOTXMaQBeRVBofUVrh211n+ti8PTVhOY48X9s5U2Q@mail.gmail.com>
 <20220304091104.g5lbeu55z4oubyej@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304091104.g5lbeu55z4oubyej@beryllium.lan>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Mar 04, 2022 at 10:11:07AM +0100, Daniel Wagner wrote:
>  static int cm_device_scan(struct connman_device *device,
>  				struct connman_device_scan_params *params)
>  {
>  	struct iwd_device *iwdd = connman_device_get_data(device);
> -	struct iwd_station *iwds;
>  
> -	if (strcmp(iwdd->mode, "station"))
> -		return -EINVAL;
> +	if (strcmp(iwdd->mode, "station")) {

obviously !strcmp()

> +		struct iwd_station *iwds;
>  
> -	iwds = g_hash_table_lookup(stations, iwdd->path);
> -	if (!iwds)
> -		return -EIO;
> +		iwds =	g_hash_table_lookup(stations, iwdd->path);
> +		if (!iwds)
> +			return -EIO;
>  
> -	if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
> -			NULL, cm_device_scan_cb, g_strdup(iwds->path), g_free))
> -		return -EIO;
> +		if (!g_dbus_proxy_method_call(iwds->proxy, "Scan",
> +				NULL, cm_device_scan_station_cb,
> +				g_strdup(iwds->path), g_free))
> +			return -EIO;
> +	} else if (strcmp(iwdd->mode, "AP")) {

and here too

> +		struct iwd_ap *iwdap;
> +
> +		iwdap = g_hash_table_lookup(access_points, iwdd->path);
> +		if (!iwdap)
> +			return -EIO;
> +
> +		if (!g_dbus_proxy_method_call(iwdap->proxy, "Scan",
> +				NULL, cm_device_scan_ap_cb,
> +				g_strdup(iwdap->path), g_free))
> +			return -EIO;
> +	} else {
> +		return -EINVAL;
> +	}
>  
>  	return -EINPROGRESS;
>  }
