Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01E204587
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912930; cv=none; b=HG8w+ExouZhOtXdncU9eiI40tNWJ1FJR2Wj29IwjOgL+Drm1kTHPkZ2nQlrrkR9W9pdokK2nX3tSGNNRqzF/hiAnYGqm74adW8H487mXugl8Uykann0M6reRes/4+EAwbsS4ZNs5jF7fwrx60gKWeZ/pkDNwBJwOh8hSiON+1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912930; c=relaxed/simple;
	bh=yQmWcIF+IlagOu1/YCnqUhNYngtyXGT1VtDkAm4dqOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uy8YZk/iIERdc9X1KUIAt4/x6XOPb65ciq2YtcpO89KboQi9P1vOCwAoEBDPHFiBsdyvzZilgHw9L5cLYiGxfrbTdmqvgbmuS8iPVSNgiz4Y4sXO301YPKJp82KNY/YBTtSDPeeEkeA77Jy4TukLZvQcdw+1rfBw2MmnLgT1eGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNP4iRqM; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNP4iRqM"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f9a7cbc8f1so1690524b6e.0
        for <connman@lists.linux.dev>; Tue, 25 Mar 2025 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912928; x=1743517728; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPENZhfzGfAUSCZESjC774rzC7ib3E5EjNto7u0H36s=;
        b=CNP4iRqMzMaTSUNxGIcDKN9F//EfbvEMPgVUc2o5+XTnpd3zK9PLBL+RCxyEmyI138
         hkQ9QVtfttGMihPISBSEWAKTaZQKlPrmaMrw5DGUyQY+FLFNKU/DMDXlKLNTSuXNXhDX
         YpAHLWq7sKpBZOuWh4oye/fFWJHz43SSCHWQN64LxS6nI8K2vn+5wS/vvauHjVP0Jx6f
         HB0NxI1AMFara9Gc8ukH4n8re4uH6QsJjRUgSdUR6W9Tgza7/KOGyBTwt5IGbr9bjNgf
         lkRVYnf4JuHfXQPNchkMOr5bP4yWnIERyL+mn44jFgzlmNLoirPu1IABX0cQkoKJq7aQ
         DgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912928; x=1743517728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPENZhfzGfAUSCZESjC774rzC7ib3E5EjNto7u0H36s=;
        b=RQMBdeZyVTESWRn0jKjqf5foCVpQD5i3+mArLekpxMgp1bm32hX9bSakfCHM95QlnA
         ICx/WFBSEN+1ssoc02FC1nb0YpsET24NiKtgcD/vbNpKGSUFPoqwWOpmpaRilPliUiPi
         atraOGk/JKz/qhH25JN/I3bTQETvXrkwcSXkbIWzWAWXzBnioa4iq01zlQjdsMDV6mtF
         xjXeHLYGEsVc4aVMGZGxAI711mn/hYsjZZhcvgrmwSlwq7qj9abCjijjtAT7NOy1UooY
         RtXPOMiwZElTvqiGqcOWaipbEvAlBP3l26h07fUuUaYrfRSNm8F5m7f4FMT3uu6P+3+7
         ODJw==
X-Forwarded-Encrypted: i=1; AJvYcCV6qO6CxikdWlW4TLwDKUbQeJGnPkpXazvF0yhC3lG7Ygwfd6DIYlcItPV0bHrXlKMov4qD2Eat@lists.linux.dev
X-Gm-Message-State: AOJu0YyyqTyFOUU5yq+ZB/lX3Bi+TvMT/2l+gjQPmhmtSZR0chhbZ/+8
	pqMpSq86gAzYA3K2Gm87XdVMuZSgodOvLW4C10z98T6zRnvGjN1A
