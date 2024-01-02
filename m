Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44AEECC
	for <connman@lists.linux.dev>; Tue,  2 Jan 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="wsgL96tu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6uEAgHx10iM1yGZj4WGG4nokOl/RuNj64g2k3cbfoQ1+OJ0TWRH/ik4l+1jc4Ijh7+cP9n36dnWR6kSGVJ9A6RnwliYXZoxL3u51PaNlUxyyZeBGbkw2ompooAJ1+hLPKXtU3Sp5rTeDoidYE5n2r1/I6otviyyxjcEeiE/sRBdvhUVN+YiegymCpQzxqt2jXc81iS0yAVjGTZ/VLUf/5I+Ej1dJxwar7KWad9jVwrXudMRSQiwFzJ3I/+C3iUxz28WcXM9h2g9OoTU4boTnsHfX030R/7CHBW/61sC7SB/wDP6/Rwwi1CvFsCgiX0z3qVgVgNIk78hGBaszM1mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LvGLI8yhGBUfrjqcQi5Pj4l3+3Ay9NNw4qzWF/7y2w=;
 b=GY1gkQteiWNV9/vJsGAE0kqnhRXQzAI7h6HD8jpaxcrwAQl43fjYGuwL7BDqL5ajI4HzyTuBhklKwp5yTV1Cl71qYtFvl0zeJVLJBZTkMWsxJrSyTLSTmSfdNT+URZNYMA3TmEpjBnLSDGSjg7ZdrGL19CRZvEa4mbh6KrQ3oKzjqXi6xl6UwLW+GNF48A9eJn5IgoeD50QdA4JsYalD5pqyRWoRneI5+cU7OwwDc1Q3bvmryUVQeBXtrpEBryrHDf04kcMGhm02nQ88ZVSgNw/24RkxUe7+OuzpVhlIzerN7dmzoLN6fNaFJGP1e3NzejkBoghJSR9hcoN4FGt5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LvGLI8yhGBUfrjqcQi5Pj4l3+3Ay9NNw4qzWF/7y2w=;
 b=wsgL96tuRCvCzfyGEwDkBmk4JtCVi3wY6ie2uG/S5/f81EY8d5NqeJcRLBGlqq1szPRqhFODzrWBzJnSxOw/xxFGsmMtIMic1onJ8/rm/BwwRXEOpzX9OfwA7e+znQEm40wtjAgj4ney4LiOFeKQNrAY2WQzRoUSqFn1hQrE4N92olXRFHeRIPQuKIDWikEEazJhAIrjsbija1peBxJR/b12jwEGB1+a96wc/LjPv4f2ZXSXtO2XCqsOvBTDJzfANxdMZ+B1ER96IRv84EvHn2xtQ6FsGrWEd7F9aJ/G9+UQvWUWAeg0MECj7bYPQnl1hbgaxEEXHYxcCzhbxRb82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AM8PR06MB7073.eurprd06.prod.outlook.com (2603:10a6:20b:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:16:49 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::1a8:462f:5146:101d]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::1a8:462f:5146:101d%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:16:49 +0000
