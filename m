Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22457A
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 07:31:20 +0000 (UTC)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
	by mail.holtmann.org (Postfix) with ESMTPSA id 43BDACED2A;
	Mon, 14 Feb 2022 08:24:18 +0100 (CET)
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
In-Reply-To: <20220214021357.522946-1-net147@gmail.com>
Date: Mon, 14 Feb 2022 08:24:17 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC6D702C-EA26-4984-8244-646FB99CB533@holtmann.org>
References: <20220214021357.522946-1-net147@gmail.com>
To: Jonathan Liu <net147@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)

Hi Jonathan,

> Fixes the signal strength reported by connman being lower when using =
iwd
> compared to wpa_supplicant.
> ---
> plugins/iwd.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/plugins/iwd.c b/plugins/iwd.c
> index ac3d1e17..2a245fe2 100644
> --- a/plugins/iwd.c
> +++ b/plugins/iwd.c
> @@ -1128,7 +1128,9 @@ static unsigned char calculate_strength(int =
strength)
> 	 * ConnMan expects it in the range from 100 (strongest) to 0
> 	 * (weakest).
> 	 */
> -	res =3D (unsigned char)((strength + 10000) / 100);
> +	res =3D (unsigned char)(120 + strength / 100);
> +	if (res > 100)
> +		res =3D 100;

I think it would be better to fix wpa_supplicant plugin to adjust to =
iwd. Since the iwd signal strength calculation should not be seconded =
guessed. That will get you into trouble at some point.

Regards

Marcel

