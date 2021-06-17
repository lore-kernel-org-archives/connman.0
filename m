Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50072.outbound.protection.outlook.com [40.107.5.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360B70
	for <connman@lists.linux.dev>; Thu, 17 Jun 2021 09:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz3PMNh2MQevtYowGtd0i3ZOc8eVz1D5c//ImmZeDzlG3ICzGQ4CGFthGx24HrFkBx7cJ03n7p3/o+tYDAKFOzISGOKyFuM0LURG5E1uuXAnpDdnXa5QY9cOmpmTIG2J12cNVveZWg7R4MKLbyLZLIkJQ8CA8Qoa1yM68a6GGbsMniYI/cH/VHTdH3OP3e/PZ70FHFoWvRPJBje6JT62kacUqPtZ+W+1V7nUKfUD+0N6qvmIA55xgLQeSmFlUwgACc3rfZPoONBfFB1c4euKZNR98gNmW5bZqWpfJvhNgIHtxHOhngRB6evK6UeorttcBpJdKBxmaPkjx/C+BraWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP+5jseY626KIMRk2+3L9UkaBK39TF2ex3MtQI9Id8U=;
 b=Gfd4mTRtdt/WXNVBmrsBFJE2nrxWwt7GEkcBV8f+aPtaXZl0ISwZpGvtNMMetmztrf8BEPrOkUFBSR1MYinuCJYqxK4AAozxedGep06MVWfhph0eSvcIPU7UuE+SjY8UK/auC+6MGaHr15zpHHJK7IhEkHKY/pVhf16sNJ7ye4JR3hkyXLkuvxOJ7mx5YUSuAD+/A+eI/F3okZbS//gr5o2nR4oGOhI2rQ5kY4pQ9jTB2uLZk6VsrmHR0D9lwcteLTgqJ4vstWxXc25KxP9Oe3iSNoHNZHSFQPGyo6h7XaXPnd5A3ZpQe/FbXFM3AkFdEQvx3oGjClmgVOl0NfjDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP+5jseY626KIMRk2+3L9UkaBK39TF2ex3MtQI9Id8U=;
 b=GQOHerMoau/fBA0dYVDAx/v8Y/EEzNQKHcC6Q1kEZN8zlplf1cAVskdPACjhy7RGXVsbnm+UwRqCGvm9LX3HkD/MyKcxTUTnaJ/GOKY5HhBNaSxyUuoA9hQQcUAVwtvgQX6UsLNaIcKN3rwBqVNufW2aWQizFxKUnv5rLel575JPY/jdW8W4mPS3Gi0wTL7L6zNTs8fihKx+PmtIxa409Fpehh9f72HPp2n1hYvsM351eoksbaKn8wrx/tur+D5w3XiwLeUCm0ZeDoQr0wFzN4bccpgdljzvLyHSY2geCbElmwH7MVzgIwJEfmI5gzWitkdFkaL2Pu9HtS2h72JE/g==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR06MB4091.eurprd06.prod.outlook.com (2603:10a6:7:9a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Thu, 17 Jun
 2021 09:07:06 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::202d:9e9:66b8:a6b0]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::202d:9e9:66b8:a6b0%4]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 09:07:06 +0000
Subject: Re: [PATCH] service: Fix preferred service reordering on ready state
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
 <Emmanuel.VAUTRIN@cpexterne.org>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <PR1PR02MB47942554247F92A1437631E893319@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <3213af74-2985-ada6-09d4-67d5ccf1f72f@jolla.com>
 <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <ac94b39a-f446-0e0c-9f1c-5102aec815ba@jolla.com>
