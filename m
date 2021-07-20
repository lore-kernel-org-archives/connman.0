Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7437E168
	for <connman@lists.linux.dev>; Tue, 20 Jul 2021 12:06:53 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id B6CF4500501;
	Tue, 20 Jul 2021 13:58:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.96.3])
	by mail.monom.org (Postfix) with ESMTPSA id 80B14500196;
	Tue, 20 Jul 2021 13:58:55 +0200 (CEST)
Date: Tue, 20 Jul 2021 13:58:55 +0200
From: Daniel Wagner <wagi@monom.org>
To: Rahul Jain <rahul.jain@samsung.com>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>,
	AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
Subject: Re: main: Fix a memory leak for str_list in parse_config
Message-ID: <20210720115855.hczt2wjidpjukrmn@beryllium.lan>
References: <CGME20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27@epcms5p8>
 <20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27@epcms5p8>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714090411epcms5p810fc79bcbc4f7a7d48028cb1f4d3ab27@epcms5p8>

Hi Rahul

On Wed, Jul 14, 2021 at 02:34:11PM +0530, Rahul Jain wrote:
> commit 6e7844d37588612aa52722da6fa17468bd677b8c
> Author: Rahul Jain <rahul.jain@samsung.com>
> Date:   Wed Jul 14 14:30:48 2021 +0530
> 
>     main: Fix a memory leak for str_list in parse_config

Patch applied.

Thanks,
Daniel
