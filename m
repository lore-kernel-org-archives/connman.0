Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A235C9B
	for <connman@lists.linux.dev>; Fri, 25 Nov 2022 15:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyXWdZwvQNWvDK9yMGXSF44fSB7HVY593gMFLpWCUr8a9Br33aWxMEoNzGRNHe6hqAb6yKJT6nfOtZehLGvHPtsZpOYQG0NbPobCgaR7wg3zdd7Yg71K/PB9Q/vmFRNO0lR4HNykKM0VYnuBvxljhAR8bMMK4bGnUXCpmJsWzBb4fHhm93rNEX3BUDnoku1rYcOHxG6vG84ebVNrnqS99MNf+LLt2AhGaiiVZNZjpd3dhb46ItsFqqzbnsbRIJJFJRlCFkdI29XOCgw+TkOIIH/sMCzakXct+AawJBMGvuuYLMcJQ1ITVDZbQNfukX41+lBnax8bk2LZCXv8n281pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=SnG84+yTkX79XFwpXM50sgXuEcwZHQN/y8JRZXImyeQw3eri5P/6VsSBtyBRfUlQwbfpxy6wVdiUBS/49ffgfNO+2fI75bIiNf4cg+yLKQL1akaNbzCvoJjzGyvB/Xn2fBEcxBwOQks86/fGfs+D6T/Zkhz0b74Sfw/mxeFTHaSnOuylcLAkZtgNjVd8Um8qB9V+hFrJcpDbcNF7zRReaaJRaZHfX+qFJ0tQwHTBdFKJrpA/n+YEQUZPU/XSPHhaXX2r3C9Om7faQJaxj08UudhxJKEnI7tRqtDfb545mPaat3gnk6HXvrtkB71ZQnWym7A93NGNDMR3S62DP9ksxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=jLvWY3EXn4fm0Vbd+2wwOZF+A5uAfYcUiR43mSNTQYY6621ovAGC7PhYSDQTLXqgd7AdO9Izx+viAQDEfU3MILwmrlTwjq2jjzqE+qFphJxruASVP/XgfiX08L+diwrGrDtDK5RWJ5L1w0BFGpF2eqmoFtPpv6TifOwoHOA144dVRgSglRNIymVrpkUsNpytbQ1b3pEPtUkWK0PQpssTUGFMW8v89SgbK5U1U/7ge6B9aQohSJjOEYs3cVxcSAU/dCZMASQnxc8Y0c2km+/YqyYOq8WuyOgnVb5iBoMzd5tcrUnnBdzNgvY8cndI2Ohkaj0JGha/MYnKARdkaMV4tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAVPR10MB6791.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2fe::11)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 15:15:20 +0000
