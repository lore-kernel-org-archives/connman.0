Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2E1DF73A
	for <connman@lists.linux.dev>; Mon,  6 Oct 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741032; cv=fail; b=toMeHHMv4Ee/yMAHv0JUNX+gDg1gUJ3x3JcvaJzpdCQCOk1e6AHFnfW9fCiJvhhdzqKDzmwyHzWbf/kxNWKrb8+cEy4IZn/NGnJhHNkSAeLwz/BRLkzrgAp0OgfPy+Ak9K0/rmh0UH7G4UXl5bWJt3pmTf6DkVVce5EoXC0ep/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741032; c=relaxed/simple;
	bh=7Uaklmbc5JjaDVf8SmEoN72O3laITIHsgT1T/J4iupg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SdI40ugxOXSBkZe830hGqPkyBenvvSbfOW7i9mywo9OHzlYTPIQm1KPo9/Te/evfvXE+ZA2DYDN5cTEDduCWeZ0ISLu+VNn6YMhha17ofRbTYMKekYBB+0PBzvAxmh2P8Jabq5LR7peAOCM2gpcujsGr5p4hso4Cdn7hL5NVNCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.52 with ESMTP; 6 Oct 2025 17:56:57 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO sniperexo2.lge.com) (165.244.66.182)
	by 156.147.1.125 with ESMTP; 6 Oct 2025 17:56:57 +0900
X-Original-SENDERIP: 165.244.66.182
X-Original-MAILFROM: shailesh.rathod@lge.com
Received: from unknown (HELO SLXP216CU001.outbound.protection.outlook.com) (40.93.138.24)
	by 165.244.66.182 with ESMTP; 6 Oct 2025 18:02:05 +0900
