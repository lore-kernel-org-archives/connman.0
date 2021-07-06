Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B770
	for <connman@lists.linux.dev>; Tue,  6 Jul 2021 07:19:19 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id E0CA750057C;
	Tue,  6 Jul 2021 09:19:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.98.41])
	by mail.monom.org (Postfix) with ESMTPSA id A470C50051D;
	Tue,  6 Jul 2021 09:19:11 +0200 (CEST)
Date: Tue, 6 Jul 2021 09:19:11 +0200
From: Daniel Wagner <wagi@monom.org>
To: "VAUTRIN Emmanuel (Canal Plus Prestataire)" <Emmanuel.VAUTRIN@cpexterne.org>
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Subject: Re: [PATCH] service: Ignore state information in service reordering
Message-ID: <20210706071911.6rl5b2nrooy6lchd@beryllium.lan>
References: <PR1PR02MB479483A5E7FB6525A8F5257D93089@PR1PR02MB4794.eurprd02.prod.outlook.com>
 <20210702075335.opqr3lc7kzell6lv@beryllium.lan>
 <MRZP264MB154432CD7A2E3A804089C9B0931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
 <20210702083720.hwb266z5eo4xlv7f@beryllium.lan>
 <MRZP264MB154471078FD87663548DE9BB931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MRZP264MB154471078FD87663548DE9BB931F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>

Hi Emmanuel,

On Fri, Jul 02, 2021 at 03:19:28PM +0000, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> If the state still matters for VPN part, maybe it will be cleaner
> to call is_connected() instead of checking the state itself.

Thanks for the explanation. Indeed if the service needs to be connected
then using is_connected() will clearly document this. I need do to test
this a bit first though.

Thannks,
Daniel
