Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B543FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 07:06:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ABE5C5E368;
	Mon,  4 Oct 2021 09:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633331171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AtB9RG5YF3bDUFHEl0hIITfdyQcaNXM7Cj3rjf+TwxM=;
	b=Opv3KUWpSG65V5x/qZtANYj5bjkmafNXYqs72tWXH9TbDr2qirtZoSEH2A2NqosUluioCW
	d0wbw1qkoCY+O2F6/MIY/CBkSW+5hMcZIT+J60lYRrSzjjK8u/0R0riJKE49vrpHl9/8V/
	q3mhSyOOsfazZGhCB5BLiugt2cAqUinTmagkjZhSOXxpD5OJFBjj4X21AsqcHPR1HchUVI
	pTR2SHUnM0IzGmjOq5MEoR9ot0YmemcxafyNRR4MyMgFeurMvKOqn0p1FfrPW7mR6KKjXN
	gPYXUVFWpTFSjnj2xrnzeCPY2DXX6GRKs1KI288/qy6YDyyfOvOXbgonyuLxLQ==
Date: Mon, 4 Oct 2021 09:06:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH 3/3] iwd: Ensure hidden services connectable after removed
Message-ID: <20211004070611.usnxi6bbmkfanxs6@beryllium.lan>
References: <MRZP264MB154491FD5A024CBCF0147E5B93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MRZP264MB154491FD5A024CBCF0147E5B93AB9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, Oct 01, 2021 at 03:29:16PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Hidden services shall always be connectable, even after been removed.
> When a hidden service is removed, the associated iwd network stays as
> known and thus shall be connected as a visible network.
> ---
>  plugins/iwd.c | 71 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 17 deletions(-)
> 
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index 961d53196207..9bd27e90c346 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -140,6 +140,7 @@ struct iwd_station {
>  	bool scanning;
>  
>  	GHashTable *hidden_aps;
> +	GHashTable *hidden_networks;
>  	struct hidden_params *hidden;
>  	bool postpone_hidden;
>  };
> @@ -646,6 +647,37 @@ static void hidden_params_free(gpointer data)
>  	g_free(hidden);
>  }
>  
> +static int connect_hidden(struct iwd_station *iwds)
> +{
> +	struct iwd_network *iwdn;
> +	char *ssid_security;
> +	int err = 0;
> +
> +	ssid_security = g_strdup_printf("%s_%s",
> +				iwds->hidden->ssid, iwds->hidden->security);
> +	iwdn = g_hash_table_lookup(iwds->hidden_networks, ssid_security);
> +	if (iwdn) {
> +		err = connman_network_connect_hidden(iwdn->network,
> +				iwds->hidden->identity,
> +				iwds->hidden->passphrase,
> +				iwds->hidden->user_data);
> +		iwds->hidden->user_data = NULL;
> +	if (err == -EINPROGRESS)
> +		err = 0;

You could do a 'return 0' here.

