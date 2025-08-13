Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023119.outbound.protection.outlook.com [40.107.159.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7AC1DEFE6
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084048; cv=fail; b=eEew0+loxqr2pYydz0Z1NnnKZH3gJIXHXhCI5eDJekNw3IXce5qDHA2q2hwgVaxV44u6HQV7HQEJEyFiJj1AdixZnZrSKjd59zXZoYfD12qruukAMrs9whzTzn8Ma5tOwQIQGjayk1kg2IneP4Lw7fz9fu8df3pKMacLrxw9htA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084048; c=relaxed/simple;
	bh=72kq5jrdQOoQeRcHjNKglCg3tmJXSA5v9CJd7uPyhcU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vd75Ewz+xYMkvmYtpRy1C5hKwRrvx/JguwaogHTSjC45Pog/SQ8jlqt9Qsgv622G+UwrDnM2WeaXbc58e4TI2DMWAGxsaLOiM0h8xPdll9mzePDpu0rMR6MjpWa1IARIeuvWGMheZcjTBNHmvfrPeHr4c5OkAmJ9spIi8kYnL+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=h+Su1aQ/; arc=fail smtp.client-ip=40.107.159.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="h+Su1aQ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Av8mqyV9/nASgzCtaMFCZjS4irexBdoDWQOaKmTZ9aDtlupgMmQx0vJ9mRB5aPThtYsHu4woQVkhcXjRqA04+GrRpUR+oRgR7KYRi86H08UWUBuli4ZXnot6nR2TI+CAQM97aaWDGk22HnoNyq+1WhCINBHP7fUavmmfNe8u3XDXoV4WLZCMkYQIiy3SRoU9NxnmjM8nSMmtODlrG0yKR6eZkIt2hlKI34V12l0U3TU3gQhySxvLkR/U8vVoeHP0FsUAVVp+TwdE6TQezoUs1A7I03exw4wdw/EYtpx8gZrFBaFkzLjp6gNpENj0wonmZcLAodKiojLp/aXzLbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr2YXAcZMx742iZLDgdF2yf3KQrqnpzE88jTSK0d3VM=;
 b=nrISO9gR4vgKnII4423q+v7sy92ciKoOx0bpdMvQbCLMONLyO6mYObfyUuqHXCOAXph7iiZVsrNNtknipmi+gHGr6nIX+/0eNdAxf6u8v15qYv75wWgz1PxEOHTkz4Lv7HbzNCt/oKSf5VQlstkc0yCTnqEFaAJM8l/zLxIZm1sAkaPBoadPRFhuYH1jVwSOGKGi6XSr6eJy3pJsLo2pmiy5nSjoD88WuVkHQCGi2TsMgowS4eyFBAF3CPNauIoWbdGjsLqrbY5US15Qk1PTzyiSezCsxUqjTRSVVEDyvXnTU2OAyUEB/Fv1kYlL/6MtPIWSryVYrHw+3MaVbHMnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr2YXAcZMx742iZLDgdF2yf3KQrqnpzE88jTSK0d3VM=;
 b=h+Su1aQ/fw67y9SfC84rTx+sWgoy1S+FE8tFXJzv0xEk6Zbx4ZmEjpH5zontRCVs1Ai/xcZLTvIHo9SEZK2t98HrCG1uWR7N1kMh7jbJw/9j5FabtqQR8IrjBJ698LeSgGf977UsznRzQgOXOEqJf8TWbE5bRhvPEWzh1D6eH5wJK/cZcaQx1p7sp9ck6GgLyafpsjgJB3QaAsC3HWfgFWVnhLiE2vBYooKqCInkWwIJeLmXCif1Q8oPQ1SjZhjnZAjENa78lc+rSvImtXQOvMIvOPDo1UavWW4aoknk9bENj06lwSBzGPUeExcqQZcnWHS+hoR/tWVvh/XQxa5LUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com (2603:10a6:150:21::11)
 by AM9PR06MB8162.eurprd06.prod.outlook.com (2603:10a6:20b:3a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 11:20:42 +0000
Received: from GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa]) by GV1PR06MB8370.eurprd06.prod.outlook.com
 ([fe80::f1a2:b7c7:380e:8caa%2]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 11:20:41 +0000
Message-ID: <af1af1f2-2009-4133-86b3-29042feaf97e@jolla.com>
Date: Wed, 13 Aug 2025 14:20:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/45] vpn: Add VPN agent use callback for plugins
To: Denis Kenzior <denkenz@gmail.com>, connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
 <20250711142736.1757060-10-jussi.laakkonen@jolla.com>
 <4810774e-ef89-4b55-a393-356ea8b78c20@gmail.com>
 <cd769d53-45c0-4b77-93a4-26afc74d5fa1@jolla.com>
 <67c4b880-4980-4c1d-a67a-a81b9941516c@gmail.com>
