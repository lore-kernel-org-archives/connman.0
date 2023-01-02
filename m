Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6020EC
	for <connman@lists.linux.dev>; Mon,  2 Jan 2023 08:20:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B711DDB6EE;
	Mon,  2 Jan 2023 09:10:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1672647010; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MStLpNA7D/ERaa0qTnDzgjK1OD8twIvGFGJXW0Gdwb8=;
	b=XVrBNR9NTEDfPDRZKsd9VBYZHqHUMmi2Wo4BzVfj2A4HWwq71T53yU6YMttzbkbdAO21uv
	nmdBRHi1vvtjLrze05O1IF8TVUJoOgnCG2/67e639+hCym7AZQBy+zGj91a1IQcvfl3m2a
	gl7FQftRW+p8uxR3fr18AyTOx0XmYUU8571I7nXUxosAGwcR65pWmTdJDGVurQPYCsrL9W
	5zWVASJDW53/245wfO8674pNZH5j2ULSLTBHgNIBtn/Go3yDSKUAMakHBTg9GBFdvRXc+D
	R1PrN431RgUAspCLUzceQPAehTE6wvdU3ifuSMUaQhHhGDzL+PlFNSDsBdWC+Q==
Date: Mon, 2 Jan 2023 09:10:07 +0100
From: Daniel Wagner <wagi@monom.org>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev
Subject: Re: [RFC PATCH 0/9] Add association state for VPNs
Message-ID: <20230102081007.jobeqdgzrzzwwwqx@beryllium.lan>
References: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Jussi,

On Tue, Dec 13, 2022 at 04:06:58PM +0200, Jussi Laakkonen wrote:
> This patch set adds the association state also for the VPNs. This state is to
> indicate that the VPN is waiting for VPN agent to provide input given by user.
> In this state service.c must not do connect timeout checks as the timers for
> both differ in length, default being 120s for connect timeout and 300s for VPN
> agent dialog timeout.
> 
> In order to facilitate this change the association state had to be implemented
> also for VPNs. It is common state for services and like with services the
> association state for VPNs preceeds the configuration state (on VPN side
> connect state). Both vpn.c plugins on connmand and vpnd side require changes
> to accommodate this state. When the VPN agent succeeds in getting the input
> from the user the state transitions from association to connect (configuration)
> state and, thus, requires no specific changes to VPN plugins.
> 
> On connmand side the association state is the initial state when VPN is getting
> connected and the state needs to be accounted as a connecting state in
> plugins/vpn.c to not to lose transport ident for it and in provider.c as a
> pre-configuration state to not to start the connect timeout for the VPN before
> the VPN is in configuration state. The reason for the latter is that the
> connect timeout should be exact and start from the point when
> connect/configuration state is entered.
> 
> On vpnd side association state is, like on connmand side, the initial state for
> the VPN getting connected. After the VPN agent succeeds getting the information
> from the user (credentials) the state transitions to connect (configuratioin).
> There may be a possibility for a VPN plugin to run without VPN agent and thus
> in these cases it is ensured that the vpn/plugins/vpn.c:vpn_notify() does
> the state transition in such cases. It is allowed go back to association state
> from connect state but not from other states.

I can't remember why the VPN part is missing the association state. Propaply it
was assummed having the configuration state is enough.

> I'd like to raise the following issues for commenting:
> a) Is this current approach sound in the way that the vpn-agent.c is
>    responsible of changing the state? vpn-provider.c:connect_cb() would be
>    ideal but that does get called in notify if there is no error. Processing
>    the message with the vpn_agent_check_and_process_reply_error() with success
>    indicates that VPN agent succeeded getting the input.

Unfortunatly, I can't remember all these details, though I think the idea of
connect_cb was to get called as final function. So it's sounds like you want to
extend it to handle all state transitions. Sounds reasonable, but I suggest to
update the name so that it refelcts more what it is doing, e.g. match it with
the service.c::indicate_state, vpn_indicate_state (?) Does this make any sense?

> b) Can we figure out a case where the state transition from VPN plugin notify
>    SHOULD change the state back to ASSOCIATION when normally in CONNECT state?
>    This change is in vpn/plugins/vpn.c that accommodates transitions from
>    CONNECT->ASSOCIATION.

Hmm, the main state machine for ConnMan doesn't allow for this transitioning
from CONNECT to ASSOCIATION (or CONFIGURATION) state. Don't know if we should
introduce it. It has a high potential to introduce a lot of bugs. At least
I would like to have a proper use case why we need it before we start
touching the main statemachine.

> c) Furthermore, might any of the VPN plugins available (elsewhere) work
>    without accessing the VPN agent? The flow now requires to use vpn-agent.c
>    for processing and state transition. However, these cases should then use
>    the vpn_provider_set_state() directly, as most of the plugins now do in,
>    e.g., error cases.

That might be the case, but I don't think we should consider this as really an
argument to stop us from updating the code base.

> d) The VPN and PROVIDER states, should these be harmonized to follow the same
>    structure as the common service states to avoid confusion or might this be
>    risky as many of the headers are public?

Yes, I think we should have all these state machines updated in sync, to avoid
complexity and reduce our maintainance burden. Yes, that might break exising
plugins though I am not sure there are any. In this case I would update our code
base and if someone is complaining we can still think about mitigation, such as
introducing some combat function/macros.

> e) Should the specific VPNs that do need VPN agent more than once then do the
>    transition back to ASSOCIATION when the first VPN agent returns and sets the
>    state to CONNECT? This is what I couldn't decide, there is another option to
>    have the vpn_agent_check_and_process_reply_error() to have an additional
>    parameter to state that do not transition state, but in the case of OpenVPN
>    the private key, for instance, can be decrypted and the management interface
>    queries the passphrase on need basis. Thus, there is no apriori information
>    on this.

No idea, you seem to have a why better understanding of the situation. It's up
to your :)

> And of course, any other issue that may trouble your mind with these changes.

I don't have any, right now. Let me quickly look though the patches. Though I
don't expect a lot of comments from my side.

Cheers,
Daniel
