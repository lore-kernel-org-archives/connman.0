Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31543FED
	for <connman@lists.linux.dev>; Mon,  4 Oct 2021 06:38:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AF9561783;
	Mon,  4 Oct 2021 08:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1633329494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Hhi7Giq0COg/T5LfYndKd/idaTB51Aj8ewVNvogzpTQ=;
	b=JRJA+QZxvH0zbr98nr2Isqw2b4v64UW7+nyTR2XyUBg0EXaVN1opgfqrZCvlR1GAYa4FZs
	dE/P5pKl2gCL/0Ictw2KV0rFy4sjuvhkKifFajmpahBj1EjQNUVC2E0pCZXlAmZXkITnvS
	eP6gGxcJUNKPJe0ynSW9Gj3EgNnnOSZp95RPwb04h6lM2qjDdC+kNfu7+u+yapCOGEToY8
	WdQBD37tFjU08jbPR7XjJpftSu8Wk+vKck+49D1LLgmfSpC8vq6RthISR9QafK4fIqt4Ng
	sw7NTkkCqrc29qNccIFcfG/BDwpO02bjwbOImtHb1ctoqwzsFgHNtRZXgA3OiA==
Date: Mon, 4 Oct 2021 08:38:13 +0200
From: Daniel Wagner <wagi@monom.org>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 1/2] iwd: Set the network index add_network
Message-ID: <20211004063813.cgqwdcbh2ypuziym@beryllium.lan>
References: <20211001122607.34360-1-michael@amarulasolutions.com>
 <20211004063214.r4a2ie5njhk4y7hz@beryllium.lan>
 <CAOf5uwmyAkq5a4+NdPw48bBW+V588Bn8X5=z9_oKqcB9EKcdFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf5uwmyAkq5a4+NdPw48bBW+V588Bn8X5=z9_oKqcB9EKcdFQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, Oct 04, 2021 at 08:35:47AM +0200, Michael Nazzareno Trimarchi wrote:
> > I've applied the version from Emmanuel. Hope that is okay.
> 
> Better commit message (aka better english) and 6 minutes before :)

The 6 minutes did win the race :)
