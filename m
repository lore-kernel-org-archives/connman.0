Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745622;
	b=aIOZQjsFu+M2zr+zla1tN9SgLZIWUkXxS9hX2mfVUdyqKQgIuhYK2mv9L9lT6TE0KJ4q
	 XXUJoLXjLmhpCSaj7qcImeauLbdbasp7IrsYBL+jV8Sj1AdA8yXOR617Szubc4TxCXCwp
	 yRwyMz47C/08Wfk6LinlxST3haKDt155sc6rZzUYP5z441jtbDjJjcpP8IuUmXq5qskCb
	 S0VdAa1TiMXBrPqxn0tUgK6o/P+td+Dkrlhuh8kDhs5vEjcTlqCbPSIE3cogJJu+GUwkg
	 FVNY2TO2tB145Vsbzrqb7cJlDpXBmBuiGujNr8u0SAixlfqCx8SsGexfnF6bRqAHLHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745622;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=2IswYIaBF1IGqS7lyN8g8w1QHkipQsj/CjHXDRJUDVM=;
	b=N4XUxYrGE8lDfgn2f/1aASdCcM10npnwdz8Y38kx9zg+FK4cSKge4XTN9J2FH7vg75JT
	 /vG5mbbce/+L5OhrVqWL6N8fQFDjuE4I39PZ0wu0X9ePsOdw6tDadpAamIdsTxl82faze
	 OFKZx/cXJL4965DT24ShmsPGKYrd8QkACYJYdHgLMr0uGxqxrOuVnZuM7QfrzpRgPx5rE
	 d2X6OSY+OsvpktVWOTOE/Zz7uN4CgIXyWwEAPhu/ugq934GXxLUaqR14npJIODGFmVnH0
	 l1ftOKsBO7o0JXCqlDeTXRF5mti0nN6jk5ogSVpvWto7r/6WCXzGSV6BeSeGsXjc2wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=XhqAG6uD;
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ABB606A31A
	for <connman@lists.linux.dev>; Fri, 23 Oct 2026 08:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31ABB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=XhqAG6uD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792745619; x=1793004819;
	bh=2IswYIaBF1IGqS7lyN8g8w1QHkipQsj/CjHXDRJUDVM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XhqAG6uDA8t1xUUQL65x3tItEslfBKAPdQjvKHcPn4T3IvAVAaE7tJS6W8/PsNJFr
	 /xXACrYzu6Xej1VJmvTe09dzoqDf9MJwtUgbjqwzg5SxMkCNUAC8aCwbexiTER9ZFG
	 0xBmlTR+9qJYTdUM1ZKCaFvK7niZw8Mr4A17vAU9faYesbi331zlAgN6S/INXFSTL0
	 NI0P8SNo8YKGtUOMSXp+H03FD2YNG2uB1n8HxXkB14XxbAId7i2dkfvc6efJ5BoLc+
	 h7r/9nxFYQWAMosZ0zy3/llEWHZDzUsB4rOW7Kj7WF/uI8LJ3ni2aZBYE8JkAJoakq
	 2WrR4GTT4Kydg==
Date: Fri, 23 Oct 2026 08:53:35 +0000
To: connman@lists.linux.dev
From: Andrei Miu <andimiu@pm.me>
Cc: cve@kernel.org
Subject: [PATCH] gdhcp: fix stack buffer overflow in get_domains()
Message-ID: <179274561161.81299.4579745057858200074@pm.me>
Feedback-ID: 230009826:user:proton
X-Pm-Message-ID: 05be36dbbc8866b8168acc61cd2e07972e4c9d79
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------ab206b02583c7185591e8ebf1a748d63bd9d9c5b8708cf3cf60a05199ccd8bb5"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------ab206b02583c7185591e8ebf1a748d63bd9d9c5b8708cf3cf60a05199ccd8bb5
From: Andrei Miu <andimiu@pm.me>
To: connman@lists.linux.dev
Cc: cve@kernel.org
Subject: [PATCH] gdhcp: fix stack buffer overflow in get_domains()
Date: Fri, 23 Oct 2026 10:53:31 +0200
Message-ID: <179274561161.81299.4579745057858200074@pm.me>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2073399584511629323=="

--===============2073399584511629323==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

gdhcp: fix stack buffer overflow in get_domains()

get_domains() copied a fixed NS_MAXDNAME (1025) bytes from the
DOMAIN_LIST (option 24) value into the 1026-byte stack buffer
dns_name regardless of the actual option length, and then walked
DNS labels with an unbounded 'c += jump + 1' loop. A crafted
DHCPv6 REPLY with a DOMAIN_LIST option of >= 1025 non-zero bytes
makes the label walk leave the buffer and read/write '.' past its
end in attacker-chosen strides (stride = label byte + 1), i.e.
out-of-bounds accesses past the 1026-byte stack buffer in
connmand (running as root). On stack-zeroing kernels the walk
performs an out-of-bounds read instead and exits at the first
zero byte.

