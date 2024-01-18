Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFABE7F
	for <connman@lists.linux.dev>; Thu, 18 Jan 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575854; cv=fail; b=jD2M3FI2ZhBCObl7X6IWixNFdzs2gAyUjTvR+ZyJNYpUC2sN2QSPI8yJN/zaMaOPHA3NwMwOvnpgx0nQ4C3MPylQzfsjX7yFLnzxSPU9WIyv/G+JbfOzUEYyVXLpqvDCaBpeO5hBbXCSoHp50FZsEDSuhjJHTTi3qek59kzqrDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575854; c=relaxed/simple;
	bh=GzjQpuCjgoN1IGe4UZ1yzYyObNpwL0ROmQWbjOYbxYM=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=etXizrc1YdO/VH99u++CR+3h2LvSn3bRPIYfy4TFVyDi/38x7Gk35BvRiR2vUsxAZC4yOAitC7qbPOf5NNNvgH+LBU/HXjrwGOZaIGWmXaQ+cEGsHvENXPoU0AQzONgWkXkSLmueNwSDDF8WHaojVb0j75cQt+pgkIKFIQwcM58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=sKnB74wO; arc=fail smtp.client-ip=40.107.247.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="sKnB74wO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu+G1nUDA8mrZec+LW3wjeCD+XkHt5QCAM29Omm+J+3zwKBR5v6jW+Nhiip2mlYg6hTjhC3F9KTwi7agSSYDhncuU/80O99/WGKMVu/fW/1dTiS6Ci6nNs5hDMv+3Tlx1igkNu20rvYk7EXgTIiMn1qq1e+sLYJqG5+bM7g7xPlO0qDGH+RK/t3les7yoF8/SI1iPZp/c4eyXOVlrP2HR0ExQ3P+lVADP88bB+geXmCkQdlUu1T++D1R+fSiYU9jOB0dMyiTnvzYOQ+HO348y2foH5aT5nKBQvBPEtMs7fW36dbj+ItAjVzsbVjnvuCqahVctXKUatUNBrD011ahiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiLmRJ3inSP1LQrPSgq5Q5fKvv7mHjFEig86gdR+oCQ=;
 b=M1aTWCjZVcTa7jcVDfcDJTx6a7oGNMxI0V3+wAOU9RoX7TrRnSeNvCTD0J2QxMy4i6OeG/HO51a6GJDBMNs33Gc0bJ7fCSweZGq0e5EhweT3IxaUyZj2e6O5Zk7brVRcj7sfEfJuytKyun0U6kDh6++NjeKBihSbw/1xuy2MIFBE1B5Nrlm89p7rn1QMNZIneUkzyo+c7RLBgfcsXVOPac6BSl1XpYvw0mYEFCKcNpFEWPjSRF0H1sh0wFWmgkrpjM83jhV3Dk+crmYdtGkbr8oWT7ljtOKxcjsOR7FyBQI0miwgHSWlwfgv0lVyeoq15dfvxfe3wFoUqu7fnD8NiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiLmRJ3inSP1LQrPSgq5Q5fKvv7mHjFEig86gdR+oCQ=;
 b=sKnB74wOpVWnb4Ypn5XuxGk5VrgpBoK0uUxiP6jJQOv/fggowv3bV1iNzEfnjMboS5QS9DRn4eRyyOrLjDqhVHNUvyoNnKIyMsFdYObUR1Z7wajgxCTcHxpROeCsifO89F+VCAgARC1jll2xtXkUxRoOI56nu66+kcGFK44hmJyQDze/eIi8wWetrT2MnXR4d92VAzk1JVpaTOivzTAjMi+SPPoGr05UoZ9QGquek+eEihAROj27ZXPTRvz4OjR61WrCyCrM0v+UVJkSFz3pYdaOstTPOlrI6FAsMgero4nt1+KBDgs0kdwMIZ73t13qK0yghYeeCXlJ4E9cRz8bRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by PAWPR06MB8859.eurprd06.prod.outlook.com (2603:10a6:102:382::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 11:04:09 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::1a8:462f:5146:101d]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::1a8:462f:5146:101d%7]) with mapi id 15.20.7181.027; Thu, 18 Jan 2024
 11:04:08 +0000
