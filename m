Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A714EC46
	for <connman@lists.linux.dev>; Mon, 24 Mar 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856330; cv=none; b=VHcGsXJlzPT0g9Q6aksuxTkEheBFeIMdPADKGMpyotezkzVWPBSFnYJo8IoFJ1QDQrAZSXMVpkJizmke6IkR8lVw9UEbWXt+zYet8Ppu1tOsuofSGcM8ZmhxZwYkffCzX6HFLFOAk3aqqyFZBPc+UJ8FczH6xvHLhQJJMjzfXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856330; c=relaxed/simple;
	bh=Ud51fI/WN1dH1vRtIF+vpmaTS7OqCmveMxuN9GnYCOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hg7doFl7IJGVb9gvWwttZI5DXMbHdmVQ64lIS8lKg1iQeIRnXLgcv8/q6Zg8ujlzkAdVIOI+78WLz6bQRO364DJhFQ6A4q3jLj3SFAe5aekHULwFC0HswsDZyxx26M1qyf/8C3InaXKKLHvUF5/mjBYMmF4V5y8ZKLlL25RRGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlqF+S4K; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlqF+S4K"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c7f876b320so470655fac.1
        for <connman@lists.linux.dev>; Mon, 24 Mar 2025 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742856328; x=1743461128; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1KfPBAosMGz18WTuWcs1ZRJHHv1hQivN/yspg74xbi4=;
        b=XlqF+S4KoRrYAfqBuWQGBdLXMQjEQTCzz7onrldCjpd64q3J+80BdYh3ipzZVU4PIq
         2pBqcXsjqzv75oojGhP1O46dFejmZa7k7ZwpZqZrN4wxWH/t5WLM+LjVlrP2P9vbLrjk
         B9i06vxQeF5zGXcpxBGdh2TGLOzlpTSupnrAxUGtXnyKtgOi+up/K0na+L/R44gRE/by
         wbJSbnZ7CH1o1hTLds7/UE3gPSBav3xiG+k72+FsmmN6kJj89MxNwX4tFZEZ+LeeY4OO
         9A6kfycnxfkVuqvhSraUL4js9YXmGolrukpa1PoVDcMAJr+az49lnabtVK+8gSa1xPAu
         fzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742856328; x=1743461128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KfPBAosMGz18WTuWcs1ZRJHHv1hQivN/yspg74xbi4=;
        b=M4FDRGbcYtHHWFrD5BxARaYGPUTjd2q29ajj/TSl42IWELIaioqVcWLDCu3sodrxJJ
         WZo+EfMS76dB0fHSIyhh805O2rLxd5RZ+e0a7tXN+sl9gyWSs3ev5vhdeaIhfTJhhPZU
         QV77Hiv0+3FU5OISEkucFbImBRO5Eym8+oaHbbtdAeJ0zuzzF0dRooBHvuaCLL+ZHT7q
         qAdjMenfMF/n1tjSpo0deu/Of72DSowRbeHPyiKF9mY7+q53EgYHuUtSFdW9Gi229xdz
         LnxWpWDtqq/ZWrJZKVNGODanTFFi/OcJ08DhYya+GdVHpMA2/d//oSJc4xopSFDw7ZnA
         k78g==
X-Forwarded-Encrypted: i=1; AJvYcCVbYzJh0PP/I/+U4zTVrjkW2BT/jsm+zI0AhUk1bQZkEHNxT8tDIEQeVgFg4w1YqEFXAez+PVhD@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/WEvCuRNYlOBh+jhoq/PQLi9j2lwb5JOlEfmeQ/vI0ox01sl4
	7G32NRmnJ4DO3kyqfVf5iF9r412CUNrDwQeXZHXiWOfOqH3T598Zl01F0A==
X-Gm-Gg: ASbGnctJ2bsljyERlbJSnycEm6xOB62OawHkIHYmLSu/2jA5ND7fldWTC4fpDbHV2nF
	ZEX96cm1YE/6q0gsFYZfi6tyGLBEuybHleBqY0AfMVOpVlHpTvjG7UT+uKH4t0FVY4OxbdlBqlf
	7UcH07MUYMV8qAUYhOo0WlMkwmggs1DXXpxwgjSQqNOtftvdghCY1sK+FGVCMtehCHfmHjIntWM
	tFYsQzPC2SPc8nViE6QIEbgme+uSp55kUWbEtdzDal3OhFEvGdP+VjuMdAyaskv196UYOvI/81Y
	tpHbINXYUlnjS36ux6kxOSBNF7OB24DXLOd9gOOAMmn0COk0NdhbsvUZOI1tawEKkurs4BlM61V
	bZLaEunOCrw==
