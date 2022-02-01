Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE582F25
	for <connman@lists.linux.dev>; Tue,  1 Feb 2022 18:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxLSjcgRkBcy70RyF9mSidA4qFnEva92QNcwnCuOp7DmCCz4PNziOTR9ykYrcAwBMFyW9celZpS2FWCEaR+DB9RG9tPQiLZAXtkWu7opMC/UwSBWdgLlz19/hfoVmBC3CTyMisHrdzP3sk+OvZoE8XEFSjsiohED8+odX9om1NTiNIH8XJn10NFl2vMwcgge6EnN5sWOHfxM7SLPE+BvHgYYFEE4ZZNkrkwmuYJwxrObxac4XBTB3wCHxa+6w3GJ+aLr4/A8kd7hKWg+32dEuwcqBePLzjb1PG9xWA2FBGMGgGWzjGgbOQH3uqB8BLgNMQNZqIwwvHItrxJV/mAFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPwuu6HDH1lfTvROjonDtmDU/LsC5KAcmgQfKSRrKY0=;
 b=gzPiO2OPS4G3haRkwW8oChH4NTTpHgXsmyQQaDaRWehadHEN0aO6y3tJVhii36BTCKQhQzCSbQ5jEfPBb54PfMfuj+jruf/Hl5TyS8v05kp97Y5VyGndOXQg6w2Bi37QVNOsQ7FWxDiKWYJfEkuKooKkfDW4lMVRPIE4ciB0nGMNLHqE5TByoLNxD1yPqkiVRK3clShouvDrDsgrr6CVbwIlH+quQWaXTT2hwWkESRUUXdPbmUjXvECD+qvTuy+GfF9w9pZVTQEPQX2/ague2o+u9JDUmcHaK8OfjIhzjgBItmgNvL6pM8vRS1tMZVw1SLLA3VbiC0IkEXpZb1YHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPwuu6HDH1lfTvROjonDtmDU/LsC5KAcmgQfKSRrKY0=;
 b=bZ/jX/mPu9fMNPRncThJfKRqsC6CB+ZrgucDqZjeJiLhdCOSzel9O9zATV38V8OB2zxOrcFk9OBdBcs06lfkfDTICFMOtDZKMBd+j0wqAepjK1puBqK2cIq/FzZq4u9fCmW9/HeFoi2ab0VIFWsf0K34CbMoBsPqbmIHwTQckgroNWzZ45OPNdDxbx8eK6IXGl+Y8DlSwSUrRk9eqWmRvaGI/WRDBiXuzi9QTjwNNvVLrF2Y5kP7IKWe66WlZfsXVDdoBnswei9TIuL9flZqKFweZ2pryflpTF77iwr8eckzbYJBCzeXL0vZWvl7fwFTcQRSQhXmpDk3s7eeieEDdw==
From: Thomas Green <TGreen2@Sorenson.com>
CC: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: RE: Question about 1.40
Thread-Topic: Question about 1.40
Thread-Index: AQHYFKQ399dc5whOc0SG8SQOXi3+bax5oimAgAVn1bA=
Date: Tue, 1 Feb 2022 18:29:50 +0000
Message-ID:
 <BN7PR04MB52671DC95591ECAACFAADA379F269@BN7PR04MB5267.namprd04.prod.outlook.com>
References:
 <BN7PR04MB526773125C2674FE24553E789F239@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CAOf5uw=BwwJvgPd8EmX72S6VRweHSiBE-0jA0+yCzrDy2hfPiQ@mail.gmail.com>
In-Reply-To:
 <CAOf5uw=BwwJvgPd8EmX72S6VRweHSiBE-0jA0+yCzrDy2hfPiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 037f0b1d-a46c-4867-b4b7-08d9e5b0d579
