Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6068
	for <connman@lists.linux.dev>; Mon, 22 Nov 2021 15:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka4ZKY0YG7ucOoLWxdM9YotaRJ9lpxoPjYqBCRcaRFkf6nQcE6JjlynL2D70As2qT/XVpB0ptMYAZr30rFgTBoc/rKtiVywL68w93hnQdUbnHXIEYRulv+ZvjyuEjoHBWybymeYa76u1YbQwZPM08cclor8FWG4jMVRoBSOwkUAnwIwhzd5wQWTzJc1y3hjCevGnUd96Mkv3+PVDmv44aH3k5fdhmeSb6d2ASimeZL4mu6SUuEPsVtd07He9+qRD+qvqqZQcbv59KHKTuOXH+encI+kafB1iERwJuSqNxYw7nUvVqo+WjLGC21p8CUWqsQ8JLi0DDNR1eN4fNKmrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXpS3+84Ys3fILmsLwQp2mNVQvevbNL5VGSQazLjXSQ=;
 b=HU0lhkO0LXEGRitAVkh0mrsebcPozcJFxlIiF/ofatJ8BWCaTg4jV70Gjj4gZJBbSEom2dAp5yYD22MlKeBaW7eGkHIfsF+D+yv9YTbHY6gSzfZYeeHlq+BuGYSoM7p7QNNlTrvr23NY0/pTx3R7oaDCI6WJV0Zcpohc9PRoRDlx2DK31Un9K6WDHNHKs1XeVWtYm5qDqbMcDFSSp/ZCadX6UiUY6+mtVPztI/EiyL/gxIuIiUKlV1TJ+iVaDIxOsQ9deU4j+B2EJYC6E1dTCrJ5ldNcBZYOwT6g3UY8xHgcpYsT+VBJn+8DGJz9oUMN1TdXPCdUs0uX+aV55E3b7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXpS3+84Ys3fILmsLwQp2mNVQvevbNL5VGSQazLjXSQ=;
 b=J+vhTaXUqc/W0pUMSOcunQLsxU5/Tx1WPlbTUP6V3KvBikIeYXh4+BUo1yDBpb0ppNK4yhVJO57n/qRcDgC5eFnF5FDb9C3UlHAT6MtZh1ApDx29u3lWi22nGypGgqFGefAO0mRUjUsOez+Trt71UpeyA5XviObBAJGUCvGCJMNlZ8tYSsuQF+/tG/Mb7hmYS7/0ioWuCQ0iQfek2zIQKTaP0QYj8US7WlqEElSpLiAFWRBXgXmQZ0ygCpo9wvuazJVJXAg3Pd1G5yvnR2Xh+EP7AlNyXcf48uCQpN28EAupGB6+S0uSMa4/SNOwWlIE3rM6DNaJ3sB8YDnD32HOxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2266.eurprd06.prod.outlook.com (2603:10a6:3:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 15:10:11 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::f4c4:9d6e:a8c3:69d1]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::f4c4:9d6e:a8c3:69d1%3]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 15:10:10 +0000
Subject: Re: [PATCH] ipconfig: Do not enable/disable ipv6 for all ifs
To: Christian Taedcke <christian.taedcke@lemonbeat.com>,
 connman@lists.linux.dev
