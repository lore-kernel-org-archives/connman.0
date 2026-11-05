Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.34.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883713;
	b=U718tKA9uzfBJ+33b708l1vdg7O0o1cTcr+HmPF+AO4mgjfU/bgGNwAOwBNZlmvhNCWv
	 WCd5C86XcGQLS1R0wB4m3sliYVad01SgjD0e21joKMmB/lTxUhGuo3A90iGggaDrQ44nO
	 tHj90FZCGHZQo033yd9ODQ5qeMwACn6LK7AQ1crd6Q+t0aY7OD3/DMJzx8aPte0nBQlvf
	 mNUjjzFttNrrxPNRYt1C2hzBrOVflY4LA35fODaKAtxSI/LxCv/yrYC22LrQwRIquI1Lr
	 eYfX2VM3Fznace8gUeOzuOwOG3Rgt2pH3WGTDntfjVaMPRqEM1ksAv1FtrDxVWmb7Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883713;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:x-ovh-tracer-id:X-VR-SPAMSTATE:X-VR-SPAMSCORE:
	 X-VR-SPAMCAUSE;
	bh=5FznetuU2FY4h0l7qBpqAaIqa4O6UFdfySSLKuYEw8I=;
	b=VsyO+u++A+UQDtDJ1oCWK5BbU73GImd12QoM5JLyaIPbh512e4HC7BTsjDIPy0Ags2JB
	 0pP7+oMuY98mO7YXrLAqaKg2fZeaX10ocd77D/0mEU3Drb1S96hZ/rO9WTqXLgu8brQxK
	 BcYi3VdIjztksExOvwbUqF5F9PXErNQi524f9L1KGKmxSdW9AmUGbUNBuUfBb9PcLLJF5
	 Pc56nfSuWE37VXyGgFB5AHhNmstB2gFttdH1PUhX/2ZZJq2Kqu79koKYW1300e9oMmtsD
	 4kSfvbpdmRXzZ8T3ZLasH5ydYOkV/Sc3nqok8ZR2m02YSvRCU2xvIX622qpYceAJX7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=46.105.34.219
Received: from 15.mo23.mail-out.ovh.net (15.mo23.mail-out.ovh.net [46.105.34.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDD606A31B
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDCDD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.111.174.88])
	by mo23.mail-out.ovh.net (Postfix) with SMTP id 4jL2WY1khlz7xVV
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:45 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [PATCH] dnsproxy: Check the question of server replies
Date: Thu, 5 Nov 2026 13:01:38 +0000
Message-ID: <b2a0934fd93f76fca771e2a73d6da6d9d1272f76.1793883047.git.email@samnazarko.co.uk>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CAS4.indiv.local (172.16.1.4) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9095300923629752300
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE5l00EXk2gTxAZSvnc2uQYJzrxEuvuIrfGGVt8HKz1AcHxBSWw8J5AjzuJUV+7auiL0kRrsyulNw7fiurCKHudIaZ4k+SBJRqUxmKBVTt/KR3nN2+9zF791ncqrWeD1exFEn4ouRh/qtgdSSLQBng0U3+vb7UM/MeLUg6V+llAiOZcBURKO1T3/dx/yrTVZ6tB8Ifa0Clos2TdykixMDZWBKXwsd1Ctdl02BnrJxYY8BnRsMJdmE6B5UqVGF9brwdby68ryWJveyepDlAcjFIqZvTjWgQOh3Jh2gor3JUdx3xUzI2t0QXPe1bniAZYoHcdOouDgN4xLUM/g39nPP36GOvaISrlc0pVUZkG4HQBdOIcCxjbzLQt9YyIh312e655p/Jhiq5nYWMjiaKoc9rqBsO0JZhBkACLVPmHO8Tk0frAEJBFyvD1QBxFy6h7A4LiQ4QsgfQj/0eEQVkrTrfMGXMucP0R+tT21gThQibz2GBvKHNjMV044KeaNK0Fc1FikOCI8yBd1iv0qJDEapdpXL7R6WbbVyWXIEThFoN7SPs0Pxz4VXY2K1IB4m3QPcz0KmDmpla+564loK1i1o0ROlNhViVVmFKPQkBGlvTQyqKr1r22PWULh4LAW1dMKJpYve+ASixewPYNiH9y1PpppShL/VIM7fDu6FNL5T5HOw

Replies from DNS servers are matched to pending requests by their 16
bit ID only. The proxy keeps one socket per server, so its source port
stays the same, and once that port is known a forged reply only has to
match the ID; sending all 65536 IDs always succeeds. The forged reply
does not even need to be about the name that was asked for: it
completes whatever request has that ID and is cached under the name it
carries, so it also answers later queries for that name.

