Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA6168
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 07:18:53 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id C8C0A500587
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 09:18:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id 9918B500289
	for <connman@lists.linux.dev>; Fri,  2 Jul 2021 09:18:45 +0200 (CEST)
Date: Fri, 2 Jul 2021 09:18:45 +0200
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Subject: Re: [PATCH] service: Let PreferredTechnologies overrule connected
 service sorting
Message-ID: <20210702071845.42llx43rhzubvqrs@beryllium.lan>
References: <20210621072036.302-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621072036.302-1-wagi@monom.org>

On Mon, Jun 21, 2021 at 09:20:37AM +0200, Daniel Wagner wrote:
> When both services are in either READY or ONLINE state ConnMan will
> always return either the service in ONLINE state (this is the correct
> behavior) or when both services are in ONLINE state service_a
> first. PreferredTechnologies is ignored in this case.
> 
> For configuration such as
> 
>   PreferredTechnologies = ethernet,wifi
>   SingleConnectedTechnology = true
> 
> ConnMan would almost never sort Ethernet before WiFi, as WiFi is likely
> to be in the ONLINE state. Hence the WiFi would stay on forever even
> though the Ethernet cable is plugged in (again).
> 
> Place the service_compare_preferred() after the service->oder logic as
> this is used for split VPN setups which has higher priority in the
> sorting.
> 
> As we place this call inside the 'is_connected' section where both
> service are in either READY or ONLINE state, it overrules the
> existing logic where the ONLINE service is preferred over the READY.

Patch applied.
