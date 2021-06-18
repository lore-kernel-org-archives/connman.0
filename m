Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00045.outbound.protection.outlook.com [40.107.0.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EE71
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 17:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyZAZEYeRnDmtXHhiCtgu2KL0zp6xTo9oWtn5jKB14OrKLcw1Uro3WId2BCwSje/vygIOck0ecn+q1Um0BL39cjMZY4U7RAiaCmwWPphH8P9U1Gb51vaTme2W+6eqA0/gp7qS0CV9Sj5nViw6zcTjFPhs18T075jzXY4I2jpca6XDOMV4Wuz+pRryhn1bbWtDr+oaU9+f9O36ggkOKw4I2AqDWIV5ft3B0k1JIKuS7yas1NwOFdub4/MVI3RUiul0hUsnv78IuAxll+MtWH9+vMVCQi0ppdk8+Q1eK82sjkQJYN55SJRx6hjCAlNDpCQsveX9tn/z/PKUbRD1xUGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lijpwDYAfO4P6pvGjzKtWDPOrPuxGip/+vMZPlB4aqM=;
 b=J7S6sY3TG1TIqxDvuHk0KPRSketJE9OqLq9S5RZL49l9gKsZx6q2Yvn6mbama4UF+ZIm85wv/sMnhv8KkAak2GbADFVoE0+nati26R4cni+W7uPtUmabtY+VVh54V+ckPPUMlPvF0CbI9S+uYskUOQRZl1K5FOS4c7zPOaxHl+lH0lSBNBs1UUA9j4msAevaME05l75HQB7w8P98+51QtZY/8A/7UHoagoE+6MrijlI3cUehHe9i4ZppKzDaQgyus1KS+EufXZjcykWP8g8pi+fKt1E5V8ZqP9tB9JiGuui+XQTTf558TLbmojXHL7fI7Yj2AilEkLcv2Fc5E/IwFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lijpwDYAfO4P6pvGjzKtWDPOrPuxGip/+vMZPlB4aqM=;
 b=Dypza1Ty29r5vxjnR9wxZRMkPQqWO6R8mEP67MUU1eR2TgNPclDOdQRZqbMl5J1IKJ3JrfGMdqxFjdq2zYSSsSx2DgzGnfB8si9KqGPCNmztM152LPdukg0XF35uJCDhuJNIavfLZXmB74Xz8T+c63mppc9RF1z7vnKcXMFiJCkN8uULpnZTG50Q6pLMX9s/7lozYjbMZz0OlTi/T/9tURDp0pWzOscalShFASfwxmLcDJzKfKL3iUysrtVxJIzzERfcBiaJlRMk6AfoGXWO+4gaw4ivt6eDaLrRlTpekr039E1OPnRgphf+RQkSok6TuNwCrMyJserVEKhaHixyVw==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from PR1PR06MB6076.eurprd06.prod.outlook.com (2603:10a6:102:d::27)
 by PAXPR06MB7406.eurprd06.prod.outlook.com (2603:10a6:102:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Fri, 18 Jun
 2021 17:53:28 +0000
Received: from PR1PR06MB6076.eurprd06.prod.outlook.com
 ([fe80::1c1f:b489:43f6:973c]) by PR1PR06MB6076.eurprd06.prod.outlook.com
 ([fe80::1c1f:b489:43f6:973c%6]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 17:53:28 +0000
Subject: Re: [PATCH] replace strncopy by memcpy
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)"
 <Emmanuel.VAUTRIN@cpexterne.org>, =?UTF-8?B?THVrw6HFoSBLYXJhcw==?=
 <lukas.karas@centrum.cz>, "connman@lists.linux.dev" <connman@lists.linux.dev>
References: <PR1PR02MB4794D05CFF3F4C689F28ECC0930D9@PR1PR02MB4794.eurprd02.prod.outlook.com>
From: Santtu Lakkala <santtu.lakkala@jolla.com>
Message-ID: <18824313-c5d2-cc30-dcbf-006a82c5ff75@jolla.com>
Date: Fri, 18 Jun 2021 20:53:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <PR1PR02MB4794D05CFF3F4C689F28ECC0930D9@PR1PR02MB4794.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.115.159.133]
X-ClientProxiedBy: HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::27) To PR1PR06MB6076.eurprd06.prod.outlook.com
 (2603:10a6:102:d::27)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.28.172.4] (86.115.159.133) by HE1P18901CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 17:53:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82abdbbc-5fda-4cc6-d734-08d93281fa51
