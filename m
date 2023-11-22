Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10092628D
	for <connman@lists.linux.dev>; Wed, 22 Nov 2023 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfjs3bVn"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so14285fac.0
        for <connman@lists.linux.dev>; Wed, 22 Nov 2023 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700671860; x=1701276660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ootzaqaBrUHTwich0h4T4HMGTKP0+Gs1XnN46yyOQdQ=;
        b=cfjs3bVnx/5b1LB+j4cGna7+AI4f2L+1mFb2uOjqrwqu6NG81rZ4Uj4zYZJkAppOte
         o/T8bDJFkEzRMJ0RWUdR2omyaOfL/v+jKaUCmpbE/hy9dZNIQQKM1qNM5UIKxgnVotZ2
         woJ1+5YbEBcB1WqE07HCPPUcKWUv/t6F2PJQX2mbORZI9oBXVofVeg2F1kZrJpX5A48U
         Yil5+vrCqmJEMk6UFJrJ9HTFbnGNZxpxQtp2jfQL0IGJ4RxlmkA2SCofhROSt6GPVlH0
         K5foFAQoIyEe7OzUP6DnzVK6OtNtEPLwcuaUvqIHj5vJABl5t8wM96W5odDLWYyY9RJH
         8B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700671860; x=1701276660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ootzaqaBrUHTwich0h4T4HMGTKP0+Gs1XnN46yyOQdQ=;
        b=kRTRdloVwo0drzZdJs+sfoptLarflXFGxlqTjgpMyzuE55h4HKQBW9yIizPf+lUsev
         /m/ZNYFfWMIoMR3F/wDmyujimF5fbCLSsKEnAlrFKzes6y7+/pqgHDkoYxlfWtU/h7qr
         4Jp+Iy2mjUdtxobno+fcqTcyG4TnOCWST7QmA4h7RFkKXwbeng1CS/Jl23dJcAya/jf1
         6dxk56JPs5PxCWmprE/gqGQ+5zNq84FacXvD2BKZFrj8npGQYmgCIQYkoGOVL+wTlI2X
         IPkhQKJtdCve0gpcUtnhbLVtH9X00B0Nd/uNgXqLRhRsQ5ahWOalZxMLDIDD80Ze4slR
         1x6w==
X-Gm-Message-State: AOJu0YzWLh2D70//vQwTspl0KrWCduEyoLzwfhAUVWbSX12R54cewTFA
	BaXryTfr8A4vP5FqOyFMGj8Qua/HI7c=
X-Google-Smtp-Source: AGHT+IHiKUYZk7rhx1sSc30UixmGK+cY/KNw8UYX7PNpd5W7WPHp2GMT53XIuDEj+ahWBS72veTybA==
X-Received: by 2002:a05:6870:1e8b:b0:1f5:b5ca:438d with SMTP id pb11-20020a0568701e8b00b001f5b5ca438dmr3633516oab.16.1700671860064;
        Wed, 22 Nov 2023 08:51:00 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id gl10-20020a0568703c8a00b001e9a253afa3sm425oab.49.2023.11.22.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:50:59 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denis.kenzior@getcruise.com>
Subject: [PATCH 1/1] dnsproxy: Changes
Date: Wed, 22 Nov 2023 10:47:36 -0600
Message-ID: <20231122165010.1217488-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122165010.1217488-1-denkenz@gmail.com>
References: <20231122165010.1217488-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kenzior <denis.kenzior@getcruise.com>

---
 src/dnsproxy.c | 251 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 228 insertions(+), 23 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index c497f735..b394ca50 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -262,6 +262,24 @@ static time_t round_down_ttl(time_t end_time, int ttl)
 	return end_time;
 }
 
+static
+char* find_compressed_pos(char* start, char* end)
+{
+	char* ptr = start;
+	while (ptr <= end) {
+
+		// check string end point
+		if ('\0' == *ptr) return NULL;
+
+		// check compressed signal
+		if (0xc0 == (*ptr & 0xc0)) return ptr;
+
+		ptr++;
+	}
+	DBG("ERR : reach the end position : start %p end %p", start, end);
+	return NULL;
+}
+
 static struct request_data *find_request(guint16 id)
 {
 	GSList *list;
@@ -528,6 +546,61 @@ static void destroy_request_data(struct request_data *req)
 	g_free(req);
 }
 
