Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2E2CA0
	for <connman@lists.linux.dev>; Sun, 19 Dec 2021 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ethgen.ch;
	 s=mail; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DgUgCJAEoea7YeR/x+2m+BCfedsXXFaqVcZ+0b/nUCU=; b=H8e+GetsnUYGuyLTOws1C9kL7w
	T43YKVbCawopm8P4g+zsqzBDuvZiP2eySjYfo9yL4z04oHBy7rmF4tJdmzu+GKZ2eWIQlic1gJLq4
	YsO+Z1eQztZkOK2XSsVAnpVhrZr9W7u6YBqnn8qfA5UN4rF+boDP0votAFjSgfLXEgfec+SN7S0sf
	eC9k6yb6ezIHAPoE2v2R070r/bQC9s/QhSGJtW/qfcPCfeoF51qfqJJs8kr4gID0C0gAoRHzJkHFS
	Tp954oSOb1o/dqMrmOUQPGgSrCz+M0Nv1eRRpMb9P3ntnpc6XAMxRbgCInXPT0KggYLcxxHk1dEep
	G2PuNjlynxtGE5M+Ws8YDyU7RPR1dD/lf6OTCbIhEocsp9ZHR6hWOHj16rmedTChU8TIzG5AwulOu
	y3/Uumu2DjrwJm8vAT/mP4eutJ/OyuGQYbvNAb3838+kSP/WSJ3LqT6C1j82DFW64fZcS6c1sVHRr
	TtVRBp9++/VjAuuAfE4ata9NdgacpSXP/ExYWbtZY+IaFUftYkJqG3YSrHBMxPR4faASfeL7QCRT1
	uuMyU5glm2rAYyyhhj9R2a8N9DJg1jdQeewYiEAqfmnSSvrCp0nw5evvWaDZqUB73wVInud3y/IEf
	FoQf0MqLaXGpmrpfcyH1iLT9uuJD6Ux28Mpa13eaM=;
Received: from [192.168.17.4] (helo=ikki.ket)
	by tschil.ethgen.ch with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <Klaus@ethgen.ch>)
	id 1mz05i-0008Mh-6a
	for connman@lists.linux.dev; Sun, 19 Dec 2021 17:35:22 +0000
Received: from klaus by ikki.ket with local (Exim 4.95)
	(envelope-from <Klaus@ethgen.ch>)
	id 1mz05i-0000wt-0E
	for connman@lists.linux.dev;
	Sun, 19 Dec 2021 18:35:22 +0100
Date: Sun, 19 Dec 2021 18:35:21 +0100
From: Klaus Ethgen <Klaus@ethgen.ch>
To: connman@lists.linux.dev
Subject: [Klaus@ethgen.ch: Re: Too many wlans]
Message-ID: <Yb9tWbma3JWG+Ah+@ikki.ethgen.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zatSe5BDJ886xvG8"
Content-Disposition: inline
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt


--zatSe5BDJ886xvG8
Content-Type: multipart/mixed; boundary="LaHmGiY4WP1fyJpH"
Content-Disposition: inline


--LaHmGiY4WP1fyJpH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

FYI...
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--LaHmGiY4WP1fyJpH
Content-Type: message/rfc822
Content-Disposition: inline

Date: Sun, 19 Dec 2021 18:32:34 +0100
From: Klaus Ethgen <Klaus@ethgen.ch>
To: Daniel Wagner <wagi@monom.org>
Subject: Re: Too many wlans
Message-ID: <Yb9sska+Eeu2bwUt@ikki.ethgen.ch>
References: <Ya4LuuATLuB7waD6@ikki.ethgen.ch>
 <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bUUkUXVtN2L9Bxj4"
Content-Disposition: inline
In-Reply-To: <20211219172226.73tupsi7z24hkiiy@beryllium.lan>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt


--bUUkUXVtN2L9Bxj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

Am So den 19. Dez 2021 um 18:22 schrieb Daniel Wagner:
> On Mon, Dec 06, 2021 at 02:10:18PM +0100, Klaus Ethgen wrote:
> > Hello,
> > 
> > I found a bug in connman when too many networks are stored into
> > /var/lib/connman.
> > 
> > I shuttle between different locations and today, connman stopped showing
> > networks at all. After some debugging, I found the following Messages in
> > wpa_supplicant debug output:
> > ```
> > wlan0: Event SCAN_RESULTS (3) received
> > Scan results did not fit - trying larger buffer (8192 bytes)
> > Scan results did not fit - trying larger buffer (16384 bytes)
> > Scan results did not fit - trying larger buffer (32768 bytes)
> > Scan results did not fit - trying larger buffer (65535 bytes)
> > ioctl[SIOCGIWSCAN]: Argument list too long
> > wlan0: Failed to get scan results
> > wlan0: Failed to get scan results - try scanning again
> > ```
> > 
> > The `Argument list too long` got my interest and I looked into
> > /var/lib/connman finding 104 directories in the form
> > wifi_XXXXXXXXXXXX_XXXXXXXX_managed_XXXXXXXXX.
> 
> Do you have the exact log for this? ConnMan uses GLib APIs for iterating
> over files and directory. I would be very surprised if GLib is not able
> to deal with this small numbers of entries.

