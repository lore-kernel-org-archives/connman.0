Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30121.outbound.protection.outlook.com [40.107.3.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D8ECA
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 09:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5UdJCR/hOXVDiF7QeygUmIAZ5WPuOyx2mk+/QDpxVhbWCe7KwQgevPBr+G6loa/dTyjKHTUN+eTaQSTCGr4VPaoBEPdeVGrH0joYfbtfZ6XewCWmFSymF4//3Q1HPK5lw+s7tOGAb5WkDzrj8Bl8N9RhPcbMPAxADE6PflZfXIdAFGr1+W6a6q0/F7uD6R2H8MfI9JWm0sw7+TLWNIG5vPdsXmnuGzWsBRQXPGV2yi+ywbajFxM3VGjv64rNRRJb04+is1dY4BOZSx3tNyljcJQ0qOE3jyGsd5RcptVMypiS4ytvsxyL3y/Cd632ols/8awxbdNpKIiXlx9tXH9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZcVnw9bjxL0qrTyBARnQtNWuMfFMGmgaKD/978Ak3g=;
 b=P3FygipTX51VVuNyLUyjn9PiXP9EkjUmqHTW57dlboHzMUsLEU9t4OzTSX9L/VaCjMiTtCFZV0mr5JxgzD2mnLNrNq/OBX4C6vZDEFK9O3mrzprCJQwaV/T6n0h1V7kgOLPgInngib5QZkmKvuDg62DUvq6kJitUyGpgDwspoR2z1P3cWm2tPxd9vgkAFhH0hgl8GT0AbALlM5O9Pzycx6bOsMnDvUw22DlCT4EV2wKRdr/YPj4amNV2EBb14RlSvlTjbLeu4/tMa+enX5dtG3PKfUiNjpTJENcoTut+/AUKPEnFmfq1Yb9eIP9e/M5kr0hCFeSSwdy2rG/9bNhi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZcVnw9bjxL0qrTyBARnQtNWuMfFMGmgaKD/978Ak3g=;
 b=LtuZ52YC7dICAKnIRJhbqOS2YAtY5QnWR5JJjoN9gwD/M9nbu69vlgjgDl9GHvcCS/F+wdTywbUJ89Dxh0HCSX/Ugofa8c+atgMsfOQQpKyXEDAuO6H/G+XRCwY8v9THnvh9Me0XYqgR6GVfAU06gSC/wkGRZaziylruEMzozRw=
Received: from AM5PR0901MB1633.eurprd09.prod.outlook.com
 (2603:10a6:203:4f::21) by AM9PR09MB4545.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Tue, 19 Apr
 2022 09:56:48 +0000
Received: from AM5PR0901MB1633.eurprd09.prod.outlook.com
 ([fe80::9595:5579:a898:1367]) by AM5PR0901MB1633.eurprd09.prod.outlook.com
 ([fe80::9595:5579:a898:1367%9]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 09:56:48 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Unable to establish openvpn connection under Debian [rp_filter
 restored to 0, notifier disconnect underflow]
Thread-Topic: Unable to establish openvpn connection under Debian [rp_filter
 restored to 0, notifier disconnect underflow]
Thread-Index: AQHYS2DY4D/RHlZSlk6l6roRaW7OkQ==
Date: Tue, 19 Apr 2022 09:56:48 +0000
Message-ID:
 <AM5PR0901MB163329B615A92BFEED7F60A7F2F29@AM5PR0901MB1633.eurprd09.prod.outlook.com>
References:
 <AM5PR0901MB1633AB6BB661EEADB165A51DF2E99@AM5PR0901MB1633.eurprd09.prod.outlook.com>
 <20220414184519.7frygekryu5caiuc@beryllium.lan>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c63c63e-b70b-4e0e-7128-08da21eaeb7d
x-ms-traffictypediagnostic: AM9PR09MB4545:EE_
x-microsoft-antispam-prvs:
 <AM9PR09MB4545A7635CE2906BBCA204D3F2F29@AM9PR09MB4545.eurprd09.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jKH+UgNvUsqXG/17+SFHILhqHMR4nltZAYyL9IbB39ifE98l/KcJE3qt+sp7VnGqe6uzdzYkN2Wf0wxUVZ34SaJLijP/fhOGoVOptsEW3bWDg7BU7UlKadd65Pd/O8pt6u4f89WAoyeSLya612OJLka3KYtLXDalOfbs1kC5iWSD9T4IztPHgRQFQVw9RNdbb0760vJZYcAge8qIZK/nX5JwGm7TNp9ns+fmFO51FQ1heGYIx/2J6vIfT/RB6cDYTWIYUSIV2Rc+2yr5sdv4zJqXZXsgseotPeEhoCgvFKoeRhDaaOJ2UWDnDthJt61ENQ4DuogiIjWfA0NXyxpEPnr+7oyJ08Rv/b1b7W2AWaN2rNCMds3FadZacYUKwcv+5XiizwmFn0asSXAbsl2Mjmw6ZOkTbfz5Ul9rAADc8MN45W06U3elA23Y1Um78DCJsdnTT6u4DN50dS/0qFZgQ3k8Y9huasPv1w94gavMA8NeFfEYVknGC/Suvuhu3SfIHZtVV8MKWCJ871mYBMKdH0uCn4GX8Mg9Q0PqiXwyn+pudTAzV/XarqMf4m/5QW5hsFPfV+WmPcDjmLLbCY1l48F2tDCkxk7hcQVz//txMLaQakXD863d1/AV6gc08ypgLIshadxeGnrMdsvxuopuIMHLVkNmCblvi3qE5nSR7m4YUeW1zAwvSvRLVSJSDRUaGruR4ve7XKKKRBWRZxI8H1ZaOB5UWEEQmOmttv6Umww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0901MB1633.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(8936002)(5660300002)(316002)(52536014)(7696005)(26005)(6506007)(33656002)(9686003)(186003)(83380400001)(53546011)(38070700005)(38100700002)(86362001)(508600001)(2906002)(122000001)(55016003)(71200400001)(30864003)(66946007)(66446008)(66556008)(66476007)(64756008)(8676002)(76116006)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W4cBi/0fMcEm9kdm1SpqlTt3mIB71UAqwkymOAh/rLGOQ3GcxdCCxKMnOjlX?=
 =?us-ascii?Q?xREvpdCf2N04NT2G4kVjK83JnkiWJjD7yT83lHpQPznn5F0I5pPXmeogOr39?=
 =?us-ascii?Q?nmbFTMiSDXXadUiT2+XwGpmTxZSXW2L+ZzyJw0IA8LgRMdj0cwIVFxt6XkTs?=
 =?us-ascii?Q?d0C5f3OmJp60jYTYXcTl5pLr5Kb8ge/iIc2GSf4za21y1WCZPypniA3wxplE?=
 =?us-ascii?Q?/MG8/mSE0Aq0AErdm+BiYfSBEZ9+M8/j4IbnSPMxg65RJWkiezzvnIE+P2fu?=
 =?us-ascii?Q?6DY+JcNBAqV2sFpoxhSPUiG8ZWkHsWUIilFo6nIU1zXIRPBMs1TBdLc/nlsE?=
 =?us-ascii?Q?mGWK3Le4iTglrlaDhuCNhAmZUFFfEyCGhyPIqZ9mm5R8pk+t5A376hLD+r/o?=
 =?us-ascii?Q?z72zSttqm3M1qCg/cTz3P42sL2GDY/1jBGXq/MKxX6QwrpN/krKdVjL6WV3r?=
 =?us-ascii?Q?VfzQVtTj1hYTuBhjN97St3WLhqy4lGfy4J6+ezixY9XZArX3ZTgpETPsPoTS?=
 =?us-ascii?Q?tFpqhgTA0N/3wz9SP+rzIFKQ54tVmyNcszvUBi/OZh4KeCC5BhI2v4T4LymV?=
 =?us-ascii?Q?4skeFZ2c1e5xJbLTNSS4HLckfWQjxov4N+Qn49P2weAlnOdAK7v+yiYKrKAH?=
 =?us-ascii?Q?G1iYDbQRPO1tia3hZ1XVWUyG8fzgsyg6+vUbV8rM62ERb1kRAzPIxx7TQjs1?=
 =?us-ascii?Q?45j0bKOsJbXo/c2InPYmphknLMTdo5BkbX94F014WBdKs8s+CkWxJ30rnV0Q?=
 =?us-ascii?Q?ZhRuLF3JB4xsLM5Dd/ZB39oMvPlOvIUUw/5AHCJENjZ/wTEZBtiqNtvp30IM?=
 =?us-ascii?Q?NqnhbDxK4Sqamq0YVw6qxPYenbrLHKJclj9iApWYpjLqKs9GduW5bCX4yOFy?=
 =?us-ascii?Q?5vmABjQ3jDiDC7JbLvA0b+zyMDHOCR5Kql0F6nIoRL2/Ystpkl12wynyiaIs?=
 =?us-ascii?Q?sHk2Hs8hBBQrRwgS3X9jXl/De/065zHXmWjMpVVVV7c7iN+sXPKi5A96/b8E?=
 =?us-ascii?Q?0opfIRRtIH7KQYgzlERUPKRI5VqGv0g4Hkn2tECrrW0FH6bXIb96WMuEkvpU?=
 =?us-ascii?Q?WEzFCsicF33TK+8CPYLB0iSTWW8533FwxA/6G1lBy0RZas9QlUIDNtGr3xiA?=
 =?us-ascii?Q?0RSM/9EhIOoh9k6b2WM24EKfFt/JDD7znPmBfAHJKmz5Fo4owYUKajtDaiwR?=
 =?us-ascii?Q?ojPpinxmW1O8wxsERLmo/2/Qp35WVYEXCL9a/gBJX4ygUODJioxDNP5pu5jP?=
 =?us-ascii?Q?W7RyUuy59FUFM5SF8ujewnLuvO+8TZtKm+4W4vml4gsnQDnuY3mTmZRo0OZR?=
 =?us-ascii?Q?8YZpJggqcXXKWoQp1lkkfHzDbf7YRxZNXUn5Mh6roPoRDjzInbuIExrtAma4?=
 =?us-ascii?Q?G5Oc8q5mikgoZHCJfOS4oUQXUqM2q7iKukKZVFfUS2FMGXyquqGUqeRc9OIS?=
 =?us-ascii?Q?mhz1RREWGPE8mlcrZHr+4N1Fk2u8M2TmAn902zvy7gVo3kF8milbTpE2kPm5?=
 =?us-ascii?Q?6Y1jD8/V4uC+N8jLDd/vq/SHGWOJyvUfdhaKKsq5qn9svZruvp5/Dfd1HPeC?=
 =?us-ascii?Q?vBwoGaHZf31t9SXFBIB+0CXW8Eljxl3+huZm/B+GSg9asL9Rmpraq8yJExNZ?=
 =?us-ascii?Q?Vi4Bb2pfryeXI0l6/4nfZsuyUf9aS3xiuLGEcNlGVLxwWJX+vLAnDHYZcV7K?=
 =?us-ascii?Q?4AOAE4FD6bWwGg9FMVmd9mc0KO31xLjrgfNaSEbs0HVEU0+T9TGU+A46iM/+?=
 =?us-ascii?Q?lOBeMi07bMOJpZZMS5c6ZdqIU64k0sw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0901MB1633.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c63c63e-b70b-4e0e-7128-08da21eaeb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 09:56:48.2652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hL0oCMe6bjau4RrZk3AFrnQAfmm1iO8UGeZam5Kztp5/qMxZzhV7CIw3a9ie+RHy+vU8OUSEV4usbWgGBvbYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4545

Hi Daniel, thanks for answer!=0A=
=0A=
On 14.04.22 20:45, Daniel Wagner wrote:=0A=
> Hi Thomas,=0A=
>=0A=
> On Fri, Apr 08, 2022 at 03:53:53PM +0000, Thomas Bartosik wrote:=0A=
>> Hi!=0A=
>>=0A=
>> I'm struggling to get connman+openvpn running on a current Debian machin=
e.=0A=
>>=0A=
>> My Gentoo notebook works fine with nearly exactly the same versions:=0A=
>> - connman 1.41=0A=
>> -- DEBIAN: built this myself as I got "netlink: attribute type 1 has an =
invalid length" with the stock 1.36 .deb in the Debian 11 repo and thought =
that was the problem=0A=
> Yes, those netlink message were corrupted due bugs in the code.=0A=
If we get this working, I'll consider opening a bug report with Debian. May=
be a version fixing this can be backported to bullseye.=0A=
> Hmm, connman-vpnd wants to kill openvpn, but why? Hmm, just a random=0A=
> idea: are the capalities preventing a proper working? Try to drop all=0A=
> the caps boundings in connman-vpn.service.=0A=
=0A=
tl;dr: Skip down to below the syslog output/snip, I found the error!=0A=
=0A=
---8<------------=0A=
=0A=
Tried this just now, process is verified to have no boundings anymore:=0A=
=0A=
root@tbartosik-linux:~# grep Cap /proc/$(pgrep connman-vpn)/status=0A=
CapInh:0000000000000000=0A=
CapPrm:00000000000034e9=0A=
CapEff:00000000000034e9=0A=
CapBnd:00000000000034e9=0A=
CapAmb:0000000000000000=0A=
root@tbartosik-linux:~# vi /lib/systemd/system/connman-vpn.service=0A=
root@tbartosik-linux:~# systemctl daemon-reload=0A=
root@tbartosik-linux:~# killall connman-vpnd=0A=
root@tbartosik-linux:~# service connman restart=0A=
root@tbartosik-linux:~# grep Cap /proc/$(pgrep connman-vpn)/status=0A=
CapInh:0000000000000000=0A=
CapPrm:000001ffffffffff=0A=
CapEff:000001ffffffffff=0A=
CapBnd:000001ffffffffff=0A=
CapAmb:0000000000000000=0A=
=0A=
Still no joy, however. The error stays the same.=0A=
=0A=
Tried a more relaxed compilation without specifying CFLAGS and disabled par=
allel compilation (i.e. make -j1), did not fix it either.=0A=
=0A=
I use openrc instead of systemd on Gentoo, and I don't use apparmor on Gent=
oo. Apparmor on Debian however does not list a loaded profile for connman p=
rocesses.=0A=
I don't think systemd or the startup configuration of connman services by s=
ystemd is related, as this also happens when I just start the services from=
 bash (which I did as I passed the debug switch).=0A=
=0A=
Is there anything more I can do to improve the verbosity so we know *why* o=
penvpn gets terminated?=0A=
=0A=
I dug a little deeper.=0A=
=0A=
It seems src/task.c is the only place where processes get killed, right? It=
 seems to boil down to connman_task_stop() as this is the only function cal=
ling check_kill() which we definitely know gets called by the log entry "pi=
d XXX was not killed, retrying after 2 sec". connman_task_stop() in turn on=
ly gets called in vpn/plugins/vpn.c and vpn/vpn-agent.c (ignoring vpn/plugi=
ns/pptp.c and vpn/plugins/l2tp.c which don't apply here I'd say).=0A=
=0A=
vpn/plugins/vpn.c only has two locations: vpn_remove() and vpn_disconnect()=
.=0A=
=0A=
vpn_disconnect() has a debug statement DBG("disconnect provider %p:", provi=
der); and I can see this in the logs:=0A=
=0A=
connmand[51826]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x564edbbccaa (ethernet_606d3c4e4cc0_cable) old state 5 (online) ne=
w state 6 (disconnect) type 1 (IPv4)=0A=
connmand[51826]: rp_filter restored to 0=0A=
connmand[51826]: src/service.c:service_rp_filter() disconnected ethernet_60=
6d3caabbcc_cable ipconfig 0x564ed3e4eeb0 method 4 count 1 filter 0=0A=
connmand[51826]: src/timeserver.c:ts_reset() No timeservers set.=0A=
connmand[51826]: src/service.c:service_indicate_state() service 0x564edbbcc=
aa old online - new disconnect/ready =3D> ready=0A=
connmand[51826]: src/notifier.c:__connman_notifier_leave_online() type 2=0A=
connmand[51826]: plugins/vpn.c:vpn_disconnect_check()=0A=
connmand[51826]: src/session.c:service_state_changed() service 0x564edbbcca=
a state 4=0A=
connmand[51826]: src/service.c:service_save() service 0x564edbbccaa new 0=
=0A=
connmand[51826]: src/ipconfig.c:__connman_ipconfig_save() ipconfig 0x564ed3=
e4eeb0 identifier ethernet_606d3caabbcc_cable method dhcp=0A=
connmand[51826]: src/ipconfig.c:__connman_ipconfig_save() ipconfig 0x564ed3=
e48c30 identifier ethernet_606d3caabbcc_cable method auto=0A=
connman-vpnd[51848]: vpn/vpn-provider.c:connman_property_changed() key Stat=
e=0A=
connman-vpnd[51848]: vpn/vpn-provider.c:set_state() old state online/ready =
new state ready=0A=
connman-vpnd[51848]: vpn/vpn-provider.c:set_state() set state ready connman=
_online=3Dtrue=0A=
connmand[51826]: src/service.c:single_connected_tech() keeping 0x564edbbcca=
a /net/connman/service/ethernet_606d3caabbcc_cable=0A=
connmand[51826]: src/service.c:single_connected_tech() disconnecting 0x564e=
daabbcc /net/connman/service/vpn_ovpn_domain_com_ovpn_domain_com=0A=
connmand[51826]: src/service.c:single_connected_tech() keeping 0x564edbbcca=
a /net/connman/service/ethernet_606d3c4e4cc0_cable=0A=
connmand[51826]: src/service.c:single_connected_tech() disconnecting 0x564e=
daabbcc /net/connman/service/vpn_ovpn_domain_com_ovpn_domain_com=0A=
connmand[51826]: src/service.c:__connman_service_disconnect() service 0x564=
edaabbcc=0A=
connmand[51826]: src/agent.c:connman_agent_cancel() context 0x564edaabbcc=
=0A=
connmand[51826]: src/stats.c:__connman_stats_service_unregister() service 0=
x564edaabbcc=0A=
connmand[51826]: src/provider.c:connman_provider_disconnect() provider 0x56=
4ed3e517a0=0A=
connmand[51826]: plugins/vpn.c:provider_disconnect() provider 0x564ed3e517a=
0=0A=
connmand[51826]: plugins/vpn.c:disconnect_provider() data 0x564ed3e6cc50 pa=
th /net/connman/vpn/connection/ovpn_domain_com_ovpn_domain_com=0A=
connmand[51826]: src/provider.c:provider_indicate_state() state 6=0A=
connmand[51826]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x564edaabbcc (vpn_ovpn_domain_com_ovpn_domain_com) old state 4 (re=
ady) new state 6 (disconnect) type 1 (IPv4)=0A=
connmand[51826]: src/service.c:service_rp_filter() disconnected vpn_ovpn_do=
main_com_ovpn_domain_com ipconfig 0x564ed3e58460 method 2 count 0 filter 0=
=0A=
connmand[51826]: src/resolver.c:connman_resolver_remove() index 12 domain (=
null) server 10.x.x.x=0A=
connmand[51826]: src/dnsproxy.c:__connman_dnsproxy_remove() index 12 server=
 10.x.x.x=0A=
connmand[51826]: src/resolver.c:connman_resolver_remove() index 12 domain (=
null) server 10.x.x.x=0A=
connmand[51826]: src/dnsproxy.c:__connman_dnsproxy_remove() index 12 server=
 10.x.x.x=0A=
connmand[51826]: src/resolver.c:connman_resolver_remove() index 12 domain o=
penvpn.domain.com server (null)=0A=
connmand[51826]: src/dnsproxy.c:__connman_dnsproxy_remove() index 12 server=
 (null)=0A=
connmand[51826]: src/dnsproxy.c:update_domain() index 12 domain openvpn.dom=
ain.com=0A=
connmand[51826]: src/timeserver.c:ts_reset() No timeservers set.=0A=
connmand[51826]: src/service.c:service_indicate_state() service 0x564ed3aab=
bcc old ready - new disconnect/idle =3D> disconnect=0A=
connmand[51826]: src/resolver.c:connman_resolver_remove() index 12 domain o=
penvpn.domain.com server (null)=0A=
connmand[51826]: plugins/vpn.c:vpn_disconnect_check()=0A=
connmand[51826]: src/session.c:service_state_changed() service 0x564edaabbc=
c state 6=0A=
connmand[51826]: src/provider.c:provider_service_changed() service 0x564eda=
abbcc vpn_ovpn_domain_com_ovpn_domain_com state 6 index 12/-1=0A=
connmand[51826]: src/wispr.c:__connman_wispr_stop() service 0x564edaabbcc=
=0A=
connmand[51826]: src/wpad.c:__connman_wpad_stop() service 0x564edaabbcc=0A=
connmand[51826]: src/service.c:downgrade_state() service 0x564edbbccaa stat=
e4 6 state6 4=0A=
connmand[51826]: src/connection.c:__connman_connection_update_gateway() def=
ault 0x564ed3998877=0A=
connmand[51826]: src/notifier.c:__connman_notifier_disconnect() type 7=0A=
connmand[51826]: notifier disconnect underflow=0A=
connmand[51826]: ipconfig state 6 ipconfig method 1=0A=
connmand[51826]: src/provider.c:provider_indicate_state() state 6=0A=
connmand[51826]: ipconfig state 6 ipconfig method 1=0A=
connmand[51826]: src/6to4.c:__connman_6to4_remove() tunnel ip address (null=
)=0A=
connmand[51826]: src/inet.c:connman_inet_clear_address() index 12 address a=
.b.c.d prefix_len 32 peer a.b.c.e broadcast (null)=0A=
connmand[51826]: src/inet.c:__connman_inet_modify_address() cmd 0x15 flags =
0 index 12 family 2 address a.b.c.d peer a.b.c.e prefixlen 32 broadcast (nu=
ll) p2p false=0A=
connman-vpnd[51848]: vpn/vpn-provider.c:do_disconnect() conn 0x5574a6cceeaa=
 provider 0x5574a6ffeeaa=0A=
connman-vpnd[51848]: vpn/vpn-provider.c:__vpn_provider_disconnect() provide=
r 0x5574a6ffeeaa=0A=
connman-vpnd[51848]: vpn/plugins/vpn.c:vpn_disconnect() disconnect provider=
 0x5574a6ffeeaa:=0A=
=0A=
----8<----------=0A=
=0A=
So single_connected_tech() kills the new connection!=0A=
=0A=
I removed "SingleConnectedTechnology=3Dtrue" in /etc/connman/main.conf and =
it works now as it should!=0A=
=0A=
I seem to have added this because of routing/DNS problems if I remember cor=
rectly.=0A=
=0A=
Does this work as intended? I'd somehow not count a VPN as a seperate conne=
cted technology, as it only works when another connection is present anyway=
.=0A=
=0A=
I'd like to prefer wired over wifi and only have one technology connected a=
nd still be able to open a VPN. Is this possible? I'll stick with "Preferre=
dTechnologies=3Dethernet,wifi" for the time being and see whether the probl=
ems come back.=0A=
=0A=
If that's not possible then please add some info in the man page that using=
 VPN with "SingleConnectedTechnology=3Dtrue" is impossible. I'd also vote f=
or an error condition/log statement when a VPN connection is started and th=
is option is true as this can by definition not work out, as every VPN need=
s two connections. Or don't count VPNs :-)=0A=
=0A=
I have a few other problems/questions as well:=0A=
=0A=
- connmanctl operates on (internal?) service names, not the human readable =
ones. This pretty cumbersome/somewhat unexpected, and leads to error messag=
es that don't really guide the user to the correct way of specifying a serv=
ices. I guess the human readable IDs can be ambiguous, but maybe try them a=
nd only error out when they really are non-unique? The missing column title=
s in the "services" output also make it hard to know what exactly <service>=
 in commands (like "connect" means). This is an example of an error message=
:=0A=
=0A=
Error /net/connman/service/vpnname: Method "Connect" with signature "" on i=
nterface "net.connman.Service" doesn't exist=0A=
=0A=
=0A=
- The VPN server I connect to does not route public traffic, so I need my d=
efault route to stay as it is (in my LAN).=0A=
=0A=
After searching around a long time I managed to fix this by using connmanct=
l's move-before command for my local LAN (before the VPN).=0A=
=0A=
Is there any better way to achieve this? (Did I not RTFM enough? I know the=
 manual states the order is important, that's why I tried it.)=0A=
=0A=
Specifying "Networks=3D<only VPN networks>" in /var/lib/connman-vpn/myvpnna=
me.config did not change this. I would have expected this to do exactly wha=
t I mean.=0A=
=0A=
=0A=
Thanks for your time!=0A=
=0A=
Connman is a great product as it's so lightweight. Configuration however so=
metimes trips me up ;-)=0A=
=0A=
