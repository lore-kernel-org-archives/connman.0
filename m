Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12D2FB2
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 09:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC3HXs19kI86BiHNLRqHWwbSTI1dGkQ/C/fF6Lsx9HAkZ2f/B/wx8CW8M/XBytl4Bk1ePyqbqwp023di2zZNGK+jKOgE8HEzBXnFzj+mjHDBBBQSQxyPxrB5TZt6xwdQhM/dkcVkrx9e4THNq6OPnSo0yBsDasJu6QU+LLc5n4zu3RxgFdyn9EKdi15bHI83O3JvBq/G1B+Oc3ZPnuipoPpygQHfOZ9wL6Bd+ICRtE8aOEytiJ4LlLaKKKX78rJJ6wU6aZgAXdMmnZqIg6QU9MmwOP9911yu5oDcuHmwNcCMOxtil1y1E0IJDYM5tyVF5KYa92qof3v4sT9f38srVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXaj169Rg/52iYru65wiqr4QUu1CdvLHH0JF6Ab6qxQ=;
 b=JP0uuYZmnlBCZB/+//To0WE8vOTa3C2vg3vUiGOnY8kb5Ok6V/UUpKSxQ4xtE3uHQGqfU9ID3GcvX9+wBJXnVE6rsoHiubFbtBC9kBU2ET5yXJj9ALje8bUOpxmghTM1htyMTY5n8b6G0iwOXiqOD0jHtT35S51fsSCl2xbsWYudXiCTFEp1kY3p8gJyWeJgZ7yIZa6xr7MXfbYwjoXFv4bGSfPoJA2kpOd7qIz1ljp40bsrZkhYHu7e4sbHQ7jKvbMP9W3K3TSzDz59RK3sQi9qJXpSd7fRCwpKczMF5eMdV0QCrQ4DNqzZJVUfaQXfc9yg4dqFB1ec7Qv8GVrSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXaj169Rg/52iYru65wiqr4QUu1CdvLHH0JF6Ab6qxQ=;
 b=Gq3G8Sshn/Hj+erSJsCgVuUnlrQgu2nh95njtcvNXWaUeebddjNjSN4OWpB/ne02+vVoRvVU1WgJe9i3g+CdaIrmTGwv4wbHopRBeOJySjzcGAfJGkiwBv0sUbXABwh5OWybamcQIfTzysRWIerItfZbyQWWdGg9OIQYa3uo0pJGAnSoQk50MahsfXWMcUiyS4qL96z63goasbRAYw99GHx3+DuySI4+sW/2hT9X4VraOtxasB6K1OuVUzkZdVaD53xFcLLC+RDpM+80beqQfE9TbCH4Q0rcZJbMI6R7Y37KbUqFiCUUzoKPyoM8Zc4vBy/fqdOA2+AxMCwQkZMFOg==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from PR1PR06MB6076.eurprd06.prod.outlook.com (2603:10a6:102:d::27)
 by PAXPR06MB7919.eurprd06.prod.outlook.com (2603:10a6:102:1a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 09:15:16 +0000
Received: from PR1PR06MB6076.eurprd06.prod.outlook.com
 ([fe80::1c1f:b489:43f6:973c]) by PR1PR06MB6076.eurprd06.prod.outlook.com
 ([fe80::1c1f:b489:43f6:973c%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 09:15:16 +0000
Subject: Re: [PATCH] dnsproxy: Suppress GCC warning stringop-overflow
To: =?UTF-8?B?THVrw6HFoSBLYXJhcw==?= <lukas.karas@centrum.cz>,
 connman@lists.linux.dev
References: <2664831.oeSPPojSJB@latitudemachine>
From: Santtu Lakkala <santtu.lakkala@jolla.com>
Message-ID: <71ce6b97-7f8c-1f0b-4497-41036acd05bd@jolla.com>
Date: Tue, 15 Jun 2021 12:15:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <2664831.oeSPPojSJB@latitudemachine>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.240.145.232]
X-ClientProxiedBy: HE1PR1001CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::15) To PR1PR06MB6076.eurprd06.prod.outlook.com
 (2603:10a6:102:d::27)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.28.172.2] (109.240.145.232) by HE1PR1001CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend Transport; Tue, 15 Jun 2021 09:15:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 435b0215-2e9c-4187-fb79-08d92fde16d8
