Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E643FC2
	for <connman@lists.linux.dev>; Tue, 31 Aug 2021 07:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkwfSc6XFWwlBsLxJX4EsmH7irzd1sCWvpw3NgymTkvtlQmayxVLgnax+23DFd/6fb5Shkac+Vh5qGk+BW5MLrrPKRfJapJnhK5QmERwFSOloY5OZWkeDb1ZBZWvkP5KWWvHBwBWs1gmp6Aiu2uw1PKBbYfYtQKVun+V5lOVvDTtY3WV9UPrXBnFS1knN/c9OiM/vjXYOG9v00a/1px6zhEye32NmcCWf1PP1M/5r4sybJuM2MgoGmWdDvhyLm0yJ+J9Ahi/ehJIse0qaCULsegr1fD8+C9QQBlRRSVaCTkq9XVoh1gvgcYbxVNXhvjKYfhlCUjR+9tKKUlXHuUxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VQ/UPOFIvRqB80zPOwVhQL0aL1HsNs15x3lQY97J4Yg=;
 b=XzrzWDl04eNZXccnd92a4xm5d9sFtoxQsIhv+HdLLVB/NC9ih55nf04HxD0+8n2BtfK3YrsbvNzD+X+/f5/DZDysqBDMfVRun+Vm+/r6/VGGHuX4JvjtS/xnklUxp19jK/C3fagV9qfbR5RKxGHETjxD2S+5972SLtsSQ2KeK0odRiMTRuXR7GsGiGSeKoNI86oTj7jiosYisXEzGZPVSNA4swbEQm3hsCl32pWI56e9Oim6qIop5WIUWABjsKRqn1StQpgdcHs37WPD+hTVDAwsVo9IQWZK7pOwMuqmDXmJ46LrGKTjogPAsIPYyZXS0A1t4lCRNad0qZBOu/MXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ/UPOFIvRqB80zPOwVhQL0aL1HsNs15x3lQY97J4Yg=;
 b=GOO4iOLl3kyqaXujc004YhGI8LMzx3fRsBQOm+LWPOqTPkqOIeA1mBr0oZ2y8/mPViP6tc8UR12qn1rOwQszwti8NC4H+vPszK7cIR5kmGhmBEIFW3I7bz0+IdoH0h95vbcFHxf4+E7wJCTusVNLBaV2eZI6BoWGT5Tvf2mPlaaIuRmY+deD4Dtd3bROs2ukREXUQ94brynE242r17fH0YYIoYi+NL0cnemljpkmXrhqijRZkiJYAsxu+/A+M4PhpivirTm0dtiHf4LVK3BHP8yzHQR07saVnds3wofdEe4nPaftKJncOB1ZVX6h6mg2forxlxeCbVK/cxqbA7rpiA==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0602MB2794.eurprd06.prod.outlook.com (2603:10a6:3:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 07:00:42 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 07:00:42 +0000
Subject: Re: [PATCH v2 0/2] Implement connmand state monitoring to vpnd
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210830092405.30964-1-jussi.laakkonen@jolla.com>
 <20210830170631.ni5frzfk6v6jn7s6@beryllium.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <a0d28b35-d3d0-8454-c1ab-159c6ccd728f@jolla.com>
Date: Tue, 31 Aug 2021 10:00:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210830170631.ni5frzfk6v6jn7s6@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::19) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.1.2] (194.110.84.59) by HE1PR09CA0051.eurprd09.prod.outlook.com (2603:10a6:7:3c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 07:00:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d84d152-0814-4de2-6421-08d96c4d0bfa
X-MS-TrafficTypeDiagnostic: HE1PR0602MB2794:
X-Microsoft-Antispam-PRVS:
	<HE1PR0602MB279488243E949BE35DA23ADDEFCC9@HE1PR0602MB2794.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YR358q0pTfzr7D2KnJdv2mDCjfbNfnDRO7sj4rKMUBxzw9m2MjT/IWioSX5/WHih6wOK8cthReBaujWBRWi46ibJREk5RdZFwnTQ4EJAutGnS6cDvxFJd7gADmaDCsGUMQJPDT5MoVrxm8FeuRd+b7ZkKbV2nf784sU7g2qjR0UP9cIHiwsUdJgH/w+v/uIQVEP3Dheg3ylL/Ev0ZHB6sc26ZvGIq/mz8xLDjQj4321/kO+2IOGfFM0CF05iF3Ag6DnuyhXT/JyNo1AFxVfJtSC87yprWYW12heX14Ii1F1ro9u3RZmuwnbbL+jFtV/sLdP7XzSMsOHS53qlJnejAeqDjKL+kGJY2nM/by+jCxfmv1A6/WYZn+1odM2hYWylYAysNPxfk02q8rHC/AnIWlkMvLl2+E49xKDtw/UvhwiqSw0oCww4v+EqeI9k2D6b9XaJZ99s9gjovkuEPnIcoH+/QefP8JYl5LwKlWw8AEJAmb85CggIvb6qMCeTP4lNlvmO7j9DGciqPvR1GQPEUtD3yu+YfQi4jyABwNenfZ6GAp0tIlSkXb7fIPraupbyIk8e3VWfKPkI0v2LQef23lxrPaRzFDG9Q5oLoQDMkEOILA6F3cBsU4yuMcII5h+YgUF8ocV1U+Dk5XfYcAYeAVbquxmpul0vkfPrKPGdiDZc30zT+D9l3+fcLUN1NE9lYkHpuaxaNN7ULE3rcHs1S6694pybw4MaYfjjuUbKGfOcW0Yhad63cjlWAJ5izammKa+yBwcgXpZ04J9f2f3FpHhNnlNHq/qDYxiNT/a8KMA2L+f5Q34bIpztxmbwPLHRwsyevcbOwbN0q4abXxSSmA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39830400003)(366004)(376002)(6486002)(956004)(2616005)(6916009)(38350700002)(38100700002)(31696002)(44832011)(316002)(16576012)(86362001)(31686004)(83380400001)(8676002)(2906002)(5660300002)(53546011)(8936002)(478600001)(36756003)(66946007)(26005)(186003)(66476007)(4326008)(66556008)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzlLcGVacGU5ZVVhSTRoRFlPblQ2d2lFeENUR3RUUlJVZkxGaGN2WUxTYVVw?=
 =?utf-8?B?YW9ibENIWGthNnJUL0ZpcGRKNFVLSlZtKzZ0MHlMV0VrNTV6VXpxOVdNZ1Bk?=
 =?utf-8?B?dDZ2WVViUkt4NFVwR0M3L2xHZVZjTzdKT3M5bEU1WFp6ZW5RSVovRUlMOVBy?=
 =?utf-8?B?Ykh6MWs3MEdUbjJodWcxUlRIcUVHblc1bWljUVlmU3gxdFJnckVUYU1MOHcr?=
 =?utf-8?B?WUFXZ3g4UjBxME1sZjl4d29yeUk5Z0VOK2JLUjBlK2F2NjdpNkdkdWFEaTZQ?=
 =?utf-8?B?Mkl2L2lqaS9qQllPeDVUWG42cmZPSjc5SmZJK04xc3ZOcVlJWDJxK3hCMlQv?=
 =?utf-8?B?RW1Jc0t5THA1cTVybDZnSGU1TzNvWUFQSElXTTFodC84WEJZWEVrREE4ZUpI?=
 =?utf-8?B?MThtU1JnU1lMdjRYMVQ4ek1ROHYyMEErcFQ1ZktHTGVUOGsrd2tqTGxFZkhB?=
 =?utf-8?B?UDdISWQ1YzNHcVB4Ukl3OEhnb2JDdnZBUklJSGFkSkR0Nno1N2I5WGcvM05y?=
 =?utf-8?B?U2FBdlZOYUlNeVRTaGEydWFHZ0V6NEd0NFRyQXcrWG10bnFRb09sSVZucEZM?=
 =?utf-8?B?WVlLS0dEQkJpeThlZHZxTElva2FSVVpkM1NGbzA4SGtZNGtOaExuZVdHc3Jh?=
 =?utf-8?B?WDVEcFNkWmhVN3dTUTdkUjBkZDlaeHBzQ3RXR1VlYWpZSUZpbFlZR1VyMW9n?=
 =?utf-8?B?V2R0N3BvR1dsM0hVVWhLQ0xmWnVRTWdBd21URS9TeStvcERWMWJIYVhzb2ow?=
 =?utf-8?B?MlFUZkZwbGpDQ1pjYTNUSllSMkFJYi80VkQvSGFiMFdJQ091bXQ2OEVubEJ4?=
 =?utf-8?B?ejRFSktTQlZsYUxRNWdVQ0lpMC93eGhTYTRTUm9rSjd6TG5DVzZ5VTdacnR1?=
 =?utf-8?B?OFBPeXZmNHlpVEVncVUxT1lCY1lmM3QwWFkxSG1RZEo0RUpWZGExVnpjdXRD?=
 =?utf-8?B?TUR2NU14OHNwVUhVNUFIZjBRbktFejU1cVZRMmFUVThTK3o2czdwNFBEQnJn?=
 =?utf-8?B?OUw4dHZRWUhKNFQzaTcwSU5ERGplOVZsWVBWaVZsSS9vVFRYSFVrK3NnNk1R?=
 =?utf-8?B?UG12NUlqZU8xdW8yazB2ZnNzaHM0NFQreFI2Sko0STZtZmUvb2ZIclBCZ3ZQ?=
 =?utf-8?B?eXF3aWk3VG9kOGdsVkdHYUc2RDRtT3FueWhXL0pMMmsxZEtrd0lZczFRMDZi?=
 =?utf-8?B?YldRbUZ1dW1GM1QyYnAwQURuUFl6V1o0OGdWVVNjNWtPZ2djb285TUppbGZU?=
 =?utf-8?B?ZFF0VGc1cjNKcmxKcFc0RStKWVR6eHdndElJeWNnNmgrQkh6Mm9ndWhpeHla?=
 =?utf-8?B?WTlMR1FrdkJVbG1wbzBvL3B0WEJkLzFyMlZuMWZJQThOSGFmNGFXRnpYWG02?=
 =?utf-8?B?c2dCbnRtdlF0a1JNL3h0YWFGM2hqNktYa1hvVmxFRWFRSmx4eEtBdDRGeURD?=
 =?utf-8?B?ODBiNFFNRkpUbHhmN0FvNDB2dGNlSXRWNGg1VXo1djdVWnYydGZ6QnRubHBu?=
 =?utf-8?B?K0dSS29WaFpwenVYQ1BKMWxia2cwdlNDcGMzQ1JqcVFUOG9NZnVlVm94M0JW?=
 =?utf-8?B?bkZoRldYZGZ0WjdUcUdWUVBhOGJsQlgveS90b2dpbTBJVnlVRFlZdksreDc2?=
 =?utf-8?B?UDBNeGE2ZEdMdkI4TjZWR241Z09FcHh4bi9jenR5L0Y2MDZWOEFoTDdaV0U3?=
 =?utf-8?B?blBydERuUDExV1ZQTjQ4S1VtUFJHclcyMDlSLzhFWVJyNGdEWWNVRDhuU2Fz?=
 =?utf-8?Q?yDnnF0C0jZoKZFLUqryurnWD/YQM7S+DQ63nOWO?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d84d152-0814-4de2-6421-08d96c4d0bfa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 07:00:42.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZHGZqtDeM+QTubPwfbz5YVsWQcjPiRUY3erfoxLfSvNZ7OGhBZLSixgA/NoHG07Ma4K5CUwwIHZsbcWHNJB5GeZTC3unafcstsSD8TXE/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB2794