DHCPv6 REPLY messages are unauthenticated and the transaction id
and CLIENTID DUID are observable on the wire (INFORMATION-REQUEST
is multicast to ff02::1:2), so any on-link attacker can trigger
this.

Fix by bounding the copy to the remaining option length,
NUL-terminating the buffer, and
 stopping the label walk at the
end of the copied data.

Fixes: bb06c47101ca24 ("gdhcp: Domain search list DHCPv6 option is checked")

---

Hello,

I found a stack out-of-bounds read/write in get_domains()
(gdhcp/client.c), reached from an accepted DHCPv6 REPLY
DOMAIN_LIST option. Details:

- Trigger requires only on-link position: a forgeable RA (O=1)
  makes connmand start stateless DHCPv6, it multicasts an
  INFORMATION-REQUEST with DOMAIN_LIST in the ORO to ff02::1:2,
  and an attacker who lifts the xid and CLIENTID off the wire can
  unicast a forged REPLY (matching xid, equal CLIENTID, one
  SERVERID) carrying a long DOMAIN_LIST option. gdhcp's owner
  check accepts it and get_dhcpv6_request() reaches get_domains().

- The out-of-bounds access is confirmed with an AddressSanitizer
  harness built from the verbatim get_domains(): for a DOMAIN_LIST
  value of >= 1025 non-zero bytes the label walk leaves the
  1026-byte dns_name buffer, e.g. "stack-buffer-ove
rflow ...
  '[48, 1074) dns_name' ... access at offset 1104 overflows this
  variable", i.e. ~30 bytes past the buffer, in the
  'while (c && *c)' loop.

- The out-of-bounds writes ('.' at attacker-chosen strides) reach
  the stack canary / saved-register region. Whether the canary is
  actually clobbered depends on the fill pattern and stack layout:
  a small stride reliably corrupts it and aborts connmand (root)
  with "*** stack smashing detected ***" / SIGABRT, while a large
  stride can step over the canary and still perform OOB
  read/writes. Net effect: an unauthenticated on-link attacker can
  crash the root daemon.

- The patch below was tested against a 7505-case corpus (option
  sizes 0..1500 x fill patterns {0x41, 0x00, 0xff, random,
  random-with-NULs}) under ASAN + stack protector with zero
  findings and no abort.

- The copy and walk are unchanged since 2013 (bb06c471), and I
  did not find an existing CVE for get_domains() / option 24.
  CVE-2023-2
8488 is the L2 DHCPv4 length fix (99e2c16e), a
  different code path.

- Suggested CVSS 3.1: AV:A/AC:L/PR:N/UI:N/S:U/C:L/I:L/A:H = 7.6
  (CWE-787 / CWE-125). Cc to cve@kernel.org in case a CVE is
  warranted. I do not claim RCE; it is not demonstrated.

Separately, a smaller thing I'd ask you to confirm (probably no
CVE): dhcpv6_send_packet() in gdhcp/common.c binds a fresh
wildcard ::546 socket per send and passes IPV6_PKTINFO as a cmsg
only, without setsockopt(IPV6_PKTINFO), so stateless DHCPv6
requests appear to egress the default-route interface rather than
the service's interface (seen on a 3-interface host: the INFO-REQ
for a veth-hosted service left via eth0 with eth0's source
address).

Regards,
Andrei Miu

--===============2073399584511629323==
Content-Transfer-Encoding: base64
Content-Type: text/plain
Content-Disposition: attachment;
 filename="0001-gdhcp-fix-stack-buffer-overflow-in-get_domains.patch"
MIME-Version: 1.0

