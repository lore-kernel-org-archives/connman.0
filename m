Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D31173
	for <connman@lists.linux.dev>; Tue, 16 Nov 2021 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id e1703342-46ef-11ec-ae1c-005056bdf889;
	Tue, 16 Nov 2021 17:14:23 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v1 0/2] Improve OpenVPN configuration value processing
Date: Tue, 16 Nov 2021 17:14:15 +0200
Message-Id: <20211116151417.14827-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework how OpenVPN processes the configuration values by introducing a
more clear way to classify different types of options. This makes it possible
to add options that may have a value or can be used without a value thus,
resorting to default value set for the option. Also the --auth-user-pass
and alike options having a special value are handled in cleaner way.

Motivation for this was that the --comp-lzo option was not processed
correctly with its value, and even though being listed as deprecated some
OpenVPN providers use the value. Omitting this option even though it was
required caused issues with both UDP and TCP VPNs:
  write to TUN/TAP : Invalid argument (code=22)
after which OpenVPN silently restarts itself.

Jussi Laakkonen (2):
  vpn-provider: Support checking if provider setting key exists.
  openvpn: Improve configuration value processing

 vpn/plugins/openvpn.c | 119 ++++++++++++++++++++++++++----------------
 vpn/vpn-provider.c    |   6 +++
 vpn/vpn-provider.h    |   2 +
 3 files changed, 83 insertions(+), 44 deletions(-)

-- 
2.20.1

