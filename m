Received: from 5.mo619.mail-out.ovh.net (5.mo619.mail-out.ovh.net [46.105.40.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9F101CA
	for <connman@lists.linux.dev>; Mon, 15 May 2023 17:16:38 +0000 (UTC)
Received: from ex.mail.ovh.net (unknown [10.111.172.95])
	by mo619.mail-out.ovh.net (Postfix) with SMTP id D4F5F22C17
	for <connman@lists.linux.dev>; Mon, 15 May 2023 17:00:56 +0000 (UTC)
From: Sam Nazarko <email@samnazarko.co.uk>
To: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: WPA connectivity issues with 1.41
Thread-Topic: WPA connectivity issues with 1.41
Thread-Index: AQHZh063nQqICy5NcUmOb4OrZ9Xmrw==
Date: Mon, 15 May 2023 17:00:56 +0000
Message-ID: <0a9616adc89f4fa08a0cd9840fecc582@samnazarko.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [77.100.255.239]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Ovh-Tracer-Id: 7298083199232317298
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufhtfffkihgtgfggsehtqhhjtddttddunecuhfhrohhmpefurghmucfprgiirghrkhhouceovghmrghilhesshgrmhhnrgiirghrkhhordgtohdruhhkqeenucggtffrrghtthgvrhhnpefhleehudfgkeeifedvffefhfefffetvdekfeehvdfgueetvdduhfdtveegjeelgfenucfkphepuddvjedrtddrtddruddpjeejrddutddtrddvheehrddvfeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeovghmrghilhesshgrmhhnrgiirghrkhhordgtohdruhhkqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegtohhnnhhmrghnsehlihhsthhsrdhlihhnuhigrdguvghvpdfovfetjfhoshhtpehmoheiudelpdhmohguvgepshhmthhpohhuth

Hi,

At OSMC we recently updated to the latest stable release of ConnMan 1.41.

Since then, we have reports that users were unable to connect to WiFi netwo=
rks where they have WPA2 and WPA3 active. Disabling WPA3 functionality on t=
he AP side allows the devices to connect again.=A0

The primary device being used is Raspberry Pi which doesn't appear to imple=
ment WPA3 support at this time. It's unclear for me why ConnMan is trying t=
o connect via WPA3. We are using the standard wpa_supplicant from Debian Bu=
llseye.=A0

If I revert the commits which introduce WPA3 functionality in ConnMan, user=
s can again connect to an AP which has WPA2 and WPA3 enabled.=A0
I also tried backporting:=A0wifi: Handle invalid-key case on WPA-SAE authen=
tication failure to see if this helped resolve the issue but it did not.

Is it expected behaviour that ConnMan should fail to connect to an AP which=
 has WPA3 enabled where the device does not support WPA3, even if the AP al=
so allows WPA2?

Many thanks

Sam Nazarko



     =
