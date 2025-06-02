Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363754CB5B
	for <connman@lists.linux.dev>; Mon,  2 Jun 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848636; cv=fail; b=aWPKX4y7hBGMKiqyswjf1ZdNBjzs0GbdDA2w7+co4DyGFL8jLk8+9OqG8HcbGx0g/is9ykQZhBPY+O4hYk5i6ZnrfJNG+EXbunFXF3u5lzafvAqy1OhIWHcNynplbeaf06Pc0BB51B5nUok3Ii6YctF2QkbjR+lO3G1vQS46xEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848636; c=relaxed/simple;
	bh=XUOm2qwcEevK/ybmhXPbZ3O8YHxZzwkFjFwY/AZ1WoM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qY+7o91znIwdsiVlNoM0ijNP1IOL78sgSuaHJFy+eklfDRH3IM1/7CXcIRqJSOa+9jZeF+bDLa98pIdjJtNWe5vEkLQrktK1rP7F4bSkxabWcuan+eg22HZHKYxNUOKTAqMZ3aclBV5tQL8ocnPTV+CW2ip5MAduoJafDI32EXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.51 with ESMTP; 2 Jun 2025 15:47:11 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo7.lge.com) (165.244.66.188)
	by 156.147.1.121 with ESMTP; 2 Jun 2025 15:47:11 +0900
X-Original-SENDERIP: 165.244.66.188
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SLXP216CU001.outbound.protection.outlook.com) (40.93.138.28)
	by 165.244.66.188 with ESMTP; 2 Jun 2025 15:52:15 +0900
X-Original-SENDERIP: 40.93.138.28
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOHptc6wNenXWs/Jf1RxVJ0YL1MzQq4VCIRuuQqmF8yf10Di9vG0zRxJV3pnfNrZm2a1yzNCXwIRurjnpTBaIZJOpj/X973lOy0vcS9ksqs+svVOIe+4CdfAeRPqyACjfAFzKhF9R7ZZ03t+cQOayZNvoy03tAkJ6Gr6XfkHEM7Np2hWfddtbSjUT8g6ogGUy9jjFp2haii/YOfNamP4K+DVoj4vDH86sHoYtYDT55tQmBcHp3kL6w6k/Et4VqcK83P5gLcbt1SXwIPfPIutPjGehTyGfqpXe6UU/HlYrbOEM/KTOIK7nmcDziX0SXzSlmN0avmtrUAL7vF9dIYGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUOm2qwcEevK/ybmhXPbZ3O8YHxZzwkFjFwY/AZ1WoM=;
 b=NCRC2y7CTGXe96Nv/hFEyQh4XEvsIIPmf13b7JQimxYeKnYmHmRu06+Ntb/blIlpG5cqfe9xoOOmM7KoF3SiahN8xpspvngPGGf/IUZoWtYhW2iJd/ZuPOmOmkHMM4a5LZqygRCrQuZJCRT8NbjgUjkogPcfo5CF/mnngh7KAD8uJwo03vLAOLkTu7vY7GRfh5Y5ppqDi6NdkuxixV2JBfV9IGsx8vJ9PyIbygLOI+dXUq/nD7GiRFHVmYNPdLR4LpHQVBYH9Aa/zfUpoEQ3aP6jtuNaOEsERKW6XOOi2mCCQX9VtUaa3WJ0Fy6nrCBVOJw/2brOSotUrWbM7gCi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by PUYP216MB3016.KORP216.PROD.OUTLOOK.COM (2603:1096:301:156::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 06:47:10 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::3435:5ac:17d8:4d39%5]) with mapi id 15.20.8792.033; Mon, 2 Jun 2025
 06:47:09 +0000
From: Shailesh Rathod/LGSI GPOS Dev <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] connman : Handle empty passphrase setting in wifi/tethering
Thread-Topic: [PATCH] connman : Handle empty passphrase setting in
 wifi/tethering
Thread-Index: AQHb04ng2vaL0QyJ6UaJDaBr0VN6Qg==
Date: Mon, 2 Jun 2025 06:47:09 +0000
Message-ID:
 <SE1P216MB2647E4A28FE116C4D93FF7B5F062A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|PUYP216MB3016:EE_
