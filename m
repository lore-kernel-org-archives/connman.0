Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3E1CAA87
	for <connman@lists.linux.dev>; Mon, 13 Jan 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776802; cv=fail; b=l9C6h+cNadtqjhz5tUApMyYIXXuggp1jao56qBBRtm3Qmw6OyE+j0tPeeHlQKRtLDYYlv4BKqv1aZKPty2blNCr0zChScn7trDvikiBOLodeOZMNDc2/tT4E6oJjBIA+rwUlmY0XGlaOi4i8zOuV8/uZeTg/c63cnAUyDntOfbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776802; c=relaxed/simple;
	bh=WHcQan89LrLpQjr5J+m1LIQH1w3fQo+4MZ+zog9FIag=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nlBLELpWvRZMcc0vOQqNxX+/QP4Nu8ejHIgZe1FhINmZdLavZlNmKgvqtXdj6bBRI8iIkf33hVhVXS1fsDZ4kfiUCECm81beSRyxZmZY/MNoF3SmowX2vNWpmeqpfJPhkktb//i+N7/qCPi36ORZeCTdzOEgjcPg5VNRMsJK/Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=KYAs94bO; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="KYAs94bO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfZThVm0aQ4kqH7TeW83a7ZKKbIYOojmSIF+3AiDfpu/7xp305HoSP3x1YD4CQXElskuQhUkgWUu01KZ6ca7u47clJgeeJvARVwTKjEy+ZhS8l7Z27lvHzU49c4F3X125ImdRvMCxlt0jwXZpCo5AsBkKkh6VU1M0I/aowQz67m0mD2Q9ULfeVaXfY6gNNQDENkxvUd01yE0RRPR72icQnDbgQHZ8wRMBbdWLg/Zrmd74xygvS2jJM6fW6rhahUKeS+la2Mci9ha2qRTpXEmeiDGFOJ14Bt8JUnjmp6seLaats/WEhoA5+DpIVa5+U5wIQfpbnJ2vP6ZpeC3y3Q6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bleJRbkdRRG/BrGz+oTcBzdBrR2thSuJvWRSawmjvo0=;
 b=iVB7eBy8zdkIg7QJs6RJbI2SwhyDl9tKbb5aFU9tfO65FPw/MdVw99/4br+LbWpXmM3CB2Zb6F6mLLp11lA+GdCYqLks++iFJo0pHoT0XGnKRj4Q/Om4vdCEIBLoevJmiGXbruHu7T2t4tjJEiHx5qkyz52Sr1wTjYYi/NlLO8v2394ABx3xCEmk2v6Yta+4vRXlnkGxAkWjR9FSnTRJ3HCkNv/yeZwp0TkDxz3u6mdtQ4kmsRpD94lhEgwJaf03HOUFW9K4gI/yWDV3gEl0P3adHr0bL7UaYnn1BEKexxbI4Ppzy4gr6OegUjIldUanSmZm1zGDdeGcUbIPPPm4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bleJRbkdRRG/BrGz+oTcBzdBrR2thSuJvWRSawmjvo0=;
 b=KYAs94bO+xC7TCbOvApgiyxAUX0UkaT8b6zIzYm1sog068eQU6wsVOiV1KmC3vFwzSWN6BqtYC2Nt0JwU7pVftqHQh+3n0AqRx2dd+FJK/Db5FLp1UwR+zZ0MQ+hsXUwowFIHIj0fCupZq5TWK8VbhkGMkiHqGUmGrRKBMVWPbA=
Received: from DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::11) by
 PAXPR10MB5541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Mon, 13 Jan
 2025 13:59:55 +0000
Received: from DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c0:b27c:804f:1925]) by DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88c0:b27c:804f:1925%4]) with mapi id 15.20.8356.010; Mon, 13 Jan 2025
 13:59:55 +0000
From: Gabriel Sanches <gabriel.sanches@prevas.dk>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: [PATCH] gateway: Fix typo when setting 'is_vpn6'
Thread-Topic: [PATCH] gateway: Fix typo when setting 'is_vpn6'
Thread-Index: AQHbZcGgb3qCR9F2HUWHK07I+FeKIQ==
Date: Mon, 13 Jan 2025 13:59:55 +0000
Message-ID:
 <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR10MB1845:EE_|PAXPR10MB5541:EE_