Date: Thu, 17 Jun 2021 12:07:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <PR1PR02MB4794AE9D35473E527750BE1F93319@PR1PR02MB4794.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.110.84.133]
X-ClientProxiedBy: HE1PR0401CA0107.eurprd04.prod.outlook.com
 (2603:10a6:7:54::36) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.3.6] (194.110.84.133) by HE1PR0401CA0107.eurprd04.prod.outlook.com (2603:10a6:7:54::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Thu, 17 Jun 2021 09:07:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec415211-85e0-4d47-a180-08d9316f475f
X-MS-TrafficTypeDiagnostic: HE1PR06MB4091:
X-Microsoft-Antispam-PRVS:
	<HE1PR06MB4091DAD6D7F669A92FC552C0EF0E9@HE1PR06MB4091.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	omxwaClMEX929vxKd2w0g6+0T0zglZCv0PBhhXMc8z5BVXexF8XtfrqbQBTxlwXTER82r+qq0qcarDhFhOz/XLU7Q/OmeL/VrbMlYGXw7+r6pmNqXG6RuUYB3+KSMfyZUkZARhe8U8atC2OdIc5msYHvVcceFcvGfp/RF5ykSmLj/p+GaSNrdtTcyplZEfxyvL9lgwCxXwIX8NSath5oZQe3HFAKXrwz4O/PHWBouBIRQ4+G+CWRJ+Fs13djkZaxY/XPew1vChgd0zvYgzNWKAsDUKAPY0ZmZHo6QW/Ir38LdKRfs1oYKY7Rj48oTIkINEAsGVctWLVc29t1kY9AIEpoGgKSHNOVMEXWHhwsch3bvqORgH7krY1wMZnVftAMqTKYCvW1JT4lAjjOXR/4ss0sn0NjaxDhTgUfvH8HGlIh5BR5y45rwAr2iu9VyFXMCT2DArBkbuMhD68cpFsDenpc39d/90VfbFUBafDM2Xn7ONxLcN9b9Q0fhV7Y2uIdHGYSXK9tIgpyLdR4Gh4l29FnldiEmIoYrTe57wZoYh0KAOCCJccVnemi/ygmFcx5DLdaF5h3pwLlFnUVHhg7s2YcdFtWdRxJD4AKTut5yFZKz+MtvsUECPJCE6GLJR6aRafEEIekVK0C7dXe+KDQLm5XVn/Aa/7AT/lwE+AwsIrm8ZeNiLeVetev6inyKntVAcehiif75pa2lRZnLNRVaFPaqodrVpo8OEkav/hawX+8lw2ldkg8Cw4QVlQKcNbn8e+sv7AhvS9dxHSosSu8Q4eMkQcjFS2hVmgdrlQFuqY1LattkwiI4CWSrTL3WE40J+6ko9oDEhouqYiFsZNefnqZgoGRjh66deC+E/0ugmw82tTT7oHminDQj02xxEOD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39830400003)(136003)(346002)(83380400001)(186003)(31696002)(5660300002)(86362001)(53546011)(52116002)(966005)(6486002)(44832011)(36756003)(8676002)(2616005)(956004)(31686004)(26005)(316002)(478600001)(16576012)(8936002)(66946007)(38100700002)(38350700002)(16526019)(110136005)(66476007)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0h3SG1DQnhieVQvQk1WR25rSC9pbVd4ZmUwNFBnZHVuWXJIdHlmMEJKZzdy?=
 =?utf-8?B?dUY1b0ZrK0ZSRisreVBNN1hjcXNSdGNXbktBOVdndENBcjZ2Tys4ZlZCdkhU?=
 =?utf-8?B?MWNPc1EvbmExMU5tQUliQVp4dXBuNDczZXZNcGN6bEhFd20wWnhvVnlCcFVo?=
 =?utf-8?B?ZGR4aEhiektPR25UL1NlQzZoSVNYd2RscHlib1h4YkJGdko1MnFyTjZuN3dD?=
 =?utf-8?B?RlpQOFBIMkgrY3dhOVJldWIwbHAwRzBGazc2R0JWdUxmYVFxRDlHSVhVcXpx?=
 =?utf-8?B?K0NXNG9oRGIzYlplKytCMWZOZmxJd1YxVkE5bUxsZnBlN2hJSkN4RnRLKzdO?=
 =?utf-8?B?ZzkvVFhnTEVibjZHOWRMd2VoYzlTNVl0ZDF2SFFERFhyMGhjOC9IK1pIVTc2?=
 =?utf-8?B?NnJVRVNTb1BNMloyL1d5K3dhRUJsWGdlNC9lUHRwREZPUi83UlZ5YU90eEt4?=
 =?utf-8?B?ZUh0M1AvbkszdnUyZG15SVJUc1RjN2c2UXRPSHI0ZmFXb0tiUVZBTTRDSjBl?=
 =?utf-8?B?dWRhOFp6YkFVa01HVGtKSTY0aWkybHl2K0J6dmowUHRNQ3VtL251VmU3RVFE?=
 =?utf-8?B?eUFWeEF6NTdnMVlxL3krc0xickQ3dnVHUWV1bXVuSkg0T2FaTWhOa3pBOVd5?=
 =?utf-8?B?UjdySzdqcmZJVkR3UkJCdU9tMXBtQ2JzajdNYnI5VVdrT1hqN2FRemVOMFNL?=
 =?utf-8?B?bGd3UWVIVTNhY0NHY1lSTWtqRndQbkwvK1NYVWxvM0xDRmdzRExOQkV1TWx4?=
 =?utf-8?B?dDZHL1hIbUZncVlhclVNNGJlMFZTY3huNkJteHQxemxkalNWdnFaSENNYXF1?=
 =?utf-8?B?MGVQN0VkQjhjaEhucXlIMWN3a1dvZ3FxcXNPbXRqUHJaS2xOR1FUaGhRaVFC?=
 =?utf-8?B?UE5qbEw1bVc2UGVzYU1sY0RITVhtb0xEeHFzKzFma29pSVBTUkRzSXNCbWVS?=
 =?utf-8?B?aVIrRFVDNGh6QVdVMktxT2M1ejRHWGhwUDdsaU5ubVZkWVg4ZzYrWWZnSkRY?=
 =?utf-8?B?b1J5MjhrTjAwT3VyTW5EMmZlcTlITW96b0ZDN3ZxZnZJRHhFRjJ5TnVrWGxQ?=
 =?utf-8?B?Q1QrTDFSN2Z3YjJmWnhHcVJUb2txQWx3TE5SNTdIY1lETkpIZE43MDg2ZWhN?=
 =?utf-8?B?RkpjaEQwM3lLTUNzY2pNUkk2MXRkU1l1YUR4YmVZdEF4b3dyTktyVnJhN21n?=
 =?utf-8?B?U2ZnSmRrWFY3cC91YU5WMTdJbHJ4bkpDWXg2YzRHMG1jMHFlWFh1NTFMcDF2?=
 =?utf-8?B?V0ZjcnFHNFh0ckxuYmJubmx1OHpZYlIwZkxUZkRhR3g3di9pQzlKOTlzSkJx?=
 =?utf-8?B?ZjE2ejY5NUNqRVBzSGhrWWgxMXVXeDFSeWU2eVdueTBBMFo0eDJVV0d1ZnpU?=
 =?utf-8?B?Z0VwQk1kcUMxZUw4ckc3NWpVZEpZYTZPc0pPTlIyanpMOWh6bjFaeWpZUUE2?=
 =?utf-8?B?VUNmVlNEblpYUng3SU1MZ3NpVFA4STRTWE1YSG94K2dSeVRIMUlCaWJIdEF6?=
 =?utf-8?B?a090dEtUZTN4K2lWOHRoWEdqaytIK3d0cWFQVkNWc1dPdTZZam9WL1NxbVZY?=
 =?utf-8?B?Ynd3NzBDb2hacUw4aE82eTNmSWI4OHpBaGYxRUV6YWhJLzV4bFZkQjdIMFYy?=
 =?utf-8?B?eXlWdHJwVW9zQ3dzZHRsMFhVWVRwTkl5NlNheExhNG1jZHdkdXFoTzlFMWZR?=
 =?utf-8?B?SnM0YSsrWHA0UDBMS3BiVUprZmIvdncyM0R4Vkk5RVZ0OVRFSlV4SGZ1cFdr?=
 =?utf-8?Q?qc06+fHGja5sHeLmMV71zEcKYvecCa6WAt7mJtw?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec415211-85e0-4d47-a180-08d9316f475f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 09:07:06.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBVZcKt3nNff438GWE/d39T63KuHU0RT+RqMPiEQgDgT83WME7tW9umK7i3NJLfALQXGPKQHGSsQNDTaKahwJkUHBaRezOJ2l3Tpblb8xcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB4091

