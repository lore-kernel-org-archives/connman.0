Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020096.outbound.protection.outlook.com [52.101.69.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5962DCF5E
	for <connman@lists.linux.dev>; Fri, 18 Jul 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857552; cv=fail; b=ChKemOnUokt5rnyNQAlJ93+gu4LavnmJq/2bYz7BW1iV7rTLfzFqtnJn/AawFmUo80YRJs1AoaenBQS1gOmH17nAY/NhKMRy5saJ26O4d3jqSIugMySBNXnlMErs4fHsr28WlNezM/1NQHsZWIVHciQ0m5s45XfhQL7xZkr6GW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857552; c=relaxed/simple;
	bh=QvBngUZlfqYOxSOlei+5YfOo1O6x5X6LTJPWeJjQgc0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFyPMG7jd9nMT+7caXKdfBWrQ3lWsu49z9QJAachN9T9no3a/3QjNawXVv9iso+8FkH5qcQRzGP5DCTsLFVV5QsHhqEMH9rCMiDyE+3Tw++9293NABBAva654vl9kXr/xJf8l4amUhBnF7oClt1j9KcPQRyEe/SXrwGyAxUUwqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=jolla.com; dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b=BLW2kIqO; arc=fail smtp.client-ip=52.101.69.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jolla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jolla.com header.i=@jolla.com header.b="BLW2kIqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+YXjOfmol8f4fBp+DZzvgFwnRGxuwclQ954kqpxv74Yk5oSgHuTroAcFdVSF38Y0vN0iGkyIaAlkav9q8oFPjUN8SGLh26ubfoP/IYZbHd5imvAScIv8pXHoTshLGqKFSbuR9G1/O7Hl0PtMXEs81gmbUud4/WBrFAOUU/LQjw4f0KoiXXob6z3K8/vnSv+Twj3B92jdOAch1QXNteQgEjWspGRann5JAxcIjNYX2v17H7mFMszTl7HDGIKlaQiBjnu1IBHaoMZxTtihKc/n3T12oDtVwdICwccVDo4DTNZ4yyfD8JH+na8mdqGwfC2lu67YHqHMlFaXsZkaCzlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qc/A/RkYOoblPUH4CVanay7T9P8rYf302ULlkgCa20=;
 b=lTAyFS3zF1715tZYyWaHR+t8ss5mtkDQz9ogVp/ypbxXvbGVDSFQqQoZHm8+/+UQNrE2ztf4+7B0QiCsFRigApImP3GnkYLsjm4gn+/ZiqcvLhSC1JDvx3G1FgFFXYEfnDA0Lkw0pQCTCQgaSX3YRhOJjPMUV2xEhP7cmIrEflY70EJIKafGQxujEIse1VIbZs7MzSUZmShIBHOuMZx4L+RFDHzuxaSNiQ2sk2CT7PcS4/Z4b4g/q3Jg98YiwZ/MvNNNctoheLuMgNtZ7fzYeqw68uAklPjLBCSdXXitF6vGysiwnSMe3wniyq6Z7qnhfTGIZKyLtxsJ8bl8i593Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qc/A/RkYOoblPUH4CVanay7T9P8rYf302ULlkgCa20=;
 b=BLW2kIqOm5x6kdl1ARp2xpX4ueaq9LCL9d4zDs+aplxP/jzeMNDnJtL2/eTaQVplyEuu0EVqFuA4AzyWWLMr0Yogx0/d8VPTAxq0fyPOQlvIxo8jesren8nt0ABWj+5XRjWykb9RX+cyoji9XAO14gKdynnl2yS8cQrkAefQS+nYRD6Sul09efv/Zra2/1J0qm/KywzzHVmF1l3FQ9VLZS2Ze5QDuDYtS7gZEXq+eHVluvmxqQJmGqJQI+Jfaophi2UxVUG/vr9tJgC1h787kDc4XbN6AtITp9xo+WuSNe5HfqGUct+4n4XR1FTU3m645Y5JosfMS2G9Vo99RrUF2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jolla.com;
Received: from PAXPR06MB8376.eurprd06.prod.outlook.com (2603:10a6:102:22a::18)
 by AS8PR06MB7718.eurprd06.prod.outlook.com (2603:10a6:20b:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 16:52:27 +0000
Received: from PAXPR06MB8376.eurprd06.prod.outlook.com
 ([fe80::a624:3da2:b1f5:e229]) by PAXPR06MB8376.eurprd06.prod.outlook.com
 ([fe80::a624:3da2:b1f5:e229%7]) with mapi id 15.20.8943.027; Fri, 18 Jul 2025
 16:52:26 +0000
Message-ID: <4d0ed972-20ef-401f-ad13-82a2ef594021@jolla.com>
Date: Fri, 18 Jul 2025 19:52:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] VPN association state, dual IP support and WG fixes
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Content-Language: en-US
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::7) To PAXPR06MB8376.eurprd06.prod.outlook.com
 (2603:10a6:102:22a::18)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR06MB8376:EE_|AS8PR06MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 9751bf5a-7a7c-414b-987b-08ddc61b78d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UERTV2puNzF2VS9JK1ZxUXA1KzJ2dkRxbEVMZDkyMUJzVjN6RGgrblViU28x?=
 =?utf-8?B?MHVDZ2ZPclBwQmlCM0ZSM2pHY1pJQmFoSXRTckNXb2wwaThqeStCL2dPQi9s?=
 =?utf-8?B?WnRFNXFQbGx3MExoS3RLcDVNdnNXd2V2VE1tWm93REFJc0kybGJVcjRXSHBl?=
 =?utf-8?B?ZjhaNS9hcGZLdE5tOWo1SzZhSlQ3NWhldTRNYTNjcHQ3c0ZVTHFTWnlFSDRR?=
 =?utf-8?B?ZDBHYnl3SERDQWRUdjV0b0FXSElsQldsWUdZOWZWUzZxbm9oOEVBcmw5QjRK?=
 =?utf-8?B?QVpYRHZYL2s2MU02VGp0Z0xkbXlEb3VFMlQ2NjArWlVxTzJYVGxhK0NzNVQ2?=
 =?utf-8?B?UThmczhyUzhBSW5xRWltNThtelU2aFRjc2d3ekJKSkp4K3pkcnNmSXFNT3Br?=
 =?utf-8?B?cWVENHlQZU5VV2ZDMWNnNVZyMnhCZFBvczEydWRMT2sxSzRBamVYbmdLU3ho?=
 =?utf-8?B?YXNmMHQyOTFlc1ZXMHhLL005ckEvZmdBOGVFaXlRS0ZZc1ZuenMrelZLUExJ?=
 =?utf-8?B?anA3b3J5YTlKaDQ1UldoZUsyWkl6TzRDcVBFL3psbzB3NWd6dXc5MkVtZEkv?=
 =?utf-8?B?WHhKT2s1eGtHMmZ0ZlVNZmx0UGsxM0ZEVG1iWWRoMlRKVDFlM2hvY0xDZ2F3?=
 =?utf-8?B?eGhuZWJnUFE1S1ZDbXR2enZjZk5TVCtPQmVuYXR2aStXaFhHS0dQUDk3QW8w?=
 =?utf-8?B?ZlYvYm53eDRGampjWWJCbXhaSWVlc0V6ZG9Welo4SGNFRTBWb2FVVWNFYXUz?=
 =?utf-8?B?clFySTdubE5KZUwxUiszemx1eHUxYnovRlhscE9iSEE5UDBTTnNZbWN1eXRj?=
 =?utf-8?B?VEJNaCtMOHp0U3hORUNDK3QzdG1YTWVGZVBIa2pQOWUxM2FobUlhdzBVZFUr?=
 =?utf-8?B?SDN1TzF6TFIyeUhCTnFXemQ0cXZBaUtPYVF0SkNSS0p6STAyb29qempmcGNm?=
 =?utf-8?B?NUtocW0yYUhJR0JuVm9UbzRlUVZVR09IeEo4TnM3Mmw3RGdZOWw4eHNUVitw?=
 =?utf-8?B?S1dYU3NZL3k2SlNUNXRVb2VuTTMrQlBIZElTTUJTd1FYdll5YmtERkN5OWll?=
 =?utf-8?B?a0JIUnlhTE1qbllJc0ZVU00wSEpGWnI5clNxT1dYaFQxd1JrNkpSa2VhVzR1?=
 =?utf-8?B?L0IrY2M4WUtjc1dWT2pqY1pEZnQzVDQxYWN0YnlONFlGdDZlT1dneXdoQzJB?=
 =?utf-8?B?ZlFJSWswTzBac0dnUW5VVDlHV2FWa3YrY1E0N0VIamI2RnRBdzQ3bGxTMTd1?=
 =?utf-8?B?azN2K1ZYZDE3QWx1Zy9OdHpISDFOaUdka3RVNGFwTEMyVUR1U3h0MVJ0eGNI?=
 =?utf-8?B?TktrQlZIbmxNSW5CbzJQcWJXbkV6a08xR0xUY2RiUVZTcFNSSE9kd0xUZHlR?=
 =?utf-8?B?bXV2Yy8zVkZGcWpaRnBQa2RuMmZHalhNS0JnNGd3NkJHT2VhenJzNlZZeVhy?=
 =?utf-8?B?bGxyOEx6OXJ1K3AvYUd1eWRMUjNOSy9IVis0WTBnZ2dJZnErcHpuZ1NCbzEy?=
 =?utf-8?B?L0QxaUk0N2xyVHVObzlhbjBIRUJ2UklTN240YnFhdEF6RHNxcDRnNjJ0T2Vv?=
 =?utf-8?B?dCtENnJJQ3pGalNwcDU4Q1A3QXNpaVZ5eU9ZSWxLaGNLYm1tbzZqUjUzKy9L?=
 =?utf-8?B?MHoyZzEvR3Bjb3lWZmF6bmV5OTVGa3BIdmZRYXNjYnhlQlhXc0xBbkRQdHRs?=
 =?utf-8?B?VGgvTHRmR3JDbGdPdXJBa0g5M1NPdmRkVm4rMlNBcXg0czRLdFpqdDhqa3Rs?=
 =?utf-8?B?bGVwdEJOMmVBRjEyam5wd0xLZzBncVlGTTByZ0VMTFNTUHJXU1dFak81V1hu?=
 =?utf-8?B?QTRQOXVDeGxIbkU4SXNhaXZMRkJFeG1aMmdReGNOekgzNHUxamhTUHBxdk1y?=
 =?utf-8?B?VWdCWmV6SEZjcG81QU9PT1pPY0RHbElHalJZcVl2OFVRUG83WE5KSFU4ejBJ?=
 =?utf-8?Q?jgSfbos1Xbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR06MB8376.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFtQzFXdFdFN2hXM09JNVB4bjFGVE5EQ0RKMXFZaDJaQ0Z6czFjc0VNMm5B?=
 =?utf-8?B?WExSRXJ5MTBWRnZ6RUR2a1RnQ1FOeXByalVLWDM2MmhzUUl6SkdUcFhoUVlT?=
 =?utf-8?B?cDdSelp6OGVwVXhrdi9YSnpieXo5QndsZWJJam0reldock1YWENCenk1YUJq?=
 =?utf-8?B?Z2Q0TEFuRlFJYlpJQmMxNlhiejFwMjFqa3h1MnlGb212MWVWdDZMYUt5a0t3?=
 =?utf-8?B?SVJHR0hsQnJSbFZEUVNMTkF4cE93NEF6THRpL2xwVUlmWGQ3c2tqVFJVS2px?=
 =?utf-8?B?VGFVWmo1T2dVWlU4cktaT21Uazh1VHo0QWtNQ2k4dmRFMS95eVNQeUJyN3dK?=
 =?utf-8?B?eTh4OWFZclNMbjNVUCsxVVJBVjgyY2l5TjFKWUVGYVZDNk9qc2lWdnY4aHk0?=
 =?utf-8?B?VThmUklCbVlyUy80cmRSQ0JkTlVhWVNnVi96a1pmR0c2SU1LYnBCYWNXb1J3?=
 =?utf-8?B?MHRGZkhiRWExY0dRRzAvUUpMdHZxb0tnUE9zdjVTNXVlc3htNG0vTDZMcUQ0?=
 =?utf-8?B?b1cxU0p3QWpORGhNdEt0dEp4c2pNSkZLUk1EMjdsMWZacCt1aE1RZkRWbW5u?=
 =?utf-8?B?NGFnNFhqOUhMUFI2bWoyb0t6YzlFU01nb1ZyM0toQWt3aE15SzNvb1pIclNC?=
 =?utf-8?B?QlRCWHk4T0RTQTd2SitaaVpJQjJhVzFMOWhnNFl2RDB4YlpIUndHSlpvdzQ5?=
 =?utf-8?B?WDN1QXR2NlZ6eWNSQjExUEVRNC85aXd0YXlVTFJlNWtFTWl5OEJ1SUhoUWE5?=
 =?utf-8?B?TnErWUx6aklOTkFLY0NkYjJPRzNkbldBelFRQVRPZ29TZkdjYU8rckIyOGo3?=
 =?utf-8?B?WlQ1Ui9RVUk5eGRQUEhBR3Z5dnJvVWRBUmpaTDlEUythTzVkeGRxV2JBdnpj?=
 =?utf-8?B?b3pXc2NUV2htR2FDTC84S1YwS0IvcWtNMy82am45U1pXd2VwSmMzRjZkNHoz?=
 =?utf-8?B?b0lEL0diS3R0M0hZWjJrY04vMVluRVhJc0l2eHMvN3lVeXZ3TWxiTFUyZzg4?=
 =?utf-8?B?dGZxMHNzdmJnU0dYTWJoZ0E4UVE3QjhIeUdOOFNWdWN4enJxdHNCWEgwMi9t?=
 =?utf-8?B?MG1HSnNKbVlTNUF0TllaL1lMcHZvbVloWGNXK3g4VEdJS2dmTVNCR1RnRDh1?=
 =?utf-8?B?dlZqOVpDQUIweU82Wm4yMm0rNE5IYUhXK3ZzS2grTVAxdWdQTnlRcy9mUm1K?=
 =?utf-8?B?OEorRkdqc3FOWTZrakpZNjRybHl4YTYyWVlqdU5LZlRVeWxBZzRPakpvaWVW?=
 =?utf-8?B?QUo3SmNWMnlpeVk0N1hOZUVmMytaM3FncVVxaTY5dnhxSFkvUVRJWWxHMkJh?=
 =?utf-8?B?Uk1mUjBjRDcxK1NjWHpRUkRkeVZpMDV1UzdvcUF3QzdWTEx6MUZTQVhRNVNH?=
 =?utf-8?B?TXpaVHlUYVZMYUhHUTlFNUZ5RnQwM2ZXUnNld2FaUEc2SkpqNlZIRGFEbzlN?=
 =?utf-8?B?azN6bFZiK3hTSlplNTNCMGtPbnc3WnIvWTJlb1NRQ0cvU2hoeTFxY3FXTE53?=
 =?utf-8?B?aE9uTkFJR0Z6VUNJTXBzOGVSOGlaMkUxcytXa1VIcURYNjlyT3RHSFRPczd5?=
 =?utf-8?B?QUdwa1JNSzZxUGVldE9NdDk0bkJCVDBocmQvcFkxVTN5bHZoR0pCVE9LUDhm?=
 =?utf-8?B?eFNjVndwRjVudHZnSndpck9laGdjVFlxVnRGOGVZcWwzN2NsalRSMFF6V1RQ?=
 =?utf-8?B?T08zYXVpMzVrN3hKYmZ6U21DdEwyUllwbGt1Z1ZkQ1BMaStlOEkzWDVpcHNB?=
 =?utf-8?B?K3ZUQStvYldOdGJhTExkbGxqb2syUlM0WEwrMFBRWnVvdEZMTk5kS3BzVzI0?=
 =?utf-8?B?NDZkdDQ4cVRmaUtmbWxEanZWZXpkS1NyY1dRem1kM2FGOHVpSVhiZEh4bk12?=
 =?utf-8?B?VEJGWVpPMWZMczdBcXcyTm1xTGdlTXBnNTB2dmIxU0hNVHNFL1VDNTFiVHdD?=
 =?utf-8?B?aFZmbkZxQytXNGxXdHZPMDVBUE9PYW5CU1orUkQ5a1RsSmZ0WmNlTENCZ3Zt?=
 =?utf-8?B?aEFHTncvajdzV0NnRTNYUjIzOTlPWGxIOEMzazZoUEpuckdaSlpNM0MwQ2RJ?=
 =?utf-8?B?L0s3S3JMcVAzOUtDcHBoUFhBUFZoTzQ2aFluaVk0cXdFTXh3RTJmMk5aQmN5?=
 =?utf-8?B?M0V6VjF0VTlCTkxJRXJFWmlySjk0VnBZWWFtUzBnTnYvS3BWaUpSbVIydmdJ?=
 =?utf-8?B?Yk1PM0NoRG5lZjFkQnhSWG5CMUk3TlRHazlXL1ZOTlFIdDU2SjZpYmN3Risy?=
 =?utf-8?B?azc1SkVBb2M4dStjWXZjV3pxZHV3PT0=?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9751bf5a-7a7c-414b-987b-08ddc61b78d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR06MB8376.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 16:52:26.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK6KNStLvvr+Q+nRfBCFOdR/fxqV+XeDjSR27IQEJz4bZMeRJq058n2NV2c7LNtj7AJxP7hZrpq2mJkYBPrDV8ukGSomqCcUfwyXrw5dJe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7718