X-Google-Smtp-Source: AGHT+IFzf5BvUWBNhwx2+InDqaOMkT5q1M+kt5aKpjvno0ImFGadKam7LEgtrg3lHq8vWfQvVDxadw==
X-Received: by 2002:a05:6870:5594:b0:2c3:1651:ca78 with SMTP id 586e51a60fabf-2c7802cf0cbmr9660319fac.14.1742856327387;
        Mon, 24 Mar 2025 15:45:27 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c77ecdc50esm2234886fac.28.2025.03.24.15.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:45:26 -0700 (PDT)
Message-ID: <432e0077-44d3-4eea-894f-7cbfc5adafe0@gmail.com>
Date: Mon, 24 Mar 2025 17:45:25 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/18] gweb: Close web request session finalization
 'hole'.
To: Grant Erickson <gerickson@nuovations.com>, connman@lists.linux.dev
References: <cover.1742513884.git.gerickson@nuovations.com>
 <0748654fa16bbc7f9c4afafddc8149faae3bb005.1742513884.git.gerickson@nuovations.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <0748654fa16bbc7f9c4afafddc8149faae3bb005.1742513884.git.gerickson@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Grant,

On 3/20/25 6:39 PM, Grant Erickson wrote:
> There exist two "holes" in the finalization of web request sessions
> that can, for example in a client such as WISPr, leave one or both of
> IPv4 and IPv6 "online" HTTP-based Internet reachability checks
> "dangling" and non-renewing such that an expected active, default
> network service failover does not occur when it should.
> 
> The first of those two failure "holes" involves an end-of-file (EOF)
> condition. In the normal case, there are a series of one or more data
> receipts for the web request as headers and, if present, the body of
> the request response are fulfilled. When there is no further data to
> send, the final receive completes with 'g_io_channel_read_chars'
> returning 'G_IO_STATUS_EOF' status and zero (0) bytes read. This should
> and does lead to a successful EOF closure of the web request.
> 
> However, there is a second EOF case that appears to happen with a
> random distribution in the nginx server backing the default "online"
> HTTP-based Internet reachability check URLs,
> 'ipv[46].connman.net/online/status.html'. In that case, the nginx
> server appears to periodically do an unexpected and spontaneous remote
> connection close after the initial connection but before any data has
> been received. Presently, all such failures hit the same
> error-handling block which effectively maps such a failure to the
> effective "null" 'GWEB_HTTP_STATUS_CODE_UNKNOWN' status
> value. Unfortunately, clients such as WISPr have no way to distinguish
> this as an actual failure or success and so it lands on the case:
> 
> 	case GWEB_HTTP_STATUS_CODE_UNKNOWN:
> 		wispr_portal_context_ref(wp_context);
> 		__connman_agent_request_browser(wp_context->service,
> 				wispr_portal_browser_reply_cb,
> 				wp_context->status_url, wp_context);
> 
> which does not "bookend" the original, initiating WISPr web request
> and leaves the original request "dangling" and non-renewed, eventually
> leading to the aforementioned "hole".
> 
> To handle this failure EOF case, if GWeb asked for a non-zero amount
> of data from 'g_io_channel_read_chars' but received none and has
> accumulated no headers thus far upon receiving the status
> 'G_IO_STATUS_EOF', then GWeb assumes that the remote peer server
> unexpectedly closed the connection, and synthesizes a new GError with
> the error 'ECONNRESET'. With the addition of the optional, immutable
> GError parameter to the GWebResult callback function, clients such as
> WISPr can now distinguish between a HTTP non-response in which no HTTP
> data was received and one in which HTTP data was received and the
> status can be disguished by the HTTP status code.
> 
> The second of the two failure "holes" involves the case where
> 'g_io_channel_read_chars' returns 'G_IO_STATUS_ERROR' status. Prior to
> this change, this funneled to the same "hole" as the 'G_IO_STATUS_ERROR'
> failure with the same consequence to clients such as WISPr.
> 
> To handle this error case, GWeb now passes a glib GError pointer to
> 'g_io_channel_read_chars'. If it is set, GWeb passes the GError
> through to the GWebResult callback function. Otherwise, it synthesizes
> a GError anew from 'EIO'. As with the failure EOF case, this allows
> clients to distinguish and handle such failures and to successfully
> "bookend" their initial web request.
> ---
>   gweb/gweb.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 64 insertions(+), 6 deletions(-)
> 