Hi Daniel,

On 8/30/21 8:06 PM, Daniel Wagner wrote:
> Hi Jussi,
> 
> On Mon, Aug 30, 2021 at 12:24:03PM +0300, Jussi Laakkonen wrote:
>> Implement connmand state monitoring into vpnd to keep track of the state
>> changes in regards to connectivity and D-Bus registration. vpnd retrieves the
>> state from connmand using Manager interface when started and otherwise it
>> monitors PropertyChanged signals as well as utilizes D-Bus service monitoring
>> to get the changes.
>>
>> This change prevents connecting VPNs when connmand is not yet online or has
>> gone away from D-Bus (e.g., restart). In case VPN is connected before the state
>> has been queried a delayed connection function is utilized to connect that VPN
>> when online/ready state is reached.
>>
>> In case connmand is offline or gone from D-Bus ENOLINK is returned as an error.
>> This is handled in plugins/vpn.c and returned back to the caller as NoCarrier
>> D-Bus error message.
>>
>> Changes since V2:
>>   - Updated vpn-provider patch to v3: cleanups, reformat, remove agent checks.
>>   - Updated vpn patch to v2: do handle ENOLINK properly and reformat.
>>
>> Jussi Laakkonen (2):
>>    vpn-provider: Implement connmand online state checking
>>    vpn: Refactor connect_reply() and handle NoCarrier ->  ENOLINK error
> 
> I fixed up some small whitespace issues in the first patch and dropped
> the else block in do_connect(). Also added the 'void' argument to
> get_connman_state() (all complains from checkpatch).
> 

Ok, that is cool. Apparently my git did not find any whitespace issues 
with the patches as I do check that prior to sending, hmm.

> Also I had to fallback to my old workflow and cherrypick the patches. b4
> was not happy with the thread:
> 
>    Grabbing thread from lore.kernel.org/connman/20210830092405.30964-2-jussi.laakkonen%40jolla.com/t.mbox.gz
>    Will use the latest revision: v3
>    You can pick other revisions using the -vN flag
>    Checking attestation on all messages, may take a moment...
>    ---
>      [PATCH v3 1/2] vpn-provider: Implement connmand online state checking
>      ERROR: missing [2/2]!
>    ---
> 
> Anyway, I gave it a quick test, all looks good. Patches applied.
> 

Great, thanks. I'm curious, what kind of workflow you have now and what 
I should take account for prior to sending the patches. Does the b4 
require that all of those patches are in the same thread or otherwise 
reset the versioning when re-sending the patches as a new set?

Also, it wouldn't hurt to download Linus' checkpatch.pl :)

Cheers,
  Jussi
