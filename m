Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E81DDC3E
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878900; cv=none; b=It9HbvQqrRf8Qel17ynMkqJmwPT/Q5tX6PhjsYjAolnzq/mRz+rHMxExIpbzTeObRbVIJeB/I6yw0SrjWLrZarYvMYFuTmb3u0IUHgrlY/LW9Oc84tyAYD5/+06ZBsm8qtRANKuHKFfXLEntUDfAAgoTdOZNMvArVpigdULTF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878900; c=relaxed/simple;
	bh=aQEb4Vpyp0P1ow4AD3Ygl+yA+8BTd/ThMmW0v329yUA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GKokbJpa3HjkUAX4pIqa4JhFQwl7ks1tfdT+45dy15mZRNR4fpWNzQqkvmzx2KUORWl4FtQehMzVO165JON6Xenmq1Gu5wOV6oyio2EU8T/HxfkoTDzgEhImA/nh9B96Vqu/2Dluvbx5GCWPnI5rISL68Z++wbegCAtco46BsuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=T56kGIJL; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="T56kGIJL"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6ADD4164A18;
	Tue, 25 Mar 2025 01:01:38 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 151D4125166;
	Tue, 25 Mar 2025 01:01:37 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v3 09/18] gweb: Adopt optional, immutable GError instance
 for GWeb result errors.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <7bd42384-c15b-4216-a601-ac18849ce72f@gmail.com>
Date: Mon, 24 Mar 2025 22:01:31 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DBBD7A0-DAF7-42D6-B7FD-A3BF8D45DBDE@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
 <4e2b089631711aaa48079f8a63b74f61d28c9eae.1742513884.git.gerickson@nuovations.com>
 <7bd42384-c15b-4216-a601-ac18849ce72f@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=Y89rqaOhsIRCiqSwfF7rdqajbN6A4xHULacVfzYUm1s=; b=T56kGIJL7N/M/WVnoGWPafyaY4ky7mzmT+H6XtOi20xcvyR7h3Na2HRInbQxTFV52D0f4QbSWg6TNe+gFNSQA7FEuk3E8EhAigPACrbjzoqxONjfDpzcMLkDUvyvxJSBzGPVDQuUH2L8ntak+6UFfCwyH511ARUBqeBCGZTPKtszzdoseJOkCnGAfjagBpktpPAqsKkszg3Jf83/vYcdr+CXQEEF8hqX0s9mD0v8M7FzB7pcmRcfxQUjD26RlA4hdywgC7XpzZq3ApROU0wuArzsXXzZk8ffzKIwVR59+AG5ZuiioKlJx1u3CMuLpcMytB21NXHiK/z6JTyr5ukz/g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Mar 24, 2025, at 3:28=E2=80=AFPM, Denis Kenzior <denkenz@gmail.com> =
wrote:
> On 3/20/25 6:39 PM, Grant Erickson wrote:
>> In the following instances, GWeb can fail before initiating or while
>> processing a web request:
>>   1. TCP connection timeout to the remote server peer.
>>   2. Decoding a chunked response.
>>   3. Non-successful events (that is, G_IO_NVAL, G_IO_ERR, or =
G_IO_HUP)
>>      from 'g_io_add_watch'.
>>   4. GResolve "host not found" DNS forward resolution failure.
>>   5. Transport creation failure from 'create_transport'.
>> Rather than trying to overload 'GWEB_HTTP_STATUS_CODE_' error
>> enumerations from actual web server responses for these non-response
>> or response-in-progress failures, the signature of 'GWebResultFunc' =
is
>> amended to take an optional pointer to an immutable GError instance
>> which describes one of the five errors above on a GWeb request
>> failure.
>=20
> This looks so much better, a few nits:

Thanks.

> Could you use:
>=20
> g_autoptr(GError) local_error =3D NULL;

Great feedback and optimization. I was familiar with g_autofree but not =
g_autoptr.

I=E2=80=99ve adopted this across the board, as well as g_error_new, =
where appropriate.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