Only accept a reply whose question matches the request: the same name
(compared without regard to case, as servers may change it), type and
class, or for the alternative ID the name with one of the search
domains appended. Other replies are ignored and the request keeps
waiting for the real answer, as in dnsmasq.
---
 src/dnsproxy.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 1dd2f7f5..1140e2e7 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -347,6 +347,122 @@ static struct request_data *find_request(guint16 id)
 	return NULL;
 }
=20
+/*
+ * Returns the length of the uncompressed question name of a DNS message,
+ * including the root label, or 0 if it is malformed.
+ */
+static size_t question_name_len(const unsigned char *msg, size_t len)
+{
+	size_t pos =3D DNS_HEADER_SIZE;
+
+	while (pos < len && msg[pos]) {
+		if (msg[pos] & NS_CMPRSFLGS)
+			return 0;
+
+		pos +=3D msg[pos] + 1;
+	}
+
+	if (pos >=3D len || pos + 1 + DNS_QTYPE_QCLASS_SIZE > len)
+		return 0;
+
+	return pos + 1 - DNS_HEADER_SIZE;
+}
+
+static bool labels_equal(const unsigned char *a, const unsigned char *b,
+								size_t len)
+{
+	for (size_t i =3D 0; i < len; i++) {
+		if (g_ascii_tolower(a[i]) !=3D g_ascii_tolower(b[i]))
+			return false;
+	}
+
+	return true;
+}
+
+/* Whether the wire format labels spell the dotted name */
+static bool labels_match_name(const unsigned char *labels, const char *nam=
e)
+{
+	while (*labels) {
+		size_t len =3D strcspn(name, ".");
+
+		if (len !=3D *labels || g_ascii_strncasecmp(name,
+					(const char *) labels + 1, len) !=3D 0)
+			return false;
+
+		labels +=3D len + 1;
+		name +=3D len;
+		if (*name =3D=3D '.')
+			name++;
+	}
+
+	return *name =3D=3D '\0';
+}
+
+/* Whether the wire format name is one of the configured search domains */
+static bool is_search_domain(const unsigned char *labels)
+{
+	for (GSList *list =3D server_list; list; list =3D list->next) {
+		struct server_data *data =3D list->data;
+
+		for (GList *dom =3D data->domains; dom; dom =3D dom->next) {
+			const char *domain =3D dom->data;
+
+			if (domain && *domain &&
+					labels_match_name(labels, domain))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * A reply must answer the question of the request, or for the alternative
+ * ID the question with one of the search domains appended. Anything else
+ * is ignored so that it can neither complete nor be cached for the
+ * request.
+ */
+static bool reply_matches_request(const struct request_data *req,
+				const unsigned char *reply, size_t reply_len,
+				int protocol)
+{
+	const size_t req_offset =3D protocol_offset(req->protocol);
+	const size_t reply_offset =3D protocol_offset(protocol);
+	const unsigned char *question, *answer;
+	const struct domain_hdr *hdr;
+	size_t question_len, answer_len;
+
+	if (!req->request || req->request_len <=3D req_offset ||
+					reply_len <=3D reply_offset)
+		return false;
+
+	question =3D (const unsigned char *) req->request + req_offset;
+	answer =3D reply + reply_offset;
+	hdr =3D (const void *) answer;
+
+	question_len =3D question_name_len(question,
+					req->request_len - req_offset);
+	answer_len =3D question_name_len(answer, reply_len - reply_offset);
+	if (!question_len || !answer_len || ntohs(hdr->qdcount) !=3D 1)
+		return false;
+
+	question +=3D DNS_HEADER_SIZE;
+	answer +=3D DNS_HEADER_SIZE;
+
+	/* QTYPE and QCLASS */
+	if (memcmp(question + question_len, answer + answer_len,
+					DNS_QTYPE_QCLASS_SIZE) !=3D 0)
+		return false;
+
+	if (hdr->id =3D=3D req->altid && req->altid !=3D req->dstid)
+		return answer_len > question_len &&
+			labels_equal(question, answer, question_len - 1) &&
+			is_search_domain(answer + question_len - 1);
+
+	return answer_len =3D=3D question_len &&
+			labels_equal(question, answer, question_len);
+}
+
 static struct server_data *find_server(int index,
 					const char *server,
 						int protocol)
@@ -2198,6 +2314,12 @@ static struct request_data* lookup_request(
 	if (!req)
 		return NULL;
=20
+	if (!reply_matches_request(req, reply, len, protocol)) {
+		debug("Ignoring reply for another question (id 0x%04x)",
+								hdr->id);
+		return NULL;
+	}
+
 	debug("req %p dstid 0x%04x altid 0x%04x rcode %d",
 			req, req->dstid, req->altid, hdr->rcode);
=20

base-commit: 9e46e4a021cd8566b942d1a72b41b14a0a58f506
--=20
2.34.1

