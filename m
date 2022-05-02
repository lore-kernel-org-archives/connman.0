Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1C17C1
	for <connman@lists.linux.dev>; Mon,  2 May 2022 10:05:07 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=TcyBtPEbRyK5RYL0ZlqE0xziAVcF8QiuJvNSgV9QGfQbxojwn+PBEOYFFJ/vAVNdfF2EqpDwbqdoCCOO8eFXv/e+C4xSWxPabtiBRqYXQI+nqjUHABOb+gWnsMKVCXZYGdGcuSJXJhGHuLLQD2qEXALw9p9qq0xr41UnUwGpro4wDjvk0qrTY6Y2dSYuyYL4ASS38ProFNMr1mRKNMSgqdOQzj6h4765gfucqSdsX4xBtC5WvcyTUeXp4qR/8dvSod36mE5yHSI3N8cxsszZNgykGVIinhOv9ay8xZxCxB3RZ8wS9A/n4zhx7hagh2PZh294CVbobaEWASRyUWtzww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD97tGf1SBin6keJYsO1YddfJEqr+9ro9nRDM8pp2TQ=;
 b=DD5dg/SW3qkXdeUCA+AAWIzYQV+LRoDNj4MxXaUsk4C1bnE6ZtgFmryuh6uAlOgCKYdKQrzUKgSDgjEpGPtmmtASY7wT3jwYisEd9XEYclAvey1ycGJ1upJGMJWJpxQiswzH9KXrdphwmm2QCXIWjZv7O+3DqUQFCtNn14/jNQtfAgK+iGayNYJ8aXC4Aly64FMg//BHoaH3w5UaqkQggTJi0lBIxZsn37qsM6/J1hW+412tQJJs+ImVsLhS/DfoN2lhj5UJ6NxsEbT7/r1YEILkn2HONdD6gsYgMzRTJ/yQcODhJ6GdkpEdxM3zTqRVFBECNGc7kNDnv8AghE14ww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.52.142.9) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=goeg.at;
 dmarc=none action=none header.from=goeg.at; dkim=pass (signature was
 verified) header.d=goegat.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=goeg.at] dkim=[1,1,header.d=goeg.at]
 dmarc=[1,1,header.from=goeg.at])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD97tGf1SBin6keJYsO1YddfJEqr+9ro9nRDM8pp2TQ=;
 b=fayHHd4Uh2DrUeWH+LxK3d6UqR2zpdXxpfpO3SS6Dz+tyXa7WmSoRoQVBZDi0qH3HjulpF1XOmIPsBGbrik/bHUnt+e1KJ4ErRJZ1CjQ0VkxuyidOTNi0Ss+2lM84nYcnMWFYIGfQpj6ROeOLiG99svzrUNW4LvOJ+BzqiwTVGE=
Received: from DB7PR05CA0063.eurprd05.prod.outlook.com (2603:10a6:10:2e::40)
 by AM0PR09MB3233.eurprd09.prod.outlook.com (2603:10a6:208:173::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 10:05:05 +0000
Received: from DB8EUR05FT053.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:2e:cafe::71) by DB7PR05CA0063.outlook.office365.com
 (2603:10a6:10:2e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 10:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.52.142.9)
 smtp.mailfrom=goeg.at; dkim=pass (signature was verified)
 header.d=goegat.onmicrosoft.com;dmarc=none action=none header.from=goeg.at;
