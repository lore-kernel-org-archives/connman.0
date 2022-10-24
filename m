Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D589659
	for <connman@lists.linux.dev>; Mon, 24 Oct 2022 07:03:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C598960E48;
	Mon, 24 Oct 2022 09:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1666594984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6dS5TcwjSgU0dpkiZoHM2QMntOmeHN8Qg3SSTVKsChs=;
	b=oHzdW7wOIE/HNaQbEkys9y/Ufj9PbySRjmOgJ70wMqa4gnwi9t78BIWUop7Vl5jvkX/Jx8
	47h9t5hXocB/9LWJlEobH6qKcsRy8MOCHbx2/0KcOCtgCdWIm3iOwnvIk/Sb/4vxSl6ybD
	WlgWahZKeafmsZTLpV8cTOwdvccu74T0j6rsSHLWhJGSaUjM4geNKHGaXMsIv9XMKlBfUl
	0dy/2SyjvJPN33rJhWvllWFeCuzkdYamzQzBy4teK3KajALBNZ4ydV6BdJ8PwlN9VjG8cX
	o99ubUZOXn6BxV7oRnkVP+iCTvGrXJSZhrg1gzm8v0+d4pfygKLHjVhSVQhlww==
Date: Mon, 24 Oct 2022 09:03:04 +0200
From: Daniel Wagner <wagi@monom.org>
To: Matthias Gerstner <matthias.gerstner@suse.de>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 06/16] dnsproxy: refactoring of cache_update()
Message-ID: <20221024070304.df66xm4rlvju2435@beryllium.lan>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
 <20221018084746.21959-7-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221018084746.21959-7-matthias.gerstner@suse.de>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Oct 18, 2022 at 10:47:36AM +0200, Matthias Gerstner wrote:
> - move stack variables into more localized scopes
> - use const parameters and variables where possible
> - use named constants over literal numbers
> - simplify some parsing details by using byte order macros or adding
>   some comments to make the intentions cleare

This patch makes the compiler angry:

src/dnsproxy.c: In function ‘cache_update’:
src/dnsproxy.c:1399:44: warning: pointer targets in passing argument 1 of ‘parse_response’ differ in signedness [-Wpointer-sign]
 1399 |         const int err = parse_response(msg + offset, msg_len - offset,
      |                                        ~~~~^~~~~~~~
      |                                            |
      |                                            const char *
src/dnsproxy.c:986:48: note: expected ‘const unsigned char *’ but argument is of type ‘const char *’
  986 | static int parse_response(const unsigned char *buf, size_t buflen,
      |                           ~~~~~~~~~~~~~~~~~~~~~^~~
src/dnsproxy.c:1410:46: warning: pointer targets in passing argument 1 of ‘reply_query_type’ differ in signedness [-Wpointer-sign]
 1410 |                         reply_query_type(msg + offset,
      |                                          ~~~~^~~~~~~~
      |                                              |
      |                                              const char *
src/dnsproxy.c:1345:50: note: expected ‘const unsigned char *’ but argument is of type ‘const char *’
 1345 | static int reply_query_type(const unsigned char *msg, int len)
      |                             ~~~~~~~~~~~~~~~~~~~~~^~~
src/dnsproxy.c: In function ‘forward_dns_reply’:
src/dnsproxy.c:2149:36: warning: pointer targets in passing argument 2 of ‘cache_update’ differ in signedness [-Wpointer-sign]
 2149 |                 cache_update(data, reply, reply_len);
      |                                    ^~~~~
      |                                    |
      |                                    unsigned char *
src/dnsproxy.c: In function ‘cache_update’:
src/dnsproxy.c:1365:62: note: expected ‘const char *’ but argument is of type ‘unsigned char *’
 1365 | static int cache_update(struct server_data *srv, const char *msg, size_t msg_len)
      |                                                  ~~~~~~~~~~~~^~~
src/dnsproxy.c:1399:44: warning: pointer targets in passing argument 1 of ‘parse_response’ differ in signedness [-Wpointer-sign]
 1399 |         const int err = parse_response(msg + offset, msg_len - offset,
      |                                        ~~~~^~~~~~~~
      |                                            |
      |                                            const char *
src/dnsproxy.c:986:48: note: expected ‘const unsigned char *’ but argument is of type ‘const char *’
  986 | static int parse_response(const unsigned char *buf, size_t buflen,
      |                           ~~~~~~~~~~~~~~~~~~~~~^~~
src/dnsproxy.c:1410:46: warning: pointer targets in passing argument 1 of ‘reply_query_type’ differ in signedness [-Wpointer-sign]
 1410 |                         reply_query_type(msg + offset,
      |                                          ~~~~^~~~~~~~
      |                                              |
      |                                              const char *
src/dnsproxy.c:1345:50: note: expected ‘const unsigned char *’ but argument is of type ‘const char *’
 1345 | static int reply_query_type(const unsigned char *msg, int len)
      |                             ~~~~~~~~~~~~~~~~~~~~~^~~
src/dnsproxy.c: In function ‘forward_dns_reply’:
src/dnsproxy.c:2149:36: warning: pointer targets in passing argument 2 of ‘cache_update’ differ in signedness [-Wpointer-sign]
 2149 |                 cache_update(data, reply, reply_len);
      |                                    ^~~~~
      |                                    |
      |                                    unsigned char *
src/dnsproxy.c:1365:62: note: expected ‘const char *’ but argument is of type ‘unsigned char *’
 1365 | static int cache_update(struct server_data *srv, const char *msg, size_t msg_len)
      |                                                  ~~~~~~~~~~~~^~~