RnJvbSA5YzJlM2YwZjg1MzcwZWNlZTMzZTA5YmZjZTFiOGFhOGMxYzU1NGQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZWkgTWl1IDxhbmRpbWl1QHBtLm1lPgpEYXRlOiBUaHUs
IDIzIE9jdCAyMDI2IDEwOjAwOjAwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZ2RoY3A6IGZpeCBz
dGFjayBidWZmZXIgb3ZlcmZsb3cgaW4gZ2V0X2RvbWFpbnMoKQoKZ2V0X2RvbWFpbnMoKSBjb3Bp
ZWQgYSBmaXhlZCBOU19NQVhETkFNRSAoMTAyNSkgYnl0ZXMgZnJvbSB0aGUKRE9NQUlOX0xJU1Qg
KG9wdGlvbiAyNCkgdmFsdWUgaW50byB0aGUgMTAyNi1ieXRlIHN0YWNrIGJ1ZmZlcgpkbnNfbmFt
ZSByZWdhcmRsZXNzIG9mIHRoZSBhY3R1YWwgb3B0aW9uIGxlbmd0aCwgYW5kIHRoZW4gd2Fsa2Vk
CkROUyBsYWJlbHMgd2l0aCBhbiB1bmJvdW5kZWQgJ2MgKz0ganVtcCArIDEnIGxvb3AuIEEgY3Jh
ZnRlZApESENQdjYgUkVQTFkgd2l0aCBhIERPTUFJTl9MSVNUIG9wdGlvbiBvZiA+PSAxMDI1IG5v
bi16ZXJvIGJ5dGVzCm1ha2VzIHRoZSBsYWJlbCB3YWxrIGxlYXZlIHRoZSBidWZmZXIgYW5kIHJl
YWQvd3JpdGUgJy4nIHBhc3QgaXRzCmVuZCBpbiBhdHRhY2tlci1jaG9zZW4gc3RyaWRlcyAoc3Ry
aWRlID0gbGFiZWwgYnl0ZSArIDEpLCBpLmUuCm91dC1vZi1ib3VuZHMgd3JpdGVzIGludG8gdGhl
IGNhbmFyeS9zYXZlZCByZWdpc3RlcnMgdGVycml0b3J5IG9mCmNvbm5tYW5kIChydW5uaW5nIGFz
IHJvb3QpLiBPbiBzdGFjay16ZXJvaW5nIGtlcm5lbHMgdGhlIHdhbGsKcGVyZm9ybXMgYW4gb3V0
LW9mLWJvdW5kcyByZWFkIGluc3RlYWQgYW5kIGV4aXRzIGF0IHRoZSBmaXJzdAp6ZXJvIGJ5dGUu
CgpESENQdjYgUkVQTFkgbWVzc2FnZXMgYXJlIHVuYXV0aGVudGljYXRlZCBhbmQgdGhlIHRyYW5z
YWN0aW9uIGlkCmFuZCBDTElFTlRJRCBEVUlEIGFyZSBvYnNlcnZhYmxlIG9uIHRoZSB3aXJlIChJ
TkZPUk1BVElPTi1SRVFVRVNUCmlzIG11bHRpY2FzdCB0byBmZjAyOjoxOjIpLCBzbyBhbnkgb24t
bGluayBhdHRhY2tlciBjYW4gdHJpZ2dlcgp0aGlzLgoKRml4IGJ5IGJvdW5kaW5nIHRoZSBjb3B5
IHRvIHRoZSByZW1haW5pbmcgb3B0aW9uIGxlbmd0aCwKTlVMLXRlcm1pbmF0aW5nIHRoZSBidWZm
ZXIsIGFuZCBzdG9wcGluZyB0aGUgbGFiZWwgd2FsayBhdCB0aGUKZW5kIG9mIHRoZSBjb3BpZWQg
ZGF0YS4KCkZpeGVzOiBiYjA2YzQ3MTAxY2EyNCAoImdkaGNwOiBEb21haW4gc2VhcmNoIGxpc3Qg
REhDUHY2IG9wdGlvbiBpcyBjaGVja2VkIikKLS0tCiBnZGhjcC9jbGllbnQuYyB8IDE2ICsrKysr
KysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2dkaGNwL2NsaWVudC5jIGIvZ2RoY3AvY2xpZW50LmMKaW5kZXgg
OTc2NzczYWMuLmI1OTRlMzQ5IDEwMDY0NAotLS0gYS9nZGhjcC9jbGllbnQuYworKysgYi9nZGhj
cC9jbGllbnQuYwpAQCAtMjIxNywxMyArMjIxNywyNSBAQCBzdGF0aWMgR0xpc3QgKmdldF9kb21h
aW5zKGludCBtYXhsZW4sIHVuc2lnbmVkIGNoYXIgKnZhbHVlKQogCQlyZXR1cm4gTlVMTDsKIAog
CXdoaWxlIChwb3MgPCBtYXhsZW4pIHsKLQkJc3RybmNweShkbnNfbmFtZSwgKGNoYXIgKikmdmFs
dWVbcG9zXSwgTlNfTUFYRE5BTUUpOworCQlpbnQgbmFtZV9sZW4gPSBtYXhsZW4gLSBwb3M7CisJ
CWNoYXIgKm5hbWVfZW5kOwogCisJCWlmIChuYW1lX2xlbiA+IE5TX01BWEROQU1FKQorCQkJbmFt
ZV9sZW4gPSBOU19NQVhETkFNRTsKKworCQltZW1jcHkoZG5zX25hbWUsICZ2YWx1ZVtwb3NdLCBu
YW1lX2xlbik7CisJCWRuc19uYW1lW25hbWVfbGVuXSA9ICdcMCc7CisKKwkJbmFtZV9lbmQgPSBk
bnNfbmFtZSArIG5hbWVfbGVuOwogCQljID0gKHVuc2lnbmVkIGNoYXIgKilkbnNfbmFtZTsKIAkJ
d2hpbGUgKGMgJiYgKmMpIHsKIAkJCWludCBqdW1wOworCQkJY2hhciAqbGFiZWwgPSAoY2hhciAq
KWM7CisKIAkJCWp1bXAgPSAqYzsKLQkJCSpjID0gJy4nOworCQkJaWYgKGxhYmVsICsganVtcCAr
IDEgPiBuYW1lX2VuZCkKKwkJCQlicmVhazsKKwkJCSpsYWJlbCA9ICcuJzsKIAkJCWMgKz0ganVt
cCArIDE7CiAJCX0KIAkJbGlzdCA9IGdfbGlzdF9wcmVwZW5kKGxpc3QsIGdfc3RyZHVwKCZkbnNf
bmFtZVsxXSkpOwotLSAKMi41NS4wCg==
--===============2073399584511629323==
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - andimiu@pm.me -
 0x897A3D75.asc"; name="publickey - andimiu@pm.me - 0x897A3D75.asc"