Hello all

On 7/11/25 17:26, Jussi Laakkonen wrote:
> This patch set (1) adds the association state also for the VPNs, (2) implements
> dual IP support for VPNs and (3) contains fixes for Wireguard address,
> especially for FQDN handling. This is a combination of all three improvements
> for the sake of testing them together.
> 
> (1): association state for VPNs
> The association state is to indicate that the VPN is waiting for VPN agent to
> provide input given by user. In this state service.c must not do connect
> timeout checks as the timers for both differ in length, default being 120s for
> connect timeout and 300s for VPN agent dialog timeout.
> 
> In order to facilitate this change the association state had to be implemented
> also for VPNs. It is common state for services and like with services the
> association state for VPNs preceeds the configuration state (on VPN side
> connect state). Both vpn.c plugins on connmand and vpnd side require changes
> to accommodate this state. When the VPN agent succeeds in getting the input
> from the user the state transitions from association to connect (configuration)
> state and, thus, requires no specific changes to VPN plugins.
> 
> On connmand side the association state is the initial state when VPN is getting
> connected and the state needs to be accounted as a connecting state in
> plugins/vpn.c to not to lose transport ident for it and in provider.c as a
> pre-configuration state to not to start the connect timeout for the VPN before
> the VPN is in configuration state. The reason for the latter is that the
> connect timeout should be exact and start from the point when
> connect/configuration state is entered.
> 
> On vpnd side association state is, like on connmand side, the initial state for
> the VPN getting connected. After the VPN agent succeeds getting the information
> from the user (credentials) the state transitions to connect (configuratioin).
> There may be a possibility for a VPN plugin to run without VPN agent and thus
> in these cases it is ensured that the vpn/plugins/vpn.c:vpn_notify() does
> the state transition in such cases. It is allowed go back to association state
> from connect state but not from other states.
> 
> (2): dual IP support for VPNs
> 
> Dual IP support for VPNs is implemented by adding an family extension that
> simply uses a boolean array of 2. With this IPv4 and IPv6 can be both defined
> on a VPN such as WireGuard and provider.c will setup the addresses correctly in
> connmand.
> 
> (3): WireGuard fixes
> 
> This improves the WireGuard plugin and adds better error case support for the
> vpn/plugins/vpn.c. This allows also to propagate the errors upward and with
> other changes, allows the shutdown to follow the same process as the other
> VPNs. Also fix the PrefixLength use in the WireGuard plugin by tokenizing the
> host before getaddrinfo() check. One of the key fixes here is to make FQDN
> work with WireGuard. Also a new option is added for using the transport
> nameservers with WireGuard reresolve queries, which by default is off (false).
> 
> First, the basic saving of the WireGuard configuration is done similarly to
> other plugins, as well as to what wg-quick is utilizing.
> 
> Second, the handling of errors is improved within the plugin and vpn.c as well.
> This will make it possible to pass the errors upwards from the plugin  In
> addition to this there is a limit for reresolve errors (5 by default) after
> which WireGuard plugin dies in case the configuration is wrong, or network is
> broken.
> 
> Third, the use of getaddrinfo() will block with invalid configuration when
> doing the reresolve for the endpoint. This is now replaced with GResolv by
> adding a wrapper for it in vpn-util.c so it can be used within VPN plugins as
> well. This avoids the blocking of the non-existent address resolve that made
> vpnd unresponsive for the time being, for example, disconnects did not work.
> 
> Fourth, the shutdown is now simulated in a same way other daemon utilizing VPNs
> do, by calling the vpn_died() with a slight delay. This makes daemonless VPNs
> work in the same way as the rest of the plugins to do the same cleanup steps.
> 
> Fifth, the host given in the configuration as an IP-address should contain
> CIDR notation but as getaddrinfo() uses inet_pton(), which is relying on the
> address to not to have the notation, the host is tokenized first for this use.
> 
> Sixth, there is an option added, "WireGuard.ReresolveUseTransportDNS" that can
> be set to boolean values, "true" indicating that the nameservers of the
> transport are used for the DNS reresolve queries. This may become useful in
> cases where user cannot affect their network setup outside their devices. By
> default this option is set off, and is saved among other options.
> 
> Seventh, the FQDN server use is fixed by using the resolved IP of the server as
> the gateway. The reason this broke networking was that the FQDN name was sent
> to connmand "as is" and it was used as gateway, which could not be resolved
> when routing packets.
> 

Forgot to add:

Tested by: Christian Hewitt & LibreELEC community


BR,
  Jussi