X-MS-TrafficTypeDiagnostic: PAXPR06MB7919:
X-Microsoft-Antispam-PRVS:
	<PAXPR06MB791925C1BDDF776F64C5BE9E97309@PAXPR06MB7919.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+O5IcZc6pDUOoBY61s6+53ONbCtLeAOr5d9iSNN1JZDgLVsvGot+VNn7+5tcTuOlSJqv/Te5bsEpP5UXCFJ3RV/6S8oO2OLvDjsVpm31NzT78ZE3GGi1mCNzXVd9lnGnmxkbFM/KbkrDd2QawCWyRT7FkNoXg5LjnPNU3/Zhnl+snm7/pwI1cJMkkfV/fNdq7GE9lbX5LIB4HDIOqunfoH1DqA6pnHfuub3JMQST4DKW4IgmH2HFLuf53lnIhwfsiUr6ohFdWcjuXlwyFlFRsP1rJo9Ztwj/jUzbC+mK7tlfWb5+ma8fccCgn7i8nxuEe290Am8jaSf4cE4DeyZ7dJ9fVsrDIaaOnDrLDB8ddB0d+TNKSah8/4qRyz2OhogwLgxiNwMTVVQ6ykXnOYLKLcApmbaeDzevexuqzk8Xgliwx1YkfXxFmd8RoBrPougXxrPqKq0WtU+n4WRJhTIYplfJ30qByRg8iaC3FTeK/wzUW3NUqXu206Nd01uyWrlBpH6hgSZ5gHwGSuK0beqfgF+U4eWVxuu/ZuBJjCudjpX5KhvfknUarh4LSqzz+1O9+Y2zAxMshk/mHGWbZKO3cNSMqwaMzbXQ4WvpmW9f6t1P+j5sl3tr89epd5kNYWlmuHOOsfCs1eiGwefZRHtuuHUBfx5YNDogJaSIvEbrVrwamgE/1omK4drxFWlBNFMm31IooXSsWyPjP58zhru0ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB6076.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(396003)(366004)(376002)(346002)(2906002)(956004)(186003)(5660300002)(86362001)(36756003)(52116002)(2616005)(4744005)(31696002)(6486002)(31686004)(26005)(8676002)(16526019)(66946007)(316002)(16576012)(83380400001)(38100700002)(8936002)(66476007)(38350700002)(44832011)(478600001)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?Windows-1252?Q?nB6/FU30F0Y39SHb8bpzss+xQFy0lj0BwnXAlW5z53YgnVx+dubbmjgd?=
 =?Windows-1252?Q?Roy6AP7IWVZ1LzAcr4ik/Ntzgw1VCG4wQcDBV/dGt/La1+0otcXyo6f6?=
 =?Windows-1252?Q?zOxhV/Hj7xe4TUsBJptlNI3Qc/ImIA4d8E5OJVuAMDiwNpsgR4xC99zK?=
 =?Windows-1252?Q?VK5biJrOZcTXm9JHnqrHCr6vCtqcQ/oSNq1f15UUVAbNRn57AIqCtkEE?=
 =?Windows-1252?Q?QvvNZKj63DjckT9kT4iWxayZokTH1dv55BwsFoHxVav1Nls9zSJypaFS?=
 =?Windows-1252?Q?bfxEWPQsgEoL8o8gHQ0X7t++DjM6GyEvvweJXtfBtpQGSdezYfx0g+lR?=
 =?Windows-1252?Q?OLxw81BAGgTB4+qizvZv/1wZZdw2xbsvJ6IS9ZIhk+1/ss3yhjCsPEJZ?=
 =?Windows-1252?Q?WJ9Q9OGLpM5lXux8OxPEIy+vpYk9/ulCIjV7MUuIYtctLuqsjUYiVPuo?=
 =?Windows-1252?Q?JLEu4VeB0DYS+rHAxfk5FtXlUKjujeNgxACHz8eVYBN2djrVO2dOytIa?=
 =?Windows-1252?Q?nMa5FnN0d219ub3Cn0RNmNMjgdim36bG9o9CT2LLhOz6KhZH+m434wmb?=
 =?Windows-1252?Q?fkUEG9nqDQ6dsOP7APTX+xCoFCLVI370KUpF1+szud2p9WgF03XOf/5H?=
 =?Windows-1252?Q?OwpfKa4vNOI9xnY7wZmbxhMf+GlglP9DpdqL7tADtK2AglKAKLQBxTT7?=
 =?Windows-1252?Q?8My5Y/LYrrOB3+9neSx6hIzQbU9ibOMrppYb3a9rlCc0TskiBF2CfrNz?=
 =?Windows-1252?Q?GvPMddzi6kUloVO7S3PAGi/ooTP6pbkm3y0ivorIgqCbRgyZIjjZ/cQC?=
 =?Windows-1252?Q?BFeHA5eAQEef3pYN1LjiJcehTyzr5UeE6BZ+sN1fQQyMhurNm1z9b7VS?=
 =?Windows-1252?Q?oBTdhZMhqMiwqEQ1n+2L17nSEapWPWQbvHK/9mrsvS69szZOP7sOk66D?=
 =?Windows-1252?Q?f9MXtqjsd4TdKsJVKsX2ICQG9+uVbDV4j4egphqROe+slLV+1JURs9iP?=
 =?Windows-1252?Q?7HDod534i7BZK5d95sGx+dP07KVpjzc/HAxlVQfkPTVRqtnkgMMs+cad?=
 =?Windows-1252?Q?nEPnyb1+6uX382ZVPnBdl63Lb00RCiFK0SJ+qZPofukDbiRBtasiuze5?=
 =?Windows-1252?Q?yMbC3nODZ8mp5R142qoPq70ujBjmf6D13TPBr4kQSRMvo84TcQiT8H98?=
 =?Windows-1252?Q?Q+E0eENU32pMA6y4HgAT/89kB+66FYpTGnOrBNToNP0rfbCGR8+xxylU?=
 =?Windows-1252?Q?Mdx/QawgtWUP3beEL1CsHagXv1X9FRKK76iM9koCtUTl8awUXMzKq9pp?=
 =?Windows-1252?Q?4EBkyRqMHnDe0IKJqcrpNT+ejOmNsrQRUQNzGmDmo9WqqsNgWYbFnZhC?=
 =?Windows-1252?Q?5jG6+YPHpL/mLD4cSz8D8Iat2/MBf+74zMbRHYYMrYUsdy+FVd8AMDpO?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435b0215-2e9c-4187-fb79-08d92fde16d8
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB6076.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 09:15:16.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRKVw9BK6DkRaef/wmWNrsqS5hfWxuDprGXh8YPhCGW66Lz1BU83wKd8h3bd/8K+QSt5Yjbw+5JtVx2piZjhoXih0UcLekE4CWNa/XdjgsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7919

On 15.6.2021 10.40, Lukáš Karas wrote:
> Recently added check for buffer size breaks build
> with GCC 10.3.0, its internal analysis suspect that code
> is not correct. Build fails with error:
> 
>    '__builtin_strncpy' specified bound depends on the length
>    of the source argument [-Werror=stringop-overflow=]
> 
> on src/dnsproxy.c:1794
> 
> I not sure if suppressing compiler warning is a good practice
> in Connman, but it fixes build for me :-)

I would say replacing the strncpy call with a memcpy call would be a 
better approach. Since all the checks have already been done before the 
call there's no functional difference, but the compiler wouldn't need to 
complain about the logic (while from security PoV there's no issue, the 
warning from the compiler has certain merit).

-- 
Santtu
