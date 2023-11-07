Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A331A6D
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8946973162;
	Tue,  7 Nov 2023 13:43:29 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3F10A731AC;
	Tue,  7 Nov 2023 13:43:29 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2] Const-qualify service leaf getter functions.
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <2D6F56DC-BBAF-4A1C-9AC2-5EDBAFFF8120@holtmann.org>
Date: Tue, 7 Nov 2023 10:43:28 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <D6211800-B4AC-48B1-88B2-09C3215DDF02@nuovations.com>
References: <F972A4C7-98B0-4667-B919-41A692B22C22@nuovations.com>
 <90BDDD2B-F715-4301-97A8-1B11BE65915F@nuovations.com>
 <2D6F56DC-BBAF-4A1C-9AC2-5EDBAFFF8120@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 7, 2023, at 7:37 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Const-qualify the network service arguments in service leaf getter
>> and introspection functions to make it clear to the compiler, static
>> analyzers, and human readers that the function is strictly a getter
>> or introspection function with no network service mutation side
>> effects.
>> ---
>> include/service.h | 18 +++++++++---------
>> src/connman.h     | 24 ++++++++++++------------
>> src/service.c     | 42 +++++++++++++++++++++---------------------
>> 3 files changed, 42 insertions(+), 42 deletions(-)
> 
> patch does not apply cleanly.

Marcel,

This has been re-submitted as v3 against top-of-tree.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

