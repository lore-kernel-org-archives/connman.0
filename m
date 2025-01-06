Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA79BA34
	for <connman@lists.linux.dev>; Mon,  6 Jan 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179098; cv=none; b=syGoI3UpHcGQq48ClJFigv2akggGDonELs5cgsne0TAFfm95VLXp8uw3ux5aR1zaj2uzx2a9lnfGfW3TtM+x9/vYoh3xek5pj9XOtmOkUJvdsOJlBGm1nHkangp5N1P+REDaX12QTiuIgaBH+hTdUvjKg3VjYWYUc8FTp50R6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179098; c=relaxed/simple;
	bh=wyjKPXqo3RM4QlOWVbZrBy4m1szyuYk6255lF+khbWA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gYvYmus+7kg2avUsuBDMFAYfvFmG9FTb+779XqMXCRvrNUKEFTl6ZIzbykFv2uDD3NpBv59trNG2tp4rTaQFOQgt+cHaPlTSVaRPgxTjMcNPrTSX7Vy1COg5jjuAXYEVqHzJ2GLIvr9CGekqPCp+pI+uiKuDFsi1q7Mz+E4/cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=n5iniq8y; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="n5iniq8y"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 607C116495D;
	Mon,  6 Jan 2025 10:51:19 -0500 (EST)
Received: from smtpclient.apple (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E9793124F8E;
	Mon,  6 Jan 2025 10:51:18 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: Send again due to delivery etiquette [Query about ipv4 connman
 web page]
From: Grant Erickson <gerickson@nuovations.com>
X-Priority: 3
In-Reply-To: <20250106021204epcms1p8d2c0f0211503bc768cf2703096f67a3e@epcms1p8>
Date: Mon, 6 Jan 2025 07:51:08 -0800
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>,
 Grzegorz Zakiewicz <g.zakiewicz@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8AAF6A6-98AE-43D3-A6B9-C240511E43FD@nuovations.com>
References: <CGME20250106020958epcms1p500dca823c653c5a4fdd99b6c1ce7e1b9@epcms1p8>
 <20250106021204epcms1p8d2c0f0211503bc768cf2703096f67a3e@epcms1p8>
To: wy1115.lee@samsung.com
X-Mailer: Apple Mail (2.3776.700.51.11.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=content-type:mime-version:subject:from:in-reply-to:date:cc:content-transfer-encoding:message-id:references:to; s=pair-202401062137; bh=C9+icHDaL04XNWKWBgYQPYt7ZpOBQNEkWucG9ki/K7g=; b=n5iniq8yBedkmKSnGc7cL9fuA/QbNJaq6bo/KlFc6YHvGnSELqDnLUbs1+1ropMWtpHh/3lS3fjm1OgEfPY1zuYDcxiIJ/fqPoIBOeq+kj+LUIow/3PfvYhMReud71aNnnB0hgBM3gtSB9kN6/YGk/UVINsIFSUA/9YlPr6bYNMYoN47tCbRjzd0f5ubO/3X7zflmLU7ScWoXsUyWB57yRVRAPbvaLE5OMT19GZ+/hnZK63oYMvsKk+h8BWE3HM0Lx0NLQCmPk6JDbLwTbjSqXHZvoynVLu/DoJmQEC0+iNrtLkLG+6gYciBPCpeWdH++aHuziOUgBa6pbLvjbEc+A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

On Jan 5, 2025, at 6:12=E2=80=AFPM, =EC=9D=B4=EC=9B=90=EC=98=81 =
<wy1115.lee@samsung.com> wrote:
>=20
> I am testing connman on Tizen platform with the following URLs =
"http://ipv4.connman.net/online/status.html"
>=20
> Result Status: 200 OK with empty body
> As far as I remember, the response has body text in the response =
before.
>=20
> Could you check it?

The 200 status with an empty body is correct, as follows:

% curl -4 --verbose http://ipv4.connman.net/online/status.html
* Host ipv4.connman.net:80 was resolved.
* IPv6: (none)
* IPv4: 212.227.81.55, 82.165.8.211
*   Trying 212.227.81.55:80...
* Connected to ipv4.connman.net (212.227.81.55) port 80
> GET /online/status.html HTTP/1.1
> Host: ipv4.connman.net
> User-Agent: curl/8.7.1
> Accept: */*
>=20
* Request completely sent off
< HTTP/1.1 200 OK
< Server: nginx
< Date: Mon, 06 Jan 2025 15:43:48 GMT
< Content-Type: text/html
< Content-Length: 45
< Connection: close
< X-ConnMan-Status: online
<=20
<html>
<head>
</head>
<body>
</body>
</html>

The key field that ConnMan indexes off of beyond the HTTP 200 response =
status to determine success is the custom header field =
"X-ConnMan-Status" with the value "online".

If you'd like to perform your own tests with a custom URL using nginx, =
the following =E2=80=9Cserver" block for =
/etc/nginx/sites-available/default on Ubuntu 20.04 has worked well for =
me:

server {
    etag off;
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        try_files $uri $uri/ =3D404;
    }
    location /online/status.html {
        max_ranges 0;
        add_header "X-ConnMan-Status" "online";
    }
}

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