X-Original-SENDERIP: 40.93.138.24
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: shailesh.rathod@lge.com
X-Original-RCPTTO: connman@lists.linux.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj0lZD605u8yACofI6vFHn0esbX5t3UvxPQ1A2QZOxxO3ovL+RiSaN1ZJsebyEJqHGzvEli2rWCo7FSf3niqLaNUorf7nJtKnFSOpxmc19dEvNRXrtrpnz+a7tRA3KuvUqvFhT3/dpHF4nfKGJ0V69UbRAkA3bRLt/a4l/RXLUNE4ekA6m/tXOj1VYR+ftq0KWGS/klXDhjDsc311N/1I5g+RH12tLgxxjUNDjY7RFoHo/2Um9xZXJZLu2oLVztX9nIxbUQVcdaeXGaCJly4/mro5LmwS94mlNqaaF7Zbgjn7Mau9MaEUCrW+N4OQNqA6/TSsd38U1PbeCTth5+uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uaklmbc5JjaDVf8SmEoN72O3laITIHsgT1T/J4iupg=;
 b=ozXByA9s9r2S/yVz/nWPXUnoJHa/a52y61KDOPOxA2gbKuzha/JVBk2MRQdOuEMSKC88Xoexm81ksWiPQDGCg0DgOp8Cc0HmmZKJ2Txls1Q2Ppyzfhf2dutpPk0RUpR3s1JMWF3b9JJjMnh+39Pfhzds5tQU+JSNeyjcSFf4GT4Irtepugisd2052DJgjpO4nbYziEIaWBxUwzjAyoD+pQolmWzN+r4nLo0CiVdoC6G709QRyXBjPU5VYALz7L38a6L94aBOquuPHFd193MrbB7MzgZVvtcEPAZY8UuOz3KF2FdrCtZUP7Nefm67m3SgyBGVGvAB35ONqyVHKlQwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d1::7)
 by SL2P216MB3115.KORP216.PROD.OUTLOOK.COM (2603:1096:101:282::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:56:56 +0000
Received: from SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::e5bd:8928:464c:62c2]) by SE1P216MB2647.KORP216.PROD.OUTLOOK.COM
 ([fe80::e5bd:8928:464c:62c2%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:56:56 +0000
From: Shailesh Rathod/LGSI Connectivity Team <shailesh.rathod@lge.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
CC: Vasu Kantubukta/LGSI Connectivity Team <vasu.kantubukta@lge.com>
Subject: [PATCH] Connman : Add group api doc
Thread-Topic: [PATCH] Connman : Add group api doc
Thread-Index: AQHcNp70ppRtyQrhqUuRIt1JwCOnBw==
Date: Mon, 6 Oct 2025 08:56:56 +0000
Message-ID:
 <SE1P216MB264750A28C4AC70F93921235F0E3A@SE1P216MB2647.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB2647:EE_|SL2P216MB3115:EE_
x-ms-office365-filtering-correlation-id: 33162e4e-979b-43c9-1050-08de04b64d56
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Hozf2zTgUw7olQybMH0bvHW3+/IWgi8J2DiFUmCDCRXZ0sE5nlPqW1i7HV?=
 =?iso-8859-1?Q?V+MWvxFGfkYyttE/M64I8A9Hr5OavPvEcuwy2VAdkhI8fukohUwerKbwIT?=
 =?iso-8859-1?Q?BZ3MMUW0E/RZQHfK8v835Bf26LEK2vyOG/FnPHutX6RzP58cfm468+IwSS?=
 =?iso-8859-1?Q?WRdKIQTlkq1CMo65JKs/+Y1H5kR4GcDrQ4tFfOCIySAjUZ5VEQlDgaY+TQ?=
 =?iso-8859-1?Q?/8gA8LtItPHvNo3781A/vp5O1KmAomIryWQwkbA18Tsu3BNuxYlJr/X6Cl?=
 =?iso-8859-1?Q?xiPefks3k6Inb+iBW9vDAlFNtrJ2YzFIIa2911FVQf1ScbHVq8hXqF3FIx?=
 =?iso-8859-1?Q?QKpVKMYgSRY0wjELbqmEILyvxxLe6yk+2f1HdcPRugxOjKAK2laKpvg+ZR?=
 =?iso-8859-1?Q?H280IzQZq2h5HrLis3AUxQwwQoLxpPbXreGd4XVBomjE/bqxQlsf5DxVjb?=
 =?iso-8859-1?Q?KjPQ/nOkvJvkCpQULsfin0D12E3w0qdwTAefT6arVK50X4kwdcJ42moWFi?=
 =?iso-8859-1?Q?3Fde3HVyb7v97Veu79658OEptVdGn6QI+HpyM/gVMyPjnszALjf4wnny/U?=
 =?iso-8859-1?Q?hzdewkGi0nJDmw2vBiJQwNqdpFCO4suFCkPYjiEW3pqFOV/FjSimtO3DvV?=
 =?iso-8859-1?Q?UxvW8v8//OTwtMpJxgsre2m/HDnmYIURGjX0oTCSSUIOTSt3CEMR6IZ9fK?=
 =?iso-8859-1?Q?+zJW/aNIPbza+w1Nfp5MuqgAtTHUFVHPdB8JHjeBwsX7eR4hHkOZW96R9A?=
 =?iso-8859-1?Q?Pip9o1dFC3Hx7G/UXSUAAy+EIOsI0bKuhswjlq37pXCl4uG0HKJaPWDzdS?=
 =?iso-8859-1?Q?Y89FMa+nz2tZzYWPR5THQZqNK32d2E/GQk+kw2HBW0fA5XTaNsA2cPZ15V?=
 =?iso-8859-1?Q?8ZXLeCIOoEh/ODtm4b++c2HIKvQUAsT3XwAklmVGtsKQG+Pgpp2pBBNOw2?=
 =?iso-8859-1?Q?39/jCOPgZcKrHhVnF9hygjLidJeKLF06fbZIRLyLyi4GoX/HnaQ5oWUgoN?=
 =?iso-8859-1?Q?A9879v8E4bXLMCd5aqsg3SyBDNmH7Nk9b42bJWMtmvkepW6F5YFaGLCfUJ?=
 =?iso-8859-1?Q?ymHP7A9nOmqHr612Ig1mIBKUO83R1cnNWQJzfbNI4K6KnJrY4jlXR/hTD2?=
 =?iso-8859-1?Q?AIrM1hbkBgvCh8hZqDKRHW7mSSUtUbUoognkLIiLN11eOQ/jkfiItssAGD?=
 =?iso-8859-1?Q?6Hl0+JKsa0SMI09iJiN+iPvFLUsUF/CVyYtVw7AUgyZPLPlviR9x08FI27?=
 =?iso-8859-1?Q?78Phq91KAAZJQIYPxAJxMrgJddJu4xbtAXQ44t85juqdP2UNKZ2YL1h3KN?=
 =?iso-8859-1?Q?+gXvQVRzokvahS2q6ZXBt4t6Ys6LtiVDhWdrJvWKLysgmpS6EeSff941sy?=
 =?iso-8859-1?Q?oCuN1PqmMBrfKg87sb53TG9ZVx86FkuSo9yBlHmOFqAHkyLwlchlFszudU?=
 =?iso-8859-1?Q?8vD0fa7zdG0oB+i1L+/GzorZEm4+EZRkdb6j7Wl+xiUToxUwuTAb4KDsRD?=
 =?iso-8859-1?Q?LXqTcH5kY8x8Pk6gblNafE3XDktj6/7EALNjJdU/JRxc+mG0JjJeTYN6gR?=
 =?iso-8859-1?Q?Np5Lkvp/cWdVIS0hdOd0Z1CPCs44?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2647.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p0tc7YgjlHwKmcRB4zTh1Z1/pF4AU57m5VbB2aUDbjwPIWozJP/idpr7VE?=
 =?iso-8859-1?Q?SbVr0ysBWWbmDTGyPfdg/vzYfY/xhjkFW34XK2zqxn6ycvBfeMQsodz3up?=
 =?iso-8859-1?Q?dVJYDhAMZywrgz7sOK4287Y2bJ0fMhrRGgpMk71dzyeHybGLuT+tzHTsmp?=
 =?iso-8859-1?Q?ZuMm0RENUsWj9gfiUKBW9Emwy62LjiVL8wVqUH8KpMtd9iW/vw/F2s/xWX?=
 =?iso-8859-1?Q?ibxNJ0k+CgM2Ll6ozoNGEJ6C8TCjDRGQkXIwdM1RCfPZ+GmPKE+D2s3+PC?=
 =?iso-8859-1?Q?J5z3JfRD+KGud3KvEeS5H5tSgXQM5KL6Ju0VynwnFEWkYkUwFkSiTomCW/?=
 =?iso-8859-1?Q?c7VR9dqSiaV/VFWnTJa1inehKPvjhWm3I/RQFH/Rx9OUjn3Z8Ox6eObsWP?=
 =?iso-8859-1?Q?wgW9prk/Q2ZRdfPRsOXwKMKLr6bg7eQXqnTzMtbB2KpcJjN3xqvszB3r8h?=
 =?iso-8859-1?Q?KkorGRhzAu4tE8+WqX2kKv/xsNRoGmQdMceDLmYTUjtjDv/4xefAyHv0DO?=
 =?iso-8859-1?Q?O6ncFwVyTWuHqzB2IhWrQFdQ6QrXp+YtWmLtxRKV9RLwAetAUZsdkYJ9u2?=
 =?iso-8859-1?Q?XgdNdBuXSWccXqHwdBMs7KTBlp77DiZivjr+sWPCHG4+xcHKIma6ZODywg?=
 =?iso-8859-1?Q?NXbBfeaWrxYwzrwZcA7WrlNWexdAgnMFMZWvQ8C8LqP4ixHFUn83+n/Dfp?=
 =?iso-8859-1?Q?cfzMNKY72E/PbtsDVkHDguwJPKijQrOkIKpObG3uJA9wsD8wODK7PpDdcU?=
 =?iso-8859-1?Q?SQjUbF+kxlkZFCdyFwku5L+467/qhNFi540FeQY0qlNVxw+Z0Ar5le2J5q?=
 =?iso-8859-1?Q?fxQLgUu8M9KRJ0/TtjC4mc9OMukAR4QAiFJHaVdMcuYR/dzUFyKydXHTfw?=
 =?iso-8859-1?Q?PNPeHgq+0QddJoEBTZFPW/9+aqRxsevGzRIsLRdUlYFiVEtxvavKGDF992?=
 =?iso-8859-1?Q?hWpIlG9dGab760kr5jCm1xkmx77zaP3Nv42aalwNq4EPc7Rt7lukEJgqGP?=
 =?iso-8859-1?Q?cgaXryLMvFGa+KePBj0rJmjSe/97lFQ21O9rg19SangtP2VRy4Qndeu3aY?=
 =?iso-8859-1?Q?oB7As+GsvihIEDjddWRrnST8MOEaT/7SiFrRK8lyabjSrQkZQEMFSe/OUs?=
 =?iso-8859-1?Q?8ytr9iCWep/MswnmgEiTE8nL1MdtHAdQnlYZ5jp7+zd4gdCtZPTyWN5GDY?=
 =?iso-8859-1?Q?uQjp1FiTBZdddUWR6t8uYzp4Tc1EWe598lH4csiKIK21K/HIqO/EGWwmnX?=
 =?iso-8859-1?Q?fhQ9u/SuunxK0xsSE/Odn6rQxjQL6tO+g21ykARebF484Xn4JpcUhP9Onm?=
 =?iso-8859-1?Q?NfLvqUYu7O4w5QnU25hdPUYP2yiDKBJQXGm9eOoYB+8T6aNdWGjqGyzaSb?=
 =?iso-8859-1?Q?RuHiYqSmTqrOX7pcFVpUynbU48Y1/c6tPsqFABodSo6eDQ0Tu6wOejEopJ?=
 =?iso-8859-1?Q?mWrIiFDASvj9JERO4of3MlQ2WJI9e1OmvKJfaA3dAL66rvWcXLwET06MSO?=
 =?iso-8859-1?Q?wx08LZsplT0KrM7mEOxAe4jHhFlY7kSwe/kBsVMueAHBcTyy7Sczp5or72?=
 =?iso-8859-1?Q?rwJjQv2V+RBbBHZ5dkvTdc/yNcQvGz0NhRXK8iKOqJD0dlW00WE81XpGKR?=
 =?iso-8859-1?Q?fo1VbiBoCfjVt2gIk3HnVSy9WtD0urPzxT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33162e4e-979b-43c9-1050-08de04b64d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 08:56:56.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BddJ+ENguNQ1lhPuUnmaHFlC9q9QbMWC4JLXg7HJtn6Dkx1PhvbSGbTsWgHwzgGClINM+H0oJwswVmdpvkSiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB3115

From 35d0aa17db4a852a76692fb550996d81b317606a Mon Sep 17 00:00:00 2001=0A=
From: shailesh <shailesh.rathod@lge.com>=0A=
Date: Mon, 6 Oct 2025 08:25:47 +0000=0A=
Subject: [PATCH] Add group api doc=0A=
---=0A=
=A0doc/group-api.txt | 80 +++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
=A01 file changed, 80 insertions(+)=0A=
=A0create mode 100644 doc/group-api.txt=0A=
=0A=
diff --git a/doc/group-api.txt b/doc/group-api.txt=0A=
new file mode 100644=0A=
index 0000000..94a7caf=0A=
--- /dev/null=0A=
+++ b/doc/group-api.txt=0A=
@@ -0,0 +1,80 @@=0A=
+Group hierarchy=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+Service =A0 =A0 =A0 =A0net.connman=0A=
+Interface =A0net.connman.Group=0A=
+Object path =A0 =A0/net/connman/group/<identifier>=0A=
+=0A=
+Methods=0A=
+=0A=
+ =A0 =A0dict GetProperties() =A0 [deprecated]=0A=
+=0A=
+ =A0 =A0 =A0 =A0Returns all group properties as a dictionary.=0A=
+ =A0 =A0 =A0 =A0Properties include Name, Owner, Passphrase, Persistent, Te=
thering, Freq, etc.=0A=
+=0A=
+ =A0 =A0 =A0 =A0Possible Errors: net.connman.Error.InvalidArguments=0A=
+=0A=
+ =A0 =A0void SetProperty(string name, variant value)=0A=
+=0A=
+ =A0 =A0 =A0 =A0Sets the value of the specified property for the group.=0A=
+ =A0 =A0 =A0 =A0Currently supported property: "Tethering" (boolean).=0A=
+=0A=
+ =A0 =A0 =A0 =A0Possible Errors: net.connman.Error.InvalidArguments=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 net.connman.Error.AlreadyEnabled=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 net.connman.Error.AlreadyDisabled=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 net.connman.Error.Failed=0A=
+=0A=
+ =A0 =A0void Disconnect()=0A=
+=0A=
+ =A0 =A0 =A0 =A0Disconnects the group from the current P2P session.=0A=
+=0A=
+ =A0 =A0 =A0 =A0Possible Errors: net.connman.Error.Failed=0A=
+=0A=
+ =A0 =A0void Invite(string service_path)=0A=
+=0A=
+ =A0 =A0 =A0 =A0Invites a peer (specified by its service object path) to j=
oin the group.=0A=
+=0A=
+ =A0 =A0 =A0 =A0Possible Errors: net.connman.Error.InvalidArguments=0A=
+=0A=
+ =A0 =A0array{object,dict} GetPeers()=0A=
+=0A=
+ =A0 =A0 =A0 =A0Returns a list of tuples with peer object path and diction=
ary of peer properties.=0A=
+=0A=
+ =A0 =A0 =A0 =A0Possible Errors: net.connman.Error.InvalidArguments=0A=
+=0A=
+Signals=0A=
+=0A=
+ =A0 =A0PropertyChanged(string name, variant value)=0A=
+=0A=
+ =A0 =A0 =A0 =A0Indicates a changed value of the given property.=0A=
+=0A=
+ =A0 =A0PeerAdded(object path)=0A=
+=0A=
+ =A0 =A0 =A0 =A0Indicates that a new peer has joined the group.=0A=
+=0A=
+ =A0 =A0PeerRemoved(object path)=0A=
+=0A=
+ =A0 =A0 =A0 =A0Indicates that a peer has left the group.=0A=
+=0A=
+Properties=0A=
+=0A=
+ =A0 =A0string Name [readonly]=0A=
+ =A0 =A0 =A0 =A0The SSID or name of the group.=0A=
+=0A=
+ =A0 =A0boolean Owner [readonly]=0A=
+ =A0 =A0 =A0 =A0True if this device is the group owner.=0A=
+=0A=
+ =A0 =A0string Passphrase [readonly]=0A=
+ =A0 =A0 =A0 =A0The passphrase for the group (if owner).=0A=
+=0A=
+ =A0 =A0object OwnerPath [readonly]=0A=
+ =A0 =A0 =A0 =A0Object path of the group owner (if not owner).=0A=
+=0A=
+ =A0 =A0boolean Persistent [readonly]=0A=
+ =A0 =A0 =A0 =A0True if the group is persistent.=0A=
+=0A=
+ =A0 =A0boolean Tethering [readwrite]=0A=
+ =A0 =A0 =A0 =A0True if tethering is enabled for the group.=0A=
+=0A=
+ =A0 =A0uint32 Freq [readonly]=0A=
+ =A0 =A0 =A0 =A0Frequency of the group.=0A=
=0A=
