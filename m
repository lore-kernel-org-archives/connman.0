Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198F1CF9B
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 511C1731F7;
	Fri, 20 Oct 2023 12:13:46 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C154273200;
	Fri, 20 Oct 2023 12:13:45 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl
 manpage
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <ZTKhk9lf-gKhS8c8@gmail.com>
Date: Fri, 20 Oct 2023 09:13:44 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C9C4F8A-EC6F-46B4-A5C4-1B4A0C9D2245@nuovations.com>
References: <20230629100000.49254-1-marcus.folkesson@gmail.com>
 <ZN9IvM5jGHuVlXv1@gmail.com>
 <CAG17S_MnQ1kdE3T-Qocp=Xe2yFbWJJA1e9Mo1J_6gueOTS_VTw@mail.gmail.com>
 <ZTKhk9lf-gKhS8c8@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 KeithG <ys3al35l@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Marcus and Keith,

I am also surprised at the low engagement, particularly given the =
10s-100s of millions of Google / Nest and Samsung devices using connman. =
I wonder if a bit of =E2=80=9Cmarketing=E2=80=9D on that front might =
help engagement a bit.

I=E2=80=99m working on both stability (see my email from yesterday =
regarding the 60 scan-build-identified issues) and finishing out =
Emmanuel Vautrin <emmanuel.vautrin@cpexterne.org> =
=E2=80=9CEnableOnlineToReadyTransition=E2=80=9D =
active-service-monitoring-and-promotion-demotion work.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

> On Oct 20, 2023, at 8:49 AM, Marcus Folkesson =
<marcus.folkesson@gmail.com> wrote:
>=20
> Keith,
>=20
> I'm also a bit worried about the engagement of this project.
> I do use it on both my (personal) PC and in several embedded
> Linux systems in my proffession.
>=20
> I'm willing to taking over the project if we think it will
> help the project forward. Although right now it is a bit unclear
> what the project actually needs to get a push forward.
>=20
> What I can offer is keep track of the mailing list, review patches,
> manage the git repo and releases.
> Anyone is welcome to contact me if there such is interest.
>=20
> Best regards,
> Marcus Folkesson
>=20
>=20
>=20
> On Fri, Oct 20, 2023 at 08:30:07AM -0500, KeithG wrote:
>> Marcus,
>>=20
>> I have been watching your investigation with interest. I am a list
>> member as well, but have noticed that there seems to be very little
>> engagement by any devs in the past year or so. I think Daniel Wagner
>> was the primary developer and he was wanting someone to take this
>> project over. I also have a feature request that has not yet been
>> implemented, though some work has been done. It just doesn't work =
yet.
>>=20
>> Are you interested in taking over this project? I, for one, would =
love
>> to see continued development of connman. If no one is maintaining
>> connman, I will have to see if I can migrate to another network
>> manager. I have been considering nmcli, but it is so complicated in
>> comparison.
>>=20
>> Keith
>>=20
>>=20
>> On Fri, Aug 18, 2023 at 5:30=E2=80=AFAM Marcus Folkesson
>> <marcus.folkesson@gmail.com> wrote:
>>>=20
>>>=20
>>> Ping?
>>>=20
>>> Is the mailing list still active?
>>>=20
>>> Best regards,
>>> Marcus Folkesson
>>>=20
>>> On Thu, Jun 29, 2023 at 12:00:00PM +0200, Marcus Folkesson wrote:
>>>> Add 'freq' to the parameter list used for WiFi Tethering.
>>>>=20
>>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>>> ---
>>>> doc/connmanctl.1.in | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/doc/connmanctl.1.in b/doc/connmanctl.1.in
>>>> index d87472c3..cf662ca3 100644
>>>> --- a/doc/connmanctl.1.in
>>>> +++ b/doc/connmanctl.1.in
>>>> @@ -10,7 +10,7 @@ SYNOPSIS
>>>> .BI enable \ technology\fR|offline\ |
>>>> .BI disable \ technology\fR|offline\ |
>>>> .BI tether \ technology\ \fRon|off\ |
>>>> -.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\fR\ |
>>>> +.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\ freq\fR\ |
>>>> .BR services \ [\fIservice\fR]\ |
>>>> .BI peers \ peer\fR\ |
>>>> .BI scan \ technology\fR\ |
>>>> @@ -86,7 +86,7 @@ by default since tethering it usually breaks =
local networks. See
>>>> for enabling.
>>>> .PP
>>>> .TP
>>>> -.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase
>>>> +.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase\ [freq]
>>>> Enable or disable wireless tethering, as well set the SSID and =
passphrase.
>>>> .PP
>>>> .TP
>>>> --
>>>> 2.40.1
