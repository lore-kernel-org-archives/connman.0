Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F343FD6
	for <connman@lists.linux.dev>; Mon, 13 Sep 2021 09:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7eR4TifCsfgOiaBIDC2vjP/cliVTqJIkgTABD7OckS8jlgLpm+S6yR8OtgCLf8Tze8JhZmenyfPpdD/7umueIlnLJyPdgTdKd526Nnk3GylBwUKDePMhFVHZmAh6vzy/w9DWVx/+msOG+dpCq6AwSjDWrmbN/6TqdE9TB5ccEj7zMadueGaWYpnKV3oT5cpzVljTDTThO6epKKMadi0Ky+LaTa+2R1M8ve7GpB6Cdo3Mx64cWR3UWrQAnztjV4627dgNeAyFc6Y8Nr7dmg8ITn27PstWnG4FUt6G2vSPlIP/niUz2ueZmhSEpxsFhtu0wz877cfcjWBIXoWrGHGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nsxOSALCrZ4QGRb0ohifyzBd8REXibKMXdBAWBa9keA=;
 b=mc5SAv9KW5EXZvvRC4vwRH523UZ6UD4ZrBnTpMtOyw23kyVJnCMABfZwCjGcUxzT54UHCAjXZYNuy2QG6rcdp5oFMEaqeirL/Ykiif/s7ThC3P1GpupGFuMsH6vRe58xPy3JtiEKfnhhV5R3jV9BNjm6ARuYhSI6yFGFfuVOBVnPWFGpEAOLdO8hjtO24IBfYFb5a7LY0YIiXasohtKemNwpe7FdypYpUxE20dO+jy319je+0qbAP5dDPrtj0U9DrbXt6tmzbXiCeX6TzeSmbjIrQoJsvXyNKYrOfQX9K3wCgsLvfg4N63ertltAjNot7JnFzm2ouzXRekinxAa5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jolla.com; dmarc=pass action=none header.from=jolla.com;
 dkim=pass header.d=jolla.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jolla.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsxOSALCrZ4QGRb0ohifyzBd8REXibKMXdBAWBa9keA=;
 b=Ys5r+/ZqcU5ekJm6LS3kn7uV8bTkLAoB63VMKJp5ubm1/oNSAluXfnNlo4NI1L2kw38zOn22D2K0B/qcDWfN3+MZVNxrMEmnN597P5ldmKEafUtX7ujJ6i8H+d2LsJmM81bSm8oPmDLmdD+09U7r8dyrkRVQOdMnzL0KBQb80F1wXkLN6zQicCmhr0MctdGER5akGpBxpwFxPpL1ySsJ+XWgvFdKI9ednT3L936Zgp6UEHQNisCAQ+sPaMqpxyXb9SxshWYaYQvTKTKmyydXtZ6Lxdy4RACXm+usK/CwroQPUNOu3/XCd2OC86aaiHIYONl2DJG04xrWL57pJT9GVA==
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=jolla.com;
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com (2603:10a6:7:89::11)
 by HE1PR0601MB2684.eurprd06.prod.outlook.com (2603:10a6:3:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 09:36:16 +0000
Received: from HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9]) by HE1PR0602MB3420.eurprd06.prod.outlook.com
 ([fe80::d084:24c1:485a:bdd9%7]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 09:36:16 +0000
Subject: Re: [PATCH 0/5] Add heurestic and customizable value for VPN auth
 errors
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20210902151124.4983-1-jussi.laakkonen@jolla.com>
 <20210913064345.7vbamqejzttgtyhw@beryllium.lan>
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Message-ID: <81edfa88-a094-14ab-2e6e-4c04d849cfad@jolla.com>
Date: Mon, 13 Sep 2021 12:36:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913064345.7vbamqejzttgtyhw@beryllium.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:3:76::28) To HE1PR0602MB3420.eurprd06.prod.outlook.com
 (2603:10a6:7:89::11)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.8.1.8] (194.110.84.60) by HE1PR0301CA0018.eurprd03.prod.outlook.com (2603:10a6:3:76::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 09:36:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878456cf-c1e7-465a-fb53-08d97699eee7
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2684:
X-Microsoft-Antispam-PRVS:
	<HE1PR0601MB2684114686B0C3520AA0451FEFD99@HE1PR0601MB2684.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1nwVAQM01DwuuyukKqh2QL902ZUpqy6wYmPSG6NYerZj+m/ZWUgsBoVB7lMXETezk8DX/rr5GbGs3IyqFsTY8Sr1W50wEYavyI4kF8Q7Sv1adUVK0FC1n+cLGyRJQC5rynjUHjgfi662sPxThqgbr4+SuBU1qCkGPq0sNZm4xl9tjXa5QMYoqpJkpKE16OdSjG91iupPkc6U5rc62bvmtpgP7TcZSw7iRUbjg6cgDzY4J5AmU0fp00i1lEdRdOZAqKklIonpFp3Q8lZVZaORNY+Ci6/Mih5bsKWKEwnkCZ+ApgvXi+LIE6g3VcvF7fl4t9j6BKUOfsu1mFDDqyu8EQ8MXkvFH24fwS9vlvJUg5u2E3u/0olvGsZ+3ERWLywtHgj0wHvjqR8eUzF5zLTpa5D7VM1RdxaEat7Eq5A1mzN66a1yyun7K114l+i0pfLu8XAxLJSotPuBp99HY725ssojk3r97D/+IKlU8DTRXJoQTTgT11xItHb16mAgfq+Iv7oaAbm3jUncD3sx+zf+CgMKb15U3JJ2sUnYXRLNjRZVNrPqfDy5bfANmwrn9RV7tJyZzlawiNOktMbH8auNtgrObFgRFDvTZWReCo68VmeJOK/KJjLEygvEH4j0dfMHkSQt8pJ/TQ/UyTxVFtNa7vjyiOC4Mftqp6QI96DcnDi+8AXPY8zPybm+tZoHPSF0mLNNWZBTmfd6wBY63hfFOcAJTT3XRjnkApgvjbXW/O2whEipWzTariYd7ORp+OAzUvanKrCBRa3frXmjNnWtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3420.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39830400003)(346002)(38350700002)(4326008)(38100700002)(2906002)(186003)(52116002)(6486002)(5660300002)(26005)(6916009)(8936002)(53546011)(66946007)(316002)(16576012)(86362001)(956004)(31696002)(36756003)(8676002)(2616005)(83380400001)(478600001)(66556008)(66476007)(31686004)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUI2L25PcHdhc2ZFMDdrRUxVaHI5TnFBSE84dXdDQnlTQzdpK0c2bHVzaU5U?=
 =?utf-8?B?OCtjajkxMCtlMndtNUMwWUY2cFBydjdXdEgvYi83RFhKWDNwK21CVDNoSFdt?=
 =?utf-8?B?M21TcnB2blBJZW5FZ3RNbnFDaHdhbGhNcHlOa3UwRnVmV2s2eFMyN0FKcVNH?=
 =?utf-8?B?aFpKcmNNNGVvdVdyaGM2S1JVcVJ5M2tQT3dqaS9EL3JoVGZqWHBrZzdxVU5T?=
 =?utf-8?B?VzRHRE9WOXZnWExwNVNkS0RUTnVCc1dET1d1dXpaSVZuTER2Q2psQUNiMDYz?=
 =?utf-8?B?aFB4ZFZxeU1qNmtFKzJEbUk2QzBtVEFYQjUvSEJKWVJ2RFJ3bjV6M0Vncldo?=
 =?utf-8?B?SUYyZnRWMUJtKzNEbWI1V1o2TmJqSnZZcERrcHRMQnlDSnBPWndlV2w0c0RJ?=
 =?utf-8?B?OW51OEdOTDQ4dG8zRElBU0xyNVU5Sy9YaVBIMGpxaXZteG15WTk3c2R5MDFN?=
 =?utf-8?B?bXl1c1c1VXppVmtBVmgwQ2pmaWRjTkJJL2hrVjZIdXJtRkVWZnk4cEpMamVG?=
 =?utf-8?B?SU4vREdmZDJJL09lWVFJZGJxZHFNL1AwYjgydTQvMGZ5a2NLZzFXU0xyS3VX?=
 =?utf-8?B?RnMzc09BZ2lsVjVXQ2QreUVYeXgxMGs4MDM0UWc1VS9yUWM0VFdyY0RUN0lB?=
 =?utf-8?B?d1Y4SGdQc1VtYTBoSkx2M21leHp1SXJLZVBMbm92bHRwYnFVMmpSNnp4RTlx?=
 =?utf-8?B?THZSRCtZdTRjaTNIckJQUk9LVDZ3UURPbjRxRVVoVjlpeitRdEpIT0MyMXpv?=
 =?utf-8?B?cXFpUEZ3UVAxYVB4cnV4WENQYnR4VTBCQk1CcDF6Z2dLVm8xOTQrRU16alc3?=
 =?utf-8?B?QjZnaWNtZkFKMTQya0V6YURnTENtOExyNHJhaDh3eElTVUpPSVk4OXpWZTdC?=
 =?utf-8?B?WEpqTlBhTnFtS3JVT3M2OFNvVHlSZWxWd0tXNHB5cElwbUhybnVwSEZPNnAw?=
 =?utf-8?B?dFpsQ1BFK3pRZUhFaGlGQS9pc0ZhUmdUV3R0VHY4Y1dLckdmVlBoUUczQTc0?=
 =?utf-8?B?L1I5OTJUWGMwZzVwZ0pSL0ovUWxscitMamt4cC95RitoOGl1UWNscDRRS2da?=
 =?utf-8?B?dDEyaFJYZjlHWmp2Vkt2aEJqdkJDYmlGeGhvUFI1VDFBTi92dUVLc1FJbWxh?=
 =?utf-8?B?a3Z5bld2dWNpaDdOeDYwbnN3ZVVFVVVUaW5rMnE2VkhsWTVqa3NRSG10M1Nn?=
 =?utf-8?B?MVdIQktMQ3dvS3RmVUlZNE11UEZzN0hvdndyWlBycUQrWFdZM21DTUgzYlZa?=
 =?utf-8?B?NE9YeGFIZGtWRmg5VVJxSTBCR3J4bUJjMDZVRnEyOEEzdnF6a05RT3NuZ3Rn?=
 =?utf-8?B?eEh4K1pQWGtYU2dwNk9Zdy95ZWh1TUNEcWcvV2FIblR2MGFaT3ptZkloeTFS?=
 =?utf-8?B?bnVPTHN2emVUazlIaVZNaFB6NVkrN1N4ZnJIYlorMFphQkU3SU9kZVJNMjR4?=
 =?utf-8?B?a0xKM3haaVJCQnBXL29UcnUzZzVnK3k0akw2QXpDOStNMW5jYThocHlkZFNY?=
 =?utf-8?B?Znp6Q1NuSjJ2OFViVHo1SGkxUDZCdnMyS1gvNitybENHTzZuRTcyaUNSbXFS?=
 =?utf-8?B?blcrbnU1RHJXeWpyNG9hUXZBTldqT1BXdy9NRDBLa01oVVQyOVdDeHpwL0o2?=
 =?utf-8?B?d3gwTldoV09GcmJoUnk3bmhkd1dPWm1oSCtTQWJ0WjdHa2hmSlZyKytOOFBZ?=
 =?utf-8?B?cmJmUXAwL1FWZ1BLQXI3NVpob1BUc1h5cC9KenpEeXQyTGVlNERZNkQ3dW9u?=
 =?utf-8?Q?oE8Jn09sCD1c6dENaIqPPewGRNY1KWOr5TxZuXh?=