Received: from PAVPR10MB6791.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::db1d:ba01:a16c:da71]) by PAVPR10MB6791.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::db1d:ba01:a16c:da71%5]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 15:15:20 +0000
Message-ID: <264301e8-d522-62f5-99aa-5f9fc7aaf9f9@siemens.com>
Date: Fri, 25 Nov 2022 15:15:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
To: connman@lists.linux.dev
From: Jim Baxter <jim.baxter@siemens.com>
Organization: Siemens Digital Industries Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0802CA0030.eurprd08.prod.outlook.com
 (2603:10a6:4:a3::16) To PAVPR10MB6791.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2fe::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR10MB6791:EE_|AS8PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 650ce579-6411-44f8-bfa6-08dacef7dcdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GNqB7H/fI94HskBOLrgfz/jlMLU6yHGAFGL8Qn2ZbYitzAvCz8m2aqApp9+3Hu3DkTJ3UJE7pRB4ydorERSQAf+rYNM6LnQSafwNyrBGNyLZRMDMdy/cAHaJcrTphDw4FUodvPIm3Ehlu8shnZpzus/ouBCn9wxtsL/lAg3iEguCJaZE/afSZZuggMrKWP9Ly505bVK65wEoN6O/K2Jtc5ZRNPLtzVVVw4SabeS8ljlfUopRX2cvr2eZ5UWDNnO1Al2qjSXpSjRrjJrG5Ppuw6UP5tZw7Ao1TCXcIzljUicK2MlzvmvQJOyvzGiKhfvzyr9vALVPldq66+n6Eboy4PLixdgC3RozYHcebqmqMFw9C1/ba2wtpzyoXyjPv+YU5MtgSRfDXsRqApKFFLAIu7VrvgwLogoHUwdGSyphEGj2iZTdgNJm1ZqnqDho/NHefWqC3GGbRVRtGk9gB9rc/rt5XfG5ZMow/9FFVV+zDwS6wDY+aMewT5vvj353wmMni7dbatJL13Bmk+CCHs6LZTe5bTMvq0VlCGmJnjulrKB/+Ml9a9eZDlTUrU7t9dfCt8NRCzkGfRb6wAAeAEc+PTmaw2vXFzh12JeHik8wEJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB6791.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(19618925003)(82960400001)(478600001)(38100700002)(2906002)(36916002)(6486002)(36756003)(41300700001)(66946007)(66476007)(66556008)(86362001)(31696002)(8936002)(6916009)(558084003)(316002)(31686004)(2616005)(44832011)(186003)(6666004)(6506007)(6512007)(26005)(25626002)(43740500002)(45980500001)(421364004)(239884005)(425394004)(19559445001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emhpNVdzSFBIQjFycmNRbEtSRVAxNWpSNkZFRTIza2pJbllXZXZIYmNxM29p?=
 =?utf-8?B?MENaaGFhMUwwbENxVjB1NUFOVGU3ZUpjemNqaEgzWW5yZTAzQmQ4aTF3dkQw?=
 =?utf-8?B?QTgrVVFJVzd3RThuaWFFTmhpRUJUK2t0TE52WGlaRTRXY0wrbncwZXhYRFQ2?=
 =?utf-8?B?V0o4MXh2bzBtRWlDUG1rR09JbmtXeU9ITHBNMlAzREtXTm5VSTlvVm9oQ1lQ?=
 =?utf-8?B?Y2MyaGxUd2w3K2c1bGtPdERnVURHVDloOEUwVmNQeXFrWGhiSDYwNlI3UU9w?=
 =?utf-8?B?aVVGRDVlT0p3Wm16NExPeUtyRXQ5dklqYkwwK2JBWnpheDdzZkQ5U0wwdVhB?=
 =?utf-8?B?K0I3TlBtYkh4eEdDZjZTOHNMVHkxTitMK1gyRUhvaXVQZGJFOHBSRUErK0dJ?=
 =?utf-8?B?WXZxbnlHNVN5SVJlOWlwTHZONWlOU3psTWhiZGhsbXRqaEJzTUdZemRMK2Na?=
 =?utf-8?B?WStVcm9KV2NNZE55VXhlNXpFdGh5V2JXTjVVanNEWVRXa2t6VGRRRThZOHEv?=
 =?utf-8?B?dngxaXAyd0JVTURuN0dIZ0d5Yk5WZERZemZ4eFdVUXl4N29pcDMxWWJVcm8y?=
 =?utf-8?B?cnlrNGlhZ2RDTkxtR0NpaWVoT01JZCtrSSszQjVkRHhEcDd1ZkVLNk5sSEZI?=
 =?utf-8?B?ZVdYUW93cGhyMkpYUUJHQ1FZcEpMTENtYXZ6aldaa2UyVkJPVTl2UkZKWlhi?=
 =?utf-8?B?VG5HYTk2UDBZa3JEM0JXQmEzY2tYdnBra29ZVnVDWnFER2sxaFhINUZ1RWVM?=
 =?utf-8?B?NGhDc1FCTnprTlVrM2oxeUtjcWZMSlVkWmlHeU5EcmxtUHZ3MTFWcFVHRk5i?=
 =?utf-8?B?MC96Z1BMK0ZUcWtMUDZZMWVvVnE4ZlNNRGRUTkF6RlNKODB0c2dUTUJ2Nity?=
 =?utf-8?B?OThpYVBia2ovbnpyblVjZjFxUkxIendzNCtLUmJLVlFBT3dwZUlSOVhKTmt0?=
 =?utf-8?B?blFvZ0Y3b05SRHlma1NiZWJZSFQ5dVNyQmhIeWw2NEV5SjQ2QVBDWnFxMnZN?=
 =?utf-8?B?bmZWam1oUTRsdnlrdGlSYXJmb3VhUjVQTTRSTWVYNW82eXJhZFplQk9vTjRF?=
 =?utf-8?B?SzEwTE1PZEZ2aEN6TkROeSsrR01sdEFWN1ErbEhvbnNIUS83V1ZSQmoyYW44?=
 =?utf-8?B?dk5CMVlHamU0WHR2QlJjRUNJMjFOZHBlSWVacFp0VS9sWC9ZVzNKdkxvd1B3?=
 =?utf-8?B?cTNaeGdIUzFJb1RvUk5jUk4xM2kxYkZyUExydmdneTMwVTIwb0o3L2hDYzZ3?=
 =?utf-8?B?N2lKTnlWYjJGeU9mNnRrekZQUndJNEUzRUJldU5GKzlMTW9sM29FOTQvVUJG?=
 =?utf-8?B?cXdieE5Ec29qdzJrMTZHSGZsZGh6bDZLUUEyVjkyRlVEcEpVNURFMG5kakdJ?=
 =?utf-8?B?REozdXRkWWgrdWx4NGExSk1NWDNVVUxadmQyTTNJMklZOE92TXZ6NTVYOElX?=
 =?utf-8?B?aERDL2JlT00rQzB4M0ZPeXp0MnE3SC9QQWE0dzhLaGVvbytuU0YxcysxdFM4?=
 =?utf-8?B?L1Roakc0b1M5RXpMZFZ4K0p0MVNBSE04a0s4UEpBQnZMQzhvN0xBTTdYQm51?=
 =?utf-8?B?R3JudUFZNEwrZ28vY1JCanRKU2UwdVhOL0VhM0hESEtZWXVTRjZZN0lDU2xS?=
 =?utf-8?B?N3R0cFBPakJmdVBGVkFzeWIvQXpJRjFVNVZsL1plQ2F1SlJyQXFsOVpCSVps?=
 =?utf-8?B?d1FLdFdpUGJ0NG1ITmhCMW1xQmUxa3Z6eFNtZ21ieWRCUTFyRmNLS29panBo?=
 =?utf-8?B?UGx5YTFQNnp3TVUzeml6WGM0V0FnWTh1WkU1RXhLYi9heUpyekJERUZjRngw?=
 =?utf-8?B?N0Nsd1J4UUhuWlhCK04rdGx5aExZS05jQWhub1NwWG5Ya2ZZekhmK3hPVXlN?=
 =?utf-8?B?MEt1NVJ2Rk5VSE9KdENpcFRGMExXRFQ3eDMraWFYM3ljN3dvVmpXWjA3UVZX?=
 =?utf-8?B?SDRyNUJLUVlYaTAvbk9HN3lPQkgyVm9jT2hPUVdjMVphSWNEYTJBUFJPc3or?=
 =?utf-8?B?YnJ0MXFMdWttMC8rWGJ2TmhCYUtKcWh0ZlVHZFlDSFY1NU9MRFgwUUtid1Rv?=
 =?utf-8?B?RTNORkZBblhaMlRLaExCaGJnMU9JNmZLSWNuV2ZUeHFNdlFaKzJSUzV1L1J1?=
 =?utf-8?Q?Rz8ZwHcwuSs1XKpQrZ14AT2Et?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650ce579-6411-44f8-bfa6-08dacef7dcdb
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB6791.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 15:15:20.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gv6IHIHBilK+VBTB2vWOQNxoa91hCXq35Etqf4PSfb62q12MFdneCx3OGY3LFJmNMGCeaTV2HVvT0eJa7aatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664

subscribe
