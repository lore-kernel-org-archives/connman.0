Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125913BADE
	for <connman@lists.linux.dev>; Thu, 22 Feb 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644301; cv=none; b=p6v/TxvqC2nRtT4XpEcNbF/isNoFTEnFiEBxI1+g1i5lQisg05WIhXZ6uAwm8SG6VvDvasvVJuFsxGswGbYmSRJo8e7c5O+2KpOxH5O9SIhyBAhUp7nilK+YgxoFCQ3yu/kxgn7qalkkN7zWHHrOS+Rq73FwRnCarzzq9O5nC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644301; c=relaxed/simple;
	bh=nCz4vzh7yfDLgmLZ+aEjgDoLcspLUMhTfvqanrG9rZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s1TsBlCEkMbma51F1M8W2lOmpZO3MCJ/b8tyeRTn0w22j52OXvEzJ7IDgg3/HEP4nzEBr+xd7sQ1yT6OPlATYkaI5rdFF//wXrreRkMHVhUxlWU88QPI1preukni9VK+7CYg1/lv/rsQURZb6MMzWwR1paAYVIwIhxBHFSd8ay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=aBGGrP1v; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="aBGGrP1v"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1DC82240101
	for <connman@lists.linux.dev>; Fri, 23 Feb 2024 00:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1708644291; bh=nCz4vzh7yfDLgmLZ+aEjgDoLcspLUMhTfvqanrG9rZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=aBGGrP1vIhG2MV868LJC53T1pJjM3K0XUF2t9U82z8qbofL/ekBkZHZJnZ026flc5
	 nwh/mvnu11F0HEdTvZUY/2kSz9C+wEF/shOXs3nKyuYJZwJLzmGp6qY5zf7Jut/yYJ
	 E170aRTvM4s84S8Z7wXY5d0nia0tJfEUHfU658kv0APgSQMNppfvqAEy8/cEZv8UKy
	 iSdn1GjjZthyDoNtI15iH+0GlIJBwkN0ReIEacxOas4QQoaCs0g7pVL1OPqGDXbJQY
	 QI9/P8XOGJnrl+ANE+kquOB+MOtIpfBDkxnsRshsMuDdt02+vc58ExIu4qyz8mRmIx
	 D2aXZRMcsJYqQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tgq424k08z6tvJ;
	Fri, 23 Feb 2024 00:24:50 +0100 (CET)
From: Christian Meusel <christian.meusel@posteo.de>
To: connman@lists.linux.dev
Cc: Christian Meusel <christian.meusel@posteo.de>
Subject: [PATCH 0/1] Use a log identity always valid while logging
Date: Thu, 22 Feb 2024 23:23:25 +0000
Message-Id: <20240222232326.1677146-1-christian.meusel@posteo.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I encountered garbled and changing log identifiers from connmand 1.42
running on Yocto Kirkstone.

    Feb 09 02:40:18 foo time[590]: Connection Manager version 1.42
    Feb 09 02:40:18 foo time[590]: ../connman-1.42/src/dbus.c:__connman_dbus_init()
    Feb 09 02:40:18 foo time[590]: ../connman-1.42/src/main.c:parse_config() parsing main.conf
    Feb 09 02:40:18 foo time[590]: Online check disabled by main config.
    Feb 09 02:40:19 foo U[590]: ../connman-1.42/src/inotify.c:__connman_inotify_init()
    Feb 09 02:40:19 foo U[590]: ../connman-1.42/src/technology.c:__connman_technology_init()

This variant is slightly patched (see
https://git.yoctoproject.org/poky/tree/meta/recipes-connectivity/connman/connman/0001-src-log.c-Include-libgen.h-for-basename-API.patch)
which creates a use-after-free situation. But nevertheless there is no
lifetime requirement communicated for the 'program' argument passed to
'__connman_log_init' and on the other hand 'basename' might as well
return a pointer to an internal buffer.

In either case, a locally allocated log identity string will prevent
potential issues.

Best regards,

Christian


Christian Meusel (1):
  log: Use a log identity always valid while logging

 src/log.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.34.1