x-ms-traffictypediagnostic: DM6PR04MB4555:EE_
x-microsoft-antispam-prvs:
 <DM6PR04MB4555AE8FD8EDB95677352EC19F269@DM6PR04MB4555.namprd04.prod.outlook.com>
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR04MB5267.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(66946007)(508600001)(53546011)(66476007)(8676002)(8936002)(66446008)(9686003)(316002)(76116006)(38100700002)(4326008)(40140700001)(122000001)(15974865002)(71200400001)(7116003)(38070700005)(66556008)(42186006)(186003)(109986005)(2906002)(33656002)(26005)(52536014)(64756008)(5660300002)(86362001)(18886075002)(20210929001);DIR:OUT;SFP:1101;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 naXAGi1NE8OL6iYjy8KYdIGgxfhuiseiwJmPTojEOqnifZHH9gSwf3O8na1mt3AK0yX9AQnaacXDtZ3C8Q1kVF26ffnouspRv1Kk/yCPdTf4kKd8TGCMq/iDLeoHYacqWoS/YZB0M7nXWXi8129P8yn3TD9BJB6xJHC29EXC7LSVMu/gWk/3D/A/qqDJhJN+dSKAFull4drV0OSarVi1EjozraSS89VX+KdO5oE0AB8kJJGy88cGJREhkqyioabWIokkzwBNz1v1ywImZlAFA1AdqfMA12w260UW12E5oAGI+wn8nlLgZ+8SWFsU3r5qBqoml8JBkVnROzIuZat2KiHjpqZTDX7ADT4NYqAwweo54zm4iyMT+xgbzi6Q4A4zog/PqevHZlSAJ8+TnB2wOpjleFSjaztbVwk0I5uZ8K1+d6vcJx7vdiZB3eG/xSVY4vfSlydT0JS2jx86fQfUexqgSTtYARnItcKC2P2bK7Z38uDcPCXoByZkpMT7Pamygw9cOVsbMFsbvbV3vq/NN50erNW53SU0p9M2j33EZEFmdfGY9POwBLai+VoSPm9IdRgD05mUANFAXglN7XHSDgOoVzzEEfb4KhAoOx3uACGFBpI4jvXPweNkZBWnZ+7j8QMMkA5U9yj9zxfi/+KDKsGrEQ+1u4AJgXhwAImmyW473L9QVqy+Gm8TrLAKXDjeLrml547G50nOuofp4+IB/q2kOurAhjl9ktHmHseCXwX3shs8x5pxzdlAY/u30r5m3nihk2UXA7CX2oQxb9eeD7+9zngISZkPZ3kYRPa4AWXHB5QUp/MiDIoqqOBhsyri
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bldsUUhWWU9DWXU4MnJDUE4ySU9DMTFlclM2UHAvc01md0kyakZ2UzZROVFL?=
 =?utf-8?B?SlFXcVN1bC9VaUxRRitVdUtxNGhybHpnQ21NZXBTZjI1RUhEVEIwNE0ydUJX?=
 =?utf-8?B?MElzQzYvd3B6U2xMWVVWa0NRV3VuQkNuU3ZTR0lMWDBhL2dLUDFRMDhmaEVj?=
 =?utf-8?B?Mk9xa1pPcTF5Z0l0TXdQbHdCQ2dEeE84T0FrZzZlTjlMaEVlMTEyN0p3bkJx?=
 =?utf-8?B?SjJNeHVldjN6cDdTS2JaREYwY3loa2RuRkdKeGxOZHRMZVltcHVuWHRyVTdp?=
 =?utf-8?B?aWtjMHF5NUxCTm1CRlNMNmNHZHhvVnVza3M5RmNxdFZ1THF0OGtSTk9Qc0Za?=
 =?utf-8?B?TEljRGlFdmRReklaTmgwYm9nbVJqOVRKNkJ1aGdJL0xmSm10eW9POHBBVEpw?=
 =?utf-8?B?cUJNSkhTRVJZdmh6R2tCTHZ5QW1yYWFRUUx3ZUVyTHZ6a1BnMHY0anlRMklS?=
 =?utf-8?B?L1d6bitYZzR5TFFTSm04NkVpWFlZODNDVkR6Y01vQTB6cERFZlN1cUg3dmd4?=
 =?utf-8?B?ZldwdkpzaXM5RFR4dlNEcytZNHNCd0JlTW1sVURXNnB6Zk11THdjRzJsRnFH?=
 =?utf-8?B?bW1HZ1krakU5MFh5RlQvd2w5OEJyQUlqaUFKV1BuSDBJZU5Zazd0NzVEdzlL?=
 =?utf-8?B?c3pTUTVvRkhtaWpyZVhBUGxGMFU4VkFyWHlqT3lvdVFDZUpISzZqUTlwVjBz?=
 =?utf-8?B?aitPZk4xRiszMFFYeGQvQmIzZVBuQjNyTGF5V1R4aGhQcGZjb0IvNFVJaFlF?=
 =?utf-8?B?S2h1SmsxSy9rakFBVDNVc29iZjdFdSt3RktCSWlXOUt4MWJUNVFzVDVldXJT?=
 =?utf-8?B?aUhMYjFOb0pwemxxUjZxaS9IQmVqTVpOclh3aTVqN0RhcDhxeGsyUzJZc0F0?=
 =?utf-8?B?aENRa0RIcTZRTnM1b3UvTzkvYi9ZbGkwcHVURHdDMXV1MVA4T29lbXk2cEIx?=
 =?utf-8?B?YTBUbmQvcm1DcDZmS1BUUFgzQlhsTERQbXo1S3VTMmZ2RHBwQm9tU2wrandU?=
 =?utf-8?B?QVovSjZnZTViYjY5Yy9mNmpZT1NENFJVWlp4RmUvWjJMUEFFK0syVmRGaS85?=
 =?utf-8?B?aDZwWXdoZ2FpRkNLY21vek8yVjJicGc3dlpwUk9zczQzN2xyM0ZjNitYU25W?=
 =?utf-8?B?RFhyVDhNcEx6RFF6dGxRb2ZCY0lLOHZXNTAxNURMZThxcGZkSXMyNWUzUWg3?=
 =?utf-8?B?WGc2a2FqZmtYaURWYmtJdmN4WnFXcjE3ZkJPdkRHaWpESjFBRk5ZS1NhN2lr?=
 =?utf-8?B?WExNaWkrSjlva1JVTnFvdVNFQTJ3ZWl0VDZxa2lHcDhoM0xVYWwrN2pkbmVh?=
 =?utf-8?B?YUVBSitCc0NNOXI5R3JrMEpLUU05dVlFdmc4Um8xOGRhQXlkV1ZnYnB4emJR?=
 =?utf-8?B?TTBCTGRyWmNseTluVUNkV0lMNDVqYW5qRXVDdVRFbE52UXNxd0srOGd4SVF6?=
 =?utf-8?B?MngvR0k3Rk1aZ1FBRFlSOUlYcXZTalFmL0xZeW8zdi9qRURrajNIV01EaVRo?=
 =?utf-8?B?RzNaV05wc0U1YkpFeC9meVFQSjJ1clI5QWgxd0xnWVJIZy9UWTdzbmtQOVh6?=
 =?utf-8?B?T1B6Y2h5ZzM1VDVYRmI2MDArZFJCeEVoSEdxdXk0bjRzY2x6Z2dkUklqdlRK?=
 =?utf-8?B?NjN6bzJQbk1WUW54WEEvQ3kydkwxNGVPcVd3TWNSTzNoZFI4d3VJOUMvMkta?=
 =?utf-8?B?cHRQWHR2VmRmZzJGL0NNUnZQVE5XSGltd2VZWXdrYkdqdlFLdy9VL2NWQVRF?=
 =?utf-8?B?bks5OGVOWnlwVE1TaERRbk44YnBpZkNqVXZ6citLaVhZWDV6R3FTN1F5SSs1?=
 =?utf-8?B?Z0dEekZGT1EwV3NOUnFEOE82b3VhY0hCOTZ0S25TQnk1MDVYRkpXdmpzTmpv?=
 =?utf-8?B?cDhBRSsvQlZWZ1VBZHNObjZ5dUd3UGZ2UjQvMzBzdHN6d1Y4OG9pMUVobFNx?=
 =?utf-8?B?S1FyZVVsSGxtbHY3NmtSMG5MMzBZTzdNNlh3QkdWM3JoaC8rbngzVU1xeGhr?=
 =?utf-8?B?WFFNdkdFRysyVzVYd0s0bzR4VUptYkd3Y2E1dzlIdThzZFd4b0hocWY1V1U2?=
 =?utf-8?B?a0MvWGIyTytQemlpcURBZmg2SC9MYTNUdTFSSlVIRVVLU1ArMmROVXhCQ3px?=
 =?utf-8?B?WnRoWlF1alh1amVCUVJXZTBaZWdXRUdNRnhiTnEwTFVmMkdJczFaQXRQWUQ0?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB5267.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037f0b1d-a46c-4867-b4b7-08d9e5b0d579
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 18:29:50.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eh+7d3JKuggmkvJfX+ObOy14g13jqVmFWWN2IuJ6Hb9+r2lTNUkoSL21hmlKF/d5wznRKRq820fCnvJ59cq3NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4555

