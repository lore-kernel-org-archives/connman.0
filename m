Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AF68
	for <connman@lists.linux.dev>; Fri, 19 Nov 2021 08:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMRIAFT2pnUMyWqZwczoGK/wNygD3LRXW4qvzuyEAvONsbSemYtkizX1+j9DTZ1lz0SSYFEgeKHlzSvfQWx11qWX6tRuEjf9rE0QX/M1Dq7Pocw3jDpHhVYE2/NOPTCMMEA+LG3DUi2XMDyNDoK5wL8Z+3zjZQMw+Uwt/V/+3lmzfE07BaYNiNrq6+0oAt9uNbbKYX9DiOyUJjr5wiueHeAI9nC2XzyfnHdzrU2TwpbV36e2lFDrV0YvnhVzj262REFxHHmBPE23vRJnSaturqHN4BGgbKiwy/Fa+mGGFtORTRDJ3NWLBuXVQLaZ3IJiT4dFNTXuRRykLxxq/SklHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4jaYtylApQdkiK8qFsMrtoJ0z8++JHXXMJef4izbC0=;
 b=aEWeg42+x+jOJuojSFHYEofyOceXKHRR8nA1xK5kS1aTw0kd+SzP5V/Dea2nx8ppY5kGm/NLBEuDZRkvPKd+hKOGuP6mcEaSED5+iIf/AwtKyTe99yycXioMHHURFWyzkvSC/35EDPVTmabP8cFO17fODAVcy95Qb0gyits1mKoiyPvf1rXTSFEerrzCtzWel5GaBjwizAOcFGsQTpWeoEzPHK80KZyC+PkCqN5Fss9BlhrYuaIie6OVtkTiPZp51/0x3awzZKF1JmuB3AcgKcR/NAze4ObCfKKKVItEtbV6VncxvfQ1bMnITLFOrJJn7IONUOgGsEcwW0s5YSOypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4jaYtylApQdkiK8qFsMrtoJ0z8++JHXXMJef4izbC0=;
 b=gDAeveJua/lxVEEDPhb7bkyQh3eulCHoQnjLEdMmliNADQuhTbgQ5l21ms1AXBMYTsjM7Gr4ljKLuHjFNFCdfuXvKpdyi28+uwUS1qtF52mpCp933cPgy1UhG7Hxgoi5Sn2n2IA51dyGKthfs2D3lZrrgFEdwe2pMK+ssAe52TTpb9wtgeko4/l3ev6lIO5rKUhIz5ObGLxvRWsd7h7eaGrABqIWI+7iI6wEsyWKPATrMR0tj3z5RQ6LNTpoxrtUkhiBKS8o+lTYrJ/A8e38hh1CVa4zaNKFhgt8H4yoBGXiqnUtZ9k7gcMF2enVZ1AoIvdkfRveeV7AIUnkeSmUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2297.eurprd06.prod.outlook.com (2603:10a6:3:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 08:09:30 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::f4c4:9d6e:a8c3:69d1]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::f4c4:9d6e:a8c3:69d1%3]) with mapi id 15.20.4713.021; Fri, 19 Nov 2021
 08:09:30 +0000
Subject: Re: [PATCH v1 0/2] Improve OpenVPN configuration value processing
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
 <20211118210239.syttg5jfgbdmgfzm@beryllium.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <71ae9054-041d-aff9-8e33-1fc8a016ea18@jolla.com>
