Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64BE31740
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D53C9730DC;
	Fri, 24 Nov 2023 12:57:15 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:e9e3:725c:3cdc:7b3c] (unknown [IPv6:2601:647:5a00:15c1:e9e3:725c:3cdc:7b3c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8A8047310A;
	Fri, 24 Nov 2023 12:57:15 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 0/3] service: Minor address_updated Changes
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <E616460C-EC81-4598-B4FE-B5510E81980B@holtmann.org>
Date: Fri, 24 Nov 2023 09:57:14 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E008930D-F202-4DD3-ACB5-DC9794579914@nuovations.com>
References: <20231116030912.636756-1-gerickson@nuovations.com>
 <E616460C-EC81-4598-B4FE-B5510E81980B@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 23, 2023, at 3:22 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> This makes some minor changes to 'address_updated':
>> 
>>   1. Leverage 'connman_service_is_default'.
>>   2. Add 'DBG' statement.
>>   3. Add documentation.
>> 
>> Grant Erickson (3):
>> service: Leverage 'connman_service_is_default'.
>> service: Add DBG statement to 'address_updated'.
>> service: Add documentation to 'address_updated'.
>> 
>> src/service.c | 35 ++++++++++++++++++++++++++++++++++-
>> 1 file changed, 34 insertions(+), 1 deletion(-)
> 
> sadly this doesnt apply cleanly anymore.

Thanks; resubmitted as v2.

Best,

Grant

-- 
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