x-ms-office365-filtering-correlation-id: 1ff84a6a-1285-438e-d7e4-08dd33da8ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AneIfOpEqWRUKpRfksA9Y+IXA3imvZTRBKlzDECJneANuxATW5u733ZZLC?=
 =?iso-8859-1?Q?1RCHcHW1MmIIg8M5zKqT5vJQrV4v+5gKSDLt74EGsCkF4quXgQB2QRWgTr?=
 =?iso-8859-1?Q?K0OVctP1/98ZQX+AI3m2M/IA8bsQ6zP2Cf7kjRURq1125BD7UvvCLMGbGt?=
 =?iso-8859-1?Q?bhQV0jwMEM56jI209P4CBQmmqeazA39kKcPRE7/AIRA2uVpgvdFNNioifm?=
 =?iso-8859-1?Q?uXnBez0YQwsNPz0hiXhG8p6IjV/7ls3Zg37XVe2Ikyrq6CvV4VK0MmBNG5?=
 =?iso-8859-1?Q?jqVnOHBx/uxUgdg19tWuEPoa5f9zeT2DBxVXcm24r32FOhFStZ3RMWoKpE?=
 =?iso-8859-1?Q?7/jsmL4vytVO1kdbQMTflPJl9WQTFh4szAgFG0FgUBKL87KGKRmYyCRaaM?=
 =?iso-8859-1?Q?3xk6Lis1SXR90WNP+oqYCYo9uHm06U+2fE/6pZejjgXlfJ0875sDsipQT8?=
 =?iso-8859-1?Q?eJ2iJIEBF/7x5nJrtHMsn0RnnvYaTLNCePxyOiBJOfTE6fkVkJOgnuPAtO?=
 =?iso-8859-1?Q?kSyqSL1siCdE92SpV7NJINpcjB08SuPLJcaWB7pt3osE1jASstSlg3ja6D?=
 =?iso-8859-1?Q?WZExJThm6YdBdOV3e9nK/cjK88A+ZaG8QXZn48w8aAJ1bZjN3qsG8x4t5m?=
 =?iso-8859-1?Q?jIV8v/8Rgb5VXycrkLsl8pQzJWVwK5GEfhhTyrhi/2Qywb1rzdcZtZQh1C?=
 =?iso-8859-1?Q?WlfXZFfwTRcsESKJLSZf25O3KfJ8g7HClwvEK4GmfUwzZKCq8e8V58kPg8?=
 =?iso-8859-1?Q?okjbUVnNxsYiaNSWUseBe88jqrQhV4SM9hqDHBcxWwethyjCwyDy+jip7q?=
 =?iso-8859-1?Q?t8ZhV6REiPz8uyevJfV1uVNeNJBfbJU2r1jqHJapj68QynhfDPWf/fZfNd?=
 =?iso-8859-1?Q?/MWQrJeG3W7vyC94qa4eQURsu86yCvbiz+8hAMjPGYD9KI4gf3W8WlVYuW?=
 =?iso-8859-1?Q?VO3I0F9k2TuFCvfS5hdeIGy0gB7U70jjtQHpwHbjn5RGacXp+TZe4BXUWR?=
 =?iso-8859-1?Q?57B0mWZmOi0etnL6TAIffQPRADkAifiRxG6krjalhvQdinXP4aA9PgyeCY?=
 =?iso-8859-1?Q?6Z7mWM/qhr4b5WtyqPCJI667cq3w0X8mWUeKTgxgLDXkbmLRHTloV9cVbK?=
 =?iso-8859-1?Q?BNqP+FKHLaKUHh564NhFY4stqNlk0W1S1AnhChFJxdFUZxMlkHtG5/vLSg?=
 =?iso-8859-1?Q?F2q5klv3q+e3AB3Jj+1c621qpUFrbAeXVtu13d7Y5451DzjFFVvoQl/PrZ?=
 =?iso-8859-1?Q?SXv8XNjltz87+sQVzNFd1mR05ey35TMcc3eRd5zUg6m+x8Q3QL166c/3Mh?=
 =?iso-8859-1?Q?rXaat4D7UWj4o00uYA+hem0XLO4bAC0fDSu9vFe0NCkz3vmuZt76kIjZpG?=
 =?iso-8859-1?Q?s3jvGZX1TLvk2xzMHCMDadnMc0FDPPVBBMJR10zOiVmysFp/frpslLJVCH?=
 =?iso-8859-1?Q?JnGcTE68q+8WgbRmyXVb1tQrJdo7EueUIgv+OwR6v7MtXiuoRJK0l1SX2x?=
 =?iso-8859-1?Q?caVOaskOmcg3S1IRH9YpWC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vh+eAKzc/wt1IDqh/ahJH5oUbL9qxt+7CDvOVRsHSUBEwBDkotCkEoQ8Ou?=
 =?iso-8859-1?Q?d8sB+DFcfEoHraKIkVm3uB3ct5xyvquLdAsVU8otXpilcF2doZeJ3vtQcE?=
 =?iso-8859-1?Q?1eFr+34xR5yw8OS6F5O4vAMlwzPRrivP8a06Ep2iVOeR32B2XcSAWyZ2AT?=
 =?iso-8859-1?Q?uMkdma4chwlyMNJTY8ZCcAixzM2219I2d8kYJBVeROOd6PZ9lrTaIkIKsJ?=
 =?iso-8859-1?Q?kKgVoO3YzuZXeX7Jwph6amlcGdc41tkgc/eGykoRgS3isnzlqObFL3F4Os?=
 =?iso-8859-1?Q?sijQ2XUem2aFiq4iWYOLAbRv5K+XT6cH4WMthn2BNc+rNMp77x6DJobizh?=
 =?iso-8859-1?Q?sxaYrxwzJLA1dE481iuV4kb0bjZ4iTm/+hkZLuRTD7LQIVvcYY2OTqFQKH?=
 =?iso-8859-1?Q?PI+2p+hOPIw/ex+Q4qJL7R0s2voNeXaXt721g3UTje8gicHKMFMLPFOk8C?=
 =?iso-8859-1?Q?oEgEY398JmwflRRKXeE+/bqfWDXocTsvw6Me2Ue+Wazosh5v3umj6NnG7E?=
 =?iso-8859-1?Q?9yiUPcHIIN60nEXrq98bhKcOu1X3PyUn6YpYdY59Keh1oi0+7jlkr9qHAM?=
 =?iso-8859-1?Q?OyKhGRYhPucL/u3KDUcuCS9u4JYjH4kSYR3KZa8GTIC9gmNG3KSoJh/j+H?=
 =?iso-8859-1?Q?2wdMKsgE3klhhxv7a/O1d6K04JsZNcec8MmJZO5nF+YPxPrSjkmhHxBT6v?=
 =?iso-8859-1?Q?eJkKL4a7pRfKyOKT/VYONhWhlGMIer5/dnJWn18/NCtll8AC6C78aOd8JI?=
 =?iso-8859-1?Q?56ljDsieQNd5lgp4+Z+fl3sTtRzP9DJwxolr/WJuZDpb/l29Y8lq91otOb?=
 =?iso-8859-1?Q?qwMeLpk0FM0cdGD8oMJMJAsB2FP0BMiNJ5d5Ee0lODlPwFKVV1KhQLBXsZ?=
 =?iso-8859-1?Q?g368tB430WHonmdY6jxUslTzkUv629b27PHfCDWfPm2p5iUs2uGPVMDQUi?=
 =?iso-8859-1?Q?9WlYUN/XrCLTdrDXNRsr0Tu7HhWnAg2I/gzx9pbuLxdZyOlE4s2m851xpV?=
 =?iso-8859-1?Q?fiWyWH0FZi7ljuasTLNLNpSkkHOQvnC7Jas5fdZzvdQcbCr1arTnoprni6?=
 =?iso-8859-1?Q?20djAfXEy/5l368hfFUQa+w2TbBANSnmyquwdM4H9MgLTp1mCdB0uUxCOe?=
 =?iso-8859-1?Q?i/Z2bCIdfZIAUQ5aOn1TQLIH6d3tL9wMHK18333ydrI5yM9dnAtwX35Y6B?=
 =?iso-8859-1?Q?VajhBgU8UNjAA5WnvfgdTvaafIeIhtDVYTeYdX/AgQMDrkoJmv2PQZD3d4?=
 =?iso-8859-1?Q?5ZPasgrcd3oPzuvKAdodwxRSxhEE9aNV+sT3LJoBr+cbi5n6NE5N2LKnZf?=
 =?iso-8859-1?Q?VclfbIJM25VHBnRECelnAn54EaTtV7dXv486TMrSlKL/RKCZWFGB70JWWL?=
 =?iso-8859-1?Q?2sbIL2SSRUxO5sZWKDrM6NDWkS5/0pMA2dNXrpQHx0g8sqTuRgpa9L/pgo?=
 =?iso-8859-1?Q?o/G5hpKPGWZ+oHVb1UpKw8420HHdVbPw/fHoy4+fQ5xyhudXSeoFW7PyI6?=
 =?iso-8859-1?Q?xdlx2tHeC/CknFEWesP+QfCKe+L2edaJTo9eUZoAURlFJhQDyP16Fuolik?=
 =?iso-8859-1?Q?pI5ajzPb5jxobmdpbZ/2WezvbIeY9sKq+RASt37MEgpf1SbTLADutB1gVY?=
 =?iso-8859-1?Q?V+6qT5DLSGn7i6Jc5BV+fus1p5m3hiIyBFONknvK8hSQH29E6J9gR7vF+b?=
 =?iso-8859-1?Q?hb0cTV1XU834vJ0/7Db+ZKIiMYMvSQ9prpYOiw/r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff84a6a-1285-438e-d7e4-08dd33da8ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 13:59:55.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WS/yRCiQ2nHsW2siWkY5jRZczglGZV5YgWn5TGZnp5GuZ/TSOAJYIZYVx9Q8vQHA9bUrTmohfxLQuRb8deRwomxMNMZFabknNTv8NsSzrzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5541

