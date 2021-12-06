Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FAC2CA6
	for <connman@lists.linux.dev>; Mon,  6 Dec 2021 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ethgen.ch;
	 s=mail; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pqV6XrxMG39YXsXebYszZcYkA/Fef7FSVxGJ9ujBFms=; b=uAt32MNzLL+Va3eWAXUU9xd4tP
	WC9YYyGUMzQeFXoKF62BBPLa/48GQm4dqHvP1t+Hjpb2gXgawu6v0sQB2pRPFL/CKEdhu5/W9YQes
	I0PAQrU7z+sCAhixSuvKcZn+oMVAKS2gQViCKwk+imjfUBVIqa1gZkrJzRu6aGNN5dTKcoyot+/NI
	+KHvQPG09fuaF2KD13x0oHNdllpn1XOpxC5mwqo/IueKTgP4Dq7IKAaD/KWLotP0aGoq2/DvN+X0L
	rjpu3nWXrkrHfp3VNwV3AOpmMvaZn9M/khOq+FrE5EwRZ1ppaXptoWxkOgR32dAw9mUQxP2WGB3A/
	ASIsCUz2yt3zhHQBvn6lN8zFFK2d5cVKv2cKVLWv/FcgrrOXBSFiErfqblhEp6WG/oPepTs8a6Viv
	I4RKBsfjGhA8YPWjQxw63eLhtMN361lpiR7FWL62+x3aubJp0oNgds0GuxN1B+6rcDDloPJ0e+VMA
	SIdYvng+nE7/4rmi1hDRCAovawNQ+b2hLLLPmCCJ66nYQYi0X06jiQA/4k7cTt2GV/ncG6Y2k3puG
	82M2e+ai2btQH8lIDq/0ycjQ9Prrg1vhIw2Br+JfhFGYkowl+hyOkIw/raYN9E2gYm9ifvuXMzaNu
	5dF5yWn7Rt7MMM0imzyEm04GD6hnfaMXMbXAg0XZ0=;
Received: from [192.168.17.4] (helo=ikki.ket)
	by tschil.ethgen.ch with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <Klaus@ethgen.ch>)
	id 1muDl4-0003OV-On
	for connman@lists.linux.dev; Mon, 06 Dec 2021 13:10:18 +0000
Received: from klaus by ikki.ket with local (Exim 4.95)
	(envelope-from <Klaus@ethgen.ch>)
	id 1muDl4-0004AS-Fs
	for connman@lists.linux.dev;
	Mon, 06 Dec 2021 14:10:18 +0100
Date: Mon, 6 Dec 2021 14:10:18 +0100
From: Klaus Ethgen <Klaus@ethgen.ch>
To: connman@lists.linux.dev
Subject: Too many wlans
Message-ID: <Ya4LuuATLuB7waD6@ikki.ethgen.ch>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gFZXqLp1vpOf9vM3"
Content-Disposition: inline
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt


--gFZXqLp1vpOf9vM3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

I found a bug in connman when too many networks are stored into
/var/lib/connman.

I shuttle between different locations and today, connman stopped showing
networks at all. After some debugging, I found the following Messages in
wpa_supplicant debug output:
```
wlan0: Event SCAN_RESULTS (3) received
Scan results did not fit - trying larger buffer (8192 bytes)
Scan results did not fit - trying larger buffer (16384 bytes)
Scan results did not fit - trying larger buffer (32768 bytes)
Scan results did not fit - trying larger buffer (65535 bytes)
ioctl[SIOCGIWSCAN]: Argument list too long
wlan0: Failed to get scan results
wlan0: Failed to get scan results - try scanning again
```

The `Argument list too long` got my interest and I looked into
/var/lib/connman finding 104 directories in the form
wifi_XXXXXXXXXXXX_XXXXXXXX_managed_XXXXXXXXX.

After deleting all directories and restarting connman, everything went
back to working state.

So, if that directories is an issue, could it be cleaned up?

Regards
   Klaus
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--gFZXqLp1vpOf9vM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAmGuC7oACgkQpnwKsYAZ
9qxc0AwAtbxRPOYlWOcG7ZxYw+SzoYcgqoEa3fwS2ZIzwisRf3sT4+ETwLZYzdV2
z/R+k5nQ+8AslT4yJKyiyon23fXjFOsJiYLiBzButF2LHxOs/ZGgkLrGCF/Mw3X7
r/39caJ1mhW9KxQOTXRe5VvF6komItKFYQz6YNRbLyxMA+XlerZUKsxiyjZ67onS
EfUXnyCRprjzkYfcKvIMBJGeS9LkWu5dVSlktbApFME9KZoq7ofdJZmrChBMRykc
RiaUxqnx9x7PQxFdtX//ytNUSIEB+YboOC41KVnQmY/z2QyQ4FMuaX6/j/35Trxm
ktVUrDGInfvDojVh/H2RYGic6dm8xAo9EnEy6plhdbB41Cg6SRACmKuqzY16idcs
CNwY7obshMJUhV/8Lau4vqn6bHkLS6z3ttMBLfdMSbJ3BQFOKrGL5lXYeQdCi/W7
Tc0SIFmYu5H9Niw6dQviUEo+qDxO8IfpAhLjDoQJ2ZZPTt2pUjgN6FMxJTolJOrV
OSSd9zL5
=lUuL
-----END PGP SIGNATURE-----

--gFZXqLp1vpOf9vM3--