Received-SPF: Fail (protection.outlook.com: domain of goeg.at does not
 designate 20.52.142.9 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.52.142.9; helo=goegsIQSUITE01;
Received: from goegsIQSUITE01 (20.52.142.9) by
 DB8EUR05FT053.mail.protection.outlook.com (10.233.238.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 10:05:04 +0000
Received: from mail pickup service by goegsIQSUITE01 with Microsoft SMTPSVC;
	 Mon, 2 May 2022 12:05:04 +0200
Received: from EUR05-AM6-obe.outbound.protection.outlook.com ([104.47.18.107]) by goegsIQSUITE01 over TLS secured channel with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 2 May 2022 12:05:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5xO+JRCzXFa+DRM8EuH2VKuAfxkEOWls/s1aQEnhlP60oKMQ2C+9GHYGTN1x+cwPLNW/fMo/nAYfoDETBV5yLdbSG2RnOvDWdap3uc8JgVYb34WbrGneICVad2QUOPczVJLQ67bjxoUoMoAKhozssd4M8asiYbwvE0AWdFjLeFWq9hOSjEEXPGEa2Jff7abNsxDgi4Yzmoq5B7xMuhe8iJuszR6s1dxT9DYxYf3gy4Nx8p6BGrm1Q/uhg1jLFITJnk4vfPIP+8subPlwNBRE632DoPbwGB2wti1uZn9a+iKjqae48qwPaoy4kSG2dUjbhRrrG/s9f8FBGdAIvurBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD97tGf1SBin6keJYsO1YddfJEqr+9ro9nRDM8pp2TQ=;
 b=SurjVVHhAi5If1hJ3U35um8CTiX3R/11U2Cck5vZViO1Vl+0FBenk5fVG6iQL4VlBZQQsjNw74D2S2kTj5QDlq111Yxwx9ugRGxCSdzN1mWJtN5/i3UuXXluH2mejXTkcvUxF8jHv0yqmVmxzNf3iJekI4a/cDFXdHwlHocpSBrmsVSSF+2EBiovC+wvdqh+skWoiw6C1Ebmr4TxwSK3icJAF/hlc7duu/stHxO9wT65p9RZYusXaFGabsQ0WnYh4n7MY2WokbIHnHrA+k88qeqk9Y4TP0hdaVEWB0NrWZzsCUV+OLSS3XDEQWgiF6ISbDpYXrvbE8r4eLcrz7Hpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=goeg.at; dmarc=pass action=none header.from=goeg.at; dkim=pass
 header.d=goeg.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=goegat.onmicrosoft.com; s=selector1-goegat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD97tGf1SBin6keJYsO1YddfJEqr+9ro9nRDM8pp2TQ=;
 b=fayHHd4Uh2DrUeWH+LxK3d6UqR2zpdXxpfpO3SS6Dz+tyXa7WmSoRoQVBZDi0qH3HjulpF1XOmIPsBGbrik/bHUnt+e1KJ4ErRJZ1CjQ0VkxuyidOTNi0Ss+2lM84nYcnMWFYIGfQpj6ROeOLiG99svzrUNW4LvOJ+BzqiwTVGE=
Received: from AM5PR0901MB1633.eurprd09.prod.outlook.com
 (2603:10a6:203:4f::21) by AM0PR09MB4195.eurprd09.prod.outlook.com
 (2603:10a6:208:199::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Mon, 2 May
 2022 10:05:02 +0000
Received: from AM5PR0901MB1633.eurprd09.prod.outlook.com
 ([fe80::9595:5579:a898:1367]) by AM5PR0901MB1633.eurprd09.prod.outlook.com
 ([fe80::9595:5579:a898:1367%9]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 10:05:02 +0000
From: Thomas Bartosik <Thomas.Bartosik@goeg.at>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: Issue with connman.service
Thread-Topic: Issue with connman.service
Thread-Index: AQHYW/xWFC8okhdiA0OfpPxIN1d05w==
Date: Mon, 2 May 2022 10:05:02 +0000
Message-ID:
 <AM5PR0901MB16332C6B48D658CA0BC03626F2C19@AM5PR0901MB1633.eurprd09.prod.outlook.com>
References:
 <CADEpph=wc+bN3kMDCYtV5b=mjaB81-V2CW2hfzZJJJ1shXXAEg@mail.gmail.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=goeg.at;
X-MS-Office365-Filtering-Correlation-Id: ad70051e-1b76-4439-d6cc-08da2c233ad7
x-ms-traffictypediagnostic:
	AM0PR09MB4195:EE_|DB8EUR05FT053:EE_|AM0PR09MB3233:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR09MB32335D9A069179609EEFBB92F2C19@AM0PR09MB3233.eurprd09.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 NbO8NqE6D8zqsDU6Zgmp/t9g98aJ2NfxiqAit26cKPReWye75s1x+GmG8jBn/qKGwRrzQBsLo+t71G8f2d82Q3hdWyeK9VhAU60ebq6ivxt61AWksIdlpRLQn5FpW4NgQJGpaqqHmEHN4tEwVZBxfDBI6h7GusOktKwsxzMAyyic/hCiFGgOqaUmB6PJQg1HlXOtnrV3Y+tqe6+QXGllVkUpcVf/1vXkoeyBzrlo0g/sRv4lRh4PERXeSlgZEWz4MIpDofyI6GCAek2ExpdNZFu9+yDuFKhidIlHhbS7tzNUYUX99xmtr4J6Mz1SifjqNSVbNTHFgnqBJSEbO25Aq8/GjeD//XiWIGFzOLUBZpw9iSCN55vGOscsngKYug84dPTjF8pVCGLkLypMuBBnl0wUKhfdh9XtMso3dpt2igNTe7NE+wrIM2bjUBEcsm60KZmesy+Tgf6t2YdP8zJKRGD/v0UlLnPNdpDRedDfKaIXz/sS5FYwo3nxEKksERcQMCyPqIQJI2whqLlvbu4pwwWPaAb9CIMBb3LlEMWPxKpg3h+TwON5ySuPONmsozmJFcheZfxxcIzgJWAXGDFAPYai/hpuF3rm//aXGgKlFhWRHr38FCni7rozTb78Hsd9LF+EwdPDL8K2wtTf+/nna71AGPsRJuA82K8EDH4PXxBPhCqEDgreiGp9oFnCKEmD9RTfYOTIWUl+hS9fxZxo+Q==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0901MB1633.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(83380400001)(66556008)(26005)(66946007)(76116006)(8676002)(6506007)(53546011)(66476007)(66446008)(64756008)(7696005)(122000001)(5660300002)(86362001)(6916009)(2906002)(38100700002)(316002)(38070700005)(8936002)(33656002)(3480700007)(186003)(52536014)(508600001)(55016003)(71200400001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4195
X-OriginalArrivalTime: 02 May 2022 10:05:03.0913 (UTC) FILETIME=[17C98190:01D85E0C]
X-GBS-PROC: 8nEwQmeqoarrBYExp6GMHG7tmKEqBVMJXSRz9HWQtZd8NUsm15dWqwS8oXsPljWS
X-GBS-PROCJOB: c6ZeQwN55MZk1tJ6sfbYor+oPdq6eQKMJSWhCIpIV7AELH73XQ03/oGdie/c+9J6
X-GRP-TAN: goegsIQSUITE01@C9A460A0D5474701AECEC0B070A104FD
X-iqsuite-process: e13a3393-6c38-45eb-8279-3913da145940
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB8EUR05FT053.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4d156105-06b5-4c70-5089-08da2c233922
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Eo3B4qsQoAIeSS7LrY3xVqwrByF4zpBFehwQqzddTZaiwwNte+I89Jr1KCDfJwx52924YeWl3N3dVyWWqcgrz0DmBooTYDLqMGPTlxbtEySkcS2B4c3wfe0P4WuHv1HJtqty2EZJ1ksB9ZUlYjnEhvGZi572fZC5YD4f0UEMs1DEBs+6Vcvxcxgb7w7OpvqofQJCHGgVE/0kh3pJyNogavZ8by+0Awf8r7fIeHBXKxZxJW4ufkbALRcIZlHqWua5+H4Pj4/4Iag+Ue0LlH1+lkVuvQvxPSbXwhPOJcO8h+BbQrG8hrnQ2bxyPCZpYY15P6qgmrHd1AKDWgZIr5z7s3tfK7+7Q4djcQwSq30sFDoYWAKmlRBytWXuuybRduCvoyY1FMXwFIhoPUzmO/LuQGGlm7nERRJzPfEo/Xuj2cy+XJkcJWhHNI06pRZqcw1gQcyK6jc0yZ3NP27WWiRLX+4srZ1fGM2xdrqTj20J/H2v0Rt0Y0ScBxx/2PtVrjlHmRf9s49687BOwHwo5XMmmgKHwEa9SvbLSI89Mg8jLwW49SQKv1QZSczZpBbYNbhCV+KIYDnSr+wCqv4rgDiXPrgOXcEoDUm1L480an1K1HOdkTFfKfCxCTM8fnGq+UHl8rqlD7NGHPU+iz4eelKOis7cPQunGC6vvLYpv4YQPajwYCDKBueMfGygNLTUL8P1
X-Forefront-Antispam-Report:
	CIP:20.52.142.9;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:goegsIQSUITE01;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(46966006)(36840700001)(55016003)(70206006)(36860700001)(2906002)(5660300002)(33656002)(316002)(186003)(7696005)(52536014)(8676002)(6916009)(83380400001)(70586007)(8936002)(3480700007)(47076005)(336012)(86362001)(508600001)(82310400005)(81166007)(356005)(26005)(9686003)(53546011)(6506007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: goeg.at
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 10:05:04.8579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad70051e-1b76-4439-d6cc-08da2c233ad7
X-MS-Exchange-CrossTenant-Id: 05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=05d2efe8-0c45-4d9d-9a5a-b2d00b1b42ff;Ip=[20.52.142.9];Helo=[goegsIQSUITE01]
X-MS-Exchange-CrossTenant-AuthSource:
	DB8EUR05FT053.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3233

If I try to connect to a service with the "human readable" name with connma=
nctl, I also get=0A=
=0A=
Method "Connect" with signature "" on interface "net.connman.Service" doesn=
't exist=0A=
=0A=
I need to use the ID in the second column (don't know how to call it, no co=
lumn title) of the "services" command. That's something I mentioned in a re=
cent thread, I think this could be improved.=0A=
=0A=
That should be something like "wifi_<macaddress>_<hexencodedessid>_managed_=
psk".=0A=
=0A=
But maybe that's totally unrelated to your problem :-)=0A=
=0A=
Best,=0A=
th=0A=
=0A=
On 29.04.22 21:07, Matthew Austin wrote:=0A=
> Hi, I'm using dbus to try and connect to wifi access point. I've made a p=
rovisioning file in /var/lib/connman as suggested by the documentation. How=
ever, when I make the call to the endpoint Connect for the service that I'm=
 trying to connect to, I just get Operation Timeout or I get that the signa=
ture doesn't exist. This happens when using my c program to do this as well=
 as doing this through d-feet. I'm not sure but it's like it ignores the pr=
ovisioning file that I have. Attached is the file that I've created as an e=
xample. Any help would be appreciated.=0A=
>=0A=
> Thanks,=0A=
> Matt=0A=
>=0A=
