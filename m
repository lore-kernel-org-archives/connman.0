Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DAB72
	for <connman@lists.linux.dev>; Tue, 31 Aug 2021 10:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/6cxiiFnRI0jht20HywgXtruUHFCHfNZWIKQZEfEDFnpV877ZgCDSsn+aDry3bxX9Fgx+VcNu4vsJvQuBPbCyPk9eEufaTyW1Gx797bXMAVLy3/Vfz8a/jSn7+B5DGAvnkO3ViRhGvMWocT0Sh0fb9s3r9oEVfquhcIT4UFhSqCVhiedUldsjlZBfW0HxjmBaotYH5hSuQKPIsNOkeKlODDXw+2NJPxJwbCro7BYk9AlP8vmmplTfdx/w1aq+cP5NVXPhTm0thjXvAfqVtsSt/R9Jwqdo5w1ieuCSUgjwkCXQQpntrTUDUqXULdi7XHdu83t1UPJBYjqWgMqENdDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfiQjZ2RQMashRbr+7y+Zl374HHxOyBmUzSKhuo4ARk=;
 b=C06TE4XgQ+gEDQn/lZ/kGMCc6abX+fhnUCZ2QHKmUdPrNSs6MKaWyXjRo0ciD2UGfhGK9kr5Gf+GtPhd0bDiLgyT6Ve/r1aq7dywhtEgrjbsKs/EX0QbTSxLOSdOkoTesaW9cbbhPHkPdG5f0e3RirpZWDbKfeTnBfvA+l6udLAJulfn96qePlF5p0SOEVwNEJKMnLlFRSRvzdU6i2oUuen8bvkW30TcoNI68D3xJb7zPXN5/atQJw8URsnJGvVcLmrhBcgeWO00eGbIvNvPa4/3DHK8AtYAi3V34DDwjhZ27uSzyo1eAiXMhBSOp6m66mv5YxqhZo8XfYWKwLCXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfiQjZ2RQMashRbr+7y+Zl374HHxOyBmUzSKhuo4ARk=;
 b=xer99Eu1TiZ0budrIILIabjmm8KlhPW7OljXZZiBcw3aTmfcmlOqy8oT95NogxhIjQrW/1ZNuXSxCdtFG7eCVAbbA0gZz+cRqqJSHNll+lfmT4ElX/namOmV8KB/llpUnIPkkWMVzC4Nmx4GbciMWG7X/WotnXcwjK4II5UKcDMp32rB/qrD19hxZOC93gU3/x9qRf3ixWYqWjfSeiPOK83p3P9hm27m0UVh+R6kZYVp5FyJsUl0qr8qoB+Olvy7P5gcGqKQIcvhNN7w2OPkhEVRgTSjP1jsTc1nLK/ef38wbORE9DzCVLmm8OcoUsJlRUxHubz49xmHu1zpZj86yQ==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0602MB3273.eurprd06.prod.outlook.com (2603:10a6:7:21::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 10:29:05 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 10:29:05 +0000
Subject: Re: [PATCH v2 0/2] Implement connmand state monitoring to vpnd
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210830092405.30964-1-jussi.laakkonen@jolla.com>
 <20210830170631.ni5frzfk6v6jn7s6@beryllium.lan>
 <a0d28b35-d3d0-8454-c1ab-159c6ccd728f@jolla.com>
 <20210831072207.4gezq2fkmrdszac6@beryllium.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <4915cdc0-4c1b-bb28-22c6-32a8bffdebdf@jolla.com>
Date: Tue, 31 Aug 2021 13:29:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210831072207.4gezq2fkmrdszac6@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0243.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::19) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.1.2] (194.110.84.59) by HE1PR05CA0243.eurprd05.prod.outlook.com (2603:10a6:3:fb::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Tue, 31 Aug 2021 10:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198f4acb-e2d1-47e9-5187-08d96c6a2844
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3273:
X-Microsoft-Antispam-PRVS:
	<HE1PR0602MB3273F888DC33B43024E6B586EFCC9@HE1PR0602MB3273.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BSwOEG8xLnEamhMqZUHOh2umkVkl4QyUSSPfFRQZxzCmyQEeYFD2UUh9vDl4Vhfc1eQhHt08CQnDWTVcTXeqqXC47gbDKEVCiO4FoF632CwyQDE/kRtteZGqW14r59P4LWD3f9HDIH/1BIB/arEXB9LGyehubEZ55dku0kClJ6kPn6YniA14/RUPmUpqhIM0uywdNW+c9E2xETXtOoWVUHdfMqgWoTpv14VRjrxaQQRVgCcYjsUJh/Mc+n1FJ63IZeMPAhVCk7Rn21SkWkAMsVJN4dGeeTJKtqY1L6KhBmDscvNKHM4vITbVqT88C/dOFUF2Yo5+gbqr11eQT6c53FHJlawajPP5C4sAkw2FqvduOh0mcuJfdS56kYKEj3sZQCtnE5UvJ6ti21Rqc8c2t0NO+9Loz2CMhGJZ9YHeq1E2NXWW9oY0sz3dXmpfEtSObbQ6BZYVzpbKMpT9x59in8tXzfphqIL9Rq2M1lWqBMg9gP18kbs5xI6l3rUglHWud6S9NQLggJwFeJe+7StbajzM/z3VAo+JNq1FOydHe1Frd+4+emMDyV9IeRSxu6wLRt8ergRqd3CHDZawQ0v9qgJAo6hnjjS5/TTZfhs3UOgcFbNeCdialq35cHwtXWD+P/Yo6IS/OPAMWGuBgWyKzjpft+M/MhrbxXBIRT9dj5TfYFgl38+iomqkAukGjNPBIc6StfRFo+7+jqhXUItbALoZmUaSxVReYlFIFiRwInmXT4ffmiouXDZ+A1RdlA1yw3yv9XTEvNJq5FUSfkmmTDjHZpc1M/nNC1M37jT54tku5kO4XV9luZpvR5dg0FGFtUfwiLKknSf1x+KZ1wigAlvVwxUcs1OOBBQXX4/qT7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39830400003)(376002)(136003)(396003)(38350700002)(956004)(31686004)(83380400001)(4326008)(36756003)(6486002)(186003)(478600001)(26005)(2906002)(44832011)(38100700002)(86362001)(52116002)(53546011)(2616005)(6916009)(66946007)(66476007)(66556008)(966005)(316002)(8676002)(16576012)(31696002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZEVWxVNUtGWFRRVmszN2RHNUsraktsdyt1ZTllZ1V0SEd5VzFIakt1bDZX?=
 =?utf-8?B?dkhqTExTYkU1UnpHWEZ4S01SSEkrbXY3cHB4Z0crVlR0YmQ1blZYbUtyaDdY?=
 =?utf-8?B?a1hiTkJZV2RSSW91SDU5dWZsanFEMkpuck0vVE5xdjJjWjh0ODBlR3BJRjUy?=
 =?utf-8?B?RHlkMDF2VFoxVEYzVDNkU3hYQUxrZkpoTFNpZjFjbElLczc3SWpQMUh3dVhk?=
 =?utf-8?B?azdyR25HMnR6Y3hiR2NpbjYwaCtQMjRkS0NoZjRZdm5XTmpiQ2MrSVRzR3Z4?=
 =?utf-8?B?dzZCODZuMUxQQlUzQkhHWDRnamtHNVNvQUVsM2hTMWY4cDNGQXhqU1B2MUNt?=
 =?utf-8?B?cFJmNi82aDh4L0xua3FSZUlQWTVBNGp5alhwQlFib3VCc040M2VaaVFaUU1h?=
 =?utf-8?B?UTVzL2ovazVVNHJMR3dtWG5FdlpFRlpoWlJ4d1YwVHFudXU5dTMzdUVuWVBH?=
 =?utf-8?B?blJrb1lkWEJjVTFCRkdHOElUbUNPeHljV0k4RHNVL2JmSVNZaExQTVhSVDFJ?=
 =?utf-8?B?V0FWVjhXcDVWMW9DeDhEZFpRYlVrckhKbnFBSlMvdDlac2lDekdQdEp1Rnl0?=
 =?utf-8?B?VVY4ekdRWjgrVmhjM2N2cEdKM1AwZEIxdWxPRmRCaVZHZmRzWk4vUHc0Mjls?=
 =?utf-8?B?NnlnaVkrTHgyL01UY1p2WUNnTEJNRUU2bjNKTlE3ZkpVZVllZUJrU0tpc3lL?=
 =?utf-8?B?UnNVVk5FRzJXYVNiSnhQUXIxMHc1SWRKMkdmekVjZHBlNi9JKzk2dDU2TE4z?=
 =?utf-8?B?MlVoSFhHZkRKd1ZDQmVCMzdWU1pQOEcvWDVETXVSMkJFcUFmVWJNZVZMeWt3?=
 =?utf-8?B?dVdITXJsdjBNQlFjZzJZZUJLTmlLZTdYSGZSUXpXcXJRS3lWZEpESFNWQklG?=
 =?utf-8?B?ME1BVU0vNUV3UkdVUjkxbzNlRExTM0R6aXArNTBrVXZOTGlMZWh5b0s5M3ZS?=
 =?utf-8?B?Tjc0SVR2SHY3RndDY2hEN2JmZWdaZ3NGMUlsdEhJSVREVnIrRlErTVJpU3pN?=
 =?utf-8?B?VTNWYzY5ZFFpS1pCYmZyNVhQQVFQVUhwRzJlTzA0T2RMSjBlT2tMVkxpRWVl?=
 =?utf-8?B?SG1kNlRnV2ZidlV1MWZ1cExIYVdmajA5YkQwRWV1MjVxdDI5bGc1RS9XL09R?=
 =?utf-8?B?VWJucG1UOExSRDg5WU90MGtxMlBUU3JxZzUwdVVKZ2NqaFY2YndoNmwyY25Y?=
 =?utf-8?B?UmtMTk1Mc0hIZk94VjdCN0dDK29FWHg2Yk54c2RhcUloWTZaYllHQ3pzZHR0?=
 =?utf-8?B?VmtsNmN4R2l5Z3dLT0xzQXUvbnJWc2kyL2pZTGFWNzE1UWFPSXQ0OTJkOXlj?=
 =?utf-8?B?Qm95L1I0WmdMdVRGU2p3VTdKM3BnT3E1U0ZVNU5DbThTQlpoSExoU0ltSEFE?=
 =?utf-8?B?UyswU3V2MiszbWdUMjlrUGp5ZUFRUHZmaitLeVk5QVgvdDdqZ0lvbmUzTzJr?=
 =?utf-8?B?YWJVT2lVTlFKTU03Rzdtc3I0UDRPVGxiVkZlMjBCU3ZIMUNMbXlkbGJhUWVm?=
 =?utf-8?B?TGVsbzdUeFduRUxTZGp4YkkzZDlYRFRmZlV3WmN4SEFKTjBCZWxJMDRjcEJY?=
 =?utf-8?B?dzRHWDFDV3E2OGZBSUVzT1RFeU5lSWhoL3hiTXF1Q0VPQUFzSDk0MDVHNlNs?=
 =?utf-8?B?eXhRRW9hV2dqb2ZIMUFOMlZlelJoV1hZTkprMy9KVVg4RU9VSUJsc3dSWW90?=
 =?utf-8?B?N05YV01yZjhVTGhGL0dUQ2pZbW52UkJyazN3NWh3WitNVFg1RUVXdjRCMFhO?=
 =?utf-8?Q?WfHRJS9gAV9bxm0HdizgrwA2pns3FRqXNAtXMwz?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f4acb-e2d1-47e9-5187-08d96c6a2844
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 10:29:05.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdT2VxIu8I1FbUg8GIEkg6Rzrg7lmm2VtCO3hVMUIwUOeFw1rrztdYLM1+aFyUPN1nI8GOgOgKIMj3FtLiGXCuXJsA3e2XnuxVklTnvuBWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3273

Hi Daniel,

On 8/31/21 10:22 AM, Daniel Wagner wrote:
> Hi Jussi,
> 
> No worries. I am using the whitespace mode in emacs to highlight issues,
> but still I manage to add random whitespace damages. At least the end of
> line stuff is pretty much gone with this help.
> 
>> Great, thanks. I'm curious, what kind of workflow you have now and what I
>> should take account for prior to sending the patches. Does the b4 require
>> that all of those patches are in the same thread or otherwise reset the
>> versioning when re-sending the patches as a new set?
> 
> b4 is really targeting towards full series with consistent version
> numbers in all patches posted as new mail thread. It understands the
> versioning strategies and workflow. For example if I tell it to use v2
> instead of v3, it will tell me, there is a v3 on the mailing list
> (subject of the cover letter has to match). Overall, it's an absolute
> awesome tool and I am glad we are hosted on lists.linux.dev, so that I
> can use it. Konstantin did a very nice presentation recently on b4:
> 
>    https://people.kernel.org/monsieuricon/
> 
> Anyway the idea is that you have changes in your git tree and to create
> a new posting do something along the lines of:
> 
>    git format-patch HEAD~~ -o ../patches/fancy-feature -v1 --cover-letter
>    [edit cover letter]
>    git send-email ../patches/fancy-feature/v1* --to=connman
> 
> and after reworking the commits, you do the same just use '-v2'.
> 
> BTW, if you want to add a change log per patch, you can use 'git notes'
> and use 'git format-patch --notes' to add them. I haven't used this so
> far, but looks very useful. Have to play with it :)
> 
>> Also, it wouldn't hurt to download Linus' checkpatch.pl :)
> 
> Yeah, just use it with a grain of salt. It tends to be too eager but it
> helps to get some consistency into the code base.
> 

Thanks for the info, I really need to look into that b4 as well. Yeah, 
that notes does seem to be useful, I've just edited the commits manually 
as of now.

Some old whitespace errors can be easily overlooked and that kind of 
checker-script just saves a lot of time. Glad to learn new ways once in 
a while.

Cheers,
  Jussi