X-Gm-Gg: ASbGnctvZ8iYYwRS48nhN+x/VvQ3i7J1RmGbridqbJ12iUckWukqud8HFD9BTjaSvp+
	2buQNeeRizOhbY/PoZUMmox/5AcOTvdEQ76fuSmvsRpRgHVoiGaX9MvQXhnR8mTsvrj+HdeKb/W
	6ZZidOSKmXVguUHEt8XSf97DeITY8k+hwSp/MuIvijBS8Dgt91kMemIFglvTTAwrfrgi0ZwOH2O
	LNGlNA9FIn84IrNxl331A5EvIMsZLYspGmHKqSJ6sfp+tOlAgHghDRhxY/O4mZvKBmf/v8dWxu6
	NXUC/DvAacJcplin5dDelJK/I1IkahHUjsQYsJ7KEQNgH0AwseB1nkiD5PU8nAa+xUCQBMHoaFr
	lwOstUuH5hg==
X-Google-Smtp-Source: AGHT+IGpJkDwYFhqMN2dfaoMBiEA+KlBL1jnyZ8HcDep5HEl2GiAfC9G1oPUBuku+KOEFttH932pyA==
X-Received: by 2002:a05:6808:2395:b0:3fa:daa:dd8e with SMTP id 5614622812f47-3febf7ef5ddmr10081140b6e.35.1742912927655;
        Tue, 25 Mar 2025 07:28:47 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-6023486b758sm1529495eaf.35.2025.03.25.07.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:28:47 -0700 (PDT)
Message-ID: <287e3eb1-a5bc-4976-b670-491fd7a7eafc@gmail.com>
Date: Tue, 25 Mar 2025 09:28:45 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] wispr: Refactor 'wispr_portal_web_result' to
 leverage 'GError'.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <cover.1742878567.git.gerickson@nuovations.com>
 <90cf71d0585440245fc9f788fbbb460a0c210f56.1742878567.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <90cf71d0585440245fc9f788fbbb460a0c210f56.1742878567.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 3/24/25 11:59 PM, Grant Erickson wrote:
> Leverages the newly-added GError parameter to the 'GWebResultFunc' to
> refactor 'wispr_portal_web_result' into
> 'wispr_portal_web_result_failure' and
> 'wispr_portal_web_result_success' with the former handling
> non-successful cases and the latter handling successful HTTP status
> code cases.
> 
> Prior to the introduction of an optional, immutable 'GError' parameter
> to 'GWebResultFunc' and this refactor, there existed a "hole" in the
> finalization of WISPr IPv4 and IPv6 "online" HTTP-based Internet
> reachability checks web request sessions that both could and did leave
> such checks "dangling" and non-renewing such that an expected active,
> default network service failover does not occur when it should.
> 
> The "hole" involves an end-of-file (EOF) condition. In the normal
> case, there are a series of one or more data receipts for the web
> request as headers of the request response are fulfilled. When there
> is no further data to send, the final receive completes a normal EOF
> that leads to the successful closure of the web request, typically
> with HTTP 200 "OK" in the nominal success case.
> 
> However, there is a second EOF case that appears to happen with a
> random distribution in the nginx server backing the default "online"
> HTTP-based Internet reachability check URLs,
> 'ipv[46].connman.net/online/status.html'. In that case, the nginx
> server appears to periodically do an unexpected and spontaneous remote
> connection close after the initial connection but before any data has
> been received. Prior to this change, all such failures hit the same
> WISPr error-handling block which effectively maps such a failure to the
> effective 'GWebResult' "null" GWEB_HTTP_STATUS_CODE_UNKNOWN status
> value. Unfortunately, WISPr historically had no way to distinguish
> this as an actual failure or success and so it lands on the case:
> 
>          case GWEB_HTTP_STATUS_CODE_UNKNOWN:
>                  wispr_portal_context_ref(wp_context);
>                  __connman_agent_request_browser(wp_context->service,
>                                  wispr_portal_browser_reply_cb,
>                                  wp_context->status_url, wp_context);
> 
> which does not "bookend" the original, initiating WISPr web request
> and leaves the original request "dangling" and non-renewed, eventually
> leading to the aforementioned "hole".
> 
> With this change, the second, failure EOF case will now return a
> GError instance pointer synthesized from 'ECONNRESET' and will be
> handled as a failure by 'wispr_portal_web_result_failure',
> "bookending" the original "online" HTTP-based Internet reachability
> check.
> 
> All of the prior HTTP status code cases are handled by
> 'wispr_portal_web_result_success'.
> ---
>   src/wispr.c | 105 +++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 71 insertions(+), 34 deletions(-)
> 