Hi Emmanuel,

On 6/15/21 3:35 PM, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Hi Jussi,
> 
>> Wouldn't this be more simpler to be done service_compare() utilizing the
>> PreferredTechnologies setting as I assume this is the issue you are
>> trying to resolve:
> As I said in the "[PATCH 0/1] start online check even if service is not
> the default service" former thread,  I have also worked on this issue,
> and I presume the reason is not related to the reordering itself, but is
> more a state update matter.
> I let Daniel and Christophe Ronco test and check my changes carefully,
> but I am pretty convinced that fixing the service_compare is not enough.
> 

The thing is that I've been doing similar work on our fork and the end 
result turned out to be fixing the sorting of the services. It does not 
anyways seem to be quite feasible to first let the sorting re-arrange 
services, then with these changes make exceptions based on a specific 
state, which then will change after the services are again sorted?

I haven't submitted our changes to upstream just mainly because of 
historic reasons there is a bit of a different approach in use with 
service.c. This hopefully changes when there is time to check all things 
and get the fork closer to upstream. Our for does involve a slightly 
stricter approach which you can see here 
https://github.com/sailfishos/connman/blob/master/connman/src/service.c#L6722 
and the unit tests (that are not yet 100% complete) 
https://github.com/sailfishos/connman/blob/master/connman/unit/test-service.c 


But since this is about allowing to follow the preferred technologies 
list that is being set why not do it in the place where the list is 
already utilized for sorting? I mean that as there is a clear reference 
to prefer online over ready state so the preferred technologies list 
should be as an exception in this regard.

Your approach works but I'm not sure if there are some corner cases 
induced by this approach. These are my notes on this matter, I hope you 
consider this proposition.

Cheers,
  Jussi
