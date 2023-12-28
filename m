Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF5F9C7
	for <connman@lists.linux.dev>; Thu, 28 Dec 2023 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p5b3d275b.dip0.t-ipconnect.de [91.61.39.91])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4461FCECC3;
	Thu, 28 Dec 2023 18:41:09 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v2] main: Use preprocessor definition rather than
 'General' string literal.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231228163833.3909969-1-gerickson@nuovations.com>
Date: Thu, 28 Dec 2023 18:40:58 +0100
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <71DD5866-999D-49E4-9FEE-8238797DECFE@holtmann.org>
References: <20231228163833.3909969-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi Grant,

> This converts a potential run time error due to a mis-spelling of the
> "General" configuration group name repeatedly used as a string literal
> into a potential compile time error due to a mis-spelling of the
> preprocessor definition that now references it.
> 
> There is no change in code size to .bss, .data, or .text due to
> this change.
> ---
> src/main.c | 75 ++++++++++++++++++++++++++++--------------------------
> 1 file changed, 39 insertions(+), 36 deletions(-)

patch has been applied.

Regards

Marcel

