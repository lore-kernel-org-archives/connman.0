Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7051835EF4
	for <connman@lists.linux.dev>; Thu, 23 Nov 2023 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id E3726CECBE;
	Thu, 23 Nov 2023 16:23:01 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Request for Comment: Implementing Non-link-level Failure
 Monitoring / Failover
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <93D46C50-3D20-4FD3-82FD-1D3A102B0D91@nuovations.com>
Date: Thu, 23 Nov 2023 16:22:51 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF25A680-F4FD-4B47-9C3E-6614E597CF93@holtmann.org>
References: <1B47C370-F3D5-4F60-9753-46D39CAB6728@nuovations.com>
 <805B2C7C-9DB6-44C7-9B10-25ADB0E5B84F@nuovations.com>
 <7D53DC6A-AD44-468D-85CD-373878CB938A@holtmann.org>
 <93D46C50-3D20-4FD3-82FD-1D3A102B0D91@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Grant,

>>> After spending some time yesterday digging in on this, it seems like =
the =E2=80=98EnableOnlineToReadyTransition=E2=80=99 option should, in =
theory, do what=E2=80=99s desired. However, I can see that there is at =
least one immediate obstacle that also explains the default service =
=E2=80=9CReady=E2=80=9D / =E2=80=9COnline=E2=80=9D flapping:
>>>=20
>>>  1. ipv6.connman.net appears to be down.
>>>=20
>>> Regarding (1), if I run 'wget -S =
http://ipv6.connman.net/online/status.html -O -=E2=80=98, I see:
>>>=20
>>>  1. I see DNS resolution to 2001:8d8:8b4:c861:5826:fa5f:6690:0 and =
87.106.208.187.
>>>  2. The connection to 2001:8d8:8b4:c861:5826:fa5f:6690:0 eventually =
times out.
>>>  3. A connection to 87.106.208.187 succeeds thereafter which then =
returns a 404: Not found HTTP error.
>>>=20
>>> Is there a monitor process for ipv6.connman.net? If not, can it be =
restarted manually?
>>=20
>> that is not good. I will look into this.
>=20
> Marcel,
>=20
> Any updates on this?

now this should be fully functional again.

Regards

Marcel

