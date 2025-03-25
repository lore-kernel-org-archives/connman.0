Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C585383
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920172; cv=none; b=EedethOpZ+FXr7n/m3s85Do/p7IOB7jH3h7YnLynr5Mo+f8Fp+/YabMQmJu00up8HCBDV4Ji9J14uF/1sZbLDQdwNzBu8TQ94VK+OROwtJBQBL0sYgjkRf59iUWi+ZBlxemPHLjV3KKdCl40r6dsekGtFdvD653Ev6nvhVE+GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920172; c=relaxed/simple;
	bh=GEu5JfMBpU8PM6/5SajSl3omwnSn4fFpSglSwtz7EF8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jM480ngcQAI9U41aUc9fsfPs77VxexnoCc9XBeL5ZHnB3FcpnVUFUvPH+HoeBbKUVdIc/rZ6+Z38WYJHddzANp7mna1eX7PQnG9yWTo/pg8JkEb1SvVs4dDVNVPedQ/vM3jPFfW/CfBzsf2xUXPinOKKsrLlmmdgEat2KlYkWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fAonlNJC; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fAonlNJC"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 786871649FD;
	Tue, 25 Mar 2025 12:29:29 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2A5E1125174;
	Tue, 25 Mar 2025 12:29:29 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v4 5/9] wispr: Refactor 'wispr_portal_web_result' to
 leverage 'GError'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <287e3eb1-a5bc-4976-b670-491fd7a7eafc@gmail.com>
Date: Tue, 25 Mar 2025 09:29:18 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <73E10B6A-822A-4950-A698-F545E93BB1DB@nuovations.com>
References: <cover.1742878567.git.gerickson@nuovations.com>
 <90cf71d0585440245fc9f788fbbb460a0c210f56.1742878567.git.gerickson@nuovations.com>
 <287e3eb1-a5bc-4976-b670-491fd7a7eafc@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=Z/jtIEwjEcFtoSHdhBm6xrE2kq4/WXuCaVS0JwEgDH0=; b=fAonlNJCElvnyWqaAgX8ZXPfyg4kdVq8hx7HCMmUHk26fqcwTrdA+yAh67Su0mpyZ01GYFRyul0dDNg0pg1fAa7vunGbZyka/zmI42YX2c/7E1/VEw6goyz56zQGSuGxJjJH7IUWaSv5TkG4mt5TlBJGEWlW43DKOiHG2+M1W52A/pFCgdEq8ml3irUVFYQ10xp2G2lokbH9uVUpod2tx9x1uz6tm/gWmZJ1gZqO4hF5oitEXvANVPMg6Nden19hhlH6QmmeB4LbrQqpgYrA6y30U/rNFvOPl3Hwq9MrfaX28+8JwdfNkLHdGjdbXbNuw5z+mydVutaexXjIfaWPPA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 25, 2025, at 7:28=E2=80=AFAM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 3/24/25 11:59 PM, Grant Erickson wrote:
>> Leverages the newly-added GError parameter to the 'GWebResultFunc' to
>> refactor 'wispr_portal_web_result' into
>> 'wispr_portal_web_result_failure' and
>> 'wispr_portal_web_result_success' with the former handling
>> non-successful cases and the latter handling successful HTTP status
>> code cases.
>>=20
>> <snip>
>>=20
>> ---
>>  src/wispr.c | 105 =
+++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 71 insertions(+), 34 deletions(-)
>=20
> <snip>
>=20
>> @@ -1085,15 +1078,15 @@ static bool wispr_portal_web_result(const =
GError *error, GWebResult *result,
>>     goto done;
>=20
> This part seems fishy.  Previous version of this function had =
wispr_portal_context_unref() call after the 'done' label...

As far as I can see, both success and failure termination paths with or =
without =E2=80=98goto done=E2=80=99 calls, lead to the =
wispr_portal_context_unref() block:

if (error)
	wispr_portal_web_result_failure(error, result, wp_context);
else
	wispr_portal_web_result_success(result, wp_context);

done:
	wp_context->wispr_msg.message_type =3D -1;

	/*
	 * Release a reference to the WISPr/portal context to balance =
the
	 * earlier reference retained to account for =
=E2=80=98g_web_request_get'
	 * maintaining a weak reference to it.
	 */
	wispr_portal_context_unref(wp_context);

	return false;
}

>>   case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
>> - portal_manage_failure_status(wp_context, -EINVAL);
>> + portal_manage_failure_status(wp_context, 0, "bad request");
>>   break;
>>     case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
>> - portal_manage_failure_status(wp_context, -ENOENT);
>> + portal_manage_failure_status(wp_context, 0, "resource not found");
>>   break;
>>     case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
>> - portal_manage_failure_status(wp_context, -ETIMEDOUT);
>> + portal_manage_failure_status(wp_context, 0, "request timeout");
>>   break;
>>     case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
>> @@ -1102,12 +1095,55 @@ static bool wispr_portal_web_result(const =
GError *error, GWebResult *result,
>>   wispr_portal_browser_reply_cb,
>>   wp_context->status_url, wp_context);
>>   break;
>> +
>>   default:
>>   break;
>>   }
>>     free_wispr_routes(wp_context);
>>   wp_context->request_id =3D 0;
>> +
>> +done:
>> + return;
>=20
> But now you have a simple return at the end of the function.  Which by =
the way is discouraged and should have been picked up by the compiler or =
static analysis.

I tried to keep the original block of logic as-is.=20

Personally, I=E2=80=99m a fan of single points of exit=E2=80=94so much =
easier to audit. But, happy to keep whatever style is preferred. It =
sounds like the preference is to replace the prior =E2=80=98goto done=E2=80=
=99 with =E2=80=98return=E2=80=99, correct?

>> + g_web_parser_end_data(wp_context->wispr_parser);
>> +
>> + DBG("wp_context->wispr_msg.message_type %d", =
wp_context->wispr_msg.message_type);
>=20
> We still use 80 character lines, so please break up accordingly.

Surprisingly, checkpatch.pl did not squawk about this. Fixed, =
regardless.

>> @@ -1629,7 +1666,7 @@ int __connman_wispr_cancel(struct =
connman_service *service,
>>     cancel_connman_wispr_portal_context(wp_context);
>>  - portal_manage_failure_status(wp_context, -ECANCELED);
>> + portal_manage_failure_status(wp_context, -ECANCELED, =
strerror(-ECANCELED));
>=20
> > 80 chars again

Surprisingly, checkpatch.pl did not squawk about this either. Fixed, =
regardless.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