Message-ID: <b34cc24f-b7cd-490d-9a1b-c7ba2ecbce92@jolla.com>
Date: Tue, 2 Jan 2024 14:16:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Ensure resolving and setting of proper ISO3166 code
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <20231222154645.278128-1-jussi.laakkonen@jolla.com>
 <3D272FAC-BA62-4533-B6A7-750F563D3F9F@nuovations.com>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <3D272FAC-BA62-4533-B6A7-750F563D3F9F@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00003859.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:14) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AM8PR06MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a85fbab-f05d-4728-e83d-08dc0b8cb1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mBt2nGZuUYe34qz2df7WJwhPMItU9qMmpB2JknqsbpPSMNEBwLoTPKJT3GSZf8mdgXIFqYSIgmsvWsDnOXoiFfjwyu2EKeVwJKm1l4TBbKi9WIRRZ308IhQDmzeaRPbcgVoWKpLGchMH3lT903mDA/Ax+IiXYZtvLH2zmPkicgUonrQ4WJQmkST9YllYoU5pjnBFuc8A/J3uk4tOf1UmrI9jYp675KVcmKZ8yGT3uJ/NeknDxJes69iLtbTToP2+W/KGvH9UHnui4j6Yc8fljZcNRUQ88FSyEG2x6yvJ6gjMfyRWVJ4FdIi1xwDaGH5p8rMl/mAa4ORiuQ3Of8+ASTveYuUNgfAblnPl9kFXyAQYcFN8WOOMSt5RoyQbF+wPKdTK+vYWyfWNjpFTfiQEtYpjZTAKnXjvriC5bPa4FErVAC1r3NMDIsuyVTZ3eCQQmAtMKn85GfnEeDW9hfQ+7cefmospibL4Mkt57B0b4JZuIUCGY+tuNBzopoDMpUEAgRMxUxjvARIkM6/tVJlCqKMwLrcbJXgKSPkoAWSuF5gN5/xBFicLduyNdUXXqHjj8oDMnOiIV6OtmugBafOwFAO3f46s1SZspbK6DP8nGWOQZkQFlOQJqmWqOQeKgR5AJ58EwUHNU/TbeI9EUrC4Ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66899024)(83380400001)(41300700001)(2616005)(26005)(66574015)(38100700002)(8676002)(6666004)(8936002)(5660300002)(316002)(4326008)(2906002)(478600001)(44832011)(6916009)(6506007)(6512007)(53546011)(66946007)(66556008)(6486002)(66476007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9MU1RLajVCWkNsRDZGcTY0UEpKc1k3MFl0TzZmdTFLcmNmTytoZDFqd0ta?=
 =?utf-8?B?TlhGN0JPZWRHaU1meEY2MkhmR3gvdVRUdkV1VXRHNFVWYjQrQ1hZY053eHRU?=
 =?utf-8?B?eDNoZ0lHeEVwTldFRnpTWmY3cmFKMDdFS0VLNEtCMjJqeUVCYnZPSXhFT1BY?=
 =?utf-8?B?b3Z1ckFuL0ZISStJVEpMUUtmNUlQbStsbHc1N2hQVjJrTjd6bmI2OGU4Njd5?=
 =?utf-8?B?L0FBblhCUDJGWC8rY3l3V0xaQ3hXeDNUWW5XRkE1UEJ5VHZsN2pSdjJXMDVx?=
 =?utf-8?B?UGNWYnI1SkRpS1JvajEvNWdLaGhlaDJ0aDV6dGxZMElnWTZUS2RyMm1LYWpP?=
 =?utf-8?B?Vmw5RnBNR3Jxd2lGMERrOVpxcXpQWUZ4TytQU3dxL2R4K3V2SE44WVdCbDR0?=
 =?utf-8?B?b3gwOGxjRmxsLzNEVDJ4SzlOcStxNHMwUWRzZjEvOTBqWk1KZVNtZ3pDTklC?=
 =?utf-8?B?MGd2L2NqRk1EbHhpYk1hbW0rTXcyUzNDM2xzUkFaSXUzcmM3MzNacmlHakE1?=
 =?utf-8?B?NFFTYTR3a0VWNUlWUHlvS2dKd0t3MGlUSGpLanVneDN3VlJsUjlBT3NMSGtS?=
 =?utf-8?B?cjFiSi9BeEh1c042RmFwaTl3MUxNamszY3VmSVhOV1lHZXcvYWVzMzVuS3FB?=
 =?utf-8?B?NVNielUwcXZ3YWZjajFzOTVyY012VXVmQ1huUVlUbmU5WWNPWnZrYU9qSzBW?=
 =?utf-8?B?N3ZueEh2S21VbTRTUXFXbkJqOEpPYTgyamVoWjNFSXM1Q1oxaU52c24yNy9X?=
 =?utf-8?B?YzBEdzlLT2NkNkhCeGFzaDlSVGhValN4MkJqK0RoN3JEWWNzTnlxTlNTWGpR?=
 =?utf-8?B?b2hnNXYrRzZ5bkU1T0FaU3FMTExPTUc2dFRsUnFkVXBaQnRXUEVZS0grNWwy?=
 =?utf-8?B?ejRRSzRFdHc1L2ppZ0E4NlpvZ3pGMm1ycVpKL1VRZkNCcE5Ta1J4c2JLck5t?=
 =?utf-8?B?OWVTTUsrcHJGTDRuWUgrb2VLZWllVWFVclkxNkQxaVNPZ0p1dlRXMGo3c0VS?=
 =?utf-8?B?N1hVV2hlODV0MHE1VkFJTjhkN2VFMDlQS29iMHlYOENFVm05TEtsYUhZYWh4?=
 =?utf-8?B?cGNYa2pHMzREV1NYd1Z0RERuTjdRR01DZk1HY2JRNCtmaVFxQ0NQdFFxM29t?=
 =?utf-8?B?ZHZKaG5vSFR0ZXZKUHBoeVJJODJCeFpzUlJVYytaN3BVM0xIWDBnZFVEL1pX?=
 =?utf-8?B?T3FWQVFDcDhUR3FIUFhGNG1VQmRoN0RSOXE5aEhESllRQjdvVFlzWmd0QjVV?=
 =?utf-8?B?L09CdjBaRlFPQU5kQVJWWWNPTndubnRxNlNMcnFwSW1PeXlxTTJGdDFndGdU?=
 =?utf-8?B?MS9hSlRYRDUyU3lvRVJLbHdwMVB6MGwwcmNQRElGdEJpV3ZmZW1SRXoxdGFm?=
 =?utf-8?B?NXN1eGJFalc4YWFSdUtHd3dCVmZiUnZqK2RsM0lWQjlwRGF1OUZyVmVYVWVT?=
 =?utf-8?B?QVJIYWZoWXE1bUZTNGN6aXhvendZMExObzUvT2Q1cjJlbHdmQXc1eGdwRk54?=
 =?utf-8?B?RHNnUGxiWWZwZFg3Tnl3b1NEbmx6QXJsNE0wbE90VHBBUEFaOUxtbXhHUkts?=
 =?utf-8?B?YjRtVHhqSFJNUVlHSHJsNFZUZmtlOEpqU0c5OWlEQTNqbkF1VExtK2dKMzdY?=
 =?utf-8?B?MCtUbnYzKzNYZkdrVmJScXRJQ2M0MWtxQTlQdEFiMitSZ3pnZ0dFQ2UwWnVk?=
 =?utf-8?B?cS9wK2pJZU9ieStUOVJmM3FpTjgwRDBvZjlZbnp4S3N3U280Q1ZZa2dSdm54?=
 =?utf-8?B?NS80Uml6clVVZnZtai8xMHQxa015QS9BS2x2U2NZVjVYVHBXMkhMWXFMSExG?=
 =?utf-8?B?RG9RYXZRbTUyaDI0SHdsQThRQkRJbUg5NTRWcHhLVlBVNCtEUk0yQTY3Zmpq?=
 =?utf-8?B?cktiTExXbVdGS0x3TTdwMDROUVZTb0ZlZVplQWFoWW9BSlFYNUFKcGdmN0FJ?=
 =?utf-8?B?azNLaS9BcnByU3VSa1AyVjBjTHJGUE5GeURFVnE2cjJFek0wTFE5SzZvbGVL?=
 =?utf-8?B?Vis0T2hIZURhQ2hRZmFCQWFCWTJHc2Nrc0g5NzBzbi9XSE9uTXpQazFhS3kx?=
 =?utf-8?B?cmVZVmVCN1FWdTJsbHREYkFBRkdFNmN6ZjlmcFFZeXNzRWpBWmV1MkhNK1dv?=
 =?utf-8?B?M29NZmVrSW03U25FZ2FzSlRncWFkLy9sWEw1N05Mb3l1b3FTdHJWRVRqb3M2?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a85fbab-f05d-4728-e83d-08dc0b8cb1fd
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:16:49.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRudqFx3lteXV+vqHOqGye1zdkksFuUe11j9LJXNNthA6JfbCwTySVe/MeqQ3evh6DKl0nOirEBBj/eP1Auce9xrhyn6GuabkA8hGWj1u9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7073



On 12/22/23 18:33, Grant Erickson wrote:
> On Dec 22, 2023, at 7:46 AM, Jussi Laakkonen <jussi.laakkonen@jolla.com> wrote:
>> This patch set amends the functionality added in commit
>> bce73f1bdbf1aa6fc28d2f75b7780f4f1d8b0e3a by making sure that the ISO3166 code:
>> - is resolved in every case using both zone1970.tab and zone.tab
>> - gets set for the technology when it powers up
>> - and, is kept in sync between technology and device(s)
>>
>> Technology now stores the regulatory domain as an internal value which is
>> changed whenever a change is detected. Similarly each device ensures that the
>> value is being kept in sync with technology as it is set always when the device
>> gets powered. Technology gets the change notifification via Ofono or via the
>> Localtime setting watched by timezone.
>>
>> In order to always resolve, or attempt to resolve, the correct ISO3166 code in
>> every country sub-region both zone1970.tab and the deprecated zone.tab files
>> are used. Initially the ISO3166 code is retrieved from zone1970.tab but if not
>> found then the deprecated timezone map is used to get the correct iso ISO3166
>> which is used as a search parameter to again search from the zone1970.tab but
>> this time searching from the string lists. This is needed in special cases,
>> such as Ålands and Pacific/Midway regions to name but a few, to have the
>> ISO3166 code set. Otherwise in these regions WiFi plugin, for instance, is
>> told to use the default region, resulting in some channels being inaccessible.
>>
>>
>> Jussi Laakkonen (3):
>>   technology: Add global regdom and regdom getter
>>   device: Setup regdom when powering up to maintain consistency
>>   timezone: Fix resolving of proper ISO3166 code from tz data
>>
>> src/connman.h    |   1 +
>> src/device.c     |  11 +++
>> src/technology.c |  27 +++++++
>> src/timezone.c   | 178 ++++++++++++++++++++++++++++++++++++++++-------
>> 4 files changed, 191 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.30.2
> 
> Jussi,
> 
> Thank you for this patch.
> 
> I have a system where the timezone is currently set to "America/Denver" which periodically results in the being incorrectly identified as “Navajo”:
> 
> 2023-12-22T09:27:46-0700 [19205453]# cat /etc/timezone
> America/Denver
> 
> But is identified as “Navajo” here:
> 
> connmand[<PID>]: src/timezone.c:__connman_timezone_init()
> connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() sysconfig zone (null)
> connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() localtime zone Navajo
> 
> But in another run is identified as “America/Denver”:
> 
> connmand[<PID>]: src/timezone.c:__connman_timezone_init()
> connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() sysconfig zone (null)
> connmand[<PID>]: src/timezone.c:__connman_timezone_lookup() localtime zone America/Denver
> 
> I will be eager to see if this patch series fixes this issue.
> 
> Best,
> 
> Grant
> 

Hi Grant,

I think it should help with that issue since comparing the tz files by 
their content was not ideal as many of them are either equal files or 
they are symlinks. Like that Navajo vs. America/Denver is, and as well 
as the case that triggered the need for this change; Mariehamn and 
Helsinki is:

$ ls /usr/share/zoneinfo/*/Navajo -l
lrwxrwxrwx 1 root root 14 Dec  1 23:51 /usr/share/zoneinfo/posix/Navajo 
-> America/Denver
lrwxrwxrwx 1 root root 14 Dec  1 23:51 /usr/share/zoneinfo/right/Navajo 
-> America/Denver

and
$ ls /usr/share/zoneinfo/*Navajo -l
lrwxrwxrwx 1 root root 14 Dec  1 23:51 /usr/share/zoneinfo/Navajo -> 
America/Denver


Likewise Mariehamn -> Helsinki:

$ ls /usr/share/zoneinfo/*/Mariehamn -l
lrwxrwxrwx 1 root root 8 Dec  1 23:51 
/usr/share/zoneinfo/Europe/Mariehamn -> Helsinki


Did a small test on our devices and they do seem to set the correct one 
with America/Denver set as timezone, at bootup and when changing it 
manually.

I guess you are also using the option to set the regdom on timezone 
changes in the configuration and not to rely on ofono plugin to set 
regdom? The change for the option was included in commits:
f035539d46ac23ccb8916ed7ae8d38ab553d32b1 to support path for localtime
aaab2161b247588bbee32fefe775ef55acc69c4d to set regdom to follow timezone

Let me know how it works on other systems.

Cheers!

- Jussi