Hi, =A0=0A=
=0A=
I was testing connman's wireguard plugin and got a segmentation fault.=0A=
=0A=
Looking at the backtrace revealed that there are some typos in the `src/gat=
eway.c` file where `is_vpn6` was incorrectly set using ipv4 variables inste=
ad of ipv6 regarding vpn.=0A=
=0A=
I simply changed them to ipv6 and got it working.=0A=
=0A=
not related to the patch:=0A=
I had to manually add ip route so the other devices could be pinged=0A=
The plugin adds routes for the WireGuard.DNS configuration setting=0A=
# ip route=0A=
1.1.1.1 dev wg0 scope link =0A=
8.8.8.8 dev wg0 scope link =0A=
10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83 =0A=
10.42.0.1 dev end1 scope link =0A=
<vpn host ip> via 10.42.0.1 dev end1=0A=
=0A=
the missing route added manually:=0A=
ip route add 10.33.0.0/16 dev wg0 scope link=0A=
=0A=
an equivalent wireguard file adds it properly (using wg-quick)=0A=
=0A=
Is the plugin lacking some implementation?=0A=
=0A=
---=0A=
 src/gateway.c | 6 +++---=0A=
 1 file changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/src/gateway.c b/src/gateway.c=0A=
index 16c87f83..b2c211e2 100644=0A=
--- a/src/gateway.c=0A=
+++ b/src/gateway.c=0A=
@@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_service *s=
ervice,=0A=
 					is_gateway_config_vpn(=0A=
 						new_gateway->ipv4_config);=0A=
 =0A=
-		is_vpn6 =3D do_ipv4 &&=0A=
-					new_gateway->ipv4_config &&=0A=
+		is_vpn6 =3D do_ipv6 &&=0A=
+					new_gateway->ipv6_config &&=0A=
 					is_gateway_config_vpn(=0A=
-						new_gateway->ipv4_config);=0A=
+						new_gateway->ipv6_config);=0A=
 =0A=
 	} else {=0A=
 		if (do_ipv4 && new_gateway->ipv4_config)=0A=
-- =0A=
2.43.0=
