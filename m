Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E51DDE2
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AE2A8731A2
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 17:45:43 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 73E8A731ED
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 17:45:43 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Heap-use-after-free in 'free_wispr_routes'
Date: Thu, 9 Nov 2023 14:45:42 -0800
References: <00594AC1-5C85-4FD1-912D-BB0B40426FF7@nuovations.com>
 <CEAB13C2-D3D1-413F-8FAB-19E6F45E35B4@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <CEAB13C2-D3D1-413F-8FAB-19E6F45E35B4@nuovations.com>
Message-Id: <08953CA6-8525-4D23-9571-4679BEA4DE2E@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 9, 2023, at 2:21 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Nov 8, 2023, at 8:37 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
>> ConnMan Community:
>>=20
>> FYI, I am chasing down another heap-use-after-free fault identified =
by the Arm GNU Toolchain 12.3.1 address sanitizer in =
=E2=80=98free_wispr_routes=E2=80=99. Details are here:
>>=20
>> 	https://github.com/Nuovations/connman/issues/66
>>=20
>> More to follow as I learn / find.
>=20
> The root cause seems to be that it is a reference counting issue with =
the =E2=80=98wp_context=E2=80=99. There is an unbalanced unref/release =
in =E2=80=98proxy_callback'. It=E2=80=99s unclear to me whether that =
unref/release is in error and needs to be deleted or if there needs to =
be a ref/retain before =E2=80=98connman_proxy_lookup' / =E2=80=98g_idle_ad=
d' are called in =E2=80=98wispr_portal_detect'.
>=20
> I=E2=80=99ll research git blame and git log to see if I can back into =
how the code got to its current state.
>=20
> I=E2=80=99ve added log annotations at =
https://github.com/Nuovations/connman/issues/66#issuecomment-1804774552.

Based on Daniel Wagner=E2=80=99s commits 723439298 and 416bfaff9 and the =
existing unref/release on the error path:

		if (wp_context->token =3D=3D 0) {
			err =3D -EINVAL;
			wispr_portal_context_unref(wp_context);
		}

my intuition is that this was an oversight. With that in mind, I am =
going to put the following diff into testing:

diff --git a/src/wispr.c b/src/wispr.c
index 4f28e8bb..f8c0b5a9 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1010,9 +1010,18 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
     * connman_proxy_lookup, since the former will always result in
     * a WISPr request "falling down a hole" that will only ever
     * result in a failure completion.
+     *
+    * Whether following the connman_proxy_lookup / proxy_callback
+    * path or the g_idle_add / no_proxy_callback path, both funnel to
+    * proxy_callback. Retain a reference to the WISPr/portal context
+    * here and release it there (that is, in proxy_callback) such
+    * that the context is retained while the lookup or the idle
+    * timeout are in flight.
     */
    if (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT &&
        proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN) {
+       wispr_portal_context_ref(wp_context);
+
        wp_context->token =3D connman_proxy_lookup(interface,
                        wp_context->status_url,
                        wp_context->service,
@@ -1023,6 +1032,8 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
            wispr_portal_context_unref(wp_context);
        }
    } else if (wp_context->timeout =3D=3D 0) {
+       wispr_portal_context_ref(wp_context);
+
        wp_context->timeout =3D g_idle_add(no_proxy_callback, =
wp_context);
    }
=20
Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