Well, not more than I already wrote.

It id really hard to get usable debugging informations from connman.
Usually, log messages are not of any use. I got the above info only via
killing the dbus started wpa_supplicant and starting it manually via
`wpa_supplicant -dddd -u -K`.

In the past I did debug (a still not working) problem with openvpn and I
also stumbled with how to get useful informations.

> > After deleting all directories and restarting connman, everything went
> > back to working state.
> 
> I don't think 104 known networks are a real resource problem as long
> there is enough memory in the system. But even then, I don't think
> ConnMan needs more than a few kb per known network.

The above messages suggests that wpa_supplicant gets all that infos and
use it with ioctl, which has some limitations (64kb). So, this could
indeed be a problem. However, just as I wrote, removing all that old
dirs and restarting connman fixed the issue.

> > So, if that directories is an issue, could it be cleaned up?
> 
> Yes you can cleanup the directories but it's recommended not to do this
> while ConnMan is running.
> 
> I think by deleting all known networks and previously corrupted? entry
> got removed which prevented the proper working before.

I don't understand that sentence. Could you be -v?

Regards
   Klaus
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--bUUkUXVtN2L9Bxj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAmG/bK0ACgkQpnwKsYAZ
9qzdPQwAj67RMUCTHHS2/2avMRp/7l94D9eOc+vPjmTEr3ywtMhxmsBgB8HUW815
h6uQBlg8phBKrrbqjdZ3s7YaDY2C2oyFO6v/G+XSdYAb1cRmQwBCajLgpJJ1rWZ7
KMMqp5f2Hm66ZJ+BbSwEfvxkqhFzckJAawy7VCv/cQC0yx2nthKKEygKA7v72v2V
ZQ7PQpttqmtQpqVYSQvBDC64XVYBF6vdnDsnL6w2xMc96ke+SNGA8VAIuj1RgfvW
zXqOOGK7ma57cYCGD/e6GgiysyvQORFb3FXRdDGun7Vty9XyQ7HWM+3Zc1Y+n5gc
/pjDrIdPUwDwrvy9WvwaKPGJGu29nrxk7q4NEDR70BLf0LECbtDLVUN6FM3gIQXO
yuPJ5B81hObE/2ichUaZrO4MM9/ZnhiFL2j9ZI0Aajc2Mt2Nr0ejtIidlTg11AHA
D5ONQc/BmfyYe8d9Ya6o7NHjBJDJaEaNJCFPchUDlYLg9xnJEEY0Grj5VsHKhWol
purMTxbT
=0BoG
-----END PGP SIGNATURE-----

--bUUkUXVtN2L9Bxj4--

--LaHmGiY4WP1fyJpH--

--zatSe5BDJ886xvG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAmG/bVkACgkQpnwKsYAZ
9qzlegwArn8wFIGBa98Hf8DqrZds5Ph4K3MOc/awTHEkajhePqol3nvgCVXdDH4x
l3U86LQVxRCjiRACOPMxyAr8Gnj9dN9InQWIdE1E6MiLk8HnvdGNNw1wukJDhIUM
iWJHRNUbjWbT9DDkP064jJ3OaLWhE4ag9oZS1uIq5gc72ecz8GGzUC7UV1d2dKq9
CsikAxON8GxwbIdB/ItiWCOeWcVB1NgPwGpPfu5AtDG6slJYOy87ySoRH1VAtClU
3avKlNDsBZvFji3hUerASCPeRtV+qgm7ViLo0kqyO43snv463goU5m2kHT+YugZk
/BZGmGtIbDLVXdmjL7lr9UpPDh1ICYJ/J3IGViGp7xLBURI31Mn4WPVP2xi3M6s7
Kq9C6qTNcv6HrrRa+7Fzz6jEC9jakVneWWoW96uEB2NV0T9sowEnR0OseSMgUnaa
PzCFSigLr6j0c1mFebbqhq/3klgIBKNzsAVaVfa46vYPXMbdx+t/t0+OqSk4uht1
Vhrg9CVg
=R6U6
-----END PGP SIGNATURE-----

--zatSe5BDJ886xvG8--
