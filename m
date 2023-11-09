Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603E39842
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6FBDF7318C
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:46:54 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 33D15731EA
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:46:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 1/3] gweb: Add HTTP status code mnemonics.
Date: Thu, 9 Nov 2023 15:46:53 -0800
References: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
Message-Id: <5B0970DE-60B6-4DB2-9332-D41E6C01CED3@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

To better make the GWeb code self-documenting and at-a-glance-
understandable, this adds mnemonics from IANA at
https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
for the currently-published set of HTTP status codes.
---
 gweb/gweb.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/gweb/gweb.h b/gweb/gweb.h
index 6c28542a..8a6304e3 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -31,6 +31,76 @@
 extern "C" {
 #endif
 
+/**
+ *  Hypertext Transfer Protocol (HTTP) Status Code mnemonics.
+ *
+ *  From <https://www.iana.org/assignments/http-status-codes/
+ *  http-status-codes.xhtml>
+ */
+enum GWebStatusCode {
+	GWEB_HTTP_STATUS_CODE_UNKNOWN = 000,
+	GWEB_HTTP_STATUS_CODE_CONTINUE = 100,
+	GWEB_HTTP_STATUS_CODE_SWITCHING_PROTOCOLS = 101,
+	GWEB_HTTP_STATUS_CODE_PROCESSING = 102,
+	GWEB_HTTP_STATUS_CODE_EARLY_HINTS = 103,
+	GWEB_HTTP_STATUS_CODE_OK = 200,
+	GWEB_HTTP_STATUS_CODE_CREATED = 201,
+	GWEB_HTTP_STATUS_CODE_ACCEPTED = 202,
+	GWEB_HTTP_STATUS_CODE_NON_AUTHORITATIVE_INFORMATION = 203,
+	GWEB_HTTP_STATUS_CODE_NO_CONTENT = 204,
+	GWEB_HTTP_STATUS_CODE_RESET_CONTENT = 205,
+	GWEB_HTTP_STATUS_CODE_PARTIAL_CONTENT = 206,
+	GWEB_HTTP_STATUS_CODE_MULTI_STATUS = 207,
+	GWEB_HTTP_STATUS_CODE_ALREADY_REPORTED = 208,
+	GWEB_HTTP_STATUS_CODE_IM_USED = 226,
+	GWEB_HTTP_STATUS_CODE_MULTIPLE_CHOICES = 300,
+	GWEB_HTTP_STATUS_CODE_MOVED_PERMANENTLY = 301,
+	GWEB_HTTP_STATUS_CODE_FOUND = 302,
+	GWEB_HTTP_STATUS_CODE_SEE_OTHER = 303,
+	GWEB_HTTP_STATUS_CODE_NOT_MODIFIED = 304,
+	GWEB_HTTP_STATUS_CODE_USE_PROXY = 305,
+	GWEB_HTTP_STATUS_CODE_TEMPORARY_REDIRECT = 307,
+	GWEB_HTTP_STATUS_CODE_PERMANENT_REDIRECT = 308,
+	GWEB_HTTP_STATUS_CODE_BAD_REQUEST = 400,
+	GWEB_HTTP_STATUS_CODE_UNAUTHORIZED = 401,
+	GWEB_HTTP_STATUS_CODE_PAYMENT_REQUIRED = 402,
+	GWEB_HTTP_STATUS_CODE_FORBIDDEN = 403,
+	GWEB_HTTP_STATUS_CODE_NOT_FOUND = 404,
+	GWEB_HTTP_STATUS_CODE_METHOD_NOT_ALLOWED = 405,
+	GWEB_HTTP_STATUS_CODE_NOT_ACCEPTABLE = 406,
+	GWEB_HTTP_STATUS_CODE_PROXY_AUTHENTICATION_REQUIRED = 407,
+	GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT = 408,
+	GWEB_HTTP_STATUS_CODE_CONFLICT = 409,
+	GWEB_HTTP_STATUS_CODE_GONE = 410,
+	GWEB_HTTP_STATUS_CODE_LENGTH_REQUIRED = 411,
+	GWEB_HTTP_STATUS_CODE_PRECONDITION_FAILED = 412,
+	GWEB_HTTP_STATUS_CODE_CONTENT_TOO_LARGE = 413,
+	GWEB_HTTP_STATUS_CODE_URI_TOO_LONG = 414,
+	GWEB_HTTP_STATUS_CODE_UNSUPPORTED_MEDIA_TYPE = 415,
+	GWEB_HTTP_STATUS_CODE_RANGE_NOT_SATISFIABLE = 416,
+	GWEB_HTTP_STATUS_CODE_EXPECTATION_FAILED = 417,
+	GWEB_HTTP_STATUS_CODE_MISDIRECTED_REQUEST = 421,
+	GWEB_HTTP_STATUS_CODE_UNPROCESSABLE_CONTENT = 422,
+	GWEB_HTTP_STATUS_CODE_LOCKED = 423,
+	GWEB_HTTP_STATUS_CODE_FAILED_DEPENDENCY = 424,
+	GWEB_HTTP_STATUS_CODE_TOO_EARLY = 425,
+	GWEB_HTTP_STATUS_CODE_UPGRADE_REQUIRED = 426,
+	GWEB_HTTP_STATUS_CODE_PRECONDITION_REQUIRED = 428,
+	GWEB_HTTP_STATUS_CODE_TOO_MANY_REQUESTS = 429,
+	GWEB_HTTP_STATUS_CODE_REQUEST_HEADER_FIELDS_TOO_LARGE = 431,
+	GWEB_HTTP_STATUS_CODE_UNAVAILABLE_FOR_LEGAL_REASONS = 451,
+	GWEB_HTTP_STATUS_CODE_INTERNAL_SERVER_ERROR = 500,
+	GWEB_HTTP_STATUS_CODE_NOT_IMPLEMENTED = 501,
+	GWEB_HTTP_STATUS_CODE_BAD_GATEWAY = 502,
+	GWEB_HTTP_STATUS_CODE_SERVICE_UNAVAILABLE = 503,
+	GWEB_HTTP_STATUS_CODE_GATEWAY_TIMEOUT = 504,
+	GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED = 505,
+	GWEB_HTTP_STATUS_CODE_VARIANT_ALSO_NEGOTIATES = 506,
+	GWEB_HTTP_STATUS_CODE_INSUFFICIENT_STORAGE = 507,
+	GWEB_HTTP_STATUS_CODE_LOOP_DETECTED = 508,
+	GWEB_HTTP_STATUS_CODE_NETWORK_AUTHENTICATION_REQUIRED = 511
+};
+
 struct _GWeb;
 struct _GWebResult;
 struct _GWebParser;
-- 
2.42.0

