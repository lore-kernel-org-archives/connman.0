Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0452FAD
	for <connman@lists.linux.dev>; Thu, 19 Aug 2021 12:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCntspPmtg8SNNzvbDuCxw57KxVqSSiqk/X2CVQKvIhH6V7wh9ahsMpFdbMQ9xe9PkKc1f+IkiUv3lUUeSPHX7hPpQ2/kxRZMUClS9wxDCHMxhkhcLUFB3adjr3XHIY99RFC+4w4Axq6yR8g1n9tNhztLQOqLa4deO4xr0s929U4hE87zfbbBHTE+e0YAsaZHqQ61QIyMTWsgexxeofrDrDXCsIH4w90KSXigdyK4zJGvHpNKWuDaGTXBcfSUNO6g/EIJYf4sj2vLeM8YHgXCmdz/6SCM8OJ/A16j08IVmjdwfoqGRI9OXQmO/6Xz120hNgcJJAuJCuZmH2mOj7I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJqgf1fSk8qLjwFIF5v6ndtgW1eb+S0kVLJIoFJxU2A=;
 b=eHOJ96jzDxKboHprEM/JeXi9p90WRvWswVGY151+WWec2B9KaP8IZpVvD0fLuQ2li7xI7aAu8ckOdd3CVdjVqXBpK/LWdjTjDc5Q15I4q2A8F7QF7heV8zoTMxm0oCOH4vTNzEV8lqhc4dC92sJxte/hmYLQfYUfS6+HziEgjGjzlJ5eqwFcCLR2yPvdHEpGaJL7R2JMNEI73tw0tN99bz5gjzuPfb0zm4ozRax9BJUh53gO2cUrlP6DhLaxaJC4hbsFqeopxP7yO9w9rqAkCmxR/TB3FvJAP30uIzIj6kBGTSUeFsSd+VDbSv4F3+nHSCNVmfDfUhEff3yjIG0wSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJqgf1fSk8qLjwFIF5v6ndtgW1eb+S0kVLJIoFJxU2A=;
 b=YxEbXkbcX5P5bYv2m4qcXT9Pyixjtp9FwjyWKDVuZoy++sIRvvtIwoXHbdo3Cfx4YDBH1IbWRItRj0ZM3bVwyzabPVbYTndfDox4gjSWlYB2z1yKRZEXpyXccITtS91zBhmu1YFQdss6nJnEd3a/UWgcxj6fu8OjSC/Vc+dwL30RnFLXMG2lFctj+m6r5UvM9fe0hOt/hx5O4NsbEjKQ/CaQjNkHMdqiNvrNExDoYIQtEQe8MquKEpg+y9LnHNUvXi3vlf5UKnyV1sv6bL7YQA6BOlpMoT176VeT3Jrkmxtjrbw7e8a4KlxsEopTMRqIICxNmdsnB0EiEWvxwdBNxw==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from PR1PR06MB6076.eurprd06.prod.outlook.com (2603:10a6:102:d::27)
 by PA4PR06MB7312.eurprd06.prod.outlook.com (2603:10a6:102:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 12:38:10 +0000
Received: from PR1PR06MB6076.eurprd06.prod.outlook.com
 ([fe80::e8e0:f52f:bdff:4076]) by PR1PR06MB6076.eurprd06.prod.outlook.com
 ([fe80::e8e0:f52f:bdff:4076%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 12:38:10 +0000
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
To: Daniel Wagner <wagi@monom.org>,
 Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
 <20210819123003.r4sqio2pquco5qph@carbon.lan>
From: Santtu Lakkala <santtu.lakkala@jolla.com>
Message-ID: <7f49edf3-75eb-3295-cc12-ae21faa903d8@jolla.com>
Date: Thu, 19 Aug 2021 15:38:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210819123003.r4sqio2pquco5qph@carbon.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::19)
 To PR1PR06MB6076.eurprd06.prod.outlook.com (2603:10a6:102:d::27)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.28.172.2] (86.115.103.57) by HE1P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 12:38:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b129f80-2cbe-4202-aae8-08d9630e3405
X-MS-TrafficTypeDiagnostic: PA4PR06MB7312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<PA4PR06MB7312F08D7FB5136010DC7E8997C09@PA4PR06MB7312.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X9Pc2GBsMqFtmIt3pQgJmkd2BSITUj9jaSOk7J13fK8yMqbqSFtUvQavskio13TQazrtsLigCp/yJlwptRl1ELzOsGOIx8d5xXMQ9DVuSjk3xduA+z5yyYysEt4CVpLfhlmwdP6tVA6MjgAm2kAUzLDdxNy1Kn6fHkRI8gYIoCgYvMYEa98Hust7o1TDEGOmJUZboBaH2iFxRko9LXgfku/Y+cufKok+c6OVBZO7CkEHbqVCFQb1aIohHfH8fotwtCp0oSyR9rNssALGaxgT3IUVbWNNk1AEIcakDEjGPcjYixD0bRyQsMD+sghs5q6fXVzZ/KaV1ToTf6QOcJRN0/7b5xbc0w4XOCC6yLHnncXS9tp6kr+WrkfCD/qCBjhhJUbGx/ugYBJwRCncPb9unFAPyrYotfFFebuxYaAdSfRXtuoeoDpZHyrmTt1egFxkS98930a+FQUfQ4N4Ie25edB1GJjdTZSQeBVw924uWdgXUnwGxpxCrTykhK4e7xeh/Qz1M5OCBdhGVPjBf02QcbeOwtUYV/eS33a80V++zMbzlnZdcBZcdDMAQZt85KsGAUPIP4kEyzGKBLGWsOdMRJP6oTQaktkNkaOtOGCPYk75b3Cs896L2cYtcMlF/5B8Z0xNE27dIq/AIExhWCf1tShIwfKC/F7TBaRgYghKrMIP78EOTqrDmoM2HRuqs3Mgc9tHWS622hGB41Ep13xBNtP+uslszzYTbtH1O4JTMmjbleoKFtIMoy9RQkJg5rQqRj4Mnw2GNa0EAWeAdNK/Wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB6076.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(376002)(136003)(346002)(366004)(2906002)(956004)(31696002)(66476007)(26005)(66946007)(186003)(66556008)(8936002)(44832011)(86362001)(4326008)(6636002)(8676002)(52116002)(5660300002)(316002)(36756003)(31686004)(6486002)(4744005)(38350700002)(38100700002)(478600001)(2616005)(110136005)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjhCeDFiOXRiVzh0UjV0RW5SRFBzcTdhaXdqL0o2UUc3N0VPbk90QlJIYzA2?=
 =?utf-8?B?cUMyUm5tQzg5MzhPOXFQNU9pbEZtRzh1bkREWHg3emF6ekJNRnNmUGNuME5C?=
 =?utf-8?B?a0xadHRsMEZtY3FCWXhPbTB2SzU0a2xtcnFhMDlJOEFpcEJTekpnVlRpcUR5?=
 =?utf-8?B?YVVCQSs2TzVFZThBWi92REczNXFwTVFSdEROL09zZzdtS2hvK1c2cStveCtJ?=
 =?utf-8?B?RXdEQlZNRzQyWFJZVUdsV0tVeVlvcExOakttZmNNSGEyQy9MRTBCdHZTckQ1?=
 =?utf-8?B?NlpHQmswR3ExeTlsYWJKemd2RjdmVTR4TkZsbHBTSzlGNm9qaEdveXFZL2RS?=
 =?utf-8?B?Zi8rc1AvdHk5LytTYk9JRmdlVlZ5cHFjREQ5T3RjZHRjMlZ6ZEIyR0Eza3RZ?=
 =?utf-8?B?RjlUMUpqbUNiMGpBZkxPQmtIdGRaRUx2OFJoY2c4WUkzQjd2TUpLNnE2dGVl?=
 =?utf-8?B?aVNUZk4xWklKNjc1VVR1YjgwV1J2NytoMEE4WnpLblhROTBWemxMK29NWE5L?=
 =?utf-8?B?OEFEdkppZGVqQ0tSeTkvNGVpamNkdWlra01YU09LQ05rOTJKZ29mL2loWkI5?=
 =?utf-8?B?aTAwaUFoVXhPL3R4QzNiL0NodjN3UlJhKys5cENUbTdDcFJHVmxuMHhUQ1ox?=
 =?utf-8?B?VWxjTFJZWG51UUE1bVYvUGhaeXlwVWJFL2htYlJmdUF1MG9TWUd4WmQ0ZWd1?=
 =?utf-8?B?TXlmanNDZTlyZlhYVW1vYmhjZzZaVGdXamJpTVNJd0pOMjFEbTErdExlZ01Z?=
 =?utf-8?B?NEExVzlmb2FPSllFYmZMVzR4U1NCZmx3WXBSVm1wYnpJb1BuY01YUjlsNUlw?=
 =?utf-8?B?M0pqSzBhcHJaQXVxZVhQWmpHSWFiUXBKeG5hcjJhSElDWUNualFHZzVmSXRC?=
 =?utf-8?B?YWtCMGx3ZU1tdU40MFI3N0tPeFZLZU9OTmVrV283eGV2T1ZLcXQxbkJFRzAv?=
 =?utf-8?B?aW5HVmhLNjRob2hZdHpOTjcrc3cyQ3M1U2FpTzZBOVQ0TjNqVXAzN1JaY01o?=
 =?utf-8?B?a0QwaFJ1NjFNdit1K0FhMmJjaitsMURGUXM2dkhlc2ZNYXlwNlRyQm5kZlBi?=
 =?utf-8?B?R01RMzNLUElMMDlqV1hVRHpHMW1ZNDZodnl3cSszU3ppRGlQelByWmlaVkUx?=
 =?utf-8?B?bG1CYmFKbFEyOFl6UUVveWlHbm8xOHdXNld6QTJQOG04eGdzbTdvcUxEWnNl?=
 =?utf-8?B?dC80RDJXZG1nOUJ2c0tXU3h6NmxOZFVVNk5hc1IvMld1SFE3b3ZBMmdVcUhx?=
 =?utf-8?B?SldJSWdQVmRWNm8rQjVheDBOMkt4TUxtWDUzQnlVaXV2ZDE1Y1NtTXZLcFhQ?=
 =?utf-8?B?NlVDaEIyZFFxcFRibUl4L0FKUStYM05ZbmZxU1UrUXFzZk5IM2pjUkVnNmlP?=
 =?utf-8?B?WEl6TlhaRmhEelNZOEd2TUJEZVZpWmpzSHcxRGZFNjJUL1k5cDE4SEtUZG92?=
 =?utf-8?B?UHZVNy9VOGx4ejZKQ2Zvak5wZm9RM1U2dXV1a3F5TDdvcFU2ek4xSERUM0hE?=
 =?utf-8?B?QmZiaVdHM2RhMHlQYU01NUs1a2YxU0FYelJ2cXp1Mm5TaEQzbGk2ZDM1RTkr?=
 =?utf-8?B?bkVRR09VK2NTTWhsVnU5S2N2Zm9Wam1CMzRwZ0ZSV2d6ZW13VTA0Y2c2ODhE?=
 =?utf-8?B?bUhuT1VCUVRNZjBURGd6STRtMmViWFhialZDOStic2x2cWVpcDluTXFieTlL?=
 =?utf-8?B?NmNXTUpwUHNBRFhvbHF3OGhGazA1MUVITGdrQ3M2bCswMUgrM0UyMXBLcHU0?=
 =?utf-8?Q?UbaCGUNfRzegfq34ZmfviQVwhK0jAvQvyrok5L+?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b129f80-2cbe-4202-aae8-08d9630e3405
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB6076.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 12:38:10.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xJjZkjbn/fuVHS3cn4NrSuSBpa1K955V3qDxBCVdtmavVEPTF+HQlFgfYPnL+nuBLKvo3lqmzsMhTY60AFiry0frltddP5LJkpVh+jsC10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7312

On 19.8.2021 15.30, Daniel Wagner wrote:
> BTW, the question on the busy loop. I am pretty sure there is no timeout
> involved if you just return 'continue'. This tells the caller to queue
> up the callback again without any delay.

Nope, it called again after the same interval that was passed during 
construction.

-- 
Santtu