Message-ID: <646d13e6-9a42-4402-9e5b-35d71b62fa9c@jolla.com>
Date: Thu, 18 Jan 2024 13:04:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] src/log.c: Include libgen.h for basename API
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, Khem Raj <raj.khem@gmail.com>
Cc: connman@lists.linux.dev
References: <20240102015917.3732089-1-raj.khem@gmail.com>
 <11C7A018-4C79-4F26-BCD8-64FC644DD58E@holtmann.org>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <11C7A018-4C79-4F26-BCD8-64FC644DD58E@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF000000FF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:9) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|PAWPR06MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: c24ac87b-de59-468e-b43f-08dc1815317f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q0gHZ2jerHHmqSJiED64JP31bTdnaNKd4K2EVtNQHFUq8Pd7edPl7lWkDIRcI0/HXJMcACKR7ocP4dd5S4JJDkYxPtyvT2UR/vqPcNgaY8o5EfEo+VRZ3urIvAWoolhaB6korOXOYYqREAFP5vFJq2pO19Hjj9KuBP7xV6VZG9/yIKkE0x3Yy1K43z8rF/2B0MerzXhttDTJDor5PO2HpfqdMf3tjlhfSm+tC5nc4euFXJpgOZhvfjeMzRkYcTOdxhUgeStL4guSnT1iTgkFP47G38W69uS5VEWelHRvYJlRORe1RwiSOs/pOtLnqJRznzAyNEpUEnxfomyskH85xE05yJ/RlBP/H9xz2FmzOYVQeYgm6HqMCY1lapG3f14rmNmReXsBwa7crfTmkD5E9QM9b7n4UxZGNd0TYh8axA4Is5v8LFPj/nlLeLHTzryCJC87TN5kKriTDsmh3qhFTRc9sLC2TbR41KL0OpP7E6xXV6uQ02McpC66ke9OFYXq9Cl8Ip1Cj2j8vIbQgdDzC0NZEYrEP1+s6OMIsVlEkngY4vWnZdIdE2SaScLwrt2fKml5sgfIgVNBHiC6zK+7H8e557jKHi8Rpz3ki8UAUsoHlrdz8AqhmcU8nE7IMJYSqkRW+N3cSdMVmL5xKVo8dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39830400003)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(2906002)(36756003)(31696002)(86362001)(41300700001)(110136005)(53546011)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6506007)(6486002)(966005)(8676002)(4326008)(5660300002)(83380400001)(8936002)(2616005)(26005)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0wzbHNKanNmK3BrTWRHTm9PZWJjbVMzQWdQaTB0Z21pdXpUSHdCaWtJeVVE?=
 =?utf-8?B?TXM4THczOWg4TzBZMHpCSnVyMVRaL2luRkVwTEJvRy9Ia3JBUDRGVFZ3KzRC?=
 =?utf-8?B?ckdCZk9OUkpTT1pnclcvQ01lUlJLRGNqb0FGeW8wbk4zT2xhVlJkZVhxdnlR?=
 =?utf-8?B?UmJWbjhhUW0rWnBzQ203Z2RSdmdtYXZhakNqSmZZNnJJV25sc3ZPeEZvWndy?=
 =?utf-8?B?REM1MzdFRDZnck5iZXZwM0NFYzVZU3RkMlhMTmpFQUxtSG1tQkJtL09EbFE2?=
 =?utf-8?B?YnM0M0NYYmVGc2pmbnRnSHlkbmtpV1dWYnZmc1RQQ2pEOVI4TDdXOFhIeVFF?=
 =?utf-8?B?eG9QNm51dTl4QURjKzd1Z0NENmVNTFpxWkxuK1R2L0lmSDVyYmI5ODZWUEw2?=
 =?utf-8?B?MlZyWmpyS0k2dFlqVUtJdytwcTVYUWowSzVoQmUySUhrUjhya3gyeUc1azBN?=
 =?utf-8?B?ZzRxNjdVWHpzdWNKSFZSWG1wYlpHV0h1ckhXTWQ1VFpyRFpZeFVYMW9ZMkhq?=
 =?utf-8?B?cHdncGh6ODdtdEIrVWJyVWdBdlFyNW1URFVRZm5qcUNRSGNPK0hsSXVqeUZS?=
 =?utf-8?B?ZzJ5M3dZdkhMbHVJNFRXOXJkOGFXcE5iS0dmaFBoOGJjRUJaVS8zY29sa2ZZ?=
 =?utf-8?B?U0t0aEN3aHFiTGUybUVoUGhxQ0xCYXpDNHVzdVkvdld0L1Vrc1pYUHFwQjMw?=
 =?utf-8?B?d2xud3M0Q3JOSlpLOSt2OGhUWUVjVzZ0T1dtZjZFTWFRYVkyN21KblViaW43?=
 =?utf-8?B?RXRIRVpHSnEyOFFMNU9aTmhreWpyUWNSQmpoWVBpZUFBYkJ3MkNZbUhIdkdm?=
 =?utf-8?B?SVF4WXROck5ZTW80cEUrU3RLTmppTE1GUURrSElXbXRIdzUzNmk4ZXJRZkw4?=
 =?utf-8?B?NXF2VERXVFM1U2RCL2VMRjd2eFNzTkxDNWgzTU5lSHdXMjFwMFNVdEFySW5U?=
 =?utf-8?B?bUpSNDFJWml1WTZkNW1XY0tQdVVDN3FmeVN1enJVSXc4ZlBJRm5OSWRDSnZy?=
 =?utf-8?B?VHZkR2JjaWk1bm4yMUN4Q3lIbUxnVk5QVnplZHFOTStuSTNxd0ZGM0NKcS9t?=
 =?utf-8?B?cmxhMC9ZTVdQcjNpaWdiMlQzYW52R3JyZm1yTUd5dXBZdDN3MWZRa29ITG1r?=
 =?utf-8?B?c3laRlVpdEJkaDRzOHZkU1FJcWNla1p4WW83cjYrZml1VU5tY292VUVOTi9J?=
 =?utf-8?B?VnRsSG1uUjZROHE5c2xyVHRjeUdsYm9OOGF1OE9mbCswLzBNdXZjM2t3WTVE?=
 =?utf-8?B?a3hML3pxOHFMRHc1WXJFc0NpeXpwVENLb05JdUtQOHpETW9TTXU0YmtPelJO?=
 =?utf-8?B?OTJ0cFdIcWozSnpqUVg2N3U2c0x0T0VNNUY2ek5tTlR5UXFhUXJkOEJ4Ym82?=
 =?utf-8?B?MTVES0tSU09tMFNwSlJkNFl2TjhHNVM5dStkaXVOYzhhR2VGSDlTSjViVGZq?=
 =?utf-8?B?N05RWG5DcmdBNXozUittTWNLclJ3T0lyeFYwVVlhcFFGakJXZVhUbkl2Z2h1?=
 =?utf-8?B?Z09GVXNTb2RKRWZVS29uRjJCb3p5dis5U3NuWXFUamZDOGJ4SFRqVEZ1VWJB?=
 =?utf-8?B?NFA5NWVnMG5wdllDb0NJR1pzK0swZERZUUZkZTd0bjJrRCs5N3RadlZLZ2Z5?=
 =?utf-8?B?MkVFT2hvNmw5TFllK1BvWC9kZGxWM25nM1NId3dhUlF2bTJRd3V3VTFJNzdo?=
 =?utf-8?B?bGdxRzZwOHJ4OEpIeDQ4elNxVE90MFJndGlpR3o3ZHRzeDVPdi9HcVZMTVVy?=
 =?utf-8?B?Mk5vNEc1SUlEME9uZGFhcm16SjdtKzBFU0lUbHBLcTJNcm1lWXJZK25ZbVhG?=
 =?utf-8?B?REJueldHOHliS1RUeUE5SnRTNlpGQ0hIY0x1MFlEWHpRVDBsREp3MGNacldB?=
 =?utf-8?B?VGFCVi9DRnNEMFVKSlZielJWN1E4OWdvZmt3blpTZTdUUmRKUFJGc3F1d2lO?=
 =?utf-8?B?UHMweU9paDZJQ2hSRmQrQTZTdk5OaHBXT2lUR0d6Y2d2RmxvdUVkV1ludjU2?=
 =?utf-8?B?Yjk3anlQb3dvcnMvc2JZTmFJczFWMlFSQ0JhMEMyK25qMWpNZUFjcmpsOXJh?=
 =?utf-8?B?cE5FbmhXNXAxWkdERVo2SCt0L1hJSW02UGFjYUVqRHl1WHFXdmFvc3NFbFJJ?=
 =?utf-8?B?bFI2K1YxRXRnMldaSHM2VXpsY2FKL3l2S0w0NzRodW93Ymx5Tld0SC9odXhw?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ac87b-de59-468e-b43f-08dc1815317f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 11:04:08.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLscJNYfIYY95DEWSJM53gvflmJ2qIZZ2qG5b5spQWPDH56tWQPyqF5idVNFMlZLVSDLE9taQ3Lw+QYL9a65NIJeCbrBAtIcifi3ZzB2Rmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8859