x-ms-office365-filtering-correlation-id: 7e850747-b6b3-4978-6139-08dda1a14c5f
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LnxXF8ZUlO89iiNJty3MSAjgWzamSp7KlwwTDaACYGxqc7yEtIhqmFQgyB?=
 =?iso-8859-1?Q?GJLgVcgKeJrLEClz7NwQGMDaHoRqfaUuRL1XPiaEuFGCZl97qdXFWqlbfX?=
 =?iso-8859-1?Q?n3vUnYFndqbF70iI4lAUMsbubwTrvSITphcE0UzJB1say3NHbZhj9Uxufb?=
 =?iso-8859-1?Q?nrSxDk7kPPQQGTM7rN7JYfCPxjj8bgIV01SxDIoFOZykm5MEIYlOqUKgWM?=
 =?iso-8859-1?Q?uhvTFxLbhoP2+oGbIiVJXbe60cK+Aoet3494/fHXtGdtP5vH9OmatZbFYZ?=
 =?iso-8859-1?Q?10gZZAUGaiVV7FqN9JLTfXd0f88SfrqH3a580r9RgEucfePxvW2u5UpF9s?=
 =?iso-8859-1?Q?eSYF/0UY/BVYjXvIQHtghS0sATPIhUR5mfJDdr+QS/G1yWsZdnvb0Rv65T?=
 =?iso-8859-1?Q?jcmW7B1/2WALoIaNmhCWd+kK7LUy4VS7tCXguE2oEy0/SFGnMJeNjxkVUW?=
 =?iso-8859-1?Q?kdUPC1hz39x/by9B57SnATNPb/9T1YWabycvEAtQEOQsMTLCYmYxtx5QG3?=
 =?iso-8859-1?Q?BvRHginSH9GheGnE/s1NfVaHIYj0fTxMYV7bwaqkE7gHnVSrAm5DFQ9SFl?=
 =?iso-8859-1?Q?iS+FXqoDCSxKgbhI74dGNw8Guxs1ZKAlGlouvyx6xK+nNW7CtRt7BQe64L?=
 =?iso-8859-1?Q?NtHRj+404lUwc2qRYFXr2AkeMy+McxHLrM6Z8B+1llNxuUSZK5pstFsm0f?=
 =?iso-8859-1?Q?ManLNk46SulsZev2Q6KYTi81NEoRPPFc/BL6XDjx5oQjzn+s2jtXgwcSDg?=
 =?iso-8859-1?Q?im7fzN6VcQMFshvyFCY6lEyQNiw0bDdOnjPtrNE43nI651m6YVMtrYH4+v?=
 =?iso-8859-1?Q?iJkDJNs0TjjtgLHy43Xt7YAiOIBuCU4iFlj72oGCVk4ePkNI7Bz6MhAk3O?=
 =?iso-8859-1?Q?mo2y+OINq6k/hx+gGjHucpMYQzp0yfRTydtPqCqgnFeFJVRbHwzTomycGx?=
 =?iso-8859-1?Q?0ST8+fIjCzVFxTUJXsfRXaXTX9dBKoXGDNEzR+qu3b1IR619BkYaFBWBVB?=
 =?iso-8859-1?Q?gVlvUtWdpdwUvpjUUMJ+W8QAlxtNDiEnUUboqA9FRy/PsfLWQ6KpWCrL6N?=
 =?iso-8859-1?Q?6qLH+88+LKBrTKebMPgdYIlWb8GMAFvT18uhQ7UhrtrcatCQBFTngOmsdW?=
 =?iso-8859-1?Q?SRC04j2vqidrQJ7rj41zGJ//fpBXJFvAHge7ZG2ircZpStR3iVFJ0MdrJm?=
 =?iso-8859-1?Q?hIQC96/mfZOswOwxH2pWOCCmkzZFbTP05Z8bsEjisv+U/G8ggZj0T2wQB/?=
 =?iso-8859-1?Q?dDIuqJS23LcCIDZTyllIh99povALcbvSImcoRTNtrLHznjCHFkfRTaIzbu?=
 =?iso-8859-1?Q?+tstLeMPMpefS/r7dtvrON1qe4BTSY6jOEJzZu3Rjd4TIKEjPy3AYczhvg?=
 =?iso-8859-1?Q?QLi5UcNOGKCcpTr1pJ9/XbpADP09thsZyAv/LH+dSmhKlgoJIkbQFoUCv8?=
 =?iso-8859-1?Q?IkjxFCIevsBnEVbhUuGR5Tzy641Y8kXOeVcj5eo9kjcA7bSP0YF0MKjulZ?=
 =?iso-8859-1?Q?x7sPOFn3JA1V1XL1akHavLNFM89AJSYkY/JAR6k7w3B4+Zot/JxXUsbqdh?=
 =?iso-8859-1?Q?SW3NXpA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q9rwub+mvxEPA4NmTTsRnkg+SWWoaVW4KrLoBB0kwSaInBsdfxOFcZH7jK?=
 =?iso-8859-1?Q?h78y311ffV3OOr656dVuO9Kwl63bnBpxGnA8yvmp63czlouxnrMAPsLCdm?=
 =?iso-8859-1?Q?1q9vef0ZI7vm7qG0JpLsd4YL3CodJFGdwudqejMZht2MMqmnKfsrQoMKId?=
 =?iso-8859-1?Q?eg48PwTRFuPnoTyktol1+lLp/LlNAORBjuoyu7gEcJCFIkMMdx/MHw9qm/?=
 =?iso-8859-1?Q?s6AlsxiExTFlHBlDA7TPr6B1s9eVNgskjOtzbElEPvqSCKK3pW1Unqqm8q?=
 =?iso-8859-1?Q?NKYM2oLL/DVmgnnrywPH6B64mdNMOFNypLHyn85DWCAXDT44UV7P4cNPH5?=
 =?iso-8859-1?Q?LQ9xh5P429eynrKQdSpWdm+wfERzbgWQwxDniOcalm4m+9F034VyBYEEgE?=
 =?iso-8859-1?Q?Pq9jn6D9dX2/34zCRsAEpbEAO8etwzD4tAHWl24b+LGFqaaoUpQdrBzPhN?=
 =?iso-8859-1?Q?PAUIM1di9jj9oeMf7aRU8a+j70pktbx5g07vnR1Gwsg9+99ZQzZHmLCIYn?=
 =?iso-8859-1?Q?zDFOn/sks29f+nVOAj0DtBdOulxDyxLMOnwJeKUelQUIZst005ytP8z7n7?=
 =?iso-8859-1?Q?DpGzOKiovuu+BctNW+qrUU3gA4G9c49o+Um9ME24wTiJx4r3PdCRM0/1yi?=
 =?iso-8859-1?Q?u18nx3AJ2e1/3l00oFKQbb8nueUVrL2cf+nVwvUtSQoLHpt7MQkGhT+s4Q?=
 =?iso-8859-1?Q?i77qOmkzGD0vv8uoGj80Th6dU78yEIYdAs/Lx42Bo7rH/1mPgDvxLnJOhm?=
 =?iso-8859-1?Q?1zoD3ueEnFcDXp6686XPfEiK5eawmehua0BeuJuJ40VFkMTfmjK4oEFyR1?=
 =?iso-8859-1?Q?lzy2iBtbAoftzUlkgtAPRoWPnm4Y40j3GTPmPeC5uAdDc6Vy0mAMikY316?=
 =?iso-8859-1?Q?Kma20b/tmXQjGbLGndG857hTGhKWu9wokyl1+YuJplyIn6C2y2QFBe/kB7?=
 =?iso-8859-1?Q?KnWxKKcCzSlYSvKS/5I3hrrDjeBRjU0RmOjHIGeX7kbiMA/DQ9j0Yujkg5?=
 =?iso-8859-1?Q?tizcT/yKjohgENMk1DG3uvnG25w7a1yDoRTMDkkccxZwZCO+bBWYqRc0EH?=
 =?iso-8859-1?Q?IwUHXQaYvSvJpGyz59ls+OSPVGhmylgJJl3RaunG7hcZWkKsNT3k0jVof5?=
 =?iso-8859-1?Q?QV7atZtZ132t+g9xb6LIYUXrM/iCdCwbJcXBR8jJeYqKZ0H6ypYuQSllh/?=
 =?iso-8859-1?Q?DQQOnMYFtTGHHnQ5h0TRpDPAQ21RAu9uHAUPYG8rRjKQb2e1GB14ydJHBq?=
 =?iso-8859-1?Q?d7apTgM2u7Ot1eUWGqD185c6eQlhO0Qmv6MXv7mcM1nEPd4Jj0mMVa4wfI?=
 =?iso-8859-1?Q?ncy2UO7EOz9zHoMe23Ao6qeWOF///TCHfwzxTAAiN4/WhDPAQmV1LoprbY?=
 =?iso-8859-1?Q?ult/2QI1b9wKGY8IoudURNMlg2+9Q5rmVjtcCIUthzR0ql5bGHFdbfeN4M?=
 =?iso-8859-1?Q?LOJVnEpic39M3sWsOOXmrUpP/IsMlj82+NYxUEw2iG7rPHH0iXuY0iQCxC?=
 =?iso-8859-1?Q?b84L+CjUgqGFZcigj8610qT9u3MQ3cxsoTye53VDeakTbr1JfB2DOR3QIP?=
 =?iso-8859-1?Q?LYwsN0FNNZP5gCihECuTmjI9Pb7e+zB085mnI5Wl6JbP49h8yNZMXVZTYl?=
 =?iso-8859-1?Q?VHF06mvflYcoOIdkNEA4ee0zyMClIkLYU1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: lge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e850747-b6b3-4978-6139-08dda1a14c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 06:47:09.9251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yt7BWDF1mJiptBTlRlQ6OZ+6Bx3CNkqGAxyxZjOwqsBRuJoIyBccR6gX+TWXC4pMfHvCf+beqrFFfOhSLx8THw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUYP216MB3016

