Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55189A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 06:47:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26C8D5DA02;
	Wed, 25 May 2022 08:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653461228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Iyjgo0JhvkHdDrU+QVcH7lXlzqPgHegKYyVStRoY22U=;
	b=uHPbrN17et683QNUx4chcZ6LDdiYK1KCmVZP2lt8FW5LK8b2PHlayw7dM0lxoAgyKBxaAi
	OXM30ka/OuH+b3L+oLS8nsInsXYJMXbEoR16IYyKdfCsiLfte9y3BD3+xU8aVx1u/GU90T
	3Yxf4yBeWAPFuDhwHnyjIfFu+BDYmAmVhSPTjVt+oiS7zVblKr2ygxJinK/yq2k9LONVoQ
	SOrpDdxWUt2qmG0+q+aYPyJfIJHnfgMycfLVp74PkfEYFTtg2728vGQ3tFZVSbq169Df73
	wi0NbnWATSNEwYLqW/j9FGIztTfLAbDF/1RnjesasXbKFXMAgeQwdsu99pnUig==
Date: Wed, 25 May 2022 08:47:07 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 02/12] dnsproxy: first bits of refactoring data types,
 global variables, simpler functions
Message-ID: <20220525064707.glbud26iqefugjiy@beryllium.lan>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
 <20220419103501.30553-3-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419103501.30553-3-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

> +	default:
> +		return false;
> +	case DNS_TYPE_A: /* IPv4 */
> +		cached_ip = entry->ipv4;
> +		other_ip = entry->ipv6;
> +		break;
>  
> -			/*
> -			 * We do not remove cache entry if there is still
> -			 * valid IPv6 entry found in the cache.
> -			 */
> -			if (!cache_check_is_valid(entry->ipv6, current_time) && !want_refresh) {
> -				g_hash_table_remove(cache, question);
> -				type = 0;
> -			}
> -		}
> +	case DNS_TYPE_AAAA: /* IPv6 */
> +		cached_ip = entry->ipv6;
> +		other_ip = entry->ipv4;
>  		break;

Please move the default to last position in the switch.

