Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130125.outbound.protection.outlook.com [40.107.13.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967E2564
	for <connman@lists.linux.dev>; Fri,  8 Apr 2022 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwWUYDYZPVuL5UnDKVB1Os/tJtF1p4cXpQ913YQW3HQ=;
 b=o2dQ3VYom2PkInprSyo1ZNSjn5BTe2eJ/huq9O5TYraRciejbgnCOkG+3NiwIsWvEOZLQ/K+1etZK7yImusmXn+wcFd47cPP8C/AJ4pahpf7e8wa9WyncdMiq+n4xSKPRjJQynYKXv7dVzZW3vp7B6sLiYkYTfcvj5COqJt5r6k=
Received: from DB6PR07CA0197.eurprd07.prod.outlook.com (2603:10a6:6:42::27) by
 DB7PR09MB2603.eurprd09.prod.outlook.com (2603:10a6:10:41::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Fri, 8 Apr 2022 15:53:56 +0000
Received: from DB8EUR05FT029.eop-eur05.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::2f) by DB6PR07CA0197.outlook.office365.com
 (2603:10a6:6:42::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8 via Frontend
 Transport; Fri, 8 Apr 2022 15:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.52.142.9)
 smtp.mailfrom=goeg.at; dkim=pass (signature was verified)
 header.d=goegat.onmicrosoft.com;dmarc=none action=none header.from=goeg.at;
Received-SPF: Fail (protection.outlook.com: domain of goeg.at does not
 designate 20.52.142.9 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.52.142.9; helo=goegsIQSUITE01;
Received: from goegsIQSUITE01 (20.52.142.9) by
 DB8EUR05FT029.mail.protection.outlook.com (10.233.239.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 15:53:55 +0000
Received: from mail pickup service by goegsIQSUITE01 with Microsoft SMTPSVC;
	 Fri, 8 Apr 2022 17:53:55 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com ([104.47.18.111]) by goegsIQSUITE01 over TLS secured channel with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 8 Apr 2022 17:53:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io7QwU550+JjNkpDuehY8N9AEbYBjaxF0XTBSkjshZKCU0jjOibb02DpkrE84hGaoDUE2wLiQbrDLyrmWuYgajIgAaQ95AGObgLavp0hTlykvk6Qc91L4YYeynVFlp1oiERYcreV4OzgCSGpWGtrOj4nJpOb5v4OvFbs14JIBcy2f5Lo61WgQfJVG4HbWjxd1k0D4E1g+711yEhiCLrXrkBynVQidR1/JUellb+Pu+E5uHJ2TdRT1U//N0I/vBfrRDiTNc6jTRBT5Dw8IwRfldLeULHqEhtp1AG6M0HXRREwXvyCgpd9QsLeCgNPCGAOF8EElSTrzPvjrn0av8fpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwWUYDYZPVuL5UnDKVB1Os/tJtF1p4cXpQ913YQW3HQ=;
 b=bPy9C4ly76WrrNyzterZnIRhBTEg5ZSl00ONaVJkp1Lh58pw3KPANL5xK0pGT6Gj9b6U6NKyj7gK2iT6PYDN7Kyj7g7nzlA1L9v5AAXYZcQ4qnaH3uOxFHe1a0E2++ASEY1wNLiNnKzPcWD204Is4vUwFrfz9soutQX0iTRxzuYL8VWX8VxU8UeDuFy5yI0O3Y++2941EQpLuTV23hVqhZeQQEyKJfllrdu/wb97jc2tFKbSIbfwjKZBJXQmnJzscNdhW3FOOsFcv2x3SRvhirklIehm0xBut2f7qzwKloLFNVEPEAI0CV5BpxxiL3GLa+dnZxi30+nt6oiNpeYbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwWUYDYZPVuL5UnDKVB1Os/tJtF1p4cXpQ913YQW3HQ=;
 b=o2dQ3VYom2PkInprSyo1ZNSjn5BTe2eJ/huq9O5TYraRciejbgnCOkG+3NiwIsWvEOZLQ/K+1etZK7yImusmXn+wcFd47cPP8C/AJ4pahpf7e8wa9WyncdMiq+n4xSKPRjJQynYKXv7dVzZW3vp7B6sLiYkYTfcvj5COqJt5r6k=
Received: from AM5PR0901MB1633.eurprd09.prod.outlook.com
 (2603:10a6:203:4f::21) by DB8PR09MB4373.eurprd09.prod.outlook.com
 (2603:10a6:10:156::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Fri, 8 Apr
 2022 15:53:53 +0000
Received: from AM5PR0901MB1633.eurprd09.prod.outlook.com
 ([fe80::d186:7efc:f811:fbd1]) by AM5PR0901MB1633.eurprd09.prod.outlook.com
 ([fe80::d186:7efc:f811:fbd1%10]) with mapi id 15.20.5144.019; Fri, 8 Apr 2022
 15:53:53 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Unable to establish openvpn connection under Debian [rp_filter
 restored to 0, notifier disconnect underflow]
Thread-Topic: Unable to establish openvpn connection under Debian [rp_filter
 restored to 0, notifier disconnect underflow]
Thread-Index: AQHYS2DY4D/RHlZSlk6l6roRaW7OkQ==
Date: Fri, 8 Apr 2022 15:53:53 +0000
Message-ID:
 <AM5PR0901MB1633AB6BB661EEADB165A51DF2E99@AM5PR0901MB1633.eurprd09.prod.outlook.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
X-MS-Office365-Filtering-Correlation-Id: 708db5c3-60ab-441a-4ae6-08da1977fcb4
x-ms-traffictypediagnostic:
	DB8PR09MB4373:EE_|DB8EUR05FT029:EE_|DB7PR09MB2603:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR09MB26036D36479EEAE8F33737BDF2E99@DB7PR09MB2603.eurprd09.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 d9KwcBQST0h8YZaxvmoxMLX5dgEIKlDpyz1d/+Xq6g4+BfxymBdwwB6Tx20jndlmgLTtxQ2imsHxxube2JMQGkIrb4cnDtwKLKPwRSm7pRT4CeAYkasuVzlduXRh6bEDXz7MEYYZTlI88Qfh0FFVpSDdMx7ZXicoQCiD3cD9Glf65WkBCav6g0XAc6Rw34VbI2fDvNttTNx8YzG43SV7FeyBLHRqQUc2gvTA755clDXOw4pqUipNkFNcgKYzeDkW6UnpuxDjEf72EFIkRK+0oKG8nyczuseBzkbfYXDnQSuMaKTdbhr7uRow3pG8tsoDIDYc/dKKDrkyI8Zs9Eafgw2tLiZxSdiHehqZC6ctrxbnu6Gj+E/EaXPXP21HLxO7LI1CInwPxQmmk7OPiXKPC3SK6vy06BM45oPeOXIMP1Q++pUtnnbiKIblYvJVOA7ySNAXZJuMAuE2ir88h8E1Xt6+oLiNKIttCDdat2t8La/pIDwCCCYG9ASlNIUR7SV3+SWxRS/IC2SNc4NFjopJv8701xgq3ajJt6rNB9oUZ+bw3UqSgeeRKfHGXhXSvGk+bJYifM1xJTBQ4riAECTABE+jKfL1+iv25y1K1dLTQvI7KaKNjhCrPa8fP3kYydgR+FUtdFG7AnOztuCl+eJZDNq3bpztBxfrSh0L7clyNzbDDPT9Ua1nU3KGG5Q+8b2JG1HwU7N1e9P97OyOxFP9qA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0901MB1633.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(316002)(30864003)(76116006)(6916009)(55016003)(38070700005)(66946007)(6506007)(66556008)(64756008)(66446008)(66476007)(8936002)(508600001)(86362001)(5660300002)(33656002)(91956017)(8676002)(122000001)(38100700002)(71200400001)(26005)(52536014)(83380400001)(186003)(9686003)(2906002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4373
X-OriginalArrivalTime: 08 Apr 2022 15:53:54.0444 (UTC) FILETIME=[D97114C0:01D84B60]
X-GBS-PROC: 8nEwQmeqoarrBYExp6GMHGsmvHXiUsI+BKlaIaWKg2iYAx2Ew57y7MZkMKEf+blO
X-GBS-PROCJOB: 5Uvlt9iGF2O34cpLndBqS6kTitt9oarUFcSoIU4HhaB1jvBwhtIqvfH1/xBCkCXx
X-GRP-TAN: goegsIQSUITE01@0E0111410EE34E4A8969595430DDF959
X-iqsuite-process: e13a3393-6c38-45eb-8279-3913da145940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB8EUR05FT029.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a9876bf8-1397-4039-c069-08da1977fb32
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZvR8ot6f++MYMxO0N2GsfKe7e1JJ/0Qnhtf15/S0fHhTntXbhftlFUv+6x42CeG1lR/jAEh0LBsAKAx0M2eJe8hCN5Hn4SPboYZlkLq4gER2xFSAAfAFmV8R8DeJ7OcI5XEDHcWTbj0hzTPmnZzZ324xMcJI6hdaFwWm0O+gXzm56dZMrt3S0WUV7erCgwl8cPvBxsigKa3QSe+6olWuB15k8xq2a3y2g2FjbfeLuJ+CvtbyHCPi8TG0yBqYW2ruFNGjQd+vFQOTWjP8ZYp8u2eWLHZnSNImXPBd5x0ar1oFw54Zw0l0YKFRPv1XTkUGGOFvRsAkJuFezjNp0bQ2YJxxvXFG3hCPbOAzh/FL1dhK0uY4ukkHdHOD2XNWUs3GTMh4ctC2XT0hGJt0d+wiZbFFKq2P++JeDbMYpbXRgIWq9N5ZOClG7AcJhgHUJTrqW7GUZmOzuUMLn2UMPJVaKfcTgomUGw+q7k5xR0leZ6Ao2EsB81sb2smRUS0pXJunlgzYNvYGk+1lKSph9mbnzx9bNpYj1yrv6iFzOu9771C7zl80YzRFILKwVUYl9iEerhtrfZkn+KgoFwpC5tzyVSI7c/nKgxCnhG2vUYRSOe8u9w/3tik1g92ioNPOq7MUbyXtB98lyrDuf+pihxA9ynzMGfkVtqYevAbGgbSZ+KZp2tdkddXOjpxiEFDjL3ew
X-Forefront-Antispam-Report:
	CIP:20.52.142.9;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:goegsIQSUITE01;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(46966006)(36840700001)(81166007)(186003)(26005)(33656002)(55016003)(83380400001)(5660300002)(9686003)(316002)(8676002)(6916009)(70206006)(70586007)(82310400005)(8936002)(36860700001)(7696005)(52536014)(508600001)(2906002)(6506007)(86362001)(47076005)(336012)(30864003)(356005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:53:55.7198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708db5c3-60ab-441a-4ae6-08da1977fcb4
X-MS-Exchange-CrossTenant-Id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff;Ip=[20.52.142.9];Helo=[goegsIQSUITE01]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT029.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR09MB2603

Hi!=0A=
=0A=
I'm struggling to get connman+openvpn running on a current Debian machine.=
=0A=
=0A=
My Gentoo notebook works fine with nearly exactly the same versions:=0A=
- connman 1.41=0A=
-- DEBIAN: built this myself as I got "netlink: attribute type 1 has an inv=
alid length" with the stock 1.36 .deb in the Debian 11 repo and thought tha=
t was the problem=0A=
--- config used: ./bootstrap && ./configure --enable-openvpn --prefix=3D"" =
&& CFLAGS=3D"-march=3Dnative -O3" make -j4 && checkinstall --fstrans=3Dno -=
D make install=0A=
--- NB: the ./bootstrap step is missing in the README file=0A=
-- GENTOO: this is the most recent stable version in the repo=0A=
=0A=
- openvpn=0A=
-- DEBIAN: openvpn 2.5.1 (official repo)=0A=
-- GENTOO: openvpn 2.5.3 (official latest stable)=0A=
=0A=
However, on Debian I get=0A=
connmand[64470]    : rp_filter set to 2 (loose mode routing), old value was=
 0=0A=
connmand[64470]    : rp_filter restored to 0=0A=
connmand[64470]    : notifier disconnect underflow=0A=
connmand[64470]    : ipconfig state 6 ipconfig method 1=0A=
openvpn[64488]     : event_wait : Interrupted system call (code=3D4)=0A=
openvpn[64488]     : SIGTERM received, sending exit notification to peer=0A=
connman-vpnd[64477]: pid 64488 was not killed, retrying after 2 sec=0A=
=0A=
=0A=
On my Gentoo notebook, I don't get "rp_filter restored to 0" but see "Setti=
ng domainname to <domain>" and then it continues to set routes etc.=0A=
=0A=
I'm pretty clueless as to what I could do to fix this.. It's the exact same=
 provisioning config (that in turn uses the openvpn conf file)=0A=
=0A=
Using openvpn standalone works nicely with the same openvpn conf file on De=
bian as well, just not with connman. That's why I basically rule out hardwa=
re or other OS differences.=0A=
=0A=
=0A=
The relevant sections with debug mode turned on are as follows (I tried to =
keep it as short as possible, hope that's the right spot and enough details=
):=0A=
=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: rp_filter set to 2 (loose mode=
 routing), old value was 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:service_rp_filte=
r() connected vpn_openvpn.domain.com_openvpn.domain.com ipconfig 0x55cb2508=
6c60 method 2 count 2 filter 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:connman_resolve=
r_append() index 54 domain (null) server 10.XX.XX.44=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:append_resolver=
() index 54 domain (null) server 10.XX.XX.44 lifetime 0 flags 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:__connman_dnspr=
oxy_append() index 54 server 10.XX.XX.44=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:create_server()=
 index 54 server 10.XX.XX.44=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:connman_resolve=
r_append() index 54 domain (null) server 10.XX.XX.34=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:append_resolver=
() index 54 domain (null) server 10.XX.XX.34 lifetime 0 flags 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:__connman_dnspr=
oxy_append() index 54 server 10.XX.XX.34=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:create_server()=
 index 54 server 10.XX.XX.34=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/timeserver.c:ts_reset() No=
 timeservers set.=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:service_indicate=
_state() service 0x55cb25088150 old association - new ready/idle =3D> ready=
=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: plugins/vpn.c:vpn_disconnect_c=
heck()=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/session.c:service_state_ch=
anged() service 0x55cb25088150 state 4=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:connman_resolve=
r_append() index 54 domain openvpn.domain.com server (null)=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:append_resolver=
() index 54 domain openvpn.domain.com server (null) lifetime 0 flags 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:__connman_dnspr=
oxy_append() index 54 server (null)=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:update_domain()=
 index 54 domain openvpn.domain.com=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dbus.c:connman_dbus_reply_=
pending() sender net.connman.Service path /net/connman/service/vpn_openvpn.=
domain.com_openvpn.domain.com=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:service_save() s=
ervice 0x55cb25088150 new 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/ipconfig.c:__connman_ipcon=
fig_save() ipconfig 0x55cb25086c60 identifier vpn_openvpn.domain.com_openvp=
n.domain.com method fixed=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/ipconfig.c:__connman_ipcon=
fig_save() ipconfig 0x55cb25085560 identifier vpn_openvpn.domain.com_openvp=
n.domain.com method off=0A=
Apr  8 17:29:44 Debian-host connman-vpnd[67023]: vpn/vpn-provider.c:provide=
r_property_changed() provider 0x556a97d4fb90 key Timeservers=0A=
Apr  8 17:29:44 Debian-host connman-vpnd[67023]: vpn/vpn-provider.c:provide=
r_property_changed() provider 0x556a97d4fb90 key State=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/notifier.c:__connman_notif=
ier_connect() type 7=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/ipconfig.c:disable_ipv6()=
=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/ipconfig.c:set_ipv6_state(=
) vpn0 1=0A=
Apr  8 17:29:44 Debian-host connman-vpnd[67023]: vpn/vpn-provider.c:provide=
r_property_changed() provider 0x556a97d4fb90 key Domains=0A=
Apr  8 17:29:44 Debian-host connman-vpnd[67023]: vpn/vpn-provider.c:provide=
r_property_changed() provider 0x556a97d4fb90 key Proxy=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:single_connected=
_tech() keeping 0x55cb25088150 /net/connman/service/vpn_openvpn.domain.com_=
openvpn.domain.com=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:single_connected=
_tech() disconnecting 0x55cb2507d720 /net/connman/service/ethernet_606d3c4e=
4cc0_cable=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:__connman_servic=
e_disconnect() service 0x55cb2507d720=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/agent.c:connman_agent_canc=
el() context 0x55cb2507d720=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/stats.c:__connman_stats_se=
rvice_unregister() service 0x55cb2507d720=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/network.c:__connman_networ=
k_disconnect() network 0x55cb25077cf0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: plugins/ethernet.c:eth_network=
_disconnect() network 0x55cb25077cf0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/network.c:connman_network_=
set_connected() network 0x55cb25077cf0 connected 1/0 connecting 0 associati=
ng 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/network.c:set_disconnected=
() service 0x55cb2507d720 ipv4 0x55cb25076000 ipv6 0x55cb25078670=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/network.c:set_disconnected=
() method ipv4 4 ipv6 5=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcpv6.c:__connman_dhcpv6_=
start_release() network 0x55cb25077cf0 dhcp 0x55cb25074d20 client 0x55cb250=
85150 stateless 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcpv6.c:__connman_dhcpv6_=
stop()=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcpv6.c:remove_network() =
dhcp 0x55cb25074d20=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcpv6.c:dhcpv6_release() =
dhcp 0x55cb25074d20=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/network.c:connman_network_=
unref_debug() 0x55cb25077cf0 name Wired ref 4 by src/dhcpv6.c:1858:__connma=
n_dhcpv6_stop()=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcp.c:__connman_dhcp_stop=
() ipconfig_table 0x55cb25072e40 ipconfig 0x55cb25076000=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/ipconfig.c:__connman_ipcon=
fig_unref_debug() 0x55cb25076000 ref 2 by src/dhcp.c:739:__connman_dhcp_sto=
p()=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/network.c:connman_network_=
unref_debug() 0x55cb25077cf0 name Wired ref 3 by src/dhcp.c:741:__connman_d=
hcp_stop()=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcp.c:dhcp_release() dhcp=
 0x55cb250754e0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcp.c:dhcp_invalidate() d=
hcp 0x55cb250754e0 callback 0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/6to4.c:__connman_6to4_remo=
ve() tunnel ip address (null)=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:__connman_servic=
e_nameserver_remove() service 0x55cb2507d720 nameserver 192.168.123.1 auto =
0=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/resolver.c:connman_resolve=
r_remove() index 47 domain (null) server 192.168.123.1=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dnsproxy.c:__connman_dnspr=
oxy_remove() index 47 server 192.168.123.1=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/dhcp.c:dhcp_invalidate() l=
ast address 192.168.123.216=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/inet.c:connman_inet_clear_=
address() index 47 address 192.168.123.216 prefix_len 24 peer (null) broadc=
ast (null)=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/inet.c:__connman_inet_modi=
fy_address() cmd 0x15 flags 0 index 47 family 2 address 192.168.123.216 pee=
r (null) prefixlen 24 broadcast (null) p2p false=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/ipconfig.c:__connman_ipcon=
fig_set_gateway()=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: src/service.c:__connman_servic=
e_ipconfig_indicate_state() service 0x55cb2507d720 (ethernet_606d3c4e4cc0_c=
able) old state 5 (online) new state 6 (disconnect) type 1 (IPv4)=0A=
Apr  8 17:29:44 Debian-host connmand[66999]: rp_filter restored to 0=0A=
=0A=
=0A=
Here's the openvpn domain.conf:=0A=
=0A=
dev tun=0A=
persist-key=0A=
cipher AES-256-CBC=0A=
data-ciphers AES-256-CBC=0A=
auth SHA256=0A=
client=0A=
comp-lzo adaptive=0A=
resolv-retry infinite=0A=
remote openvpn.domain.com 1194 udp=0A=
auth-user-pass /etc/openvpn/domain_creds=0A=
ca /etc/openvpn/domain_ca.crt=0A=
cert /etc/openvpn/domain_user.crt=0A=
key /etc/openvpn/domain_user.key=0A=
remote-cert-tls server=0A=
script-security 2=0A=
lport 0=0A=
verify-x509-name "openvpn.domain.com" name=0A=
auth-nocache=0A=
explicit-exit-notify=0A=
=0A=
And the provisioning file:=0A=
=0A=
[provider_openvpn]=0A=
Type =3D OpenVPN=0A=
Name =3D domain=0A=
Host =3D openvpn.domain.com=0A=
Domain =3D openvpn.domain.com=0A=
OpenVPN.ConfigFile =3D /etc/openvpn/domain.conf=0A=
=0A=
I have not been able to succeed (on either OS) with using just the provisio=
ning file's OpenVPN.* parameters. This should however not be the problem, a=
s it works on Gentoo.=0A=
=0A=
I don't have access to the openVPN server side.=0A=
=0A=
Any pointers appreciated!=0A=
If I can provide more debugging info, please say so.=0A=
=0A=
Thanks a lot in advance (and for a bloat-free connection manager)!=0A=
Thomas=0A=
=0A=