From: Shailesh Rathod<shailesh.rathod@lge.com>=0A=
Date: Mon, 21 Apr 2025 18:38:01 +0900=0A=
=0A=
Handle empty passphrase setting in wifi/tethering/setState=0A=
=0A=
While setting WiFi tethering only cases for PSK enabled=0A=
network was handled. Add case to allow empty password for Open SSID too=0A=
For certain application enabling softap without PSK is required.=0A=
=0A=
Signed-off-by: Shailesh Rathod<shailesh.rathod@lge.com>=0A=
---=0A=
=A0src/technology.c | 12 ++++++++++--=0A=
=A01 file changed, 10 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/src/technology.c b/src/technology.c=0A=
index 719c680..1bcd184 100644=0A=
--- a/src/technology.c=0A=
+++ b/src/technology.c=0A=
@@ -1045,8 +1045,16 @@ static DBusMessage *set_property(DBusConnection *con=
n,=0A=
=A0 =A0 =A0 =A0 if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_not_supported(msg);=0A=
=0A=
- =A0 =A0 =A0 err =3D __connman_service_check_passphrase(CONNMAN_SERVICE_SE=
CURITY_PSK,=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str);=0A=
+ =A0 =A0 =A0 /* Allow empty passphrases for setting up an AP with open=0A=
+ =A0 =A0 =A0 =A0* security type */=0A=
+ =A0 =A0 =A0 if (strlen(str) =3D=3D 0) {=0A=
+ =A0 =A0 =A0 =A0 =A0 g_free(technology->tethering_passphrase);=0A=
+ =A0 =A0 =A0 =A0 =A0 technology->tethering_passphrase =3D NULL;=0A=
+ =A0 =A0 =A0 }=0A=
+ =A0 =A0 =A0 else=0A=
+ =A0 =A0 =A0 =A0 =A0 err =3D __connman_service_check_passphrase(CONNMAN_SE=
RVICE_SECURITY_PSK,=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str);=0A=
+=0A=
=A0 =A0 =A0 =A0 if (err < 0)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 return __connman_error_passphrase_required(msg);=0A=
