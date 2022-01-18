Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209862C9D
	for <connman@lists.linux.dev>; Tue, 18 Jan 2022 09:31:01 +0000 (UTC)
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
	by mail.holtmann.org (Postfix) with ESMTPSA id E803FCECD9;
	Tue, 18 Jan 2022 10:30:54 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: Network with same ssid question
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOf5uwkrmCystgz9E4327HAdYvF7UMJNW4_oEdPxe4iFZeLStw@mail.gmail.com>
Date: Tue, 18 Jan 2022 10:30:54 +0100
Cc: Daniel Wagner <wagi@monom.org>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBA85205-B3F2-4F8E-BA6F-D992F5917E3A@holtmann.org>
References: <CAOf5uwnmUq0FN_2=udD4UcUcy_tVCbyQ-zNUcG7J0_iB-b8Z7Q@mail.gmail.com>
 <55549edc-f52b-0552-2134-d87c6dc71416@monom.org>
 <CAOf5uwkGg_XA2Wc00hKMYAxTVW8QAZfEUT0NcZJbmFR2QnJKBw@mail.gmail.com>
 <CAOf5uw=319J8Dewg8_j575kBsp0pEkh=bpTaS0jiBb5imemNfw@mail.gmail.com>
 <03304641-cc5c-4150-277e-3ac77732f9f1@monom.org>
 <CAOf5uwn3TyX_mKLRmSy1Hk98esi-AbKV9rqjo3-oh0-hngKAHg@mail.gmail.com>
 <8AF20224-E145-48EE-9484-D1527448A3CA@holtmann.org>
 <CAOf5uwkrmCystgz9E4327HAdYvF7UMJNW4_oEdPxe4iFZeLStw@mail.gmail.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)

Hi Michael,

>>>>> suppose you have 3 access point with different signal strength on =
a
>>>>> network, the best will be connman select access point in the area
>>>>=20
>>>> This selection is done by the wpa_supplicant/iwd, not by ConnMan.
>>>=20
>>> the wpa_supplicatan using wpa_cli show all the network so connman
>>> can create several services with the same ssid name. The logic to =
what
>>> service to connect is can not be done even in connman
>>=20
>> actually iwd does select the best possible AP and will also roam =
between them in case one AP tells iwd that a different AP is preferable =
or even if it gets asks to move bands. That is all done inside iwd. It =
is impossible to do sitting on top of wpa_supplicant.
>>=20
> This depends on the tsf of the latest scan and how cache is managed
> and on hardware too.

no, it is impossible since wpa_cli only gets parts of the required =
information. So you are just out of luck. Trust me on this since the =
code in iwd to manage networks and roaming and band steering and so on =
is actually complex. Source code is available, feel free to check for =
yourself.

>=20
>> Keep in mind that one physical AP broadcasting on 2.4 GHz and 5 GHz =
is already two BSSIDs with the same SSID. The client (like iwd) has to =
roam between the two bands.
>>=20
>=20
> That was already clear but this is a different use case because you
> know that both are part of the same access point.

Actually you don=E2=80=99t know that. They are two independent BSSIDs as =
well.

>=20
>>>>>>> IIRC, ConnMan merges those together and only exposes it one =
Service.
>>>>>>=20
>>>>>> is_duplicated the one that merges them? I think that in scenario =
when
>>>>>> multiple access point
>>>>>> are present we should not do it. I have seen that even iwd does =
not
>>>>>> show duplicated. Is that correct?
>>>>=20
>>>> wpa_supplicant or iwd? I can't remember the wpa_supplicant details =
here.
>>>> For iwd, all these stuff is done in iwd. Not ConnMan.
>>>=20
>>> I have tested iwctl and wpa_cli. The first one show only one ssid =
the second one
>>> all the access point. iw scan show all of them
>>=20
>> The wpa_cli shows BSSIDs and so does iw. You see every single BSSID =
broadcasting. iwd works on networks. Every BSSID with the same SSID and =
matching security settings gets merged into a network. As it is meant to =
be done by the WiFi spec.
>>=20
>=20
> Ok, now it's clear. So iwd re-use the same password. Do you know if
> wpa_supplicant does the same?

I lost track of what wpa_supplicant does. We always found that whatever =
it does it is half-baked. You have to think about it this way, the main =
user is a human sitting in front of wpa_cli and typing commands. iwd is =
meant to just work. You provide the passphrase (or other credentials) =
and it does the job of keeping you connected.

Regards

Marcel