Content-Type: application/pgp-keys; filename="publickey - andimiu@pm.me -
 0x897A3D75.asc"; name="publickey - andimiu@pm.me - 0x897A3D75.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuMTAuMAoKeGpNRWF0c1hIaFlKS3dZQkJBSGFS
dzhCQVFkQTlzVTJveUdiTzJEai9EY1dUZG50cGxDWFhlMElhN3ovQytFUwpmcHREYUZETkhXRnVa
R2x0YVhWQWNHMHViV1VnUEdGdVpHbHRhWFZBY0cwdWJXVSt3c0FSQkJNV0NnQ0RCWUpxCjJ4Y2VB
d3NKQndrUStOVlJhMVY0b0JaRkZBQUFBQUFBSEFBZ2MyRnNkRUJ1YjNSaGRHbHZibk11YjNCbGJu
Qm4KY0dwekxtOXlaNUl5UGFXSnY3Uncxd2hjMEkvd0E1ZlFtY3o2V2k0bDEyNTFaN283WG11R0F4
VUtDQVFXQUFJQgpBaGtCQXBzREFoNEJGaUVFaVhvOWRTUnVHZ3cyRVNWQStOVlJhMVY0b0JZQUFB
a2NBUHNIY08vTWxWWitGUWxqCjZSUmdJbnBnQjJpWkJid0dMT1g5ZWZZMk0wVlp1UUVBMUZFeENV
bUQ4L0hBK3JrWHZ1QkJ6bVc3b3NDbDJEZjMKbG5sSFVka2h3UUxPT0FScTJ4Y2VFZ29yQmdFRUFa
ZFZBUVVCQVFkQTkxb2N4eURSeEhUZFgrOG85RlVORUxMagpVeUV5dFRPbVRGNlNlQ0w2L1ZBREFR
Z0h3cjRFR0JZS0FIQUZnbXJiRng0SkVQalZVV3RWZUtBV1JSUUFBQUFBCkFCd0FJSE5oYkhSQWJt
OTBZWFJwYjI1ekxtOXdaVzV3WjNCcWN5NXZjbWUvUU4wZStYYTlYMUNQWHpaRkllcGoKdTVSNERi
OFQrTERSQnludkJxRG5YUUtiREJZaEJJbDZQWFVrYmhvTU5oRWxRUGpWVVd0VmVLQVdBQUFmTFFE
LwpWZGVHdm83MlFQQkNxWEtVMmRONDJHRVZDK2dIZFBNR3dzVDNDT2FCeVNRQkFJUTZyalZ6c05W
Y2oxT09iUXkvCnBQTXlHckZTSXcveTBKcW1LSTRWa1EwSgo9alJrcQotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0t
--===============2073399584511629323==--

--------ab206b02583c7185591e8ebf1a748d63bd9d9c5b8708cf3cf60a05199ccd8bb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmrbII4JEPjVUWtVeKAWNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmf9tGRjRza/f6iblsOdJ45yFiEEiXo9dSRuGgw2
ESVA+NVRa1V4oBYAABM3AQCN+dcn0BbU6iOMdM0YhuPiOWiqv2h3aHrTDdDz
izWHygEA0vNvo5zJMWpmL8hpvfinCPv2y8iM4mmYSypC9SdRRAU=
=/eBk
-----END PGP SIGNATURE-----


--------ab206b02583c7185591e8ebf1a748d63bd9d9c5b8708cf3cf60a05199ccd8bb5--

