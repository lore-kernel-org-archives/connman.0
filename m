Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de [80.67.18.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE333C1
	for <connman@lists.linux.dev>; Mon, 21 Feb 2022 18:04:15 +0000 (UTC)
Received: from [77.183.191.50] (helo=[192.168.178.31])
	by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <sebastian@pipping.org>)
	id 1nMD1f-00065D-Br; Mon, 21 Feb 2022 19:03:07 +0100
Content-Type: multipart/mixed; boundary="------------iMOkgFrsmcvYZjHSdGoAT0mk"
Message-ID: <292dd348-fc58-11a8-c97e-30fdb7f48a00@pipping.org>
Date: Mon, 21 Feb 2022 19:03:04 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
From: Sebastian Pipping <sebastian@pipping.org>
Subject: [PATCH] Fix vpn/vpn-polkit.policy parse error
X-Df-Sender: aGFydHdvcmtAYmluZXJhLmRl

This is a multi-part message in MIME format.
--------------iMOkgFrsmcvYZjHSdGoAT0mk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello connmon list,


the USBGuard ticket at [1] and a search for "auth_self_keep_session" 
(leading to [2]) made me find that connman had the same problem as 
USBGuard, where Polkit would discard the whole policy file due to a 
"parse error" caused by use of by now unsupported value 
"auth_self_keep_session".  Attached is my proposed patch for review. 
What do you think?

Best



Sebastian


[1] https://github.com/USBGuard/usbguard/issues/403
[2] https://github.com/NixOS/nixpkgs/pull/20859#issuecomment-264693932
--------------iMOkgFrsmcvYZjHSdGoAT0mk
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-vpn-vpn-polkit.policy-Replace-unsupported-auth_-_kee.patch"
Content-Disposition: attachment;
 filename*0="0001-vpn-vpn-polkit.policy-Replace-unsupported-auth_-_kee.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2ZTgzMjFkYWFmYjI2OGQwOGVkMmI3ZWU0MWI1MTY3MmJjZTI4MzJhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTZWJhc3RpYW4gUGlwcGluZyA8c2ViYXN0aWFuQHBp
cHBpbmcub3JnPgpEYXRlOiBNb24sIDIxIEZlYiAyMDIyIDE4OjQ1OjQ0ICswMTAwClN1Ympl
Y3Q6IFtQQVRDSF0gdnBuL3Zwbi1wb2xraXQucG9saWN5OiBSZXBsYWNlIHVuc3VwcG9ydGVk
CiAiYXV0aF8qX2tlZXBfc2Vzc2lvbiIgYnkgImF1dGhfKl9rZWVwIgoKVGhpcyB3aWxsIHN0
b3AgcmVjZW50IFBvbGtpdCAoZS5nLiB2ZXJzaW9uIDAuMTIwKSBmcm9tIGZpcnN0IGNvbXBs
YWluaW5nCmFib3V0IGEgcGFyc2UgZXJyb3IgYW5kIHRoZW4gZGlzY2FyZGluZyB0aGUgd2hv
bGUgZmlsZS4KLS0tCiB2cG4vdnBuLXBvbGtpdC5wb2xpY3kgfCA0ICsrLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dnBuL3Zwbi1wb2xraXQucG9saWN5IGIvdnBuL3Zwbi1wb2xraXQucG9saWN5CmluZGV4IDBj
NDI3MjIwLi5iMTg3YjM3NyAxMDA2NDQKLS0tIGEvdnBuL3Zwbi1wb2xraXQucG9saWN5Cisr
KyBiL3Zwbi92cG4tcG9sa2l0LnBvbGljeQpAQCAtMTMsNyArMTMsNyBAQAogICAgIDxtZXNz
YWdlPlBvbGljeSBwcmV2ZW50cyBtb2RpZmljYXRpb24gb2Ygc2V0dGluZ3M8L21lc3NhZ2U+
CiAgICAgPGRlZmF1bHRzPgogICAgICAgPGFsbG93X2luYWN0aXZlPm5vPC9hbGxvd19pbmFj
dGl2ZT4KLSAgICAgIDxhbGxvd19hY3RpdmU+YXV0aF9zZWxmX2tlZXBfc2Vzc2lvbjwvYWxs
b3dfYWN0aXZlPgorICAgICAgPGFsbG93X2FjdGl2ZT5hdXRoX3NlbGZfa2VlcDwvYWxsb3df
YWN0aXZlPgogICAgIDwvZGVmYXVsdHM+CiAgIDwvYWN0aW9uPgogCkBAIC0yMiw3ICsyMiw3
IEBACiAgICAgPG1lc3NhZ2U+UG9saWN5IHByZXZlbnRzIG1vZGlmaWNhdGlvbiBvZiBzZWNy
ZXRzPC9tZXNzYWdlPgogICAgIDxkZWZhdWx0cz4KICAgICAgIDxhbGxvd19pbmFjdGl2ZT5u
bzwvYWxsb3dfaW5hY3RpdmU+Ci0gICAgICA8YWxsb3dfYWN0aXZlPmF1dGhfYWRtaW5fa2Vl
cF9zZXNzaW9uPC9hbGxvd19hY3RpdmU+CisgICAgICA8YWxsb3dfYWN0aXZlPmF1dGhfYWRt
aW5fa2VlcDwvYWxsb3dfYWN0aXZlPgogICAgIDwvZGVmYXVsdHM+CiAgIDwvYWN0aW9uPgog
Ci0tIAoyLjM1LjEKCg==

--------------iMOkgFrsmcvYZjHSdGoAT0mk--
