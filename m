Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020118.outbound.protection.outlook.com [52.101.84.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FE3370FA
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432999; cv=fail; b=T94kV/3ZYhl7NYhoW0hhkmCRCPQFQjPiaGJKutBEtoVzJau+9GSziRssh7V95y8I96PGeU3RT/PFqBV2ZqhDiBl1izoqkvHj375m5e4WaN6QE9OuOpZD5/4FB+eeneAWeF+SHzDrmRNK5TD0rpTWyD+e2T/kQNzUvntEfHfX1Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432999; c=relaxed/simple;
	bh=1jkq7lABG0AAV9tE7veU6jlzEXHRCPVtGYJq+ooNYm0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HeL/Nt+bTjcbNwInzm7fn3xs9+jFxdgRZ+Ps+hBG3G92ufC5r0vckwk2HjyHhLKoeBb/gUfkteKoIpecKF2KDi9OzpCcQV6gR7ejQK1iJbk6S7jyfk5VvW0fp63XxDLrpGHDyRZ4W8HaWOzSbRzZHF3WsY09a5VZhAY/GkRmRjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=bIGDau2C; arc=fail smtp.client-ip=52.101.84.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="bIGDau2C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOR189ugTDhsfenVtEUy2hFWms/+HruQLGjFlTwnOHhSuFoSZTe7AnF9ewvfQ2HsZG5jsJExgTJRKM7gRPBASe+I26t64B5ePa2ZrJzrHC6aUlFULY19xTPY9Hs1Y2RKeoh0TpaCDJfH7t5RkJxMdtragc4B6WpUWsSpDKGRl3QlxKuOGlkPmctQURiWNLRvxSnJrlcXBFe3z5jpVW2RrblXzuKHyKBAU53JQygAtTaBY6Ny9tiSF8SsKzshcIChufXMEMO0E5YNMT5q0Kwz823beVoqoHcQ4xLORlYpIyFs69LhzK5q7WIISAhcvCvWmSSWkU9k02teCTq8qo/Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uWnQYokN/hr6yHyf0kEvn3fWwLwOJGEYuPRTKozx/c=;
 b=oP8AJzxvjU0NgGoXtcrlhiy+RkjChCiYA2K4d813RTXc2a2Xos+RZUMXy0+W47wQFsEI76qqwInZ5U7oPh/N4YdVuTZeGsTB3ktd1P5Jh4JCVt7DHpcTF/vjXsj3Cj0oWJIdwcUTZ8yK0UgXzEtCjmnvG7HyQF1jYPBtW7e579RBNUooOiChD1hhyyyHTw5Mr+D1Hh9QjLTG3HgnADhJPzzbAKTs/MgEZg1cBhsDkS5bAZaV5REZ/cJZJwQ3e0/twIy9AjWlqhHgR99Ry+nKf/UJkpfmHA2wVqsfFhB2i7KBfeg/dB4yurqTbCI26XEb2gp3/ZNfsoIMHNyCZrjAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uWnQYokN/hr6yHyf0kEvn3fWwLwOJGEYuPRTKozx/c=;
 b=bIGDau2CeXfi+QD6qz54dsJCt0wQcchGuQShDTwhpPR5F+XoIS3Y/EyXuJM38UWVowYUuboSqmFhGRWJfpQQywG+RQ7WWIOW90ElKmMrnV64JhOA9RbvIY63qReJMrPxjusHLznhwXnqJqGgo67yXbe5kII696XVeWiDEW5V6yHMqJLgh/R3DC4Np1zjxYWmPZZuCAXoLODAnZW88VnvxteJhZ71awT5VIHpdBlPbecOmEKvImYwhVl1qTuT5KmnEthcCJs02o/2++44HDRPJzzvUaxr2M2d5frqUK66XD3IsAmjrn7a961/sjtvB9zZaaR86BvAI6d68YoP7D7uXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from AS8PR06MB8167.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::13)
 by AM8PR06MB6866.eurprd06.prod.outlook.com (2603:10a6:20b:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 13:09:51 +0000
Received: from AS8PR06MB8167.eurprd06.prod.outlook.com
 ([fe80::fea6:d2a5:783c:3138]) by AS8PR06MB8167.eurprd06.prod.outlook.com
 ([fe80::fea6:d2a5:783c:3138%3]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 13:09:51 +0000
Message-ID: <a544b41d-ff71-4f8c-90ed-1f8045d18c49@jolla.com>
Date: Mon, 26 Jan 2026 15:09:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] systemd-resolved: Use DNS servers of the default
 service
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
References: <20260126125906.37683-1-jussi.laakkonen@jolla.com>
Content-Language: en-US
In-Reply-To: <20260126125906.37683-1-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AS8PR06MB8167.eurprd06.prod.outlook.com
 (2603:10a6:20b:3c1::13)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR06MB8167:EE_|AM8PR06MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: a9be8a51-66a2-48ef-ca72-08de5cdc3079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlJsdFJyZXppSFRqam5kaUFtYXUwdnhDYng3TUxmMS9ITkhKYmZJQWVMQnN4?=
 =?utf-8?B?eHN5Z0F2M3NrSGRzVUJRS1NlSGlzL3JvbmhiYWdzTnkyYjlYRndheEJvZUFi?=
 =?utf-8?B?MHNyZ216WGFBNGhmWUIvUXk1SEpRY1IxM3hIUzY3UllwS0dpT2cyUER3ZU1z?=
 =?utf-8?B?Smw3UTJ6Ym1vd1FaN1A4WHlyQU81MDhwVjFSNHp1eFU4THZIbVFHNHhreW5o?=
 =?utf-8?B?VGJvaXFINUV0MEZuVDVVK2tibkRtM2dKM0NySWs0a2Ywb00wMlVZTVFjb2ha?=
 =?utf-8?B?eVpxK3p4RVVWd1Z2NzlWTGwxWm1uOFBVdWt6UUEvYnR4N2E4UzVYVGVLQUdR?=
 =?utf-8?B?V0w3eUFQZTJBYjRoZzZramRxOWhCOWphUkZEcVQvUFJJN25PU1hKMWs2RStT?=
 =?utf-8?B?WHpVd0ZrUjBqOXI0UGNiTmtNRGNTeUZ6aWdZT2FYaE5JM1VMa3NJSnhsbWdq?=
 =?utf-8?B?aUZFUU5Yd3prN1NETEpCM25VNzdsVHNwcy9na1VEMU15MGVvZkJta1l2amxX?=
 =?utf-8?B?b2Q3N2JSZU9ORlNHeGxNY0xtS0NXUzYwdXB4c0F1bHgvY0lzVzZJRitWQzdu?=
 =?utf-8?B?UjdESmVINXZiWVBaeU9KTmxqbFpuNFZiRmZEWnpMM0kwMDk4eFJMeHFzQzN2?=
 =?utf-8?B?S3BFbnE1RWZ2K3lHenNXSzRUaWQvcXM3a1F5M0E3QkFTODhYSlZjR3Rkck0z?=
 =?utf-8?B?LzJCRUZwdEFtL3p4MTdkTEoya05TRTgweG1HT3djNFl1NWY2TWpjQzlhUnFM?=
 =?utf-8?B?OTRpSnhpcEpNL3l1VklwQ251SkV2bnpaM2VMT2JaM01rWW50bjl2M09PRmZj?=
 =?utf-8?B?cGJrL3VzVUcrcC9CaG5oSFRBL3R5clhQUkpXcnBKUU1VelhyQThOSEtOQUw5?=
 =?utf-8?B?NWV5dUI1VnlHa3RxVk1JbGpnek93QnkrbGxHbm4xdEpaU2lWeXFnZExneVFS?=
 =?utf-8?B?TXFsWXQybnVLTkxzbDRMR1ljc0ZzNEhKZzJZeVU5OFI4dWx2NUJhOXYvMk5p?=
 =?utf-8?B?dUNhK2lUQW5jc3NOaWJiOTYyOUcyblExektyK0dQc3hqMlNBb1hmOStRSXcz?=
 =?utf-8?B?Szh0S1VVdDl4RzFNUVZ2MlJmUld6bTZPNXVaSVUra2NyODhRM3pMVlBUdjBh?=
 =?utf-8?B?WjAvZ1lWMjhXd3BrcU14VDdReG1GUHJHdE1yZUZ5ZkQzWkRMbVBWdFo2aUlP?=
 =?utf-8?B?bTVOYytrb3FGYUd4dW5ScXY1UU4reEVvZyttTitKcnVNbElJc3d2anRGT1pq?=
 =?utf-8?B?NEdCdzhhV3ZZYVJaaDhHTGFEQTNQa1I3K1B6M0duRUM5NWVaRzByVjB5bHdh?=
 =?utf-8?B?Q3FNTTI5c2JzZ21vdVkyLzZUcnBiNlAzNHgrNy9XaWRXNkdyRVd1aWQwOVI1?=
 =?utf-8?B?bklkaXZSeTZQaStBUGY1Vmp6SXdDQVBKVnRUclVvby9PK1E3c1JmYm8rVEI3?=
 =?utf-8?B?ZGlxNmswVlVjSjkvU0x5RE11dmYvbThaYmx4SHpSTG5kbDJ2b01teFlVckUr?=
 =?utf-8?B?RUxQTlhPQ0V3Q0EzQzg3STdzSXNQeXM4eDZIUVZhdXovRUJ4bno0cm9GNXJs?=
 =?utf-8?B?dVZFM3VIdWQzMHhBaVFrRmwxL05MOW9QY2pYbDBsMUVQN0llaU1iTnMzUi9D?=
 =?utf-8?B?L1FZK0JKdkNOUzQ3eGFhVEFoZzh3UWZ4Vlh5cXdzcG5IMU16L2FVMlFoK3Z6?=
 =?utf-8?B?TFZBZm9pelVkb0k5cGtnWEZEK2RVV1NsbGhtTHMvYWQvQ0p6bTQyakw3NDNR?=
 =?utf-8?B?Vm1YcEFGdjBQZUN3akFPVXJmWFB2VlY4QW1HTUJ4cmpmN09DTWs4RjhJYXdS?=
 =?utf-8?B?WUttems4emI1ai9ZNmo2d2dFWUc5akZMQ2RIMFNrMDRtUE4xZ1JCc2VRTS81?=
 =?utf-8?B?TEd4Yk52cVZHR0JUb29mR3BHVG1FWE1uR1JEZnY5aUNuSzBPdFZYcjFnMkV3?=
 =?utf-8?B?TDBkUURtWkF0TXN5S28wYUNmRzBjUFZvYWpVLzFJejNKZVBlc3dFWlk4eU5I?=
 =?utf-8?B?N2p4VUFGajFBRnlqZ0dReTkrWlQvamJiNW9sOWdEMEJLYlNZOStWSFVscHF2?=
 =?utf-8?B?dGthaFZ5YzlZdmp5SGpkRUMycnZ3UU1qQzdTV3VHQmNncXB2VnNIdG11WWwr?=
 =?utf-8?Q?FE/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB8167.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V01iVjVsOUowYlhnVW1NWkJnR3pCS1BpVnNOR2wzQklYOEZIMTRZQlRFTUhK?=
 =?utf-8?B?eEwrUUtrdjdpUUd3K25JdFQ5MXhWZ1JZNlF1YjFiVmUxQzlBQUdZYmJvZzhZ?=
 =?utf-8?B?Um15Z3B1aG8vWjQ1ZDF2dkoxNkVhOGg1NnNLYVRRMVA1bEFCZkZabS95S29n?=
 =?utf-8?B?NGx2ZmxSaTNZdEdyOEJLN21ibVROUDV0UlVocm5IZnI1cEZValJsKzIxR1Zy?=
 =?utf-8?B?K3RaVzZEay8rcDVvUDdiWUR2eU5ZdlhTc3ZtaXdSRFQzVnRTaXc1MEYvTTBX?=
 =?utf-8?B?MDRwZGU1NUIzcGNJTEsxNlNwaHUrVG9nY08rUy9JejkrNDZmUlBVSllnVEtX?=
 =?utf-8?B?T2xpZ2Myc0VZdGN6eUlPL2FvWlV5QkpFY3BPa2Z0eGR6cjRsVzdyM0Y3dklQ?=
 =?utf-8?B?UEdjdTJSL0N5L3hYd2t3anA0M3I4TWlIbHZoYUZEcjNwL3FVS0RBVnYyd2NO?=
 =?utf-8?B?R25TaGhiVVRVR0QwWjdpSFZXYVF0cmFIK0dpZmZTMUY2WStwMnVXd0ZGdlVW?=
 =?utf-8?B?ZEljZG1Mb1FhWUVwK0hydU9PVkJEeGhQZWduT29HRi9La01STkpENkRQeU90?=
 =?utf-8?B?QWgzMzQ1eGo0YWxrMGF2M2lzNkR6bWlVV3J1ekNleFc1TVhwRmdTWlo2TWJL?=
 =?utf-8?B?SnVCYlU4ZE5GRnpuMmJjM1FEbUllTEIxYmVuYUxzNkxHSDIzSTNmR1lIaWVS?=
 =?utf-8?B?bDcybVdwMWxQUHp4R3BoNzNlWGtpOWE0b3IrVHgwOFhsL3JrSk1HOThiUEIy?=
 =?utf-8?B?eXRQcFFXTktTUEE5QVFhVXZaR0ZzZ254WkMrSzV6L1FPYVV3OHN3c1YvNERG?=
 =?utf-8?B?eWlWRU9FTzRRZ0NkS3NmVUIraS9ZNndWbDlGMUR2TjdTYzZ3bzY5NDdtL3hy?=
 =?utf-8?B?YU92UVRrVzhUQ0Q0M0Jab2hmNFNoL1AyeE9XbmpwaEp0ZDdSSmpab2FyeXFG?=
 =?utf-8?B?YVFZdjNMYWd4eXlMOVVDS29xb3NuUDNRZ3l5clByMk9SZVNuZEZVZmRveVFD?=
 =?utf-8?B?N3ExbXNEeis0T2pncWxEUVcvOE5UY2JHUkhOWTFWMVZyMDZuLzRxaGUzQ1lL?=
 =?utf-8?B?cG41aXNKMkNNYWppMzRsY21VZE5LdFh0dEVBdmFrUGlJYVlCZVpVQTltSFpv?=
 =?utf-8?B?dGd1QzRjWHh5YlBjVGZCLzVyeHY1OWZzNmtpd01zSWFNMU5mR1ViSk9EUmdr?=
 =?utf-8?B?emRsejArZGdvVFZ4QnowaUFLak1SeWhzUU5xTkJUem9Ga29mNnN1Uksrckhv?=
 =?utf-8?B?R1dCaURZbHphREFiZDZVWWw2M0pyTU5PTTRNSllTOVJ4YnRRc21TYWo3VmZ1?=
 =?utf-8?B?OVcyOGZNNEIzZVc0QUd0UGhwc3JGLzhSS0lWM0svSGlnNHdQQUcvWHd6NlZZ?=
 =?utf-8?B?ZytrOXVzV2RpTlJLZTZZUGZWcy9DNGhobTluN2RQQ1k0bVFWMDNaNzNzQi9Y?=
 =?utf-8?B?RWtkY1AxeXVJbVNWMzNnNFVYTDBGQlliSTJacXBnbGpFOWNQY0tDTFhlS3lO?=
 =?utf-8?B?ZURDa3gwUE1ETkZrQlMxTjJjZlZBV2htWmxYSmdYZEF1QWZFTFBoZEVJMmlw?=
 =?utf-8?B?V1V4TTNGT2lDL3BwbDRuZ09xci84dEJjK2QxODI5ZlQ4WXVjYXlXN0xQd3I5?=
 =?utf-8?B?Q29kelArMEJQWDRvTE1wTk12cUVkSi9zbWpRWnRQR0NCdG13YTdXNDY4Q3BM?=
 =?utf-8?B?VGs3aWZ0ZDdoQ2gwM1IyZW8ra2lGYjgxcFdrQW5iSVhpYmlXUG0zOUxzQWY2?=
 =?utf-8?B?RXhOcG1JYW1rTzhEemFhcjFlUFFkeDl0c1dIRzlvbGF0cHJyS05sUVBYS1lj?=
 =?utf-8?B?bVpUc1gxZDRYVTV3R21JTUxteGhzRDVkenNDVHM5Z1dicmpPTWdUNldzblA3?=
 =?utf-8?B?MGlQNmFadEFSdzNrUXdpLy9hTFo4d3FYUG0rVEFrZHdQMVdnQUVwbnFFT1hE?=
 =?utf-8?B?ZFBwVVBiTzNtc2pXYUdmTHFGOGVlOTR0aWhOdFpqb1JhRk1UbjFHV08zMzNl?=
 =?utf-8?B?a1VRdW0wZ2dobm9SN3M4S3JVL2xWMFBna3V4Z2ZxQTAxakFQK2FwN1ZJMGdG?=
 =?utf-8?B?eld5bkgvMXlkVm5YM0N4WkNEL1JoYlBjdGpFcDN1QW1xNTFhSDlBRnNCWDlx?=
 =?utf-8?B?d0ExYW93MmFxQlpUbmlCaTM5ZDcyNW9XSngzTkRiNWVTTVlqdmR3RXFTZWNa?=
 =?utf-8?B?MTRsNCtUaURkei82RWwrWmJVNGJNNmkwVUp3aGV6bmhiblorMFRZeDQwT0xs?=
 =?utf-8?B?UGlOTnN3L0M1STBWTXR1a2tlUjNnSXNUYjdHWVZJQzE0NTVrcGdVY2kvZ1Nt?=
 =?utf-8?B?YWJ5WWdtTU93R2pVeUZLcUxrVVRxQ3JxZkh2MjhzQllOSUlxN2NNL3dobHZ2?=
 =?utf-8?Q?1oroKZM2e1kREZE0dyc80mOjS0nzXw012Kw7Jw4j8DHL7?=
X-MS-Exchange-AntiSpam-MessageData-1: gxHSHTRhYckzVv3c8LiBowPur9xhOfCf+fI=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9be8a51-66a2-48ef-ca72-08de5cdc3079
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB8167.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:09:51.1676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4wWTXH6HX3eWJRw5RdJqMrIevc/meDkvqLI37bXLhDuJRDQG8nwSliRFVZgiKqyU0IsGizBZA8gLKd0kGIHW+T9jGSeRsSi4R9hNqSqsHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6866

Hi all,

Heh, I think the first patch mail was lost in transit. If it does not 
appear, regard this as v1 instead of v2 - just sent the wrong file by 
accident.

- Jussi

On 1/26/26 2:59 PM, Jussi Laakkonen wrote:
> Register to get the notifies about the default service, service state
> and offline mode changes. When default service changes set it as
> default route in resolved, revert other links' status and flush the cache
> so only the default service's DNSs are used. This brings the similar
> behavior that is is in dnsproxy.c, and prevents leaking of DNS queries
> outside VPNs as well. Thus, effectively making only the DNS servers of
> the default online service to be used.
> 
> To ensure that the servers are gone the domains and servers lists are
> cleared when the service is disconnecting. The current default index is
> being tracked and when it is being reset, the cache will be flushed as
> well.
> 
> ---
> Changes since v2:
>   - Send the correct patch file without the internal bug reference.
> 
>   src/dns-systemd-resolved.c | 340 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 337 insertions(+), 3 deletions(-)
> 
> diff --git a/src/dns-systemd-resolved.c b/src/dns-systemd-resolved.c
> index 912ab3fe..9dd0328c 100644
> --- a/src/dns-systemd-resolved.c
> +++ b/src/dns-systemd-resolved.c
> @@ -36,7 +36,7 @@
>   #define SYSTEMD_RESOLVED_SERVICE "org.freedesktop.resolve1"
>   #define SYSTEMD_RESOLVED_PATH "/org/freedesktop/resolve1"
>   
> -struct mdns_data {
> +struct resolved_dbus_data {
>   	int index;
>   	bool enabled;
>   };
> @@ -48,6 +48,7 @@ static GDBusProxy *resolved_proxy;
>   
>   /* update after a full set of instructions has been received */
>   static guint update_interfaces_source;
> +static gint current_default_index = -1;
>   
>   struct dns_interface {
>   	GList *domains;
> @@ -55,6 +56,7 @@ struct dns_interface {
>   	int index;
>   	bool needs_domain_update;
>   	bool needs_server_update;
> +	bool enabled;
>   };
>   
>   static gboolean compare_index(gconstpointer a, gconstpointer b)
> @@ -405,7 +407,7 @@ static int setup_resolved(void)
>   }
>   
>   static void setlinkmulticastdns_append(DBusMessageIter *iter, void *user_data) {
> -	struct mdns_data *data = user_data;
> +	struct resolved_dbus_data *data = user_data;
>   	char *val = "no";
>   
>   	if (data->enabled)
> @@ -419,7 +421,7 @@ static void setlinkmulticastdns_append(DBusMessageIter *iter, void *user_data) {
>   
>   int __connman_dnsproxy_set_mdns(int index, bool enabled)
>   {
> -	struct mdns_data data = { .index = index, .enabled = enabled };
> +	struct resolved_dbus_data data = { .index = index, .enabled = enabled };
>   
>   	if (!resolved_proxy)
>   		return -ENOENT;
> @@ -434,6 +436,332 @@ int __connman_dnsproxy_set_mdns(int index, bool enabled)
>   	return 0;
>   }
>   
> +static void setlinkdefaultroute_append(DBusMessageIter *iter, void *user_data)
> +{
> +	struct resolved_dbus_data *data = user_data;
> +	dbus_bool_t val = data->enabled;
> +
> +	DBG("SetLinkDefaultRoute: %d/%s", data->index, val ? "yes" : "no");
> +
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT32, &data->index);
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
> +}
> +
> +static int resolved_set_default_route(int index, bool enabled)
> +{
> +	struct resolved_dbus_data data = { .index = index, .enabled = enabled };
> +
> +	if (!resolved_proxy)
> +		return -ENOENT;
> +
> +	if (index < 0)
> +		return -ENODEV;
> +
> +	if (!g_dbus_proxy_method_call(resolved_proxy, "SetLinkDefaultRoute",
> +			setlinkdefaultroute_append, NULL, &data, NULL))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int resolved_flush_cache()
> +{
> +	DBG("");
> +
> +	if (!resolved_proxy)
> +		return -ENOENT;
> +
> +	if (!g_dbus_proxy_method_call(resolved_proxy, "FlushCaches",
> +			NULL, NULL, NULL, NULL))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void setrevertlink_append(DBusMessageIter *iter, void *user_data)
> +{
> +	int index = GPOINTER_TO_INT(user_data);
> +
> +	DBG("RevertLink: %d", index);
> +
> +	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT32, &index);
> +}
> +
> +static int resolved_disable_interface(int index)
> +{
> +	if (!resolved_proxy)
> +		return -ENOENT;
> +
> +	if (index < 0)
> +		return -ENODEV;
> +
> +	if (!g_dbus_proxy_method_call(resolved_proxy, "RevertLink",
> +			setrevertlink_append, NULL, GINT_TO_POINTER(index),
> +			NULL))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +struct interface_search_data {
> +	bool enable;
> +	bool forced;
> +	bool disconnected;
> +	int index4;
> +	int index6;
> +	int vpn_index;
> +};
> +
> +static bool interface_index_match(int index,
> +				struct interface_search_data *search_data)
> +{
> +	if (search_data->forced)
> +		return true;
> +
> +	if (index == search_data->index4 || index == search_data->index6) {
> +		DBG("interface %d match", index);
> +		return true;
> +	}
> +
> +	if (index == search_data->vpn_index) {
> +		DBG("VPN interface %d match", index);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void toggle_interface_dns(struct dns_interface *iface, bool enable)
> +{
> +	DBG("%s interface %p/%d", enable ? "enable" : "disable", iface,
> +								iface->index);
> +
> +	if (iface->enabled == enable) {
> +		DBG("already %s", enable ? "enabled" : "disabled");
> +		return;
> +	}
> +
> +	iface->enabled = enable;
> +
> +	if (!enable) {
> +		DBG("disabling interface %d", iface->index);
> +		resolved_disable_interface(iface->index);
> +	} else {
> +		DBG("re-enabling interface %d", iface->index);
> +		set_systemd_resolved_values(iface);
> +	}
> +
> +	if (is_empty(iface)) {
> +		DBG("removing interface %d", iface->index);
> +		g_hash_table_remove(interface_hash,
> +					GUINT_TO_POINTER(iface->index));
> +	}
> +}
> +
> +static void check_interface(gpointer key, gpointer value, gpointer user_data)
> +{
> +	struct dns_interface *iface = value;
> +	struct interface_search_data *search_data = user_data;
> +
> +	if (interface_index_match(iface->index, search_data)) {
> +		/*
> +		 * Clear domains and servers before updating the status to
> +		 * resolved when interface is disconnected.
> +		 */
> +		if (!search_data->enable && search_data->disconnected) {
> +			DBG("clear domains and servers of %d", iface->index);
> +
> +			g_list_free_full(iface->domains, g_free);
> +			iface->domains = NULL;
> +
> +			g_list_free_full(iface->servers, g_free);
> +			iface->servers = NULL;
> +		}
> +
> +		toggle_interface_dns(iface, search_data->enable);
> +	/* If DNSs of an interface are to be enabled disable the others */
> +	} else if (search_data->enable) {
> +		toggle_interface_dns(iface, false);
> +	} else {
> +		return;
> +	}
> +
> +	if (!update_interfaces_source)
> +		update_interfaces_source = g_idle_add(update_systemd_resolved,
> +									NULL);
> +}
> +
> +static void resolved_offline_mode(bool enabled)
> +{
> +	struct interface_search_data search_data = { 0 };
> +	int err;
> +
> +	DBG("enabled %d", enabled);
> +
> +	search_data.enable = !enabled;
> +	search_data.forced = true;
> +
> +	g_hash_table_foreach(interface_hash, check_interface, &search_data);
> +
> +	/* Offline mode is not on, skip default unset and flushing of cache */
> +	if (!enabled)
> +		return;
> +
> +	err = resolved_set_default_route(current_default_index, false);
> +	if (err && err != -ENODEV)
> +		DBG("failed to unset interface %d as default route",
> +							current_default_index);
> +
> +	current_default_index = -1;
> +
> +	resolved_flush_cache();
> +}
> +
> +static void resolved_default_changed(struct connman_service *service)
> +{
> +	struct connman_ipconfig *ipconfig;
> +	struct interface_search_data search_data = { 0 };
> +	int index;
> +	int err;
> +
> +	DBG("service %p interface %d", service,
> +					__connman_service_get_index(service));
> +
> +	if (!service) {
> +		/* When no services are active, then disable DNSs */
> +		resolved_offline_mode(true);
> +		return;
> +	}
> +
> +	if (connman_service_get_type(service) == CONNMAN_SERVICE_TYPE_VPN) {
> +		/* VPN is either or take both to be sure */
> +		search_data.index4 = search_data.index6 = -1;
> +		search_data.vpn_index = __connman_service_get_index(service);
> +
> +		if (search_data.vpn_index < 0)
> +			return;
> +
> +		index = search_data.vpn_index;
> +	} else {
> +		ipconfig = __connman_service_get_ip4config(service);
> +		search_data.index4 = __connman_ipconfig_get_index(ipconfig);
> +
> +		ipconfig = __connman_service_get_ip6config(service);
> +		search_data.index6 = __connman_ipconfig_get_index(ipconfig);
> +
> +		if (search_data.index4 < 0 && search_data.index6 < 0)
> +			return;
> +
> +		/*
> +		 * In case non-split-routed VPN is set as split routed the DNS
> +		 * servers the VPN must be enabled as well, when the transport
> +		 * becomes the default service. Try first with IPv4 and then
> +		 * attempt using IPv6 if not set. VPN can be either or.
> +		 */
> +		search_data.vpn_index = __connman_gateway_get_vpn_index(
> +							search_data.index4);
> +		if (search_data.vpn_index < 0)
> +			search_data.vpn_index =
> +					__connman_gateway_get_vpn_index(
> +							search_data.index6);
> +
> +		if (search_data.index4 == search_data.index6)
> +			index = search_data.index4;
> +		else
> +			index = search_data.index6; // Prefer IPv6, as usual.
> +	}
> +
> +	if (current_default_index != index) {
> +		err = resolved_set_default_route(current_default_index, false);
> +		if (err && err != -ENODEV)
> +			DBG("failed to unset %d as default",
> +							current_default_index);
> +
> +		current_default_index = -1;
> +
> +		err = resolved_set_default_route(index, true);
> +		if (err && err != -ENODEV)
> +			DBG("failed to set %d as default", index);
> +		else
> +			current_default_index = index;
> +	}
> +
> +	search_data.enable = true;
> +	g_hash_table_foreach(interface_hash, check_interface, &search_data);
> +
> +	resolved_flush_cache();
> +}
> +
> +static void resolved_service_state_changed(struct connman_service *service,
> +			enum connman_service_state state)
> +{
> +	struct connman_ipconfig *ipconfig;
> +	struct interface_search_data search_data = { 0 };
> +	int index;
> +	int err;
> +
> +	index = __connman_service_get_index(service);
> +	DBG("service %p interface %d state %d", service, index, state);
> +
> +	switch (state) {
> +	case CONNMAN_SERVICE_STATE_DISCONNECT:
> +	case CONNMAN_SERVICE_STATE_IDLE:
> +	case CONNMAN_SERVICE_STATE_FAILURE:
> +	case CONNMAN_SERVICE_STATE_UNKNOWN:
> +		DBG("disable interface %d", index);
> +		break;
> +	case CONNMAN_SERVICE_STATE_ASSOCIATION:
> +	case CONNMAN_SERVICE_STATE_CONFIGURATION:
> +	case CONNMAN_SERVICE_STATE_ONLINE:
> +	case CONNMAN_SERVICE_STATE_READY:
> +		DBG("connecting/connected mode, skip interface %d", index);
> +		return;
> +	}
> +
> +	ipconfig = __connman_service_get_ip4config(service);
> +	search_data.index4 = __connman_ipconfig_get_index(ipconfig);
> +
> +	ipconfig = __connman_service_get_ip6config(service);
> +	search_data.index6 = __connman_ipconfig_get_index(ipconfig);
> +
> +	if (current_default_index == search_data.index4)
> +		index = search_data.index4;
> +	else if (current_default_index == search_data.index6)
> +		index = search_data.index6;
> +	else
> +		index = -1;
> +
> +	if (index != -1) {
> +		err = resolved_set_default_route(index, false);
> +		if (err && err != -ENODEV)
> +			DBG("failed to unset %d as default route", index);
> +
> +		current_default_index = -1;
> +		resolved_flush_cache(); // Do when index is unset
> +	}
> +
> +	/*
> +	 * Disable DNS servers when the service is not connected and clear the
> +	 * domains and servers. Use both indexes as service can have two
> +	 * separate interfaces, both of which can be registered to resolved.
> +	 */
> +	search_data.enable = false;
> +	search_data.disconnected = true;
> +
> +	g_hash_table_foreach(interface_hash, check_interface, &search_data);
> +
> +	if (!update_interfaces_source)
> +		update_interfaces_source = g_idle_add(update_systemd_resolved,
> +									NULL);
> +}
> +
> +static struct connman_notifier resolved_notifier = {
> +	.name			= "systemd-resolved",
> +	.default_changed	= resolved_default_changed,
> +	.offline_mode		= resolved_offline_mode,
> +	.service_state_changed	= resolved_service_state_changed,
> +};
> +
>   int __connman_dnsproxy_init(void)
>   {
>   	int ret;
> @@ -451,6 +779,10 @@ int __connman_dnsproxy_init(void)
>   	if (!interface_hash)
>   		return -ENOMEM;
>   
> +	ret = connman_notifier_register(&resolved_notifier);
> +	if (ret < 0)
> +		DBG("cannot register notifier");
> +
>   	return 0;
>   }
>   
> @@ -458,6 +790,8 @@ void __connman_dnsproxy_cleanup(void)
>   {
>   	DBG("");
>   
> +	connman_notifier_unregister(&resolved_notifier);
> +
>   	if (update_interfaces_source) {
>   		/*
>   		 * It might be that we don't get to an idle loop anymore, so