Date: Fri, 19 Nov 2021 10:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211118210239.syttg5jfgbdmgfzm@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0050.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::39)
 To HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from [10.8.3.7] (194.110.84.60) by HE1P190CA0050.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 08:09:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f10cba-08f6-4503-ce8b-08d9ab33e972
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2297:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB22973B7C9A68202BD516559DEF9C9@HE1PR0601MB2297.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	20AiAyC8CvUMa+4ue0TW62xjef8SkEoetHOzPLi59EIVLVK2BNsZ29hkBdMOvTATJ/4xVhcijiy7MBY0Bz2BV0VVUZkcxJnrArfOjqUpVtK19gp91Uv2Sp1z2ViITOVPgTRS7WFl5vo1LXAtj035nMEvZnhbyFBr+eccSLN6cuL435BsmxDnSzDSKRTBXySGz4WhejNc3OJBIk2MIVTZ8U56b3jHahqBRhSoeaOYZcEVYMeFvwqHputOjIPXhB8YBwBu5bQGuABGmnkJdehRsMpLrUs/Qbbbr3sPn7UV2GIVQmBXPTuYIE/x/7otpLB3pBJvamsw18xeZdKCmDNkGyDz1mGbUUbykLdKgAIR8JYeb/PfWHaLLCB8ojoKYIDBD4mysAk0Qy3E+qA/pjQxvdo2ROkN8VZnbVGcF3HfWBiRKnL+jOpkrbK/U0D8j5zd2KnSNqqzZQgMQ+Pgs7evXn8ZMQ0d6qisB0jYP67HBMw0d8iwbNJaTCksC4bs+0nFsWIhe9YDbs6gzgvyDNyzK1MIilOM4HkxqJIzUx3u8Rh1/PAkf+RaHezUWn6E4LlbnDKzRcoVxtt9Fp9YnxhAKH0PA1In5sIqmP/AZgo3IRyMEDJH4q8vWrGQ/DTt4jDRwNqBMDPjqWa5f4EXRDLIgLADjWGupeFFUwkcAZf1XR7/E7Tphj1/NXgByFmmtCotCMnjjoOjPCuksjHE8j5PbK24RDmY1uIcZZ317HQH3yLVPOVNtRh9KEiUCotwR+wjCLvsWDepiM07gePQ/sj11Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(366004)(376002)(346002)(136003)(6486002)(66946007)(83380400001)(2906002)(66476007)(66556008)(86362001)(31696002)(186003)(508600001)(52116002)(16576012)(8936002)(38100700002)(53546011)(316002)(38350700002)(4326008)(5660300002)(2616005)(44832011)(956004)(26005)(8676002)(36756003)(31686004)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NhZytDSXJsQjJmUUM3V2t1OWp0bnRTbGRZNEczMlBVYUE2TERQMmRDa0FM?=
 =?utf-8?B?ajZ1YzNsOGJpTzFWV29ONlVsREs2c0dMVjdvckRna0NkbitoWm9XVW9vN2V1?=
 =?utf-8?B?L0pNb21FYVJVV0Uzanp3clFCVzdNUEQyemVqUkhNWmVQYlZwV0ptTXVpaUdD?=
 =?utf-8?B?d0Y4SmJobFdJcFVLTVVlckhPWnNJK3V1dGVjcGxFQU5LRUMvS3BIVmpGbGVx?=
 =?utf-8?B?Y2NqMjhkajZlNjQ2T0h5SVMxZnh5MjdGdEwvUDN5WURUbW9XbHoydXM0Ly9l?=
 =?utf-8?B?enNUS0NmYmhSMjQwR2FMOUhJeEhEUk9KZWw2ZkkyTUZOY0FpVS9tdXZPMjB6?=
 =?utf-8?B?ZXhVdEM5MHpkYkc0WFZLOVBvNDZDMUlWeHVwOXJmQ01HYmVFRFFma0MwczN0?=
 =?utf-8?B?ckNUTEFuS0lXQktocUtLaFc5WjVqVlFUakVJMHNJU2JYWlBRTEYrUlU3dm1P?=
 =?utf-8?B?MWhyNHBlRXlkb3J1M0VySkRIdFB2d0lIb2pCTE5pakVEL25EZWNFSk45cXMz?=
 =?utf-8?B?OHEveDQyZkF3bjc2b3FaZ2t6Yy9kamZFclBmdWhJV2gxbDhQc0p0d3hZMnB0?=
 =?utf-8?B?NjJwVjJxSEFNUjFSL2tVZy9pOWRZNmtuSlZGRUxlV09TQVBnYlNzUHNXY0dU?=
 =?utf-8?B?eHMrbWw0czV0UmR3bzdRbWN1Wkg4ZUVqc280VWtQSysrZllORCtzVkVoRWln?=
 =?utf-8?B?SG5vN2hPMWtEUW9MUlZGME15bEIrVlhWQ2M4aGtBVkNQN1RjejJXelpDMUwy?=
 =?utf-8?B?NStaaTJGTS9ueEM3MzFFa2htVkVILzlmNGFsQ1g2K1dsZnhGTjRYTXFDMFhL?=
 =?utf-8?B?YUpUM1hzMnFmbkZuV1J3a1Q3bzJldW1DY200aEdQajBZKzc4NllMMG8rNDc5?=
 =?utf-8?B?OENFUXJyOFR0V3pFM2VJaHlMaWRMczkyYVk4SVFZTElGWm9hSXQycEkrN2pN?=
 =?utf-8?B?UmNsOHc0cDhpc3dQcjI3eW0wWCt0Z0J3ajRCYnEreksybXdyT0hsb2hmSWVX?=
 =?utf-8?B?ZThpeU5HSXEyZ0xJc0xibE92NG55cUNvVVNYa0NVemFreDFzSit0TWUyUzFy?=
 =?utf-8?B?SzduSjNET0NOMW5Ra3ZOMmVYalA0aW1UaEVtdFg5RFNnbkFnejJoN3hvdUJx?=
 =?utf-8?B?TGMxbXNLc0tCMGlZQTM4RDlwcG9mTHo0SFFOUVNlMDlDTEtDSzhnYTZQaFl6?=
 =?utf-8?B?ZitybHM1MHczeWlIVUhIYkwxU1FUWUY5K29pYVU2QU1nMzB0YzJMNjN0NEhY?=
 =?utf-8?B?eVk2cWdvVStISFVaUS9ueGZUbmN2TWpCaTRhQ0dRdkJhL1hYSUU0REZTZmdW?=
 =?utf-8?B?aUFPL2VValpIdTRtSWRYZ3JpZkprMW5Qam5YWXZnbzR2V3daUGtXWER0OHM0?=
 =?utf-8?B?RGw2M0RINkZrV0VjdUVuR3I3QVFweDdGZkpOQzB6cGxWMlRBemZraHpsUWlI?=
 =?utf-8?B?dmRIRTNuOVh1YUsxeC9LNzVjR0RrdGhoK0tYWlNaZEs5NDNNU2RjcnY4czNn?=
 =?utf-8?B?RlBiR21wMmFwZW12MVVFblVhSmovVEZYSFZZVkd0dG9uakRBb2RZVGhVb2I3?=
 =?utf-8?B?M3owaUU2TUJGRUZheE1yZVFVSzMrcWkwQkRUbnZNbGJ4TXNRWFZkTUFXU3Fr?=
 =?utf-8?B?L0ZwNXcraE5lV091VktQTlN3U1Znd3ZFd21OeWFQL2lSa0pmUktHTjNKNTVu?=
 =?utf-8?B?a2h0QmFxL21jOXkrSEt1Y1dsWmtDeDdQZDZ4dEhNR1kxWFBxK2xLVE8wbWlQ?=
 =?utf-8?B?UUk5cXREaFFlUTJQRk84TlN0SnRYaHV1ck0wWGNpaVd2NlhZcFQ1RDdqdjNZ?=
 =?utf-8?B?T2xVRnFwNVpSL3d5ZW5FcDlXcElZMUN5NFJ3MXdwK2M2emN1RTJpQTU1dXlJ?=
 =?utf-8?B?QVRSNXI2N214ZDE3SkVLTFVmSGEyRkI1T0FJOTI3blM2bW5FeXZITlJBTDB5?=
 =?utf-8?B?cCtxbWhvRnFhcmVZOU4wN1VWVnMyekpEUDhqYjB2V1U3VEZueFlWVVJNU1dN?=
 =?utf-8?B?RmVDZXFuMWVhcW1BV3Rrd0dkNjNlSDJJQ1VVb1ZBNmF2bEE4SE05bDZhQXN5?=
 =?utf-8?B?eEFBUm9wbGtoQlhhVTJ1R0c0bmlrZTBqUCtiTnRqNFl2dE5jeEZWcmVhdHpw?=
 =?utf-8?B?SDE4c3IrazVjWnFQWXovUWt5MjBpNUI3VEVDaVVYREc3LzlXdS9rUnpVN0wv?=
 =?utf-8?B?TDVyaHdvTDh5SkYreUNiakpNV1ZyQ2xnMVp1Y2hjNXk2Y2pzVWE2VDQwWkZa?=
 =?utf-8?B?NlJKSWRiaFVWeUlJZVdZUUo0RWt3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f10cba-08f6-4503-ce8b-08d9ab33e972
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 08:09:30.0411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfxaYopxEcJnvE5KZlt3aG7IZjDTWkqRH3Ke0iNYyMLZIR2LU2wVoTtlqGgCw9V2soNUVE7Lgb9xGKZJ+UH+11tXyyPrOvjfpak5ihx8eUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2297

Hi Daniel,

On 11/18/21 11:02 PM, Daniel Wagner wrote:
> Hi Jussi,
> 
> On Tue, Nov 16, 2021 at 05:14:15PM +0200, Jussi Laakkonen wrote:
>> Rework how OpenVPN processes the configuration values by introducing a
>> more clear way to classify different types of options. This makes it possible
>> to add options that may have a value or can be used without a value thus,
>> resorting to default value set for the option. Also the --auth-user-pass
>> and alike options having a special value are handled in cleaner way.
>>
>> Motivation for this was that the --comp-lzo option was not processed
>> correctly with its value, and even though being listed as deprecated some
>> OpenVPN providers use the value. Omitting this option even though it was
>> required caused issues with both UDP and TCP VPNs:
>>    write to TUN/TAP : Invalid argument (code=22)
>> after which OpenVPN silently restarts itself.
> 
> Both patches applied after fixing up a warning:
> 

Thanks.

> vpn/plugins/openvpn.c:394:25: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
>    394 |                         const char *opt_to_null = ov_options[i].ov_opt_to_null;
>        |                         ^~~~~
> 

Oops, sorry. My build env did not complain about that so I guess I 
overlooked that bit.

Cheers,
  Jussi
