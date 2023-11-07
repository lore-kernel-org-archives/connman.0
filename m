Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCF23158C
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4ff9f475.dip0.t-ipconnect.de [79.249.244.117])
	by mail.holtmann.org (Postfix) with ESMTPSA id 2A389CECEE;
	Tue,  7 Nov 2023 19:55:40 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 0/3] service: Add Debug and Documentation to WISPr-related
 Functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
Date: Tue, 7 Nov 2023 19:55:29 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D59ACAC-4FBF-47A3-A2B8-A5838BDC0337@holtmann.org>
References: <5B8BB01A-C6FA-41A0-851B-B21D1D78DABD@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi Grant,

> This patch series adds =E2=80=98DBG' statements and function =
documentation to service WISPr-related functions to aid in debugging and =
correlating multiple in-flight online check attempts that exist in a =
multi-technology environment with =E2=80=98EnableOnlineToReadyTransition' =
asserted.

all 3 patches have been applied.

Regards

Marcel

