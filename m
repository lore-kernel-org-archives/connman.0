Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DAA125C3
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 44386CED00;
	Sat, 11 Nov 2023 11:17:55 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 3/3] wispr: Leverage GWebStatusCode mnemonics.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FEE0F97A-C19A-4919-980C-BCA510E61B64@nuovations.com>
Date: Sat, 11 Nov 2023 11:17:44 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E178EF3-7791-495F-8F17-2AE627D6E3AB@holtmann.org>
References: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
 <FEE0F97A-C19A-4919-980C-BCA510E61B64@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

> This leverages the 'GWEB_HTTP_STATUS_CODE_*' GWebStatusCode mnemonics
> from gweb.h for improved code self-documentation.
> ---
> src/wispr.c | 22 +++++++++++-----------
> 1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/src/wispr.c b/src/wispr.c
> index 57e74a83..0c9bdb69 100644
> --- a/src/wispr.c
> +++ b/src/wispr.c
> @@ -794,13 +794,13 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
> DBG("status: %03u", status);
>=20
> switch (status) {
> - case 000:
> + case GWEB_HTTP_STATUS_CODE_UNKNOWN:
> wispr_portal_context_ref(wp_context);
> __connman_agent_request_browser(wp_context->service,
> wispr_portal_browser_reply_cb,
> wp_context->status_url, wp_context);
> break;
> - case 200:
> + case GWEB_HTTP_STATUS_CODE_OK:
> if (wp_context->wispr_msg.message_type >=3D 0)
> break;
>=20
> @@ -815,12 +815,12 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
> }
>=20
> break;
> - case 300:
> - case 301:
> - case 302:
> - case 303:
> - case 307:
> - case 308:
> + case GWEB_HTTP_STATUS_CODE_MULTIPLE_CHOICES:
> + case GWEB_HTTP_STATUS_CODE_MOVED_PERMANENTLY:
> + case GWEB_HTTP_STATUS_CODE_FOUND:
> + case GWEB_HTTP_STATUS_CODE_SEE_OTHER:
> + case GWEB_HTTP_STATUS_CODE_TEMPORARY_REDIRECT:
> + case GWEB_HTTP_STATUS_CODE_PERMANENT_REDIRECT:
> if (!g_web_supports_tls() ||
> !g_web_result_get_header(result, "Location",
> &redirect)) {
> @@ -842,12 +842,12 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
> wispr_route_request, wp_context);
>=20
> goto done;
> - case 400:
> - case 404:
> + case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
> + case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
> wp_context->cb(wp_context->service, wp_context->type, false);

an alternative that I sometimes prefer is to comment that value. =
Especially in these cases of switch statements when parsing messages.

	switch (status) {
	case 400:	/* Bad Request */
	case 404:	/* Not Found */
		..
		break;
	}

Especially with pretty much well understood protocols like HTTP and most =
developers know half of the error codes from memory anyway, I would =
prefer this style.

For example Unix file system mode 0755 mean something to many people and =
the attempt to change values like this to constants turned into a total =
mess.

Main problem I sometimes see is that we end up having so much =
namespacing prefix in these constants that code becomes actually harder =
to read. A comment is context specific and can be short and achieve the =
same affect of giving you a hint if you end up no remembering what 308 =
for example is.

That said, that we did neither in this code, is stupid and most likely =
my mistake if you git blame it.

Regards

Marcel