X-OriginatorOrg: jolla.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878456cf-c1e7-465a-fb53-08d97699eee7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3420.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 09:36:16.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b6cd1562-9512-488f-a364-34d46554c96a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sEyDI5CVF8rO12QAGtIrNUvR0B477TjvmmJim57eydqRxTc02dJC20KbL9ID/5YvfQdDU+RbqTf0EiBDgoiPnuLK5+E6YwaiujljPzN2tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2684

Hi Daniel,

On 9/13/21 9:43 AM, Daniel Wagner wrote:
> Hi Jussi,
> 
> On Thu, Sep 02, 2021 at 06:11:19PM +0300, Jussi Laakkonen wrote:
>> Implement heuristic for auth error counter to avoid losing credentials
>> because a VPN server can report back AUTH_FAILED control message
>> unnecessarily. This seemed to be common with OpenVPN providers that
>> allow only one authentication at a time from one account only and until
>> a short leeway-time (usually 30s) after an improper disconnect the
>> credentials are allowed again.
>>
>> This is achieved by adding a per provider property "AuthErrorLimit" that
>> can be set by the user via D-Bus or by a VPN plugin. By default one (1)
>> auth error is allowed until credentials are re-requested (or cleared by
>> the VPN agent) if there was a successful connection made in the past
>> hour. The feature can be disabled by setting value 0 for
>> "AuthErrorLimit".
>>
>> This was noticed to happen in a scenario where an OpenVPN is connected
>> over UDP or TCP (with some providers this seems to happen quite
>> frequently on both):
>> 1. connect VPN over cellular with autoconnect set
>> 2. connection is switched to WiFi and let VPN to autoconnect,
>> 3. set cellular off and back on again (WiFi should be preferred here)
>> 4. disconnect WiFi and let VPN to autoconnect over cellular
>> 5. re-enable WiFi after which VPN server reports AUTH_FAILED to client
>> 6. next connection attempt re-requests VPN creds with error set in msg.
>> Usually this is enough to time the network disconnects in the sense that
>> OpenVPN binary cannot send the disconnect message back to server having
>> following in the system log:
>>      openvpn: event_wait : Interrupted system call (code=4)
>>      openvpn: SIGTERM received, sending exit notification to peer
>>      openvpn: write UDP: Network is unreachable (code=101)
>>      openvpn: Closing TUN/TAP interface
>>
>> As a solution each provider sets a run-time only previous_connect_time
>> using the monotonic boot time clock whenever the connection has been
>> successful. This, in conjunction with a limit for allowed authentication
>> errors is used to determine whether the actual authentication error count
>> is reported back to the VPN agent or by returning 0 attempt again with
>> the current credentials. After a connection has been made all errors are
>> cleared. If the connection abruptly goes away, e.g., the server is lost
>> only the conn_error_counter is increased and previous_connect_time is
>> cleared but this does not trigger clearing of the authentication error
>> and, provided the credentials are still valid, the next attempt succeeds
>> when the server is again reachable. Same applies for a proper
>> disconnect. Thus, this solution does not interfere with normal cases but
>> mitigates unwanted credential loss in case if the VPN server determines
>> connection limit being full and reports back with an authentication error
>> message.
>>
>> OpenVPN sets this value by default to 10 unless already defined and can
>> be disabled by setting value zero (0). Some VPNs may not require this
>> option and that is why lenience of one (1) auth error is allowed by
>> default.
>>
>> Also change to report back EALREADY in case a VPN is attempted to be
>> disconneced when already disconnecting. It shouldn't be treated as an
>> error.
> 
> Thanks again for the extensive documentation. I've applied the series. I
> assume this has been in production for a while, so it supposed to work
> :) And it doesn't look too complex to figure out what's going on. So
> let's see if there are any regression reports (which I don't expect)
> 

You're welcome. These kind of odd issues that do not happen that often 
do really need a long explanation. If the fix to odd issue then has some 
issues itself these kind of stuff in commit messages help a lot I bet.

Yes we've been running this for a while now. Wider test comes when the 
new release comes out. It may be that the 1 hour limit could be adjusted 
downwards in the future but wider results show (or, when there are no 
more complaints - the origin of this was a report from an user) what are 
the most optimal limits. That is why the attempt count is an user 
configurable value. I'll setup new patches if needed.

Cheers,
  Jussi
