Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7E1FBD
	for <connman@lists.linux.dev>; Fri, 25 Feb 2022 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id cc4d00eb-9629-11ec-ae1c-005056bdf889;
	Fri, 25 Feb 2022 12:58:00 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] Check for active pending requests from agent when connecting hidden WiFi
Date: Fri, 25 Feb 2022 12:57:58 +0200
Message-Id: <20220225105800.501005-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hidden services do not keep the pending call when connecting as that is
forwarded for agent to handle, if present. This patch set adds simple search
to agent.c that can be used in service.c via agent-connman.c to check if the
hidden service has a pending connect request.

It was noticed that two consecutive connect requests for a hidden service was
possible and this resulted in adding two separate requests when agent was
present. First requests was placed as the pending request on the agent and the
second one was allowed as well but it was put into the queue. And when time-out
happened on the first one then the duplicate request would have been sent.

UI components relying on D-Bus API should not have to deal with this, it is
better to handle this case on ConnMan side.

Jussi Laakkonen (2):
  agent: Add support to check for active pending requests
  service: Check if hidden service has a pending request

 include/agent.h     |  1 +
 src/agent-connman.c | 16 ++++++++++++++++
 src/agent.c         | 28 ++++++++++++++++++++++++++++
 src/connman.h       |  2 ++
 src/service.c       |  5 ++++-
 5 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.30.2