References: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <eaf58704-04c3-b6be-54b9-88ef707f95d2@jolla.com>
Date: Mon, 22 Nov 2021 17:10:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211122130346.114768-1-christian.taedcke@lemonbeat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::27)
 To HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from [10.8.3.3] (194.110.84.61) by HE1P190CA0038.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 15:10:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d980dbf-689f-4404-7bca-08d9adca2d38
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2266:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB2266A44589AF2A6D79E8F0D3EF9F9@HE1PR0601MB2266.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6C/yjpnufK4B6FMUR5eF2mjZrRsGQMIJ4d5yJL7CE/CwOah+U68DRx5np4Zcfx/TaZm8wDH/oxnqjhjIqK3fuqAd0/7pJHfavHWVPf6strb+es4PPyRDPABdK7AnzU8g29Gdcg82p3CkFDW12td5kL0XLmMaomnrkNhMXyFruEIzFKAFFrC/1oX8oo5sbyCqlhvpxLwnuPeedJggJRNxU8uJ17EzQu03AhdGlCdmN9Q8V7uODz93ma3n51E/MiH3Qd8bvyfJKlrflkx0BSzPP5WUzmChLyU50hw8/SmY5RrFuDfE+grNIS318lYsiPXmHB/Aj4Gu8TV0/RNWFlsnlH0lBM2ScGXnQmBeb9laiyM+QGqLeRX0ZUSDB1KCc4dUlEXQFUbyqzqlAP+O5bA0k75DbI4p6ryCwQ+7RxW3xMxlxJSDfR+LGO4D/DvkyACJuAeQP7GSBuYd5OEkiEFtN0SSp7ixftgCpksbOmTSe/N7jAHwavIw6MWjB2wq/KDTj2vQrRZAJv9hZbY4O+AO7jgx4Kl8Pbukf/ZY6rCULrh1zhiiAinYojI8rN6yX1kYIv1riIj4b0REybMFu6AJxIkJeP90HuSlcdVALtYybjUZnkv6eeQifOPPt71YTSFDJyRLYAxHgzcU3odDbACRbFuLUFlICp2VWmuQFGbZOTW1sfrZ86pTKxQs7NxkJsM8Mcn7vovVVqpXNg43zgfNNaMeByns3TyZOxeu+78qWmQhSVi6eUyAETNxTUOLjJJ2iA9oHaSvA7eZi5g3E6LnpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39830400003)(366004)(346002)(396003)(5660300002)(38100700002)(86362001)(38350700002)(83380400001)(31696002)(66946007)(36756003)(16576012)(8936002)(8676002)(66556008)(66476007)(26005)(53546011)(186003)(316002)(2616005)(508600001)(6486002)(31686004)(52116002)(956004)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uzk5VEdvczQ2Rys1NVAyWlZ2WFRJU0RKcFFNaEUzNVBWdTBGR0dnZUx3QlVp?=
 =?utf-8?B?ZGZ5V01Tc2Uxc2VHQ3l2L3hRSS83VVVqMW1Qb0tMNFRPZmhSUEc5V2lxbXFs?=
 =?utf-8?B?Z2RCZDBDekY4N2dNM1ovMnloRHBxTzQ0TTRnOGhsRmpocXV3MlhhT2ZKa1ZN?=
 =?utf-8?B?eGU0UXYzNVRINjlpNDNsSFNscngvUW5ibDhITHQ2L1Q0b1dvOUVrbmNLWG1B?=
 =?utf-8?B?M0UvaU5wYnA3ekJKNVY5Wkw5aCtmamdBNGl6aUo4RmhsNCtxVHFTVVBmdmJa?=
 =?utf-8?B?SmJPbmVuY3hXVkhYTUtKbHpZVFhBZ0JGcW83eXpYN0ZoMkFhT0tJRDNPaG5X?=
 =?utf-8?B?ZldQa2JNUURralhHT1J1V245ZEl1M2JaWm53Mml2bWRTRnJQU1RkbzlKSCtK?=
 =?utf-8?B?QzJQRkF1cG1TMkZyVzdqdUk2bTJxWitBeTY5Ulc2SlEzR1MveTZhSUk5Tm1u?=
 =?utf-8?B?dkIrSlZZWXFsQWZnSEZRN09Nb1loV3pkSFl6anVJck0vOTVWTXZsYVBqdEZa?=
 =?utf-8?B?SkJDSXY5aVRxNXNkVTRTZldGSTNWYjgxMC94K3lIbkRINjZLZVcxZ0tpNGFI?=
 =?utf-8?B?dFg1MGlWVDBFMUVlRlh1UG9adGNKNFpJZTFPdFJDS3lMdWZ1TlRucGpBZUpP?=
 =?utf-8?B?dnFGUHdJaUhnNksxYzZrVmZYeS9KekxKYzdlR1FwdCsyclRwU3BVZERVVGVB?=
 =?utf-8?B?MmtYLzEzT1BDM2xFSzVlQnNsZ0VWNzNxU1pCV3BkZkZDVThKdnlTenF1QVdl?=
 =?utf-8?B?VzNmUGdxMWJnS1NsUTNEeDhYNUlPZE5YUmVsdlJWV3c1cWJUM2VXVDl1Skl2?=
 =?utf-8?B?dm9aU2l3Ukl4UDl1ZjVoSHhDYnBrT0d0NjRTOVhsbUxZSk92K29tbzVBV0tU?=
 =?utf-8?B?U1lITVNQTngyZzlhQWpya0w1Zjc5Q04wZHBlWCsrVHZtUjg0MDg5Y2Q2Mjg0?=
 =?utf-8?B?UGVuRFJsQW1wUWptRlFRZUcwbS9MbHQyS0FBVHdBZDFET0wrbkR4bkdNSWR4?=
 =?utf-8?B?NjJHbmhzZFloL3hLeEE4VlF5M2RDaS9QejF0cVJiTlZDbUJjQnBMcnhaU2wy?=
 =?utf-8?B?Uk5La1hrZDM1QjFSRUdSajhudnZ2amZiQzdOcGEvQXBjdHlRRHlYL2ZlazFK?=
 =?utf-8?B?T3hhbTRXM1JMaGNlVkJLRm9uVVFXMDVEMkNrYVp0QUZaVUk4SmFxYWY5ZXFr?=
 =?utf-8?B?dy9OZmZqbzRiM2VzRHVsaEEzUlkvSnl5VlUza0IyaFNUOVhqVDRUMjRDaHhN?=
 =?utf-8?B?eExUUFhNa3hUQmVlci8vMnNHcER2NHBSVFRxTlJISzliQzk3MXpEcGN0SkhE?=
 =?utf-8?B?d2d4TWtZQU9EVmtGenI3Rzh6L0NtUS81MEd0SzhaUzJaQjNzL2l4OXZBVlFI?=
 =?utf-8?B?QnhqSVgxNVllTWRLSFJ3MWJEZFlRQ3N3UnJvQkNGMEs5Zld4Z3VkcU5TM0pV?=
 =?utf-8?B?Z2tjOGFHbUxkZjYwVXVtVkJhQkdmM240NVJpdHhJZTNBdG1BN0NEbDI1YW5O?=
 =?utf-8?B?Ykdyb3htdlkvdUJHOUtUdEdwWTEvSWN0WEw2eERheXA4eFFFc0R6VXdJekd1?=
 =?utf-8?B?TG52Q2xndU1iaGNkYkdlK1JiWW9qNkFLNmE3bndzalQwWkJzcURXVDhIUTJ3?=
 =?utf-8?B?U1lVUGtBL0REKytiUUQ4YmJtNTNzbjhhaW1NY0hPSmZkR0lERjVNZ0F2bVVz?=
 =?utf-8?B?STRTbExRZkVScnlqNi9pSlNBeWJLYlJna3RjTXVqREZTZ1VpSTFpcXoycTU1?=
 =?utf-8?B?Qy9wZGovUWpYQ3ZvbGJIdndBeG1lVWw2VXdVQStrdzVKSXEzdTgzR0VtaFMw?=
 =?utf-8?B?cHhOWElaMXY1SGxvYnJzc0tRWk03MUZxTGZJWEZsaEh6NmhaaXdGb0pnTUlq?=
 =?utf-8?B?ZE80aENTWlJwS3NXMWhLSzZPblA2YlQzUnFlTDR4eGhVUFlkS25kTGF3Y2pV?=
 =?utf-8?B?SkQ5MmxhVVBuN2s3MGdad3F0alA2NFE1TnBYdXcvT1NKZkZ0bVQ4ZFhybERl?=
 =?utf-8?B?UnN6R1p6bWJtSnZ4SVlaTXp6QjVVR0prTG9udnBoZWlNL1o5Lytzb0srYmhl?=
 =?utf-8?B?dXJ5TE1HV1ZhdnlDWWhSbDdIOUdxeEcxMHRLdnhxT1ArcWl0enhDdUt0MUla?=
 =?utf-8?B?YTg4Rmg5UWpweUxvV1MvQ2djRXdvYmUwSmZnTTJNWVpuRXNwckNwanhYc0Y5?=
 =?utf-8?B?N1dRYUxmNGdMdUxkK1hhZUt4OTViYXhtNC91UzBVYWxXcml5Y1orU1FRTnZJ?=
 =?utf-8?B?SVpWSlNuNDNuelpCQWJmK05EdkJBPT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d980dbf-689f-4404-7bca-08d9adca2d38
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 15:10:10.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gYCC4oQY792Xtnp2WJY6jSpzJreTDNE6q1tiScDP5ntUtAvUmMYmFrGanE143L+199gFRQZRK/uMKDTljADKMPiGDYVgW5fTfbvMR40b8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2266