<snip>

> @@ -1085,15 +1078,15 @@ static bool wispr_portal_web_result(const GError *error, GWebResult *result,
>   
>   		goto done;

This part seems fishy.  Previous version of this function had 
wispr_portal_context_unref() call after the 'done' label...

>   	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
> -		portal_manage_failure_status(wp_context, -EINVAL);
> +		portal_manage_failure_status(wp_context, 0, "bad request");
>   		break;
>   
>   	case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
> -		portal_manage_failure_status(wp_context, -ENOENT);
> +		portal_manage_failure_status(wp_context, 0, "resource not found");
>   		break;
>   
>   	case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
> -		portal_manage_failure_status(wp_context, -ETIMEDOUT);
> +		portal_manage_failure_status(wp_context, 0, "request timeout");
>   		break;
>   
>   	case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
> @@ -1102,12 +1095,55 @@ static bool wispr_portal_web_result(const GError *error, GWebResult *result,
>   				wispr_portal_browser_reply_cb,
>   				wp_context->status_url, wp_context);
>   		break;
> +
>   	default:
>   		break;
>   	}
>   
>   	free_wispr_routes(wp_context);
>   	wp_context->request_id = 0;
> +
> +done:
> +	return;

But now you have a simple return at the end of the function.  Which by the way 
is discouraged and should have been picked up by the compiler or static analysis.

> +}
> +
> +static bool wispr_portal_web_result(const GError *error, GWebResult *result,
> +		gpointer user_data)
> +{
> +	struct connman_wispr_portal_context *wp_context = user_data;
> +	const guint8 *chunk = NULL;
> +	gsize length;
> +
> +	DBG("error %p result %p user_data %p wispr_result %d",
> +		error, result, user_data, wp_context->wispr_result);
> +
> +	if (wp_context->wispr_result != CONNMAN_WISPR_RESULT_ONLINE) {
> +		g_web_result_get_chunk(result, &chunk, &length);
> +
> +		DBG("length %zu", length);
> +
> +		if (length > 0) {
> +			g_web_parser_feed_data(wp_context->wispr_parser,
> +								chunk, length);
> +			/* read more data */
> +			return true;
> +		}
> +
> +		g_web_parser_end_data(wp_context->wispr_parser);
> +
> +		DBG("wp_context->wispr_msg.message_type %d", wp_context->wispr_msg.message_type);

We still use 80 character lines, so please break up accordingly.

> +
> +		if (wp_context->wispr_msg.message_type >= 0) {
> +			if (wispr_manage_message(result, wp_context))
> +				goto done;
> +		}
> +	}
> +
> +	if (error)
> +		wispr_portal_web_result_failure(error, result, wp_context);
> +	else
> +		wispr_portal_web_result_success(result, wp_context);
> +
>   done:
>   	wp_context->wispr_msg.message_type = -1;
>   
> @@ -1117,6 +1153,7 @@ done:
>   	 * maintaining a weak reference to it.
>   	 */
>   	wispr_portal_context_unref(wp_context);
> +

Please don't introduce spurious whitespace changes and keep the patches minimal.

>   	return false;
>   }
>   

<snip>

> @@ -1629,7 +1666,7 @@ int __connman_wispr_cancel(struct connman_service *service,
>   
>   	cancel_connman_wispr_portal_context(wp_context);
>   
> -	portal_manage_failure_status(wp_context, -ECANCELED);
> +	portal_manage_failure_status(wp_context, -ECANCELED, strerror(-ECANCELED));

 > 80 chars again

>   
>   	wispr_portal_context_unref(wp_context);
>   

Regards,
-Denis
