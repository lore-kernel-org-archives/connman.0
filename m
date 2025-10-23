Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023074.outbound.protection.outlook.com [52.101.83.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACDC2E0
	for <connman@lists.linux.dev>; Thu, 23 Oct 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761260401; cv=fail; b=fbEJqIZG9ACKaomgevneXWHUG5JnIxtPEnQ7Hjo3YwmFALSysqqx028dfWxQ26FpnmAxqCgusDsbE1rCPqNuWqHZGkN4+NkIOag8gaDCwUhRaZuLESB0IaSnNuGRqBUaXWuatJNbsMUjPVhYzsMX2k1u9ksQhX8zgj2ugC5xPUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761260401; c=relaxed/simple;
	bh=g2JByS8TvV62f/8cMEIVJyl+CPenTpNfzesbB2fxyok=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WOcx/tzyrhhaW6nA6xjX6aDmTpIDz7E4CraRSItO7rNziKtmcX4azVnyzDYW27KNElgzQCGRc40qNyTswDHk8sSkc3ZP4Bm2uIjIZjvxJzeORjJDaw3qte12dkkpeh0ZE1fIED6czBCdPB4vrqDc3SdNmkWuLkG27ObY0eH/0kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at; spf=pass smtp.mailfrom=goeg.at; dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b=lDbzscUL; arc=fail smtp.client-ip=52.101.83.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goeg.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goeg.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goegat.onmicrosoft.com header.i=@goegat.onmicrosoft.com header.b="lDbzscUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cst1c63st/raqsmLrCRtXk86QMjNwuTgSP6MzPbqtPyXNklF26mwrHbz3q0tJfu641D4aBk5cKBP0kpSSmqLT/0nDbyvqWIym6BRWDJ90CYBOHRhg299NuwgzNp6p36FI4ihElpb5RTbVIPu6F+IqhwfErSK6GrOReXigXvb45esjP7dHnQNFDZ708CBPQeF2ib1JI7IQTBCSldb0g5DI7Mu4tb+A+cSxUpioB88rIr9eBba7Mt20iPyy9DJP5nF6IUbBeWgWyFrEfvM1Ml4hH3kkj5TW6spHgmQm05tAMibuvTHe5w6NgQsjKtiPyd885lg7JukioN8CF4R4FidPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seUWRu7VhRlTVACjmxf/jrWS1kBZN0UE2+3+h4EJXo4=;
 b=EHsduHZKTFX2merXXsggOcFEfBQUTgSl5j1wpBmcPW2OEbgrsS/y2F8QW7eWFwiam7jD7hN0mtcyp0e29R87d59591SJmlw+FuYwvHdcQoZ4RbOGWijRiT1ylGEnUdR1WrLhMF59rhkvQNUU0C1pMv/Zkdc7jRkCeqr8Dz0aQbu+euOsf08is8n9zsLUy/GBopLVv2DCdn5VNvU5FzbtOPucji3udpCfa0kxFxhoEcJMGq8MO62TDvaqIjbu2o2wQzC3loTZIDuxUU3V144vwaUXVU9t9CsxyJPBKujAiJXFaoDUI4846E7lw6R2eibMAXxYUVTe0+ZpMjjOThOgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seUWRu7VhRlTVACjmxf/jrWS1kBZN0UE2+3+h4EJXo4=;
 b=lDbzscULWujmH8Gt7h7C3ZPzNME9dsvBdptoZAunhuO5hykjCri5uGUkOOfXoznD6zlQ2pLJuUfyIfG2Ar8Wy6fVFoAsXzg7xD5Nnm58XgIiqUY7rgMjxnNLMGfLvSO7Y78sXujpZ1en3ooBHEi5tJ1e4M6qxcVTsTyklosbpqY=
Received: from VI1PR09MB4462.eurprd09.prod.outlook.com (2603:10a6:800:153::15)
 by DU0PR09MB8167.eurprd09.prod.outlook.com (2603:10a6:10:5a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 22:59:52 +0000
Received: from VI1PR09MB4462.eurprd09.prod.outlook.com
 ([fe80::e395:88fb:63a7:122d]) by VI1PR09MB4462.eurprd09.prod.outlook.com
 ([fe80::e395:88fb:63a7:122d%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 22:59:51 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Wifi tethering:  Cannot enable NAT -2/No such file or directory or
 -97/Address family not supported by protocol
Thread-Topic: Wifi tethering:  Cannot enable NAT -2/No such file or directory
 or -97/Address family not supported by protocol
Thread-Index: AQHcRGFsNxVqOW7Zek2Qc6U8jvKYcA==
Date: Thu, 23 Oct 2025 22:59:50 +0000
Message-ID:
 <VI1PR09MB4462DB922DCF5D30C77BB49DF2F0A@VI1PR09MB4462.eurprd09.prod.outlook.com>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB4462:EE_|DU0PR09MB8167:EE_
x-ms-office365-filtering-correlation-id: d4109fa8-7acc-4414-f8ae-08de1287df56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SnXqAybwJhgjeK7+hcAmVLObIz83lAs8mCnd9ZcAdIF7jgJJxdkwSiKx5F?=
 =?iso-8859-1?Q?wLoVbWfcTWu7KC1Iy5AT7SQbTrnP3iQQ+c0H/PuJxRkod+1C8+Ek/WDg77?=
 =?iso-8859-1?Q?SLoXJuDIh4yXHRjYRH+L+fpxIzJmgwVUrWEZveo3nE1W0NpungNsnG2IDp?=
 =?iso-8859-1?Q?byv2fGTcFklHjc1EJiTUOtvTHZJcV0I+HIFlHiGmfg0rrS11FFpdUcIhna?=
 =?iso-8859-1?Q?YuaistxnKl93oMwSLnDERKxNIMZG95KVD2Q9NmqG0SlKeRu3Tbvs21r11+?=
 =?iso-8859-1?Q?ej4cImPCvSMznshPUb81eUrio+EWLMJnRql90AMbi0RCnNJXZEmNjpVHNM?=
 =?iso-8859-1?Q?MUjY1zkWp9ODFwaFgCdFBCFHaEj2P6t4tpCpP0ki3GERKcOEgdFithNwDH?=
 =?iso-8859-1?Q?UguETTDs9iIWH+CIWb07la8xnneU7AERY1HY/RBII6FXnuDDkVT/MGbjBl?=
 =?iso-8859-1?Q?8MWlN3cwF/vgAMeMy2Uf0wMfBYNikdqshGv7SdOVMJ87TXcaZBCOqJtPtT?=
 =?iso-8859-1?Q?zrzTmkb8YzFkIQVA+1GfbpwkWrR9Jmfr+iu85q7MLGjERm11E7pqVAiYiD?=
 =?iso-8859-1?Q?3RKr7FjiMLmU8oP8nfnkUbga7Z+uiuy4T8adpxLQI57uvjOBAhGyJRGnkK?=
 =?iso-8859-1?Q?3aUEmcjenqYJ4zaTEG6YJhuzQcmQlIFPc3aXT0By5I+9pNxcerhpAd109C?=
 =?iso-8859-1?Q?uPk/b7ovWTCnUdO9YBgfYq8kp5Oo1Vy8YUIa7ra0U6rSJEbTrCP1BUd222?=
 =?iso-8859-1?Q?qv0bsEHru/lyuGPI0mgzyBmcqw3YFduPxqpruD5j0SfJXMgflP2NyyiYx5?=
 =?iso-8859-1?Q?SYuZwp7tBZPSCD2/Xt3i12kFqvQ0YHmC+BW6uaR427P7b+132cTHaNgqbz?=
 =?iso-8859-1?Q?zG0DD8vIVNUvnMwwGfTQ+bN41Ma24HYBg0gO9ROIfq1x8OGhEKw9CdodXj?=
 =?iso-8859-1?Q?ABwy6lvkYBYdkMIctu5SAkGxQ+bsqv7irowJpU53W/YEsk2nsFAusmfz+H?=
 =?iso-8859-1?Q?UF9LmEtztfiR5TL4QfkoTDEEgX7K8CO3zhHbrn+wutuDuWHrp1bYUkVUL/?=
 =?iso-8859-1?Q?Zb45P/Z8HUA/ILCV1YBavg4eSHnwmEOFNQjNfBUbiVsbS/ytXxdBOv/Fin?=
 =?iso-8859-1?Q?ZU99gfGNu6b1g9pvZVpCpXN6T/zYha6cSLyI8m0zn8a3c9NEzkZZoDNzw+?=
 =?iso-8859-1?Q?iqgvsZ1gPbC4W6EnnikYhhkeiEXHLL9WfG2StKONRs3NlxlcDaSgJpZMu6?=
 =?iso-8859-1?Q?ce7mpYA99cOAgHFa8zt7YLFjIL8PkuQxgQt0B/Ki1yOq5dgLQZRW6R0fjt?=
 =?iso-8859-1?Q?BaKGfp7dgPPvQxfV4eyIJJoGkvnOCW1p+bAxNW7IEtoy1tHXmGaDRhTN8D?=
 =?iso-8859-1?Q?iy1u98eusyQ42xdTp/Ww+twCZtjYQ/p0K95/lHVyVOL96p0GXIEx3OulsV?=
 =?iso-8859-1?Q?aQgNmg+gysfeSNDZx+HaX0duLcc+//JtJw6/+nBa+6Gsj65KmrIaArWHCr?=
 =?iso-8859-1?Q?JnnorOhSVfm+EVIZ9t6kA2WERdmBEU+dfNHlZwXkLVqxUT9OZbrh1aLGe4?=
 =?iso-8859-1?Q?6/ySd9y+PnB+ASTVcfnbDOnZ25HJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB4462.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5DiAl5B74rAu66GtdNIbvhl0BygGLm+JyVTYnKYWxzhxXM3gFLcitSoW32?=
 =?iso-8859-1?Q?Xijt309aabiVKgYTAvF4Xk8wMTpFox0VpfpNQcoYR0R7buDjEJ3hsl0fHJ?=
 =?iso-8859-1?Q?9BWqrxqEaKACXmMmku26oJIQzcLtKl2VrOe4wDZewQwTPpAI+MURWo+rVG?=
 =?iso-8859-1?Q?61wUdtWHdipIEgnqDObQ9AafovYlK84sFjUcgn9vU5fmbn1Q3U3X5gxCyB?=
 =?iso-8859-1?Q?BgYfKMbZ4xgw/mSKMXBWMFsN/i4vSGUtDxYb/5hBnchz2U7v1SotsR7+La?=
 =?iso-8859-1?Q?9IDJqx2VY0XM3gV7cHt/Nm6zOMYXvPM+nQKE7aFZlJDUBNL3y18MIY/VNc?=
 =?iso-8859-1?Q?+nEeuSBZDZ4Jos1xu1cVl7LAzhPvfz42MgMhhmPdFgd8layHey/7hy+aJI?=
 =?iso-8859-1?Q?3pVYrH2GCsnzZ4Am1CbyClsFSlQLZdpRLA9BbgPDLgPsRHqGH591KzAdiY?=
 =?iso-8859-1?Q?Dj69S0YLgqtfyM0zyWtt3tBvh1ANMrFrkbH/+6K05C22pL52Y9r6K1httP?=
 =?iso-8859-1?Q?glccOG/T1HOmddZgQ6WzvtLrtghBBypmFzQCIqW4DWf4dfS+xb87Yk2uXw?=
 =?iso-8859-1?Q?JpfMcwofzpc5AVOq14UEno3iEUDCBSytj9lz6vjZme17DRWYySwuF10h5R?=
 =?iso-8859-1?Q?cNXiB29TiCWmOelvJcDncRix+++bU+H0LJ4QSfayaNRacprtYBz7aMA3DL?=
 =?iso-8859-1?Q?i7lYRPUulH/oB0njgQbrov3D4Kl5Nv1/oUGk7xbrGfe02OR7IuwMZZ8+0l?=
 =?iso-8859-1?Q?A2AY/xRTJNRUmWQZMWAE9jZalwFZxxHiVCoMgTrJCz4lYnREYqan/zkfFM?=
 =?iso-8859-1?Q?l2RJ9PpuUtBx68nQEbs3h6T+bhqstajMVM3adlQHjkYmjFW1B652pHT3mW?=
 =?iso-8859-1?Q?LjJ6Z0a2lipyvv+f+KfAy0iIG9Vr6ZFqQVELixIc8iaO+xXKneAfBMJT4T?=
 =?iso-8859-1?Q?+U+p9dV1hGvgwa5VY5c6h2+CukeJkzRbE06pEXf1RKWnl7tJF8ZwFrjx7h?=
 =?iso-8859-1?Q?d6zZpZnvI3ySnKWuKdvygKac1p97eLVCYnta1pEoKlZ3Y6g4b+3KiSj+Wk?=
 =?iso-8859-1?Q?+a8+e07bJ7zoTlMZsFVGkDAQGes3w7B6u1sLGj33WnWHndbqSIoNd35Ap4?=
 =?iso-8859-1?Q?0hGnVkL69rMpmTS74udoEjqnI2VT33MNWkLAK1yTLY6hMei4QB/ksR440n?=
 =?iso-8859-1?Q?BGaOwl0MNgD3rnCx+xuFB5JaF+X5R+EaVrN0iVZUCG82v5s9z7pmLhnmXg?=
 =?iso-8859-1?Q?uqEQIBCxcNTA0kxkrxyttQmA7AtevDhaQOT0d+H3uZL17JnE+tOCxQ1uMt?=
 =?iso-8859-1?Q?i1l0zVPirLjQw/oiMNVsNE/mQDYaSBcpWnu65vILM4ThR0Y8VsibwmB4qy?=
 =?iso-8859-1?Q?+jtr5MlLmHWwccoTfURe/vn0yOQpKSthiWrGq0Eh2heGCr4aX/YCb4Ct+v?=
 =?iso-8859-1?Q?yRdZEwmbQrMezCWDPTuHNrxr8EyDOnLnSYdkOEYUpDDGZGsGoLddJXCgQq?=
 =?iso-8859-1?Q?oG5LwQdG5hLLr8It/POovy5Mc0iE6sKZSfmTX7bFELNQDQXpM1R9Uj2AdI?=
 =?iso-8859-1?Q?jljGrmi76sdBPUaGIRdY5FYFkFSqrv/79x0UkcYzHd0YJOtYRytwya0nF9?=
 =?iso-8859-1?Q?9D1vwvHvezyMxG/60KFOsRwDF9Q86cH6KQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4462.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4109fa8-7acc-4414-f8ae-08de1287df56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 22:59:50.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTJhM66mn01KcXEiylAKDOMZtl/DRxDd8SeGLQp5uPkv/vr+rPpL8s9HaUJ2zFm/DnA6Uj2oSYOS5skqEZPq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB8167

Hello list!=0A=
=0A=
I am trying to make connman wifi tethering work.=0A=
I read the README in the git repo (but I think it is outdated for current k=
ernels; i use 6.12; e.g. CONFIG_NF_CONNTRACK_IPV4 also is now CONFIG_NF_CON=
NTRACK if I am not mistaken).=0A=
I therefore enabled:=0A=
=0A=
CONFIG_BRIDGE=3Dm=0A=
=0A=
and, as my kernel config help says:=0A=
CONFIG_IP_NF_TARGET_MASQUERADE:=0A=
This is a backwards-compat option for the user's convenience=0A=
(e.g. when running oldconfig). It selects NETFILTER_XT_TARGET_MASQUERADE.=
=0A=
=0A=
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm=0A=
=0A=
lsmod tells me:=0A=
=0A=
# lsmod | egrep "(ip|xt|nat|bridge|nf)"=0A=
xt_nat                 12288  0=0A=
xt_MASQUERADE          12288  0=0A=
iptable_nat            12288  0=0A=
nf_nat                 40960  3 xt_nat,iptable_nat,xt_MASQUERADE=0A=
nf_conntrack          110592  3 nf_nat,xt_nat,xt_MASQUERADE=0A=
nf_defrag_ipv4         12288  1 nf_conntrack=0A=
iptable_filter         12288  0=0A=
ip_tables              20480  2 iptable_filter,iptable_nat=0A=
x_tables               40960  5 iptable_filter,xt_nat,ip_tables,iptable_nat=
,xt_MASQUERADE=0A=
bridge                233472  0=0A=
stp                    12288  1 bridge=0A=
llc                    12288  2 bridge,stp=0A=
nf_tables             331776  0=0A=
libcrc32c              12288  3 nf_conntrack,nf_nat,nf_tables=0A=
nfnetlink              16384  1 nf_tables=0A=
=0A=
so I guess the kernel config should be fine.=0A=
=0A=
I do not have nor do I want IPv6 support (and I think I should not need it,=
 right?). I also want to use nftables, I do not have iptables.=0A=
=0A=
This is Gentoo, connman is installed with=0A=
=0A=
Installed versions:  1.45(14:47:49 2025-08-11)(bluetooth ethernet nftables =
openvpn policykit tools wifi -debug -doc -examples -iptables -iwd -l2tp -ne=
tworkmanager -ofono -openconnect -pptp -vpnc -wireguard -wispr)=0A=
=0A=
which translates to=0A=
./configure --prefix=3D/usr --build=3Dx86_64-pc-linux-gnu --host=3Dx86_64-p=
c-linux-gnu --mandir=3D/usr/share/man --infodir=3D/usr/share/info --datadir=
=3D/usr/share --sysconfdir=3D/etc --localstatedir=3D/var/lib --datarootdir=
=3D/usr/share --disable-dependency-tracking --disable-silent-rules --disabl=
e-static --docdir=3D/usr/share/doc/connman-1.45 --htmldir=3D/usr/share/doc/=
connman-1.45/html --with-sysroot=3D/ --libdir=3D/usr/lib64 --localstatedir=
=3D/var --runstatedir=3D/run --with-systemdunitdir=3D/usr/lib/systemd/syste=
m --with-tmpfilesdir=3D/usr/lib/tmpfiles.d --enable-client --enable-datafil=
es --enable-loopback=3Dbuiltin --enable-bluetooth=3Dbuiltin --disable-debug=
 --enable-ethernet=3Dbuiltin --disable-test --disable-l2tp --disable-nmcomp=
at --disable-ofono --disable-openconnect --enable-openvpn=3Dbuiltin --enabl=
e-polkit=3Dbuiltin --disable-pptp --enable-tools --disable-vpnc --disable-w=
ireguard --disable-wispr --with-firewall=3Dnftables --disable-iospm --disab=
le-hh2serial-gps --disable-iwd --enable-wifi=3Dbuiltin=0A=
=0A=
I enable tethering with=0A=
connmanctl> tether wifi on myap password1234=0A=
Wifi SSID set=0A=
Wifi passphrase set=0A=
Error enabling wifi tethering: Not supported=0A=
=0A=
The syslog says:=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {create} index 10 type 1 <ETHER=
>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {update} flags 4098 <DOWN>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 address 26:2=
4:7F:6D:05:20 mtu 1500=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 operstate 2 =
<DOWN>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {update} flags 102467 <UP,RUNNI=
NG,LOWER_UP>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 address 26:2=
4:7F:6D:05:20 mtu 1500=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 operstate 0 =
<UNKNOWN>=0A=
Oct 23 23:06:56  connmand[2414]: No IPv6 support=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {update} flags 36931 <UP,RUNNIN=
G>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 address 1A:1=
5:DC:E6:69:E2 mtu 1500=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 operstate 0 =
<UNKNOWN>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {update} flags 36867 <UP>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 address 1A:1=
5:DC:E6:69:E2 mtu 1500=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 operstate 2 =
<DOWN>=0A=
Oct 23 23:06:56  connmand[2414]: No IPv6 support=0A=
Oct 23 23:06:56  connmand[2414]: DHCP server: option_code 1 option_value 25=
5.255.255.0=0A=
Oct 23 23:06:56  connmand[2414]: DHCP server: option_code 3 option_value 19=
2.168.0.1=0A=
Oct 23 23:06:56  connmand[2414]: DHCP server: option_code 6 option_value 19=
2.168.0.1=0A=
Oct 23 23:06:56  connmand[2414]: Cannot enable NAT -2/No such file or direc=
tory=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {update} flags 36866 <DOWN>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 address 1A:1=
5:DC:E6:69:E2 mtu 1500=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {newlink} index 10 operstate 2 =
<DOWN>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {dellink} index 10 operstate 2 =
<DOWN>=0A=
Oct 23 23:06:56  connman-vpnd[2498]: tether {remove} index 10=0A=
Oct 23 23:06:56  connmand[2414]: failed to read /proc/sys/net/ipv6/conf/all=
/disable_ipv6=0A=
Oct 23 23:06:56  connmand[2414]: (null) {create} index 10 type 1 <ETHER>=0A=
Oct 23 23:06:56  connmand[2414]: (null) {update} flags 4098 <DOWN>=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 address 26:24:7F=
:6D:05:20 mtu 1500=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 operstate 2 <DOW=
N>=0A=
Oct 23 23:06:56  connmand[2414]: (null) {add} address 192.168.0.1/24 label =
tether family 2=0A=
Oct 23 23:06:56  connmand[2414]: (null) {update} flags 102467 <UP,RUNNING,L=
OWER_UP>=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 address 26:24:7F=
:6D:05:20 mtu 1500=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 operstate 0 <UNK=
NOWN>=0A=
Oct 23 23:06:56  connmand[2414]: (null) {update} flags 36931 <UP,RUNNING>=
=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 address 1A:15:DC=
:E6:69:E2 mtu 1500=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 operstate 0 <UNK=
NOWN>=0A=
Oct 23 23:06:56  connmand[2414]: (null) {update} flags 36867 <UP>=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 address 1A:15:DC=
:E6:69:E2 mtu 1500=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 operstate 2 <DOW=
N>=0A=
Oct 23 23:06:56  connmand[2414]: (null) {del} address 192.168.0.1/24 label =
tether=0A=
Oct 23 23:06:56  connmand[2414]: (null) {update} flags 36866 <DOWN>=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 address 1A:15:DC=
:E6:69:E2 mtu 1500=0A=
Oct 23 23:06:56  connmand[2414]: tether {newlink} index 10 operstate 2 <DOW=
N>=0A=
Oct 23 23:06:56  connmand[2414]: tether {dellink} index 10 operstate 2 <DOW=
N>=0A=
Oct 23 23:06:56  connmand[2414]: (null) {remove} index 10=0A=
=0A=
So "connmand[2414]: Cannot enable NAT -2/No such file or directory".=0A=
=0A=
I therefore strace'd connmand and got:=0A=
connmand[5866]: No IPv6 support=0A=
connmand[5866]: No IPv6 support=0A=
connmand[5866]: DHCP server: option_code 1 option_value 255.255.255.0=0A=
connmand[5866]: DHCP server: option_code 3 option_value 192.168.0.1=0A=
connmand[5866]: DHCP server: option_code 6 option_value 192.168.0.1=0A=
openat(AT_FDCWD, "/proc/sys/net/ipv4/ip_forward", O_RDWR|O_CLOEXEC) =3D 27=
=0A=
connmand[5866]: Cannot enable NAT -2/No such file or directory=0A=
openat(AT_FDCWD, "/proc/sys/net/ipv6/conf/all/disable_ipv6", O_RDONLY) =3D =
-1 ENOENT (No such file or directory)=0A=
connmand[5866]: failed to read /proc/sys/net/ipv6/conf/all/disable_ipv6=0A=
connmand[5866]: (null) {create} index 6 type 1 <ETHER>=0A=
=0A=
This somehow seems like ipv6 is strictly necessary/the check is hard coded,=
 or is my interpretation wrong? Do I need to add some kind of config variab=
le/parameter to disable v6?=0A=
It would seem to me connman correctly detects "No IPv6 support".=0A=
=0A=
Running in debug mode gives me=0A=
connmand[25248]: src/firewall-nftables.c:__connman_firewall_create()=0A=
connmand[25248]: src/firewall-nftables.c:__connman_firewall_enable_nat() ad=
dress 192.168.0.2/24 interface wlan0=0A=
connmand[25248]: Cannot enable NAT -2/No such file or directory=0A=
so it seems nftables gets used.=0A=
=0A=
I tried to add some debug statements, but if I do so, the error message cha=
nges (?) and sometimes I even get "Enabled tethering for wifi"!=0A=
=0A=
connmand[29044]: src/firewall-nftables.c:rule_cmd() in rule_cmd=0A=
connmand[29044]: src/firewall-nftables.c:send_and_dispatch() in send_and_di=
spatch=0A=
connmand[29044]: src/firewall-nftables.c:send_and_dispatch() after debug mn=
l dump rule=0A=
connmand[29044]: src/firewall-nftables.c:send_and_dispatch() after mnl_sock=
et_sendto=0A=
connmand[29044]: src/firewall-nftables.c:rule_cmd() after send_and_dispatch=
, err: -97=0A=
connmand[29044]: src/firewall-nftables.c:__connman_firewall_enable_nat() af=
ter rule_cmd=0A=
connmand[29044]: Cannot enable NAT -97/Address family not supported by prot=
ocol=0A=
=0A=
this is what I added to firewall-nftables.c:=0A=
 281     DBG("in send_and_dispatch");=0A=
 282     debug_mnl_dump_rule(req, req_size);=0A=
 283     DBG("after debug mnl dump rule");=0A=
 284=0A=
 285         err =3D mnl_socket_sendto(nl, req, req_size);=0A=
 286     DBG("after mnl_socket_sendto");=0A=
 287         if (err < 0)=0A=
 288                 DBG("mnl_socket_sendto err");=0A=
 289                 return -errno;=0A=
 290=0A=
 291=0A=
 292         DBG("send_and_dispatch: err1: %d",err);=0A=
 293         portid =3D mnl_socket_get_portid(nl);=0A=
 294         DBG("send_and_dispatch: err2: %d",err);=0A=
 295         cb.type =3D callback_type;=0A=
=0A=
I don't understand why I never hit line 292.=0A=
Sorry if this is of no real help, my dev skills are pretty limited..=0A=
=0A=
One last question: Can I tether wifi to wifi if it works, i.e. use my noteb=
ook as a quick range extender for a microcontroller with bad antenna design=
?=0A=
preferrably bridged, not NATed?=0A=
I have one Intel Corporation Wireless 8265 / 8275 in this notebook.=0A=
AP mode basically works with hostapd.=0A=
=0A=
Thanks for you patience!=0A=
=0A=
Best,=0A=
Thomas=