<snip>

> diff --git a/gweb/gweb.c b/gweb/gweb.c
> index 7ad12c977ff8..6d517f9467bb 100644
> --- a/gweb/gweb.c
> +++ b/gweb/gweb.c
> @@ -1202,14 +1202,65 @@ static void add_header_field(struct web_session *session)
>   	}
>   }
>   
> -static void received_data_finalize(struct web_session *session)
> +static void received_data_finalize(struct web_session *session,
> +				GIOStatus status, gsize bytes_available,
> +				gsize bytes_read, const GError *error)
>   {
> +	GError *local_error = NULL;

g_autoptr(GError)?

> +	const GError *passed_error = NULL;
> +
>   	session->transport_watch = 0;
>   
>   	session->result.buffer = NULL;
>   	session->result.length = 0;
>   
> -	call_result_func(session, NULL);
> +	/* Handle post-channel read errors, which could be either
> +	 * G_IO_STATUS_ERROR or G_IO_STATUS_EOF.
> +	 *
> +	 * For G_IO_STATUS_ERROR, simply pass through the GError, if
> +	 * non-null. If there is no GError, create a GError anew based on
> +	 * EIO.
> +	 *
> +	 * For G_IO_STATUS_EOF, this could occur at the end of a nominal,
> +	 * successful get. That is, some number of headers, with or
> +	 * without a body, termiated by an expected end-of-file (EOF)
> +	 * condition. However, G_IO_STATUS_EOF can also happen as a result
> +	 * of the remote peer server unexpectedly terminating the
> +	 * connection without transferring any data at all. The only
> +	 * reasonable recovery for this case it to fail the request,
> +	 * synthesizing ECONNRESET as the error, and to let the client
> +	 * request again.
> +	 *
> +	 * If we asked for a non-zero amount of data but received none and
> +	 * have accumulated no headers thus far, then we assume that the
> +	 * remote peer server unexpectedly closed the connection;
> +	 * otherwise, we assume it is a normal EOF closure.
> +	 */
> +
> +	if (status == G_IO_STATUS_ERROR) {
> +		if (error != NULL)
> +			passed_error = error;
> +		else {
> +			local_error = g_error_new_literal(G_IO_ERROR,
> +				g_io_error_from_errno(EIO),
> +				g_strerror(EIO));
> +			passed_error = local_error;
> +		}

Why is this needed?  Isn't g_io_read_chars always creating a GError object for 
you in case of G_IO_STATUS_ERROR return?

> +	} else if (status == G_IO_STATUS_EOF) {
> +		if (bytes_available > 0 &&
> +				bytes_read == 0 &&
> +				!g_web_result_has_headers(&session->result, NULL)) {
> +			local_error = g_error_new_literal(G_IO_ERROR,
> +				g_io_error_from_errno(ECONNRESET),
> +				g_strerror(ECONNRESET));
> +			passed_error = local_error;
> +		}
> +	}
> +
> +	call_result_func_failure(session, passed_error);
> +
> +	if (local_error)
> +		g_error_free(local_error);

This could be omitted if g_autoptr is used

>   }
>   
>   static bool received_data_continue(struct web_session *session,
> @@ -1330,9 +1381,11 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
>   							gpointer user_data)
>   {
>   	struct web_session *session = user_data;
> +	const gsize bytes_available = session->receive_space - 1;
>   	gsize bytes_read;
>   	GIOStatus status;
>   	GError *local_error = NULL;
> +	GError *error = NULL;

g_autoptr?

>   
>   	/* We received some data or condition, cancel the connect timeout. */
>   

Regards,
-Denis
