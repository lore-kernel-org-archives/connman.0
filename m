Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF78A56
	for <connman@lists.linux.dev>; Wed, 25 May 2022 06:48:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BF7A5D945;
	Wed, 25 May 2022 08:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1653461334; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0hBrbQ4Jjh7kVXKXJPldM+IcZQ6J95I9AaI/03szYe4=;
	b=PDQl8YeFKcm+gVOaaRL0fzRiqXDXZAQcSxiKIbi2EPave1ac/64hT7Jyhpc1UVP2UrEmzR
	FAs1t6oi7/4J3pibgalpVuGhF2B+jllvUrdTf62qcZjHzxip1EEs+9xYofKA2SX7NgTYFL
	cGZivoIZZetcYu7C2vBemRsBZEo0q+fDn9aMs5PK1gMYELMJEkXWIuorAK9sdAb/roo5OP
	zq7yyatfqrgnxMBR1Om6mtbrmSEJvWxP1DQWY/jqYLsMTsAprlgTCZaEL94gE5GdwWuUfy
	ODPnaBT1v9nvDGDIuxoowVrbvOz3f/utTrk471PRge2qbN5hQBgt58PK0Wq71g==
Date: Wed, 25 May 2022 08:48:54 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 02/12] dnsproxy: first bits of refactoring data types,
 global variables, simpler functions
Message-ID: <20220525064854.nd4x74ggk7rvsbws@beryllium.lan>
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

> +static void cache_free_ipv4(struct cache_entry *entry) {
> +	if (entry->ipv4) {
> +		g_free(entry->ipv4->data);
> +		g_free(entry->ipv4);
> +		entry->ipv4 = NULL;
> +	}
> +}
> +
> +static void cache_free_ipv6(struct cache_entry *entry) {
> +	if (entry->ipv6) {
> +		g_free(entry->ipv6->data);
> +		g_free(entry->ipv6);
> +		entry->ipv6 = NULL;
> +	}
> +}

Use early exist here and move the opening bracket to a new line

static void cache_free_ipv6(struct cache_entry *entry)
{
	if (!entry->ipv4)
        	return;

	g_free(...);
}