Hi all,

On 1/15/24 09:56, Marcel Holtmann wrote:
> Hi Khem,
> 
>> Use POSIX version of basename. This comes to front with latest musl
>> which dropped the declaration from string.h [1] it fails to build with
>> clang-17+ because it treats implicit function declaration as error.
>>
>> Fix it by applying the basename on a copy of string since posix version
>> may modify the input string.
>>
>> [1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
>>
>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>> ---
>> v2: Fix formatting
>>
>> src/log.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/log.c b/src/log.c
>> index 554b046..2df3af7 100644
>> --- a/src/log.c
>> +++ b/src/log.c
>> @@ -24,6 +24,7 @@
>> #endif
>>
>> #include <stdio.h>
>> +#include <libgen.h>
>> #include <unistd.h>
>> #include <stdarg.h>
>> #include <stdlib.h>
>> @@ -196,6 +197,7 @@ int __connman_log_init(const char *program, const char *debug,
>> const char *program_name, const char *program_version)
>> {
>> static char path[PATH_MAX];
>> + char* tmp = strdup(program); >
> declaration are char *tmp;
> 

And perhaps use g_strdup() instead? coding-style.txt indirectly refers 
to use of g_ functions when available, as it is done with the rest of 
the codebase. Also, when small allocations fail the program should crash 
(M8).


>> int option = LOG_NDELAY | LOG_PID;
>>
>> program_exec = program;
>> @@ -212,8 +214,8 @@ int __connman_log_init(const char *program, const char *debug,
>> if (backtrace)
>> signal_setup(signal_handler);
>>
>> - openlog(basename(program), option, LOG_DAEMON);
>> -
> 
> Put the strdup here.
> 
> And you need to handle tmp == NULL since then it seems basename returns a constant “.”.
> 
>> + openlog(basename(tmp), option, LOG_DAEMON);
>> + free(tmp);
> 

I was just thinking maybe it would be better to handle the duplication 
of the program name, argv[0] in main.c (both connmand and vpnd), where 
it is given as initialization arg to __connman_log_init()?

Cheers,
  Jussi
