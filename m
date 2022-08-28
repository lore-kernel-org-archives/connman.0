Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6D443A
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 16:21:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB7B15E04E;
	Sun, 28 Aug 2022 18:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661703701; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4UfeDRgBcsUMl4/uwGCJKn99Ymukc1cD4nuvN8uLHq4=;
	b=hKb+5Y2fAHa4G+bm8H3ASNHCqcWfQu2l9r/8Hnko9EWITsBkgifd3PEDkmYy0uD+38kNGP
	YqgktEv3kq3vcTpIOj09LCV8sBgcFZKVMzhoBN5flhPQtcbU+PbQUkhUVylwvra1bHebQs
	45S6+4Gk7sX3X+zy8Qy8A+kBVVMPlSctXSFHtpeRjUQ0iriBFxk5PSX7OabwN3Qw+pDu+8
	qo5pwT0iD34Xdoy9S3SUQFsQjyHLhmQqEzgaa3bTYer3kKBxijap0zLAXHWx3TPc2Bo119
	Sckb/Yw5JHHCE7lcWZQVZ5jjCedg2KxdAWW5UrvYFg/HpqbIJmZZAXyEBpj80A==
Date: Sun, 28 Aug 2022 18:21:40 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 03/16] dnsproxy: first bits of refactoring data types,
 global variables, simpler functions
Message-ID: <20220828162140.6sqnovhiypbtu3ch@beryllium.lan>
References: <20220610123323.8974-1-matthias.gerstner@suse.de>
 <20220610123323.8974-4-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610123323.8974-4-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

Hi Matthias,

Sorry for the long delay.  Looking at the final result with the C99
mixing declaration with code I think it doesn't make sense to do it just
because it's possible.

On Fri, Jun 10, 2022 at 02:33:10PM +0200, Matthias Gerstner wrote:
>  static struct request_data *find_request(guint16 id)
>  {
> -	GSList *list;
> -
> -	for (list = request_list; list; list = list->next) {
> +	for (GSList *list = request_list; list; list = list->next) {

This is fine and I think we should do it. The iterator is limited to the
loop context and this is what we want most of the time.

>  static void dummy_resolve_func(GResolvResultStatus status,
>  					char **results, gpointer user_data)
>  {
> @@ -330,8 +350,6 @@ static void dummy_resolve_func(GResolvResultStatus status,
>   * Refresh a DNS entry, but also age the hit count a bit */
>  static void refresh_dns_entry(struct cache_entry *entry, char *name)
>  {
> -	int age = 1;
> -
>  	if (!ipv4_resolve) {
>  		ipv4_resolve = g_resolv_new(0);
>  		g_resolv_set_address_family(ipv4_resolve, AF_INET);
> @@ -344,6 +362,8 @@ static void refresh_dns_entry(struct cache_entry *entry, char *name)
>  		g_resolv_add_nameserver(ipv6_resolve, "::1", 53, 0);
>  	}
>  
> +	int age = 1;
> +

But here nothing really is improved. In fact, it makes it harder to read
with the rest of the code.


> -static void send_cached_response(int sk, unsigned char *buf, int len,
> +static void send_cached_response(int sk, unsigned char *ptr, int len,
>  				const struct sockaddr *to, socklen_t tolen,
>  				int protocol, int id, uint16_t answers, int ttl)
>  {
> -	struct domain_hdr *hdr;
> -	unsigned char *ptr = buf;
> -	int err, offset, dns_len, adj_len = len - 2;
> +	int offset, dns_len;
>  
>  	/*
>  	 * The cached packet contains always the TCP offset (two bytes)
> @@ -449,7 +468,7 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
>  	if (len < 12)
>  		return;
>  
> -	hdr = (void *) (ptr + offset);
> +	struct domain_hdr *hdr = (void *) (ptr + offset);

So this struct domain_hdr should still be at the beginning of the basic
block.

>  
>  	hdr->id = id;
>  	hdr->qr = 1;
> @@ -461,42 +480,40 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
>  	/* if this is a negative reply, we are authoritative */
>  	if (answers == 0)
>  		hdr->aa = 1;
> -	else
> +	else {
> +		const int adj_len = len - 2;
>  		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);

This is fine as it starts within a basic block and was possible to do
even without C99.

> +	}
>  
>  	debug("sk %d id 0x%04x answers %d ptr %p length %d dns %d",
>  		sk, hdr->id, answers, ptr, len, dns_len);
>  
> -	err = sendto(sk, ptr, len, MSG_NOSIGNAL, to, tolen);
> -	if (err < 0) {
> +	const int res = sendto(sk, ptr, len, MSG_NOSIGNAL, to, tolen);
> +	if (res < 0) {

As I said the main reason I argue against this, we don't do this in the
rest of the code base and I think it's better to keep it consistent.

I skimmed through the rest of the series and looks reasonable. So it's
just this 'little' nitipick.

Thanks,
Daniel
