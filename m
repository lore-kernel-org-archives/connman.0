Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943FA7A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 14:30:21 +0000 (UTC)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
	by mail.holtmann.org (Postfix) with ESMTPSA id 0369FCED32;
	Mon, 14 Feb 2022 15:30:18 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] iwd: Use same signal strength calculation as
 wpa_supplicant
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com>
Date: Mon, 14 Feb 2022 15:30:18 +0100
Cc: Daniel Wagner <wagi@monom.org>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BEE7C10-D87C-4D53-8DAF-8C7CCCAC06D5@holtmann.org>
References: <20220214021357.522946-1-net147@gmail.com>
 <20220214073654.5wwvht6ntswylci5@carbon.lan>
 <CANwerB32EdUdktYrPx36X2XBrO366s6mHCcy0da0FUm6LMH8ig@mail.gmail.com>
To: Jonathan Liu <net147@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)

Hi Jonathan,

> It is the same mapping of dBm to 0-100 range as
> =
https://git.kernel.org/pub/scm/network/connman/connman.git/tree/plugins/wi=
fi.c#n2805
> For wpa_supplicant,
> g_supplicant_network_get_signal(supplicant_network) returns the dBm
> value.
> For iwd, you need to divide the number by 100 to get dBm value.

from iwd documentation.

                        int16 SignalStrength                             =
       =20
                                                                         =
       =20
                                Network's maximum signal strength =
expressed
                                in 100 * dBm.  The value is the range of =
0
                                (strongest signal) to -10000 (weakest =
signal)

Anyway, the signal strength in % expression is a total mess since every =
hardware reports different value and none of them are normalized.

It is better to fix the GSupplicant code to do exactly what iwd does.

Regards

Marcel

