Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E553FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 07:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFoIede/Vb54dhqPhX38h//akknawx+mcLSAQJktYqYLbjUroktZ61OpQ6tOpc/MDROgAGfL3JxAaROP54MxH6W5KQorvFC2HXcv1UvOypRqAECDfO7/57SNPTLIN1eeBDMe4ZTPHQ4utQbanCen//euVqk78ZlNbX/u6D2PHFDUbZsAYte17Yk3KD5ylem/5jEGTBulFe4TscV5+81NRSITe1W4DyMV+68ZVix//sIEV4N9ShW126aAMc2+8jRDLCQ6chuKVzzAagefZnYPbIGcIeutmpHwD/vNBNFLtSxKYAR55tGvlXrlDct7h8900u9NHz4rviFp4FrD6iqdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avxEtk6GZ9W3pYIs1jtAJIsJgRcAwVvwGMQgMcp5NNA=;
 b=X0P9VNsZb66O4B3kzfpbEQQs8oeFHXD5TTeJFnQJK2YJ/2uJRS5CL81j2XLRB5e3UPEWHg//hbkmP3Pvq1FpKCi7pv4BJnorWrydykiXNrDEPQ6T0TGraL8cmdqvsouKJPzjI9OZQlY2tfq3I6kmu7lkHedS4PkikWqYREJFcBTRUafvfGRtQUcWwZczOq7KcdzFDPNX6H5HHUCozhxpACqKbfsBb4ey+urns+NNH0m3TdXi2g6t8Y4Edk1+sbxyyGXzOYmABxdOCnvZ3cFfEbwdSsXzuBIKIoyLNtSR1M8Xp9uHxsUIptHO+fUAYQBcHghVqaX8vALbsbPHyOTEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avxEtk6GZ9W3pYIs1jtAJIsJgRcAwVvwGMQgMcp5NNA=;
 b=xSIFYp2gF2VzvLhPgnbLomIrVj27SchmVPFDeHxU2pwiLu7D5BeDv9wMrKSg6YuSPQp1VTD3jrnwRdQEKVvTlUMJEVDnYVqUZHUmd5y75LtRKKqO9nU5kHgDxq9TyX/sz7PHdanVZQ+hFqWk0SusHY1UeFP4AxBgEM2rynzw5gMIizxnNRNT8/l9HgE3w0eFBYPg2HocO4wQryG6VpQoGO3S0+gv0vUlGxZRL057qWPkkH/ccHnZlglgYYEEX3W0geoltCycLuEUn9YtyxDdstePDO+0qECtvYi2OUuExt9azQyBgBH26DePpTqgAHXt4Y7OdJRsy/0RydALBRwUIg==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2202.eurprd06.prod.outlook.com (2603:10a6:3:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 07:00:01 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 07:00:01 +0000
Subject: Re: [PATCH v2 1/2] vpn-provider: Implement connmand online state
 checking
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
 <20210818103137.17409-1-jussi.laakkonen@jolla.com>
 <0fbd12e6-7e18-25fc-4d13-511289895168@jolla.com>
 <20210819123003.r4sqio2pquco5qph@carbon.lan>
 <5f76dcbc-8e93-61fe-8d7b-6b0aa7bcb786@jolla.com>
 <20210829182735.yfulxx4f2lwrhxlw@beryllium.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <5eae634b-1abd-a752-7a11-9255b051ed8c@jolla.com>
Date: Mon, 30 Aug 2021 09:59:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210829182735.yfulxx4f2lwrhxlw@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0301.eurprd05.prod.outlook.com
 (2603:10a6:7:93::32) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.1.6] (194.110.84.60) by HE1PR05CA0301.eurprd05.prod.outlook.com (2603:10a6:7:93::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Mon, 30 Aug 2021 07:00:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd4e0f36-c2e5-4ad2-ceb4-08d96b83c937
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2202:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB220214FD147DF105E089AA20EFCB9@HE1PR0601MB2202.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eUTf+djdnRcWWEN5CtPeu12gvHFe1wTdKk5kuCLemBvSSLLoNjxCnveD9TMjU0Z8O96aFP5Rzz3tNDqYqpdSdtQ+mmw95P5uTw2WaLvHuHQb/JvJBvip58rc8kX2pwaK/NCh9dEnUVr3HKR+OLEI16BwoN+dZy/apF3flX/wLnE4omkIsjm7Dm0HvEhvfKLRtHAF/GoB1K8AfOj89K7+GRnXuiTVQ47fVBY8uW7we1EqbMeLzUMoh0GBKMjWOebTCEBuNYWoItjIZjHMbwBtFfZFTJyfhmWKFHM1/pE3w8sWdesnt6HDSLGofk4sw/pBK8VouGz3RsN6iFIBG5uuR+5t3OqFXQUayFF204t4tWQi8Ccx5uTLX6KxZqRTslwpjuL7xx8XaqB7U1tKG/jZxVjnnSwScaf7w4lfdcU6f1AI9aMhQdyazDuO9C4gGYYZvDLDI0BV6wRsb2wrGYx+7Wb2ibWPUmTg5a3vHGzP9d77JHn49+Z1mx/vk9WI1PSs8CVbr3rWIWXrOqxKTuDKqRj4S795xtkcOF/12BsRJPilBkRlMTMlsck5Rz6NSnOmEM2045uY6l3Tikud036HuEa9c9xTkl8ECca2nLP5L3pugVMo3G5MeTMGsTC356hnlwqYH7vQrUS3rT30Qk4vtvAjpXOy/DNqpmG+/9Bf5JUaZvHsz8NOFuFx7gke/Q4UkJJ3nV/4S9P9xrCyI5Wp1bZohqqYgCW6ZboC8hPNNfJ065CXKkwgEyVOEcoQhz3ot6faWhjm3Tx/WYV9mF2WDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39830400003)(376002)(136003)(16576012)(66556008)(53546011)(66476007)(44832011)(31696002)(316002)(186003)(38350700002)(38100700002)(8936002)(26005)(66946007)(6486002)(478600001)(4326008)(36756003)(8676002)(6916009)(2616005)(83380400001)(52116002)(956004)(31686004)(2906002)(86362001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVl6SzlsMXNVZWdvUHNYNnhteTJCS1FYM2dYWHFBclRUY01tMlNHV2V0TG1N?=
 =?utf-8?B?SVBFSG5HNFdHKzZrZkF3K1N0cTlYejdiUVZaamVaRURwNmhtR0hlRVc4Q0Np?=
 =?utf-8?B?Nk5hUHhTakZTZFVraSttVGhzcGNPNXhsQmplK1MxOStBMjc4ejJwUUlhcnBB?=
 =?utf-8?B?YVVIYnljZng4V1NodG02RnR3dUZnK0dZUDRHVGFobHIySWJSYkZuaTFSZVdJ?=
 =?utf-8?B?NHlXcUkzUmJOdTlIZW44QVM3N2FvV3I0eTRMajNPY04zb01KVXNsUjVJSUlr?=
 =?utf-8?B?MmdhSU1KL0wxTnFHU0hqZVVlQ0hVR3R1TlpUdUFIeDNLdk5NZUJHQXRJN29k?=
 =?utf-8?B?VmZmTU05d0FxWTFWdmVVbkRzMVdETVJKY29ZUEpYaVNESVAwTHVqNXl3MW0y?=
 =?utf-8?B?SU9tRUd1RnF2KzlSbXFCeGVJQ1hwNjRNald5Y3FCYld6U2pzRjhITWpmaVh5?=
 =?utf-8?B?YVF3TCtVNW1Wa1pNVlJPQy84dlVIRXM3UVU5NkVoRlFkblhWZ0VIR3pES3hr?=
 =?utf-8?B?Yk9FaWVwTE11NTRuN2hTcnlIZnJHd3c1ZFNTSTZMaUxvS2hoSjMya1NkZVRG?=
 =?utf-8?B?NnNGb1J4ZW40R25yYzZnTjVGanViZE81UENyNFdiWGdJRW5pUHQzYWpOVkpV?=
 =?utf-8?B?bUVSajd2T2NUV0RvU0pCQy9IMTRmWVViVWRvRVVZRzFnem5NTDNCK0dvWjlx?=
 =?utf-8?B?MGg0QjRjMUZDZUVFaUE5NC9RZXUycmhBMGZyRGZBRDN0K1V5TklUSm43dTRB?=
 =?utf-8?B?NWV2dDhVUVJBOUNXWFNrQUZTdDFtTEZJQitnUTM2NEFvTEY4QXZkL2E1ZGNL?=
 =?utf-8?B?OTNPNjJ6TkpTK0doa2VjeWR3MnpscVZTQThDV0d3SnpqdFhpazVMdCtwakFF?=
 =?utf-8?B?bXNMcS9hUUFQblM2bjdjVURENW9DMnFib2RSQmlUeXM3Q0xwQXpDQ1F3Q2lH?=
 =?utf-8?B?YVhXbi9CS2E4RXJCb0lwL3NwTHloa3hDSnFJaWoyYnBzMFl6bjNYaWZWYnd3?=
 =?utf-8?B?b2w2ZXJnZWpqS25jdWMzUGVCeGkrTUpHMEtFLy9TNWJSRG1remQ0TnIyQnBs?=
 =?utf-8?B?UVBLUGFkWTUyMTNXL09xaFFUZFNEdUMxUFppYW9hdWhRejNBczNUODE0N3Rl?=
 =?utf-8?B?cWIvZ2RCdHNpUSs2cm54bUZ0R1VLMTBBTVVhdGRDUFdXQkREYkVDZXVSK0RY?=
 =?utf-8?B?VkQ5RW9acU9mUTVTOVcxWmltbDkvVkNKaC9LclpXeVNXNHpsYWVGKzRzWVph?=
 =?utf-8?B?U3dyNC9UUTE1eUdxNFpuNXp6YXJvY0RYbEN3U0lRMDM1VlFDa21qeU5oODBq?=
 =?utf-8?B?VkRPWHdDOG1NVXJma2dPTUQ5SlhQd2c3Ly9ZdURtSFFSNHlsOERaQWtQUEZ1?=
 =?utf-8?B?cHRDa0pDTzJ6di85ZFJ3Z0Ivdm96SEZQSTdIRTV1T1JnOEt4cS9UaHFpcEpD?=
 =?utf-8?B?Snk2bjMxdkdzWG1odERVQXZDWmtVMmZERXZYMlBFOTVRQmNiZGttN1NDaEFS?=
 =?utf-8?B?SEZjVU1MVEVYRVUzVlBGWGRrSWgvSWx1TGRPVkt6MVNHb2FNOVJXWFkvc0dv?=
 =?utf-8?B?R0JYa245YTROV3FJVEJ5SS9mZ1ArL2xvLzJwTzYxR3BvUkxaTEFxN1ZUbU4y?=
 =?utf-8?B?OTV5Q1lLaWY4cEZnZ25hR0FxbldUR05rTEZHNjAyQ1lUOW9xZmhTVGM3WjFN?=
 =?utf-8?B?YlZLd1VOekJ2VGxYOXU0aXVIelJqbEdRWWRoaDdiN1A0dWdtb2xudE5vNTgr?=
 =?utf-8?Q?KXJrk1NiBaZw8LERvK80dNiCU6pk5taO5Wac6qW?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4e0f36-c2e5-4ad2-ceb4-08d96b83c937
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 07:00:01.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoAdCVSUEqZK9PORI9Jr12NfVqxMEWdVFDq5tV9vxIrXu4pWojDGQGz7fp6Gh3DCqfxL7nrZsGyxDPH2xUlknRx6AXssX7nKuroAMEjLtfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2202

Hi Daniel,

On 8/29/21 9:27 PM, Daniel Wagner wrote:
> On Thu, Aug 19, 2021 at 03:40:04PM +0300, Jussi Laakkonen wrote:
>> But the issue is about VPN agent usage actually which is caused by the
>> different - and quite possibly invalid use of VPN agent in our case. We
>> always have an agent connected so that is our OS specific case which after
>> all these years I completely forgot. But after checking with AntiX the issue
>> is completely different. I need to dig into that again.
> 
> So the patches are no needed?
> 

Sorry for the confusion. I think they're needed in order to let vpnd 
know the state connmand is in. The issue was in relying a VPN agent 
being present at all times which was a misunderstanding from our behalf 
because in our case VPNs cannot be connected without an agent.

So yes, I've updated the patches [PATCH v3 1/2] and [PATCH v2 2/2] last 
week, as I took another look on the old code noticed some issues to fix 
as well, which are included in the patches.

Do you want me to send them as one new patch set again or do you have 
some comments on the contents of the patches?

Cheers,
  Jussi
