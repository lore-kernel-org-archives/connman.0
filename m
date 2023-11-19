Received: from www1.webmail.pair.com (www1.webmail.pair.com [209.68.6.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326918040
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="JVvQlvgs"
Received: from rc.webmail.pair.com (localhost [127.0.0.1])
	by www1.webmail.pair.com (Postfix) with ESMTP id D22411A097C;
	Sun, 19 Nov 2023 12:08:47 -0500 (EST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sun, 19 Nov 2023 09:08:47 -0800
From: Grant Erickson <gerickson@nuovations.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH 00/17] Address Redundant IPv4 Reachability Checks
In-Reply-To: <542EA7A2-E02E-443E-9061-6C6FA5809D85@holtmann.org>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <542EA7A2-E02E-443E-9061-6C6FA5809D85@holtmann.org>
Message-ID: <53515e05d02bd34f62ea96f483c5c105@nuovations.com>
X-Sender: gerickson@nuovations.com
Organization: Nuovations
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=mime-version:date:from:to:cc:subject:in-reply-to:references:message-id:content-type:content-transfer-encoding; s=pair-202306091031; bh=/KwHdpPO20jamfK5zvPuu1zv+G16nSA1Oo9SytW/zKU=; b=JVvQlvgsUkjdB7BXT7wZhnC6YJA64IgS+2c7/tF3YCLeaIqhxgzi4mor/zrmaq3Bkj2WZeaAeAmpbkX9AV7MKG4nTNZji7VhKhYiNv7ZwPQe6oAHYdqwE0Ihm6bg8/36IWLe9PwFyZboym9Rh6rH9Xw3yHjyp+xuhyAMHyBPUIehbghqUN46ne19gYEjLblxHQghq9MvUp0ETH6CEwQ0S6nSgQi+4wz/kww5vi+gODWGQcaadPU+yF2qUh+PC9k5YOu30fefN3+Kbgy1gF4IrWjZ9flJzZew1DcoommLb4fB+36GNaQI8K056LJCcsX+MY1d4Rl9CD/SECad44EttA==
X-Scanned-By: mailmunge 3.09 on 209.68.6.94

On 19.11.2023 06:12, Marcel Holtmann wrote:
> 
> [ ... ]
> 
> I got this when trying to build the patch set.
> 
>   CC       gweb/gweb.o
> gweb/gweb.c: In function ‘do_request’:
> gweb/gweb.c:2357:57: error: comparison of unsigned expression in ‘< 0’ 
> is always false [-Werror=type-limits]
>  2357 |                         status = session->resolv_action < 0 ?
>       |                                                         ^
> gweb/gweb.c:2359:49: error: operand of ‘?:’ changes signedness from 
> ‘int’ to ‘guint’ {aka ‘unsigned int’} due to unsignedness of other 
> operand [-Werror=sign-compare]
>  2359 |                                                 -ENOENT;
>       |                                                 ^
> cc1: all warnings being treated as errors

Marcel,

Thank you; I've addressed this error and that in 'is_wispr_supported'. 
Submitted as a v2 on this thread.

Best,

Grant