DQpUaGFua3MuLi4uIEl0J3MgZml4ZWQgaW4gMS40MQ0KDQpUb20NCg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVs
QGFtYXJ1bGFzb2x1dGlvbnMuY29tPiANClNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDI5LCAyMDIy
IDEyOjU2IEFNDQpUbzogVGhvbWFzIEdyZWVuIDxUR3JlZW4yQFNvcmVuc29uLmNvbT4NCkNjOiBj
b25ubWFuQGxpc3RzLmxpbnV4LmRldg0KU3ViamVjdDogUmU6IFF1ZXN0aW9uIGFib3V0IDEuNDAN
Cg0KW0VYVEVSTkFMXSANCg0KSGkgVGhvbWFzDQoNCk9uIFNhdCwgSmFuIDI5LCAyMDIyIGF0IDE6
MTQgQU0gVGhvbWFzIEdyZWVuIDxUR3JlZW4yQHNvcmVuc29uLmNvbT4gd3JvdGU6DQo+DQo+IEkn
dmUgYmVlbiB0YXNrZWQgd2l0aCBldmFsdWF0aW5nIHZlcnNpb24gMS40MCBtb3ZpbmcgZnJvbSAx
LjM5LCBhbmQgSSd2ZSBjb21lIGFjcm9zcyBhbiBpc3N1ZSB0aGF0IEkgdGhpbmsgaXMgYSBidWcu
ICBXaGVuIGNvbm5lY3RpbmcgdG8gYW4gQVAgYW5kIGFuIGluY29ycmVjdCBwYXNzd29yZCBpcyBl
bnRlcmVkLCB0aGUgY29ubmVjdCBjYWxsIG5ldmVyIGZpbmlzaGVzLiAgVXAgdG8gdGhpcyBwb2lu
dCwgd2UgZG8gZ2V0IGFuIGFnZW50IGVycm9yLCBidXQgdGhlIGNhbGwgdG8gY29ubmVjdCBhbHNv
IHJldHVybnMsIGFuZCB0aGUgZGJ1cyBlcnJvciBpcyByZXR1cm5lZCBhcyB3ZWxsLiAgSXMgdGhl
IG5ldyBiZWhhdmlvciB3aGF0IEkgc2hvdWxkIGV4cGVjdCBnb2luZyBmb3J3YXJkPyAgT3Igc2hv
dWxkIEkgZXhwZWN0IHRoZSBjb25uZWN0IGNhbGwgdG8gY29tcGxldGUgd2l0aCBhbiBlcnJvciBh
cyBpbiB0aGUgcGFzdD8NCj4NCj4gQXR0YWNoZWQgaXMgdGhlIGxvZyBmcm9tIHJ1bm5pbmcgY29u
bm1hbmQgLWRuIGFuZCB0aGUgbG9nIGZyb20gY29ubm1hbmN0bCB0aGF0IGlsbHVzdHJhdGVzIHRo
ZSBpc3N1ZS4NCj4NCj4gSWYgSSBtaXNzZWQgYSBmaXgsIHBsZWFzZSBsZXQgbWUga25vdy4gIFRo
YW5rcy4NCg0KVGhlcmUgYXJlIGZpeGVzIGluIDEuNDEgcmVsZWFzZS4gQ2FuIHlvdSBwbGVhc2Ug
dGVzdCB0aGF0IG9uZT8NCg0KTWljaGFlbA0KDQo+DQo+IFRvbQ0KDQoNCg0KLS0NCk1pY2hhZWwg
TmF6emFyZW5vIFRyaW1hcmNoaQ0KQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2Vy
DQpNLiArMzkgMzQ3IDkxMyAyMTcwDQptaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkFtYXJ1bGEgU29sdXRpb25zIEJWDQpK
b29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAx
MTEgOTE3MiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3dy5hbWFydWxhc29sdXRpb25zLmNv
bQ0K