Content-Language: en-US
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
In-Reply-To: <67c4b880-4980-4c1d-a67a-a81b9941516c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00011B55.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:19) To GV1PR06MB8370.eurprd06.prod.outlook.com
 (2603:10a6:150:21::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR06MB8370:EE_|AM9PR06MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9c41ac-5577-49a3-e0a5-08ddda5b7016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5KZnhaNm1SNGtjRUhiOTdCTUtnNXBhdGdUSExLNGxSZi9PRmFNYmdvajRw?=
 =?utf-8?B?UWExd3dJWWRtRitSWFgvQWRMamVFdUZhZTJBODdWN2E4SlRqS3BwZk1aQ2g5?=
 =?utf-8?B?RVRld0pTMHpoV0tZWHV0cTE3ckN6VHJteE0vcU9FeUdUKzlSQUFUcWowaFlO?=
 =?utf-8?B?Tm50Yi9IelQzcmlrSEQxbkIwemtlQmN6cm03WCtrOVhMZEdoazNaVWRkZ21J?=
 =?utf-8?B?dThkZHpqUlJJRWltM2tWcld4ZVdWL1JRa1YrcDZhOU5DYmJNTnBwZGV6aXB3?=
 =?utf-8?B?Z3piN3ZSTkZZUElsczBsdmh4cDZaS1hzQ25SaHJtZGtRQ3oyVVNnaFpMMGdp?=
 =?utf-8?B?REdUYjhuSkhBTlYzVTh3cUYzV2FZNndkZW9zalJmSkZVT0RLdUtSSlNkamFm?=
 =?utf-8?B?bURmZU9wTDhBRkhPM2NhcUVCUUt6cDg2eFJZclUxdDdwTk9CK05hWWFyZkNr?=
 =?utf-8?B?T2RTSG40RWNqV2xqeExUMGtiOFg4V3pqazIyVUd4U3pxZExWM2RvNlpsMURv?=
 =?utf-8?B?UjFFVjJkU2Z0WTNoVy96MEJhaGtmMWRyMGNGVVJBNVEvWmJVUU95bG85YUV6?=
 =?utf-8?B?TDhhYWlNM2x3MW9FWmtKYnQ0S2NBYSs4KzkrS2NDN2w5anFLRFdndkh3MEpS?=
 =?utf-8?B?a1JDMWVOOW5ZZ0I3OGdOSlBhdWdJeFFPUkU4VTBLekdISm04dCs0eDQvS3Zx?=
 =?utf-8?B?RDM4VU9BQTF2YjAvRVFORC9zZDVxeUVERXYxM3J4MHdVVG9OanVVK2dUb2Ex?=
 =?utf-8?B?VTd0L3pmSTVxN2R2QXkvUUYzS3dWR0dzMmZjMm5QUGJSb21INGhCV056QXQz?=
 =?utf-8?B?RVhSQ25WSS9vL3dFVWw3dnRYOTlSN1JFcGoya2VuSGVsVTBMNjJNR0JLdjZL?=
 =?utf-8?B?ejd4Nys3akpIT1hrWm9JZFFyZjJUTUJYYXJWZjZleEtQZnEySUg0SEpuWVdK?=
 =?utf-8?B?M3U5dWQ4TzF5RFNlQ2pWU0NZdFJYZjNTUEhaQTBhTGVSWDM3a2tnb1dHbUVy?=
 =?utf-8?B?NGdwUnVhbmlzN1hMdlFSU25SaDlqRS9RRHRDNnNYczF4ZDRFQ01jSnBqTzFQ?=
 =?utf-8?B?bHY4REt4Q3pLRmg2eVgxUUxiUXdVZFFIUlRYaGdxcjU2aGxBMFFPMGR4eEFE?=
 =?utf-8?B?WFpPc0wwOThCd1VCdXZvMjk0SVh5czBweWRPcUIwQUJUK09iOXZiZkZUdW1K?=
 =?utf-8?B?dmo2dHNPN3F3NlRiWGdVbjA4NVBjNzJWUDF2UTBRSHdNZjkwNk9saWxWdVhW?=
 =?utf-8?B?Y2ZPdlAwbmpKYkJOVUd2VXZ5RUQrS0FXUGs1WTE5dGhqc2pwcEhXY0lsdUs3?=
 =?utf-8?B?b09OUEFPYTRWZ1NGTksrai9SWnl3WVRQQnRWUW9acTFrQ0RDU0xtSEdnd3Qy?=
 =?utf-8?B?VDhUSk8xMDY5cHRnc21VSEtjNEJJSlBPR3RTS1VJbklBYjZHUE1WaTJxQ0dD?=
 =?utf-8?B?MWZ1clFsZTRJakR1VzNLSmZ6cklNUFI5aExjUVZmTjhnZ3dtKzV3WGhTcU13?=
 =?utf-8?B?MGRCZS9tTFFFZ1pEL0EyaWZTMG11S2lVR0UvVEtaTU9zUldzenJSMlFlTHZG?=
 =?utf-8?B?ZVFXUzcyZi80MEtUOWhrTlpYbVJ2dlFiOXFnY09IZW9OTW1ocUJiQVhvSS9F?=
 =?utf-8?B?dXZnZ1MyWm9SVERqczhOdVUzcFQwNjJRblAvLzllTEZpWEsyTFhoMW9KcnJx?=
 =?utf-8?B?VzhmbzRNWG9TT0dNNGs2RGY0Y3Jid3ErVWVIcHZaanAreElwdEIwcjhoZnlQ?=
 =?utf-8?B?cTZSUlV3Vmc2ZFpTUEM5bUhYbEZrVTJkMWsxeFR0ZGY3elA4c0VoMy95NDNM?=
 =?utf-8?B?TU5xb202WmZ4RmIvaE5Dcm0zeCswTWoyQ3A2emM5RFpBOW5ad0Jjd1VzQzJY?=
 =?utf-8?B?SU12bDNtVm5lYXpoYU1UTXJ5T1YvblNmMVlGRncwaWl4Nkk2TDd2U2xTcHFJ?=
 =?utf-8?Q?yTbzIWp1wDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR06MB8370.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHR0WUJNWnZQUkVGRm40ZDRKTTFzWTBMUENOWDlMMUtaaUFrMnNsY3hCc25s?=
 =?utf-8?B?bnpkdkxwL0JpQmFiWnAycnJKY09PK1pTaXQwa0t6bjF0ZkMxRFp1M3VQQ290?=
 =?utf-8?B?MUV4SFNIdDB5RE1BMVoyV2hOakxXOHJpM1ZzMVlNMHlIYy9neFk5UE42ZkFN?=
 =?utf-8?B?UStMTDl3QzBCZlRHMU9FeEFwS3VZNWovdlFLZXhzRi81SmUvTzE4VmpJYWdi?=
 =?utf-8?B?MDdOemVkK2gwWTNiN0hxajVvZHQ4d0JSRDJhTmMva0NER2g0T05SeG1ESzVF?=
 =?utf-8?B?U2ZEaHNWNjFsTm1oMUl2NGtWMy90ZngyN0tHNExxbGR3WUJqaFRTb2h4NFpn?=
 =?utf-8?B?Wk5mdk11K0tqNytJbDFUNmdScmNiSC9QUytVS0FiT2oyNTl0OG1CZTVsK0JG?=
 =?utf-8?B?ZVAzb2dMbHNydkFaa1BjZXREU0RYVXl3VjRHeGFkaHB5ZGVyZ2lyU0VybTA1?=
 =?utf-8?B?ODJnU0xWdXFyYUJ3K0lNTXlGQnpGUERPZXpRTCtqdmhRNDB4SjV2QS93azB5?=
 =?utf-8?B?eXZXTzB4alRYckpFY2gxRWZIbFB3QU9SRUNJa05GcUpnVCsyQXpQS1pXS3NO?=
 =?utf-8?B?aDUrRkpSNzc0M0NOcXRWb3hvb1pPeURoeXNNUExWalpZNStuSUdtL1pFakVs?=
 =?utf-8?B?UjhIZk91VWNnWWxNTkRpSHJEMGZFcmxTQ2I5QjFRM0lYdzV3bGlYRC8xc0J0?=
 =?utf-8?B?V0EzSG9RTkhwRnExTnlrRlJhajUrNzkwRTdNVWEwVlNYOFdHUkdCVzl6OVM3?=
 =?utf-8?B?dExPOWJoL1hTTjFrSmFNQmh3b1JjZ0FCMVpySFpLb0tPeE5oR09tbVVTY1F3?=
 =?utf-8?B?b2twQVlvYkR0S1V5dEcrNHgvb3I4L00vVjNNNkdKVzZMRkFweEhid2xmVENa?=
 =?utf-8?B?UnJkRGt2R3hDLzJOK1dsSG0xaW54Z3ZscDVraWRUdVpMUVd2alVHYm1HRXhQ?=
 =?utf-8?B?VTllNFg4bG5aakhNYXI5RGcxbWlPQWZMMWhyeEI2ZzVHUzdxb1Q1QTNLRFp0?=
 =?utf-8?B?OUphT3duMlZDUFYyODhUV0pIVzV0S3ExdVVuVVVTQWE5MS9LSTMrT1FDN09m?=
 =?utf-8?B?V3ZUZWY1Tk01RVhWaU80bjZJdzErcUI5aWx2aTZRSzBMVDBtMER0KzBRdjhi?=
 =?utf-8?B?SzNtekxmQzBQdTNIaStpYlRoWHNLYmJZZnRocGF5R2FFVDJYMnNRTGZPY2xl?=
 =?utf-8?B?V0tjbkxjUU1TZldHZ0VTd0k3QXk0MGhJbzFhQ1Rmd2E1V0FjVXE5M25wZ2xU?=
 =?utf-8?B?b1cxTWNyRE1ZZ1htdncyeDI1eXVaZTcrK05tNmhkT3VJNkd4aitjWUs3NVY4?=
 =?utf-8?B?Y1JjRWwza1ArT3Qzem01ZDlrd25NOXJkTkdyTFlqb3daMU9hNlJ0Wnd5YjVq?=
 =?utf-8?B?OEdYUFlWL3M4NW5rMDZQb21EL3JwcnRreHhwMm4zZUcraUx3TUU5ODc3TFZP?=
 =?utf-8?B?N01kL3JLeVJZa0p1VkZQSW5kZm5reFQ0TndoTFNMZUlEb1c5ekxCK09WcmFn?=
 =?utf-8?B?OHRBR0VIdExwSjA0WW8rR0R0NVBQb3RScHpTY0tlK2pQaFZXL3hMUTNhaGRh?=
 =?utf-8?B?bGdFWmZPaXZ5cUIxU2NtNU55TzZXOCt3V200S1FPMlp0S3IvZ2Z1QVptV1hD?=
 =?utf-8?B?dkhnUlFmbHpTdDREcHZ4bkZnNFN5VDFIcGIrV0IzbEY4U2FIY0IzYXZHby9N?=
 =?utf-8?B?ZjZ4ODRhdGsyOEVwQnZ1dU9wQnAzc1NIWVo0VFh3NGZENUthOVowb1NoNjdi?=
 =?utf-8?B?emhiSmpobm1IY3dTRHRtM3hEd1JPN1NRU1BaV3hmbHhQMys4eG9QM0prbmJH?=
 =?utf-8?B?Y0RQK01wL1RKUzNRdTI2dEdpVlVFSDRHYjNKb3UvMXI3a3dPUmc1TlRkdm9l?=
 =?utf-8?B?TUc5QlN4RzdwbmY2cC8zRFBvUkNTUVB1WGtnWXpFSGd5QnFsSXY0TE9ZNDFH?=
 =?utf-8?B?SDNFVEJlYU9WVnFVbWpNcnMvQ0kzajN1UWVPSkVmeUhJOU9BQXpPZmFzSTQy?=
 =?utf-8?B?N1dENFRTSjFGUmRQWnVXL2dWQmlTa0xoSkpQTHZ5N2lMQVo2MzAxRi9BOVYz?=
 =?utf-8?B?N2ZoVEN3TDlVYVVjNEJ5Q3lEQ3V1MUViQURDN0JMbDhEMUVENCtTbytQLy9Y?=
 =?utf-8?B?VFZSbmN2N0RIdmZGWEhoaUxFK1B6QzNnRUFxU3lkaXl4Wk1TaUczcktJenVy?=
 =?utf-8?B?dUJxMzVxbTA5a3ZzOHppRU1JbExlY2pCUUZaV1pYa0QrR3IxSThrcXM0WUtQ?=
 =?utf-8?B?akFXRFR2aHgvYkRzUTlOUTR0K0d3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9c41ac-5577-49a3-e0a5-08ddda5b7016
X-MS-Exchange-CrossTenant-AuthSource: GV1PR06MB8370.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:20:41.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSG8LioQPeEpy8NWmy7RX1s+ycXKM6ihPmU0hIpQuuM/hrsx7Q6E1j/zBrykAZuOEWqDoPun/8d2bDqDg1RekFDNuOZpYD17TFmviRn7n8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8162

Hi Denis,

On 8/8/25 18:57, Denis Kenzior wrote:
> Hi Jussi,
> 
> On 8/8/25 7:28 AM, Jussi Laakkonen wrote:

> 
> Hmm, but we already have:
> 
> #define VPN_FLAG_NO_TUN     1
> #define VPN_FLAG_NO_DAEMON  2
> 
> Wouldn't this fit the existing pattern?
> 

Ah, now I get what you meant. To extend these flags. Well, that should 
be doable here.

BR,
  Jussi