+static bool udp_request_refuse(struct request_data* req,
+				gpointer request, gpointer name)
+{
+	struct sockaddr *sa;
+	int sk;
+
+	if (!req) {
+		connman_error("%s: ERR : req is NULL", __func__);
+		return false;
+	}
+
+	DBG("id 0x%04x", req->srcid);
+
+	if (req->protocol == IPPROTO_UDP) {
+		if (NULL != req->request) {
+			g_free(req->request);
+			req->request = NULL;
+		}
+		req->request = g_malloc(req->request_len);
+		if (NULL == req->request) {
+			connman_error("%s: ERR : no free memory", __func__);
+			return false;
+		}
+		req->name = g_strdup(name);
+		memcpy(req->request, request, req->request_len);
+		sk = get_req_udp_socket(req);
+		sa = &req->sa;
+	} else {
+		connman_error("%s: ERR : not udp request", __func__);
+		return false;
+	}
+
+	/*
+	 * There was no reply from server at all.
+	 */
+	struct domain_hdr *hdr;
+
+	hdr = (void *)(req->request + protocol_offset(req->protocol));
+	hdr->id = req->srcid;
+
+	if (sk >= 0)
+		send_response(sk, req->request, req->request_len,
+			sa, req->sa_len, req->protocol);
+
+	req->timeout = 0;
+	g_free(req->resp);
+	g_free(req->request);
+	g_free(req->name);
+	/* to avoid double free req */
+	//g_free(req);
+
+	return true;
+}
+
+
 static gboolean request_timeout(gpointer user_data)
 {
 	struct request_data *req = user_data;
@@ -836,7 +909,7 @@ static struct cache_entry *cache_check(gpointer request, int *qtype, int proto)
 static int get_name(int counter,
 		unsigned char *pkt, unsigned char *start, unsigned char *max,
 		unsigned char *output, int output_max, int *output_len,
-		unsigned char **end, char *name, int *name_len)
+		unsigned char **end, char *name, size_t max_name, int *name_len)
 {
 	unsigned char *p;
 
@@ -857,7 +930,7 @@ static int get_name(int counter,
 
 			return get_name(counter + 1, pkt, pkt + offset, max,
 					output, output_max, output_len, end,
-					name, name_len);
+					name, max_name, name_len);
 		} else {
 			unsigned label_len = *p;
 
@@ -867,6 +940,9 @@ static int get_name(int counter,
 			if (*output_len > output_max)
 				return -ENOBUFS;
 
+			if ((*name_len + 1 + label_len + 1) > max_name)
+				return -ENOBUFS;
+
 			/*
 			 * We need the original name in order to check
 			 * if this answer is the correct one.
@@ -898,14 +974,14 @@ static int parse_rr(unsigned char *buf, unsigned char *start,
 			unsigned char *response, unsigned int *response_size,
 			uint16_t *type, uint16_t *class, int *ttl, int *rdlen,
 			unsigned char **end,
-			char *name)
+			char *name, size_t max_name)
 {
 	struct domain_rr *rr;
 	int err, offset;
 	int name_len = 0, output_len = 0, max_rsp = *response_size;
 
 	err = get_name(0, buf, start, max, response, max_rsp,
-		&output_len, end, name, &name_len);
+			&output_len, end, name, max_name, &name_len);
 	if (err < 0)
 		return err;
 
@@ -1031,7 +1107,8 @@ static int parse_response(unsigned char *buf, int buflen,
 		memset(rsp, 0, sizeof(rsp));
 
 		ret = parse_rr(buf, ptr, buf + buflen, rsp, &rsp_len,
-			type, class, ttl, &rdlen, &next, name);
+			type, class, ttl, &rdlen, &next, name,
+			sizeof(name) - 1);
 		if (ret != 0) {
 			err = ret;
 			goto out;
@@ -1097,7 +1174,7 @@ static int parse_response(unsigned char *buf, int buflen,
 			 */
 			ret = get_name(0, buf, next - rdlen, buf + buflen,
 					rsp, rsp_len, &output_len, &end,
-					name, &name_len);
+					name, sizeof(name) - 1, &name_len);
 			if (ret != 0) {
 				/* just ignore the error at this point */
 				ptr = next;
@@ -1719,12 +1796,90 @@ static char *convert_label(char *start, char *end, char *ptr, char *uptr,
 {
 	int pos, comp_pos;
 	char name[NS_MAXLABEL];
+	memset(name, 0, NS_MAXLABEL);
 
-	pos = dn_expand((u_char *)start, (u_char *)end, (u_char *)ptr,
-			name, NS_MAXLABEL);
-	if (pos < 0) {
-		DBG("uncompress error [%d/%s]", errno, strerror(errno));
-		goto out;
+	char* compressed_ptr = find_compressed_pos(ptr, end);
+	if (NULL == compressed_ptr) {
+		/*
+		 * The whole name is not compressed :
+		 *
+		 *  --------------------------------------------------------------
+		 *  | <host len> | a | . | d | o | m | a | i | n | . | c | o | m |
+		 *  --------------------------------------------------------------
+		 *  \_____                    dn_expand                      ___/
+		 *        \                                                 /
+		 *         -------------------------------------------------
+		 *         | a | . | d | o | m | a | i | n | . | c | o | m |
+		 *         -------------------------------------------------
+		 */
+		int ptr_len = strlen(ptr);
+		if (ptr_len > 0) {
+			// remove length part of domain name
+			pos = dn_expand((u_char *)start, (u_char *)end, (u_char *)ptr,
+					name, NS_MAXLABEL);
+			if (pos < 0) {
+				DBG("uncompress error for uncompressed name [%d/%s]", errno, strerror(errno));
+				goto out;
+			}
+		} else {
+			DBG("WARN : ptr length is 0");
+			pos = 1;
+			name[0] = '\0';
+		}
+	} else if (compressed_ptr == ptr) {
+		/*
+		 * The whole name is compressed :
+		 *
+		 *                       ----------------
+		 *                       | 0xc0 | <pos> |
+		 *                       ----------------
+		 *       _______________/                \______________
+		 *      /                   dn_expand                   \
+		 *      -------------------------------------------------
+		 *      | a | . | d | o | m | a | i | n | . | c | o | m |
+		 *      -------------------------------------------------
+		 */
+		pos = dn_expand((u_char *)start, (u_char *)end, (u_char *)ptr,
+				name, NS_MAXLABEL);
+		if (pos < 0) {
+			DBG("uncompress error for whole name compressed [%d/%s]", errno, strerror(errno));
+			goto out;
+		}
+	} else {
+		/*
+		 * Part of the name is compressed :
+		 *
+		 *  -------------------------------------------------------------
+		 *  | <host len> | a | . | d | o | m | a | i | n | 0xc0 | <pos> |
+		 *  -------------------------------------------------------------
+		 *  \_____                     dn_expand                     ___/
+		 *        \                                                 /
+		 *         -------------------------------------------------
+		 *         | a | . | d | o | m | a | i | n | . | c | o | m |
+		 *         -------------------------------------------------
+		 */
+		if (compressed_ptr < ptr || (compressed_ptr - ptr) >= NS_MAXLABEL) {
+			DBG("ERR : too long name : compressed_ptr(%p) ptr(%p)", compressed_ptr, ptr);
+			goto out;
+		}
+
+		int uncompressed_len = compressed_ptr - ptr;
+		if (uncompressed_len <= 0) {
+			DBG("ERR : uncompressed_len %d", uncompressed_len);
+			goto out;
+		}
+		memcpy(name, ptr + 1, uncompressed_len - 1);
+
+		name[uncompressed_len - 1] = '.';  // add '.' between host and domain
+
+		char* name_ptr = &name[uncompressed_len];
+		pos = dn_expand((u_char *)start, (u_char *)end, (u_char *)compressed_ptr,
+				name_ptr, NS_MAXLABEL);
+		if (pos < 0) {
+			DBG("ERR : uncompress error for part compressed [%d/%s]", errno, strerror(errno));
+			goto out;
+		}
+		pos += uncompressed_len;
 	}
 
 	/*
@@ -1737,6 +1892,7 @@ static char *convert_label(char *start, char *end, char *ptr, char *uptr,
 		goto out;
 	}
 
+	DBG("pos %d comp_pos %d", pos, comp_pos);
 	*used_comp = pos;
 	*used_uncomp = comp_pos;
 
@@ -1752,9 +1908,10 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 {
 	char *uptr = *uncompressed_ptr; /* position in result buffer */
 
-	DBG("count %d ptr %p end %p uptr %p", field_count, ptr, end, uptr);
+	DBG("count %d ptr %p start %p end %p uptr %p", field_count, ptr, start, end, uptr);
 
 	while (field_count-- > 0 && ptr < end) {
+		DBG("field_count %d", field_count);
 		int dlen;		/* data field length */
 		int ulen;		/* uncompress length */
 		int pos;		/* position in compressed string */
@@ -1762,9 +1919,13 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		uint16_t dns_type, dns_class;
 		int comp_pos;
 
+		memset(name, 0, NS_MAXLABEL);
+
 		if (!convert_label(start, end, ptr, name, NS_MAXLABEL,
-					&pos, &comp_pos))
+					&pos, &comp_pos)) {
+			DBG("ERR : convert failed");
 			goto out;
+		}
 
 		/*
 		 * Copy the uncompressed resource record, type, class and \0 to
@@ -1772,10 +1933,16 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		 */
 
 		ulen = strlen(name);
-		strncpy(uptr, name, uncomp_len - (uptr - uncompressed));
+		if (ulen <= 0) {
+			DBG("WARN : name is NULL");
+			pos = 1;
+			ulen = 0;
+		} else {
+			strncpy(uptr, name, uncomp_len - (uptr - uncompressed));
 
-		DBG("pos %d ulen %d left %d name %s", pos, ulen,
-			(int)(uncomp_len - (uptr - uncompressed)), uptr);
+			DBG("pos %d ulen %d left %d ", pos, ulen,
+				(int)(uncomp_len - (uptr - uncompressed)));
+		}
 
 		uptr += ulen;
 		*uptr++ = '\0';
@@ -1791,8 +1958,10 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		dns_type = uptr[0] << 8 | uptr[1];
 		dns_class = uptr[2] << 8 | uptr[3];
 
-		if (dns_class != ns_c_in)
+		if (dns_class != ns_c_in) {
+			DBG("ERR : dns_class %d", dns_class);
 			goto out;
+		}
 
 		ptr += NS_RRFIXEDSZ;
 		uptr += NS_RRFIXEDSZ;
@@ -1801,8 +1970,13 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		 * Then the variable portion of the result (data length).
 		 * Typically this portion is also compressed
 		 * so we need to uncompress it also when necessary.
+		 *
+		 * RFC 1035 : Standard RRs
+		 *		CNAME RDATA, HINFO RDATA, MX RDATA, NS RDATA,
+		 *		PTR RDATA, SOA RDATA, TXT RDATA
 		 */
-		if (dns_type == ns_t_cname) {
+		DBG("dns_type %d", dns_type);
+		if (dns_type == ns_t_cname || dns_type == ns_t_ns) {
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
@@ -1861,11 +2035,15 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			ptr += 20;
 			total_len += 20;
 
+			DBG("total_len = %d", total_len);
+
 			/*
 			 * Finally fix the length of the data part
 			 */
 			len_ptr[0] = total_len << 8;
 			len_ptr[1] = total_len & 0xff;
+		} else {
+			DBG(" ERR : not support dns_type(%d) !!", dns_type);
 		}
 
 		*uncompressed_ptr = uptr;
@@ -1882,6 +2060,8 @@ static int strip_domains(char *name, char *answers, int maxlen)
 	uint16_t data_len;
 	int name_len = strlen(name);
 	char *ptr, *start = answers, *end = answers + maxlen;
+	DBG("start %p end %p : answers %p maxlen %d name_len %d",
+			start, end, answers, maxlen, name_len);
 
 	while (maxlen > 0) {
 		ptr = strstr(answers, name);
@@ -1898,19 +2078,26 @@ static int strip_domains(char *name, char *answers, int maxlen)
 				end -= domain_len;
 				maxlen -= domain_len;
 			}
+		} else {
+			DBG("WARN : not found domains");
+			ptr = answers;
 		}
 
 		answers += strlen(answers) + 1;
 		answers += 2 + 2 + 4;  /* skip type, class and ttl fields */
 
 		data_len = answers[0] << 8 | answers[1];
+		DBG("data_len = %d", data_len);
 		answers += 2; /* skip the length field */
 
-		if (answers + data_len > end)
+		if (answers + data_len > end) {
+			DBG("ERR: answers %p data_len %d end %p", answers, data_len, end);
 			return -EINVAL;
+		}
 
 		answers += data_len;
 		maxlen -= answers - ptr;
+		DBG("answers %p ptr %p maxlen = %d", answers, ptr, maxlen);
 	}
 
 	return end - start;
@@ -2022,6 +2209,7 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				memcpy(uptr, ptr, len);
 
 				uptr[len] = '\0'; /* host termination */
+				DBG("host name is %s", uptr);
 				uptr += len + 1;
 
 				/*
@@ -2050,22 +2238,28 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 						(char *)reply + offset, eom,
 						ptr, uncompressed, NS_MAXDNAME,
 						&uptr);
-				if (ptr == NULL)
+				if (ptr == NULL) {
+					DBG("ERR : parse answer section failed");
 					goto out;
+				}
 
 				ptr = uncompress(ntohs(hdr->nscount),
 						(char *)reply + offset, eom,
 						ptr, uncompressed, NS_MAXDNAME,
 						&uptr);
-				if (ptr == NULL)
+				if (ptr == NULL) {
+					DBG("ERR : parse authority section failed");
 					goto out;
+				}
 
 				ptr = uncompress(ntohs(hdr->arcount),
 						(char *)reply + offset, eom,
 						ptr, uncompressed, NS_MAXDNAME,
 						&uptr);
-				if (ptr == NULL)
+				if (ptr == NULL) {
+					DBG("ERR : parse attached section failed");
 					goto out;
+				}
 
 				/*
 				 * The uncompressed buffer now contains almost
@@ -2077,10 +2271,11 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				 * domain part. Note that glibc getaddrinfo()
 				 * works differently and accepts FQDN in answer
 				 */
+				DBG("uptr %p ptr %p answers %p", uptr, ptr, answers);
 				new_len = strip_domains(uncompressed, answers,
 							uptr - answers);
 				if (new_len < 0) {
-					DBG("Corrupted packet");
+					DBG("Corrupted packet %d", new_len);
 					return -EINVAL;
 				}
 
@@ -2123,8 +2318,10 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 out:
 	if (req->numresp < req->numserv) {
 		if (hdr->rcode > ns_r_noerror) {
+			DBG("WARN : response has error");
 			return -EINVAL;
 		} else if (hdr->ancount == 0 && req->append_domain) {
+			DBG("WARN : no answer section");
 			return -EINVAL;
 		}
 	}
@@ -2134,6 +2331,7 @@ out:
 	if (protocol == IPPROTO_UDP) {
 		sk = get_req_udp_socket(req);
 		if (sk < 0) {
+			DBG("ERR : socket error");
 			errno = -EIO;
 			err = -EIO;
 		} else
@@ -2621,6 +2819,7 @@ static bool resolv(struct request_data *req,
 				gpointer request, gpointer name)
 {
 	GSList *list;
+	bool has_useful_server = false;
 
 	for (list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
@@ -2641,11 +2840,17 @@ static bool resolv(struct request_data *req,
 				continue;
 			}
 		}
+		has_useful_server = true;
 
 		if (ns_resolv(data, req, request, name) > 0)
 			return true;
 	}
 
+	if (false == has_useful_server) {
+		connman_warn("%s: WARN : no useful dns server, try to refuse request", __func__);
+		udp_request_refuse(req, request, name);
+		return true;
+	}
 	return false;
 }
 
-- 
2.42.0