Hi Christian,

On 11/22/21 3:03 PM, Christian Taedcke wrote:
> If the interface name could not be determined (e.g. because the usb
> device was unplugged and removed from the system), do not disable ipv6
> for all devices.
> ---
>   src/ipconfig.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index 1551826b..34b1724a 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -1593,6 +1593,9 @@ static void disable_ipv6(struct connman_ipconfig *ipconfig)
>   
>   	ifname = connman_inet_ifname(ipconfig->index);
>   
> +	if (!ifname)
> +	        return;
> +
>   	set_ipv6_state(ifname, false);
>   
>   	g_free(ifname);
> @@ -1612,6 +1615,9 @@ static void enable_ipv6(struct connman_ipconfig *ipconfig)
>   
>   	ifname = connman_inet_ifname(ipconfig->index);
>   
> +	if (!ifname)
> +	        return;
> +
>   	if (ipconfig->method == CONNMAN_IPCONFIG_METHOD_AUTO)
>   		set_ipv6_privacy(ifname, ipconfig->ipv6_privacy_config);
>   
> 

Good find. This indeed fixes this particular issue, IPv6 does seem to 
get disabled after removing a USB ethernet device. Surprising side effect.

With a quick glance I cannot see any problems related to this, I'm not 
100% sure if there is a case where this disable_ipv6() is used via 
__connman_ipconfig_disable_ipv6() to completely disable IPv6, Daniel?

Cheers,
  Jussi
