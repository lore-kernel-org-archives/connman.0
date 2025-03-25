Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C42CA6
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742879097; cv=none; b=jIpEih+pVlV8/4/XmAlareYr+imXlctlND1+sxwbusdMVBLL7v1oOZJ5wJonl5wcVrRmzX5pvIppp9V0VZAsd9cLvbUjcdfJzCiCGt9/UkAmyzQr9ykQ1vror5FLr72JDb7UKSozcfEwjVX4Iyb+7dPyVZLhhWSlKBL3XXrkEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742879097; c=relaxed/simple;
	bh=xDrr3arJywL4eP/gbAv8YNUf62M2x7iQBPy7k3DTAfo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gB1DtlM8/vFCrlgtGI+g0fbhJPvTV4RjJT7QEPxCOgCWP/YJSexR0EGCuF3I0s9Bp9VSIVIqKSFrwBivKU2pbieZwfQutmvXN5kCztZ0A/m0uCvHB1044ISLEHcysOQj8Mp80yMygbFr4BfDoHdIX8TO5vAXB9HmgKDdCaJ5rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ScefKrge; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ScefKrge"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 2F72E164A18;
	Tue, 25 Mar 2025 01:04:54 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C9E6F125166;
	Tue, 25 Mar 2025 01:04:53 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v3 11/18] gweb: Close web request session finalization
 'hole'.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <432e0077-44d3-4eea-894f-7cbfc5adafe0@gmail.com>
Date: Mon, 24 Mar 2025 22:04:50 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2746494-6ECF-4F8E-A4B1-5AE15F1BAC5C@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
 <0748654fa16bbc7f9c4afafddc8149faae3bb005.1742513884.git.gerickson@nuovations.com>
 <432e0077-44d3-4eea-894f-7cbfc5adafe0@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=vdyfSQ3Ifr90zfm8QMS+qUCcxfONX3hnUw2LqpT7obc=; b=ScefKrge0hXEaLmKHOr55adPCxXXifE6fVx98RKxvYMEGt1ztRlcb+3FW/UKdl1tR/Ff1lr7twU19ytPFndKj3NxZf6QEE3XAWq++K5CuvCIMl5op8Erzbu4jVagMY6s7J9YZvsdhajaRxmi8j7nKc3J5OIhXRSUTAAab0dIosoDOptKEGPLYHAC2I+Le1EBONMwcXqQ2K4YYNfnYlV+fSPxCSl67YUwLfx1EIIP4FhCEby10pXdNFnlKfTaqCaS9vnT3e2hyj9bm7+n9Gpqz3IolUlhreCo3IqxvkoQGa2SUmbqv15QQL6y0CODdM3V9CB+o2bNItVtqFhYGRVUYQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 24, 2025, at 3:45=E2=80=AFPM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 3/20/25 6:39 PM, Grant Erickson wrote:
>> There exist two "holes" in the finalization of web request sessions
>> that can, for example in a client such as WISPr, leave one or both of
>> IPv4 and IPv6 "online" HTTP-based Internet reachability checks
>> "dangling" and non-renewing such that an expected active, default
>> network service failover does not occur when it should.
>> The first of those two failure "holes" involves an end-of-file (EOF)
>> condition. In the normal case, there are a series of one or more data
>> receipts for the web request as headers and, if present, the body of
>> the request response are fulfilled. When there is no further data to
>> send, the final receive completes with 'g_io_channel_read_chars'
>> returning 'G_IO_STATUS_EOF' status and zero (0) bytes read. This =
should
>> and does lead to a successful EOF closure of the web request.
>> However, there is a second EOF case that appears to happen with a
>> random distribution in the nginx server backing the default "online"
>> HTTP-based Internet reachability check URLs,
>> 'ipv[46].connman.net/online/status.html'. In that case, the nginx
>> server appears to periodically do an unexpected and spontaneous =
remote
>> connection close after the initial connection but before any data has
>> been received. Presently, all such failures hit the same
>> error-handling block which effectively maps such a failure to the
>> effective "null" 'GWEB_HTTP_STATUS_CODE_UNKNOWN' status
>> value. Unfortunately, clients such as WISPr have no way to =
distinguish
>> this as an actual failure or success and so it lands on the case:
>> case GWEB_HTTP_STATUS_CODE_UNKNOWN:
>> wispr_portal_context_ref(wp_context);
>> __connman_agent_request_browser(wp_context->service,
>> wispr_portal_browser_reply_cb,
>> wp_context->status_url, wp_context);
>> which does not "bookend" the original, initiating WISPr web request
>> and leaves the original request "dangling" and non-renewed, =
eventually
>> leading to the aforementioned "hole".
>> To handle this failure EOF case, if GWeb asked for a non-zero amount
>> of data from 'g_io_channel_read_chars' but received none and has
>> accumulated no headers thus far upon receiving the status
>> 'G_IO_STATUS_EOF', then GWeb assumes that the remote peer server
>> unexpectedly closed the connection, and synthesizes a new GError with
>> the error 'ECONNRESET'. With the addition of the optional, immutable
>> GError parameter to the GWebResult callback function, clients such as
>> WISPr can now distinguish between a HTTP non-response in which no =
HTTP
>> data was received and one in which HTTP data was received and the
>> status can be disguished by the HTTP status code.
>> The second of the two failure "holes" involves the case where
>> 'g_io_channel_read_chars' returns 'G_IO_STATUS_ERROR' status. Prior =
to
>> this change, this funneled to the same "hole" as the =
'G_IO_STATUS_ERROR'
>> failure with the same consequence to clients such as WISPr.
>> To handle this error case, GWeb now passes a glib GError pointer to
>> 'g_io_channel_read_chars'. If it is set, GWeb passes the GError
>> through to the GWebResult callback function. Otherwise, it =
synthesizes
>> a GError anew from 'EIO'. As with the failure EOF case, this allows
>> clients to distinguish and handle such failures and to successfully
>> "bookend" their initial web request.
>> ---
>>  gweb/gweb.c | 70 =
++++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 64 insertions(+), 6 deletions(-)
>=20
> <snip>
>=20
>> + if (status =3D=3D G_IO_STATUS_ERROR) {
>> +     if (error !=3D NULL)
>> +         passed_error =3D error;
>> +     else {
>> +         local_error =3D g_error_new_literal(G_IO_ERROR,
>> +                g_io_error_from_errno(EIO),
>> +                g_strerror(EIO));
>> +         passed_error =3D local_error;
>> +     }
>=20
> Why is this needed?  Isn't g_io_read_chars always creating a GError =
object for you in case of G_IO_STATUS_ERROR return?

Without having looked at the actual implementation of =
=E2=80=98g_io_read_chars' in any particular version of glib, from the =
documentation alone, it is not clear that =E2=80=98error' is always set =
when the status is G_IO_STATUS_ERROR.

As implemented, this seems more defensive (which is what=E2=80=99s =
desired for this overall patch set).

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