X-MS-TrafficTypeDiagnostic: PAXPR06MB7406:
X-Microsoft-Antispam-PRVS:
	<PAXPR06MB74061A4F7E19640E92BA8CC9970D9@PAXPR06MB7406.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XSS80AWL8dOsdzIUq5fnwNHTdB0WRvZi4OvHi7fs4IaLtvfOHzTOCwSqxeXhiS6leqvr4YEAoQ2DsP2tUrGspO6A/fR/dhsRzG6SMc86y80SkZY+hdRmZ6qP1yIfe5GUw+El34MyyXzFqIrblF8Q57DSQRZVG+h5BgdykPSbcVQqpgqF69AU1V7q0HeYnMRYnu995nWXy6PwgyNFegXth/Nl2JREeYlK4/BkU+ZlAuWtmKZFHhXdh0XkH8zdU+OuaYKyyWw7Brp9M8mxMqcB9RtL6S90Gpt3vySvKQemTxqfjIllhC3kCKeH1LJPq5ZQuUHR3zEpMD0+L0Vh3hHQg6Z89RE941+HojKVcmgXd/5dONt4a05KWw6Fd35b2kaKJg8uf2zAM6Pygy+Nm4igxvecU1wjFmuIzhprTnqgAtCeEsQ1dhf9du97jJPjE7rwpc98CIzFoGv5vlqDpuus0ddt5LUixNJLeujxn6Bd0G3nLuEZ9sYwN8Cg5RLCkQk8yehn+epJIU/ha00+HwxysiDMQRsRbr2URozUsP+bVxNTlFJUqYP0zff8d9w0D0FhRzXBvqqt5xOxlo9Edgcy5kbb3rhJN6W5mPttd4AUZo/paXa6uhyjBMp3vEGcrSkS7M7xCLegEeHAHbg+URIWFaFgBQb7fYauq45xAK3WIt/JjcLNxm8ItQ/H8X4EtZrPqa6RUWakhQTrj5ZEemNaQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB6076.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39830400003)(346002)(136003)(376002)(83380400001)(86362001)(8676002)(478600001)(36756003)(2616005)(38350700002)(956004)(110136005)(31686004)(52116002)(44832011)(186003)(16526019)(66476007)(6486002)(38100700002)(66946007)(66556008)(16576012)(5660300002)(316002)(8936002)(2906002)(26005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?Windows-1252?Q?gjmwdTZOuLcHArJJ4Y6KA5v5bNDaaR0Ox1GMqtSVcGTEG1zDb70GnByh?=
 =?Windows-1252?Q?SZU2n0cpqi/WmCQZWIBjfZKrjqDjJz4qF3ypVKyfuW1hL9fAspweaTt3?=
 =?Windows-1252?Q?gA8bCK15JfwqUc79PTihwyidri2elfMdmaErTWJ4o6QtImL+R7OQhmNf?=
 =?Windows-1252?Q?dtOxLY1WgI+EbjqRm4uJVwwoKXxSA0zdjNw5BRXJW+A68K7GbO7HAmXk?=
 =?Windows-1252?Q?U1W/pKqJ6Muzav4eSzrEvTvk6Tso9u+niXlUN6Y6VTNut+HhOTBJtnK2?=
 =?Windows-1252?Q?wNtP+WPhy5JOoiBnVEB/ErT2rm8hvUdoec4nSwe7FAc4lMJ1+F37b60/?=
 =?Windows-1252?Q?JoNliw4ovq0MUz/9kFPASu2A9quTnYMS9k0U1XPYf2ODnU+jVgPgy5IQ?=
 =?Windows-1252?Q?1tNMD7gd7+JJunLoKT/3i8cjpX3S+pvwv4vW8o1jIkFx3+oVNyjVPaAj?=
 =?Windows-1252?Q?l28InLy1EmkE0dbQb65Imrtf1A8vYQLKu6xRJ7tyFkFlc9ybT7KygYUr?=
 =?Windows-1252?Q?gRI5Qj6LB5xCq+MeRuqWoJDyXprB2e3nTSYpwNw86/FQmryOvfsGuoVe?=
 =?Windows-1252?Q?Pz3sngrWkPCGcD5hMbU6yjKJRmGU09jEkmz4bcgKTycQDucfbtiprxTc?=
 =?Windows-1252?Q?FRsoerz3Qah+W1w28DWWgAVmIHxjgW8bx2uD/4nYo83oKl2cS4z27Eiz?=
 =?Windows-1252?Q?sFHcNzvDeVD49gB+nlyOThMBfmks7gm68e6wRVaSNkDZ+jM+BrWHOOHI?=
 =?Windows-1252?Q?ZwEFvKOYSplvJNKeALsoACpsdG8tJsaCbeycyCFkcCmzRY3Q8FcezlTN?=
 =?Windows-1252?Q?+j83ba7oDjCh9spDSEnGnYBCbL4yC5vZF/mVr3y3qpRP5f5RSpZO9z6d?=
 =?Windows-1252?Q?8lQoTqyFSwtFF6MySMYvzOhsX7V/58E1lVfO9BCRS4J4CTSIK6pO5AFX?=
 =?Windows-1252?Q?x0y3p5p8PcqOlzazNOACXAGWM23UDXJP7JAYOXVNnXO4TnP1mll48FtW?=
 =?Windows-1252?Q?egAmnC3QV8wTBhF7zofK/6LDyEwly2nXk61FTnV5Yv/8foAWY3CbDTc8?=
 =?Windows-1252?Q?Dy6aS1pFXAtGxr7xtQUehBroK434HmHgsBnY/SOPsEzQFPt9eDDjBDJa?=
 =?Windows-1252?Q?oguM0RF6PTD8S8rYZomjKjestbB9T9eCPGT8kZcsfuzhnU8UfCC3p2mN?=
 =?Windows-1252?Q?tdQgKliOlJopnLKuatYJywB9u9WCDIkjU+SL9kRPzUrqqNgi0qQVel8B?=
 =?Windows-1252?Q?W3eJaCxEE5KE8ZjH7wtzNchwz4KVRjoGQC0XmZIkpfo9PxoN0P2NJfNw?=
 =?Windows-1252?Q?71Gd6WFrBohEQI8/FUWtDjrtphiZMjdYIi472WuwzOM+SgBchKmidGw1?=
 =?Windows-1252?Q?nzYnh7tdl3MZKxlKmZJJnpKDTmqJsc3v0W8Atd/NhOFaWXK+ItqGcoG/?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82abdbbc-5fda-4cc6-d734-08d93281fa51
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB6076.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:53:28.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YYIOGsHAbt+T4sXh2GeTbX7mC/uZlzjuX9U0oFPvSswDfU1S3Iar/tfvHAwZ7O/JlDDQlSjNaptvEsHf2yuiFH/vIaf9gqrsiWABVMuM3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7406

On 18.6.2021 15.38, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> Thank you for your patch, but, even if I have not checked the
> related sources, I really doubt about your fix. Maybe it will not
> be a problem, due to the following check:
> if ((uptr + ulen) > uncomp_end)
>   			goto out;
> 
>> memcpy is equivalent to strncpy here as pointed by Santtu.
> Please be careful, no more warning does not always imply that
> the problem has been fixed. The warning has only disappear here
> because you have replaced the call to strncpy by another one.
> memcpy and  strncpy are not equivalent.
> strncpy is dedicated to string processing, and enables to avoid not
> null terminated strings, when the string length is equal to the destination
> buffer size.
> The good fix is just to replace, in the strncpy call,  ulen by  ulen -1 or
> strlen(name).
> If you really want to propose a patch, please refer to the commits
> (sources code + commit message) I mentioned
> (90f0e412569b327d8b25b834623b814f1fddbd19
> & 3dbcc963a66d43e4ac51c97de4fe116ec72eb9f6),
> it will be a better approach.

This is a different warning, this warning is about using strlen(src) as 
strncpy() length argument. I see a few possible fixes to acknowledge the 
warning:
  1) replace strncpy with memcpy (as done in this patch, no change in 
behavior, only theoretically slightly more performant)
  2) replace strncpy with strcpy (available space is already checked)
  3) replace strncpy length argument with available buffer space (would 
unnecessarily zero the buffer to the end)
  4) change the whole paradigm, and do something like:
     uptr += snprintf(uptr, uncomp_end - uptr, "%s", name);
     if (uptr >= uncomp_end)
         goto out;
  5) do 4 with strlcpy, but we don't have that

-- 
Santtu
