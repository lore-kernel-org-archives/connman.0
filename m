Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527384;
	b=Brfi+BxUCZDYmAelaR/W2+fj8/x6Ld9R5l74AsYBdX4CIR/SKCBmqDG1fzX++oDjqO3R
	 8fT55vIFoa3uDyAXcNFDJoss/szBK9c/aVPnrW1U3Hbu0k8L+hw0i/UtY3puFteW5KGcs
	 xGxhoQxIXC9CsxxkwfenSxbJ+o1G65uv779RgA3ctfcRTC5/7ys0bN7kevSgWBwg0AIMi
	 UMnzNa2AvaPi+TEqcbDL0C3zDlKTzu5lvGx2/QZr9aXLyoqIJHwxq7myY1Ua0gTxncaFs
	 G++xSX15q7yraHGk/LQbOPFeXnTy7wliWX0RhBM6p76ZHEzjUuG4cFG2ubZugEH/HXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527384;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=1FmLmxZIGHgCfjQq4eqMrw3B4lOfIDuvZ6NJ5pHRAvc=;
	b=A0UKOO7KwWzENfi77S2+Iy71HV25bpsF1ltXMmbd4CCPXncT5Js1dWW2ne6SRU1qCzMF
	 lpZPmigzj95i0BrNA6lg/LTGIYbGtB52xEPutMFQA2PlNQuBtCY7w41SPF983fxRQAQXy
	 FortxppaUP0edUd8aLvDTEVrOp1tkdTrZfj6sWppNc2IzPPjGIDzHA/XK5+OFhJHZMU1X
	 SLEgJsgkLKhkVMpmUEBxC1j5XspUlWrJGKxRYipjYcU05PLDMacc9VYmKQHgQlK7vvwRN
	 UOWgCRih7RzJyaI1lZPjqQFuAfn6BRpJHIm4lqyxrWXcDC4cBuaPXoEEdOvjbwj9JpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=QWa4K+nc;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3B606A323
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 23:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C3B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=QWa4K+nc
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 04717160186
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:49:36 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B070F124B8D
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 18:49:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] iptables: Make the entry offset the same type as a jump verdict.
Date: Thu, 12 Nov 2026 15:49:34 -0800
Message-ID: <20261112234934.1627035-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=1FmLmxZIGHgCfjQq4eqMrw3B4lOfIDuvZ6NJ5pHRAvc=; b=QWa4K+ncaq+ma3syGXmM5k/D828/hwuFFoKhISoCNkBwvI0K4BhfwJhSrKL1gKwonzrURKawaGFgvNVPcDm2yo1O9TxRnpVS/ZZKcm2Q7OznGr2+4hO8mURRF5UKVLsxBtYFdTfQ4gn4Ai0Xq2iTjmlj52VugQL/oVJilY9HDp/M6gi19qwsId21Sumu3fAHS0xq9t49d81pA0Tqgk66iybX0ativef+meUuKcRDYsz2PR02GWGKhzLfKzWa394boRhupv4JnZW5CE/B/nsqxCtbNaQVeCzf2ivFu/UbXZXuYSyhfcn02i1jeZBQ53OrKPUPfjsXoSGTfXsxWwQo+w==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This addresses -Werror=sign-compare compilation errors surfaced by
both GCC and clang/LLVM in 'update_targets_reference' when
--enable-maintainer-mode is asserted and connman is configured with
--with-firewall=iptables:

    src/iptables.c:805:40: error: comparison of integer expressions
        of different signedness: 'int' and 'unsigned int'
        [-Werror=sign-compare]
    src/iptables.c:808:40: error: comparison of integer expressions
        of different signedness: 'int' and 'unsigned int'
        [-Werror=sign-compare]

The 'offset' member of 'struct connman_iptables_entry' is the
entry's byte offset within the table, and its one purpose beyond
bookkeeping is to be the target of a standard-target jump: it is
written into a 'struct xt_standard_target' 'verdict', in
'prepare_target' and for fall-through entries in
'update_targets_reference', and it is compared against existing
verdicts in 'update_targets_reference' to find jumps that must be
moved when an entry is inserted or removed. The kernel ABI defines
'verdict' as 'int', with non-negative values being jump offsets and
negative values being standard verdicts. So, rather than casting at
the comparisons, give 'offset' the same type as the verdicts it is
written into and compared against.

With that, the comparisons in 'update_targets_reference' are made in
the verdict's own signed domain. Previously, the usual arithmetic
conversions converted the verdict to 'unsigned int'. 'is_jump' does
not exclude every negative verdict (for example, -NF_STOLEN - 1), so
such a verdict would have compared as a very large unsigned value and
been adjusted as though it were a jump past the modified entry; it
now correctly compares as less than any entry offset and is left
alone.

Entry offsets are bounded by the table size, which the kernel limits
to XT_MAX_TABLE_SIZE (512 MiB) in xt_alloc_table_info, so every valid
offset is representable as an int, as it already must be to be
written into a verdict.
---
 src/iptables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iptables.c b/src/iptables.c
index a81a07792e9f..5b1f5650a30e 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -151,7 +151,7 @@ static const char *hooknames[] = {
 
 struct connman_iptables_entry {
 	int type;
-	unsigned int offset;
+	int offset;
 	int builtin;
 	int counter_idx;
 
-- 
2.52.0

