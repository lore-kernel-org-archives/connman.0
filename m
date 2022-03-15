Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3F2F56
	for <connman@lists.linux.dev>; Tue, 15 Mar 2022 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1647383787;
	bh=YlGk2gyjxnrEuA0ka4h+cEE9croF6DINS/cUeeSSMMQ=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=M0VCcnXfdyem5OcZ0/id3zmYDIaH9OoP+pZ8fOHWxpeH303bonqwxIqi8TOchags9
	 MPMezAQgJitY5GVVC9oE/ubnDM41Y6fgwShF24OCRnVBeZSJvfoUrxFOYn0jBufkYn
	 Ytjvn+6SdLLi0ty/jG1TgDQOUMMnu5BFCDxZdyT8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.44.3] ([94.134.11.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1nxJFw2ePD-00lAw8 for
 <connman@lists.linux.dev>; Tue, 15 Mar 2022 23:36:27 +0100
Message-ID: <608c9e61-b916-7558-2c03-cabfd46910aa@gmx.de>
Date: Tue, 15 Mar 2022 23:36:00 +0100
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: connman@lists.linux.dev
From: corubba <corubba@gmx.de>
Subject: Non-persistent IPv6 DUID issue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aVqn7VIrkSNRv9GcI/hYmM6NrU80EWg+x7HLjXM3kj8TcUbXMe+
 XqqkMepx6o2RzQ1UOgnbMSnoBbuCkZpuKAcYGsyM4IRte12TqvFv4HyQ0fYVxPsPHK3SZLW
 bx7u8d8UorxjqRVmeVd9JjuNFsslVIsvcM5pMw66Bc7HufGpwtIsHVQ53rVZzxRieOn75A3
 gdy3wLxa7e/x4VmG7Z9Fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+Pkopkdnrk=:yR3IF6ends/sM5u3gZom2u
 EnuOsouAawGQfa+5jxeCZGi5+3AWdM8ouHF8STz4zJCpcoO/V2TDC+EAqSfZExMypB/dVSseL
 V/cu2KumiTFghWV5rXS6Flj6Vmcd8bJevzNpyPmI4G5VJ/xkweVXvQrQCv8t5Jmd0DGZT5Sr/
 qcxXe86HEAgyio4ezzw4/DD89dMZUxrM+BwXG/BqIlJzVuJtSeGR7mAulQKjpWZiBfI1R8p7J
 6FjbryUjOjUqrbHBygKRaK+tGROkTC9+WBvikpVplaioHrru25sxkzVukgkVuUtwx4ojRnadO
 y/9mNxDC22ERgzL5VX2BMy64phWhaziYiT8Xyod3hsFaCR1eEjnBAjnLcLOzUoHxeEnL3T6CA
 40SkkMxXu0X+QCrgsym/a8pwXe1GltoddOp7sT+ryBUo706kfLzi3XDPLB1TNXeIscNI4Peal
 KlD4jAq34hxQNFTFneloPNXZY8pXhfD0wjdeV8K281tsH3Jv9VCOwt1lZrrb2Uy2Apc8jqS4X
 vdgzhn0LQeO6L9bI8YvoJx9cFSGtfLUNrwXK0FCaxpu19CPsRGlh/JvpSqgyx+w3FE0CYs4lW
 KQ0F6KweKK6/zl0ykd9y6DI9MUiX3y+5Tlq1ZvsPCeH/kFv2NeFsjsiACkCGr6FneVcbGcuml
 OR7BiPUSduvWlvqXisrJZf3Xupkrrk7zvnrEzx6XhkGHUVd4sv3C80Clq13IyS4m79DrAViqL
 77s9gnzCgRx2h1kHVuokIl3m1gDiL/E2hHcf4iA9jOnxD4VY7dpycIt23lIxHoXWwfoyE09Ja
 pQNjaREpIruJjUozEpuhV4nLtf8JM1HkBlLOxXVicerifpuOfZ98D/0IyRwBoNdJP/V0FJod3
 xc3uKmZkDiqSLOHYZG3OPlLpd/M76luIBdqy+fdupXBCqMyBAuFw1EwZcHmSqgiL9yJLYb7Nx
 v7Bj3qPEE4/o075F+bUtd6iNhh6eIw0HhrCJmZdMiihlCU/Aj//tb70QyUJkEtNGDyAkZ8pi6
 cmmQhWgXTFXqSMx4JouGQQALnHS4bQtzs/nH27n+4q39coMJtEyCGy8tk5i9FhnHPlThhpQi0
 m/pmaLuIF9fQjA=

Hello,

I recently discovered a bug in connman v1.40 which effectively prevents it=
 from getting an ipv6 address via stateless dhcpv6. My investigation revea=
led that this was because on every link-up connman will generate a new dui=
d (dhcpv6 unique identifier) and request an address with it, which fails b=
ecause the server won't have a address for that fresh duid. Normally the d=
uid is generated once and kept/used for the lifetime of the service, which=
 is also supported by the comment on `set_duid` [0]. I further pinpointed =
this change in behavior to commit 0f9e6af6 [1], which changed the start-po=
int for config building from the old config to an empty one. While it has =
the nice side-effect of getting rid of unneeded or duplicate keys, it also=
 throws away any existing duid which is the root cause of the issue. I als=
o checked the most recent `master` branch and confirmed the issue still ex=
ists.

I cobbled together the patch below, which basically just copies over the d=
uid from the old config to the new empty one in order to keep it; and I co=
nfirmed it fixes my issue. But full disclaimer: That is a quick'n'dirty so=
lution, and probably not of mergable quality.

I am looking for advice and suggestions from more experienced contributors=
 on how to fix this "properly". I am also not positive on what this findin=
g means for the `*.DHCP.LastAddress` keys (which probably also get thrown =
away currently) in the context of stateful dhcp (v4 and v6) when you want =
to use it to re-request the last address again.


[0] https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/dh=
cpv6.c#n186
[1] https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=
=3D0f9e6af61527ff93c5c10290258f086c42471293

=2D--
  src/dhcpv6.c  |  2 ++
  src/service.c | 11 +++++++++--
  2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/dhcpv6.c b/src/dhcpv6.c
index 8b683599..5942774b 100644
=2D-- a/src/dhcpv6.c
+++ b/src/dhcpv6.c
@@ -205,6 +205,7 @@ static int set_duid(struct connman_service *service,
  	hex_duid =3D g_key_file_get_string(keyfile, ident, "IPv6.DHCP.DUID",
  					NULL);
  	if (hex_duid) {
+		DBG("use existing duid %s", hex_duid);
  		unsigned int i, j =3D 0, hex;
  		size_t hex_duid_len =3D strlen(hex_duid);

@@ -222,6 +223,7 @@ static int set_duid(struct connman_service *service,

  		duid_len =3D hex_duid_len / 2;
  	} else {
+		DBG("create new duid");
  		int ret;
  		int type =3D __connman_ipconfig_get_type_from_index(index);

diff --git a/src/service.c b/src/service.c
index d4387361..8b310206 100644
=2D-- a/src/service.c
+++ b/src/service.c
@@ -655,8 +655,8 @@ done:

  static int service_save(struct connman_service *service)
  {
-	GKeyFile *keyfile;
-	gchar *str;
+	GKeyFile *old_keyfile, *keyfile;
+	gchar *old_value, *str;
  	guint freq;
  	const char *cst_str =3D NULL;
  	int err =3D 0;
@@ -670,6 +670,13 @@ static int service_save(struct connman_service *servi=
ce)
  	if (!keyfile)
  		return -EIO;

+	old_keyfile =3D connman_storage_load_service(service->identifier);
+	if (old_keyfile && g_key_file_has_key(old_keyfile, service->identifier, =
"IPv6.DHCP.DUID", NULL)) {
+		old_value =3D g_key_file_get_string(old_keyfile, service->identifier, "=
IPv6.DHCP.DUID", NULL);
+		DBG("copy over duid %s", old_value);
+		g_key_file_set_string(keyfile, service->identifier, "IPv6.DHCP.DUID", o=
ld_value);
+	}
+
  	if (service->name)
  		g_key_file_set_string(keyfile, service->identifier,
  						"Name", service->name);
=2D-
2.35.1
