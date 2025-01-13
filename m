Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2128.outbound.protection.outlook.com [40.107.241.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E723A565
	for <connman@lists.linux.dev>; Mon, 13 Jan 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767430; cv=fail; b=GpSClsuk2IQfishRCY8imiyd23wCbUPmlogUqT5mj1GOZGq6gmZRWU2j/E6f/zBtdKmcArfA9yTyrXb/A2OQS6ZRAN3TaCD6eGoehORSmJ+iv2dnk7URNM5diwvIf/VkYlXUhgyJFRqTBn6iZn4TndG5M7/fRb1pHFoj0qz5Vmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767430; c=relaxed/simple;
	bh=n0YWBNrxGDqjEU63Tc1eDsMPE2rgotzn5JItYIVw8oo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=izCYQmktEEpzwq+G7lng3y5yyWE6VGN0wXd+VJY7ty8BMyPpKkuIHTv58ce5nbKyvNy8q1+F7JoySYwRjYfjchUEqQrkKyCQrs8V6oQKzN6v3H2WmQI2pqhZi0nXLk+s/hikOFi9fG8aNQPlS/IYOwmFw5IhD6odT0WxOtFHLis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vaillant-group.com; spf=pass smtp.mailfrom=vaillant-group.com; dkim=pass (2048-bit key) header.d=vaillantgroup.onmicrosoft.com header.i=@vaillantgroup.onmicrosoft.com header.b=LWLrBTy5; arc=fail smtp.client-ip=40.107.241.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vaillant-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaillant-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaillantgroup.onmicrosoft.com header.i=@vaillantgroup.onmicrosoft.com header.b="LWLrBTy5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIvw+xU0eyr4WwuFyrPPw7DOJTuwM5Mgh4nCXvq9LmvfAXJ7Qacov5uq/ST49AcT1DPMSfDBrBCPObsP1/iN9UlJCWwnQqyEvEsuSTMqF0uOh5lszn64jORtc/Uer9zAgwBkNLokSZyVghl/q+tm7/i+zqgziO643sn8nWhFY5YdL2H1+h7SmuFe7nDqE/hAUNmh54cPXHfAer5MmL7OXAQtV59hVfATnoZ6u0deURVhuR9Qj9/3IaAZIMep3aRR5P6HfODKsaGdXEGu2Td0YzPjUg4p/1t2yiMP3ZKHuR/6OQigsucn4wGiNwk2W5fB26/EPk0y5keVvr2uSVBI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0YWBNrxGDqjEU63Tc1eDsMPE2rgotzn5JItYIVw8oo=;
 b=YWIc7a2z1j1Fpwt1Bzm4tkPL3u36mC4cDFayc4TSzpn/bjXmFodT9bXSjEsnrfSQVNWSmfvimGqiLxOYfhqP6BhCVNthvoBbIV0c0fJJvbzmvZFq6X2rU9bPOmSZsNWhnrdn6YuXDqD3q5vE+FRWVlNjX5fKeNWxptLKK5lfkTvvB5V/NraQFjLmbajMrixVEr9L0ugK3pHnyVht9hd72xn9qyj8SL4hTulqS76YPDBPPWA7h1FvZMafYL/tkwOr6G3KvTHbu263dVnIkVWOtDFMvuH2PuNnZjRQWq6WousRAj0IjaINDQ3eS8sZcgnu3tPSYWEtGOa9Ma2BYKKt9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaillant-group.com; dmarc=pass action=none
 header.from=vaillant-group.com; dkim=pass header.d=vaillant-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vaillantgroup.onmicrosoft.com; s=selector2-vaillantgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0YWBNrxGDqjEU63Tc1eDsMPE2rgotzn5JItYIVw8oo=;
 b=LWLrBTy5Vc4tz69R4drSCqwioptvl1doPizCDFEuZeiS51aMp6My9Bck6Z8wILe8xSzHqdbogWCW2kPNKngOpol+n7SN1O7VLgy7un01Vc5e+SXlN5xrlNtcx5hC0a/pfgDGl9OZLYXe69CN6vmUwXXyxudPjmEJUKvoQIxHrFhkTrsJQSM/N1oJ/1/C2nkZHwOaP8+OJ6KdDV4uFQcFLeEYjhXzYFFSbtbhHcufoOAeCf0NjZfAXEZIKXuy3jDsld8DWuLod95zPwHPguHBmHu2q9l5PLlOuzTt4pGI4m3oHml+Mglfgff6h/uJHuLir9vIYQccwCVhjy4EXOU1wQ==
Received: from AM0PR09MB4500.eurprd09.prod.outlook.com (2603:10a6:208:18a::18)
 by VI2PR09MB7413.eurprd09.prod.outlook.com (2603:10a6:800:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 11:23:43 +0000
Received: from AM0PR09MB4500.eurprd09.prod.outlook.com
 ([fe80::8471:7382:7dc7:af9e]) by AM0PR09MB4500.eurprd09.prod.outlook.com
 ([fe80::8471:7382:7dc7:af9e%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 11:23:43 +0000
From: "Dieterich, Peter-Simon" <peter-simon.dieterich@vaillant-group.com>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Bug in stats module causing endless write to file
Thread-Topic: Bug in stats module causing endless write to file
Thread-Index: AQHbZakfdAr+StbFy02Xyw6LqBzYIw==
Date: Mon, 13 Jan 2025 11:23:42 +0000
Message-ID:
 <AM0PR09MB4500BF2A13FBACE6E7046E23881F2@AM0PR09MB4500.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaillant-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR09MB4500:EE_|VI2PR09MB7413:EE_
x-ms-office365-filtering-correlation-id: e698c212-365b-477c-25ac-08dd33c4bcc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0ZLU7OGeZkmFMm6bP2vBgT/90ncYqsJYzzmVzIT1tqt9oZEcX3ZsXc+9mA?=
 =?iso-8859-1?Q?nz6uJurwSwBJn+OYDRVDBaju4bjRoe6T2d28gnhuzYW3PM97kQmRPFfLre?=
 =?iso-8859-1?Q?qDAvA25eFqREW5AcACPodoOGlKASNTJcUAtqWol2jrrsFSaDIztza1r0Mo?=
 =?iso-8859-1?Q?KwjTVT9bHcvjoeoTM8eITAj+S4/UWZe2jiDC9Dp+bUhl96R+a3bR/sO7K+?=
 =?iso-8859-1?Q?ophesZja+3Aj5G+mfoyuMFBl7JfLYSB319CmkSJhQKy66oIpaDMPMjtVc+?=
 =?iso-8859-1?Q?4teRDGsnHmToUKMvxIRWW/qn6wyuXmE/R5BcAZaPmIoGBlFKvvYGw9Ii/J?=
 =?iso-8859-1?Q?cLUxQAvuHkuTxqRib/d9zJL10qCpocEJ7VU5srvo1bTacZoJWpr8xkcc25?=
 =?iso-8859-1?Q?jseYdKWBMtadKANy4lcSfE/S2Qb1g9Hp9j+iau6SdRnaSnpSCgToWDmNKZ?=
 =?iso-8859-1?Q?UG5wZEbC19ZvVQ1QthIwvT5s6Tngd8fXvlxhL6PS1RpNNJLv1TLvFM7vdd?=
 =?iso-8859-1?Q?p/uZVAupL6cecCs7mURNrRzKEZbVY7Zdayw05nTzsh1TlbhlrCDQ1ZHlHx?=
 =?iso-8859-1?Q?HoNYFe0/cyz2CZUUUS6172eNBd/ku72RMpg0rpMkxZudfi3TQOPUSItdmd?=
 =?iso-8859-1?Q?yxalK3obhegg2WiDd6Ea3MGGDCI3SmZdv05rz/Zj+x1fpn8FKRA3+wIRJt?=
 =?iso-8859-1?Q?jIVTEAY7Enxf+En4RkUYCXH+6jHbBZs+gD4vzkbkFvSjl3jasmU79JCbzl?=
 =?iso-8859-1?Q?IWxJs5Xg3VNkf4VvYJWZSveKkBBBVAUG/UgPC+T5SsX9+dy7i7yKS6ZXdC?=
 =?iso-8859-1?Q?F7vLHGwXODiiBl1q6s3UAWWghEEBVwpUBJc9VFpDM44tPevAdu3j6gY36F?=
 =?iso-8859-1?Q?yqviK14GlFoc/impghL903e4k7ySewBZ805mF/BFkPWUmnyhLJtw2Fnx8v?=
 =?iso-8859-1?Q?/wgujzaKTTyhvyOOTiSHX6EEkRDbLKYLHF/eWqMmwI0XtKC4uE9Nec1mom?=
 =?iso-8859-1?Q?oQOdAKpl4uFwcqWouL0+1vGx5IIM9P54ZcpmbEgO4YjcYLFBClClaWK6Mj?=
 =?iso-8859-1?Q?Iv20hDwstfgf6Tv/frAGtqwYpcE4+Dr0I/8XwDprnwqlXQnQ8cn/VVymjb?=
 =?iso-8859-1?Q?/xRonMZIa2PVcvmJgMZ1Pw2LsAbnKqVzVpHhrKOmmVdoBx4pG9Es7eh3H+?=
 =?iso-8859-1?Q?DLj78JFUGy/ia6Vr6yEf65yO9BrC4EbdisRHpvmrYRNu18Ds4ipm7VIH5c?=
 =?iso-8859-1?Q?sSdSY7FwXKvX6ItLZ0UG58gZHSegztDJmHR34u3wbfGML4z/J/zJgXwUyN?=
 =?iso-8859-1?Q?7uO3Lz0BSCETAiZi2O33/6mDfAQ02dfmDuDGbhHfgg6zVi3plMbWLrR90i?=
 =?iso-8859-1?Q?CAEESYCKtpySHraTYc336UkMAUrvMn/FV5hh/TXR0tTmll4c3wVjO5YxFa?=
 =?iso-8859-1?Q?3gCXwT13q8Q+MwqISPT9ft+a24he1aGKVIMoHE+d7hB17RTesOXgGWHjzV?=
 =?iso-8859-1?Q?KItxXZd2pYsCWTAQKCvsY0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB4500.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KLWLO5kgLYVMyoTIrS72xc+CskEqfUGVEyrzFTdSV8VAmwol15eSkXf4tA?=
 =?iso-8859-1?Q?veZjTq/tGOx4z6r3mdUliHRSrA5SHvzscvYExrBzoFixhynjiIoFMXr70/?=
 =?iso-8859-1?Q?T9mw3E/TzoJ/tPSYgMbG3nvFtQWQv2czl03Za7PkqgQJubRLkTD20j6ynA?=
 =?iso-8859-1?Q?0IyqGSGk69LGp0A3YUqEvqnhGqJGLjVUuPgYTqY7ntEuQNrtRND/mKiQNs?=
 =?iso-8859-1?Q?Qj25EP5jCRXcIMJ2FN2eLC/OMeB34aae4YpD5ySZ2FF1/0R9SBKzLrqbBs?=
 =?iso-8859-1?Q?MGXTITrED4RU5ONvUpc8VVow5zP8j0ZQWaG5fQdUSs3unEqHDahqSsVg4e?=
 =?iso-8859-1?Q?cGIjpjf/jCekde6Qa/49Q1VN3gNOi4HB+h5CHKSNSffNAwP1wd4ivs00S1?=
 =?iso-8859-1?Q?XIKpF7nZx4o7EP2wmfmyBafBLV/TptVZFH0n2xfwxWa8TaHL0eBO4dOWoP?=
 =?iso-8859-1?Q?OaGi3ATuQoCA2FDYWwXxK8rE/E2iRCtkHvJBZvRIHZaKSJQjC7hmZ3OUIc?=
 =?iso-8859-1?Q?HcJX4/yjg+6SKXw3diTFwdngyvPDGSK3NRRd4V7bBWuPfKgzpcAOzQ2Z97?=
 =?iso-8859-1?Q?oFmlrnfT3HY4Ls25lhds+rJ/PijZ7296pPTtAsb1UswU4nA2NkikS6/Sm0?=
 =?iso-8859-1?Q?4aBjzYHVEBkSHuB80IfdoHP7cj7Q7TmMhMV5g7UCTBIxifLPwOCahhRfBR?=
 =?iso-8859-1?Q?DkLFQ9aAK1C/+Xme7Hj6jDcM1CXBP8emR7OH9Dw9OiaOJYVOIV7reQYhdB?=
 =?iso-8859-1?Q?vR50XZB0GV6RmNAiYQZOjsDyRHxsAlxY79qApghZCcYOwI42vjFOGmyAxj?=
 =?iso-8859-1?Q?XAZXlITq5Dv4WbGySp0IEk6A70I7p6m4jPbqTrKu+7EAXceihFWLpfbDIY?=
 =?iso-8859-1?Q?mW390HYVSSMSUYXsgVwjndpQmpB3OTLQwidaVGaRgYeoyyxX7YRGPTkJNO?=
 =?iso-8859-1?Q?n24MnsnBI6HsV05799iBPmW6DuuWhufquH+q6v7sfupE3RcT9DUaDs9IwK?=
 =?iso-8859-1?Q?qcaTj51PThCqTEVICW5nLfMdG5qbC1WgQfcQnjs0VJpDEC/RgA5y75gA2V?=
 =?iso-8859-1?Q?q/SuvNf7WFwC0z8RfoiT1avjtuNwNyqnqZF/EHPzlDTkYdWLpehR2/xdhN?=
 =?iso-8859-1?Q?WbJxDdhgzvAcA2A9KuAERle/dpgGpD6uyvZco0NRx9LrcqwPKE+zW8yQt0?=
 =?iso-8859-1?Q?1SqoyFn/t7//KQ+KpSVzZlUnq9TNHNy9f6nOcXZtj4HCj4dnA1am/3GC9o?=
 =?iso-8859-1?Q?n/uZLa/uELnSD8q+LVnqmOPCDD876jtZWD2idmw0RpV9gDEHVzvCyFrpeJ?=
 =?iso-8859-1?Q?aWU5PKuXbEQ9GMV9iBxwXf3U5E7z7buwi3OjT5RhJf7HQrzS4gA5uMCfXx?=
 =?iso-8859-1?Q?bDMTfyxZrNu/17H/JYgtpvgJCV6sNg388d03sQL50IgRfc5WCXktDCsjgP?=
 =?iso-8859-1?Q?vLzDMGox7BT7vTAqo0BWu0UpTi4HpVW3iGgQDhOIXSuHl8uq5Bng223xtp?=
 =?iso-8859-1?Q?so+PzGOReAm+g/ETJnrL8yxKhirq34g7Porp7hZsAVSKOm4BJ+70e2eKGK?=
 =?iso-8859-1?Q?JXHsxkzj/AGSZOH9Pu6EoWYbBZ2roHVAQRCm20S1DlMFrJRxwMzN5nUAPM?=
 =?iso-8859-1?Q?VxnOun64dIJriGOdiNXAbMicQtN4wdCYAsfKS6p38WPVZnuEeNONViZAbc?=
 =?iso-8859-1?Q?uKWiZ6V2zfGTfCkeq2E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vaillant-group.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB4500.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e698c212-365b-477c-25ac-08dd33c4bcc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 11:23:42.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 67e4db54-80ae-4739-b54d-5ee94bd6472e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5asIPz4M6O4dCC7/Na0iT/cz7xxwPKOyfiVM1OElVlgBsx72TglNWCP6zUIK0JhoenyhLczYDzUZhXneixHG7KdnlVJAP92DrnHJrjSbz3Hl33h2nQxZupbZ4pIMUC+nBnZdFhxwSOIHs8lPUDLTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7413

Dear maintainers of connman,=0A=
=0A=
I would like to report a bug in the statistics module of connman that is ca=
used when the definition of time_t changes from 32-bit to 64-bit, e.g., aft=
er a Yocto update from dunfell to scarthgap.=0A=
=0A=
On systems that experience a high number of wifi reconnects this sometimes =
leads to an infinite loop when connman rotates its statistics, causing high=
 cpu-load in the connman process and creating an ever increasing temporary =
file in /var/lib/connman/.=0A=
=0A=
The bug can be traced to src/stats.c, where stats_record, the record type c=
ontaining time_t, is written to /var/lib/connman/<profile>/data. The data f=
ile contains a header and a ring-buffer type structure with elements of typ=
e stats_record. When the data file is full, connman removes old entries by =
first writing them to a temporary file in /var/lib/connman/. During the rot=
ation of the statistics in the process_file function, the abort criterium f=
or the while loop processing the entries is effectively iter->it =3D=3D ite=
r->end, which may in some cases never become true if an existing data file =
contains records of mixed type.=0A=
=0A=
As a workaround, I would suggest disabling the stats module with --disable-=
stats. A possible fix could involve saving the size of stats_record in the =
header on creation and invalidating an opened file on a discrepancy.=0A=
=0A=
Best,=0A=
Peter=
