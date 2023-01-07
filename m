Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B779DA
	for <connman@lists.linux.dev>; Sat,  7 Jan 2023 21:50:35 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id v14so5076499qtq.3
        for <connman@lists.linux.dev>; Sat, 07 Jan 2023 13:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvJOgZ2KeepE6qKmflKVzFPHh43d1vRWXXMtuvrk7XI=;
        b=eomZ74zK4Tql+EED1couQ9mxx1BQXB9uvr5ke4OLXxpsXRb5W7DKIOUFgftsybJmGh
         6C2UIl8KSffCNUWjI93kdaofKExddLtAaKWAUwrGD6UMGDaenynfIBEFJrYTGmsNYYN/
         Wubmx6V96PIqoWIOqoYkK81BKVu//PcreG2ngdle80PEDPodAYVKWddRH5eu8ZpWP8hQ
         UnjqfGMR5AIPMr+UuKHOxQBEAXaq8boQwDZrHw06Njax/Kv0b9CbtVUxj7aPiL1keCP/
         j7vN8LLxcGttKDEdFIITGBWJB2QJDFyPJCnefvJTxp1fZ0cdTJEM32UOGxjy6bNlN2mK
         EGPw==
X-Gm-Message-State: AFqh2kq3JM00KR1PJ52oRMWeo8uOs4BHk4tbg48N0g045qWTpsMTfnfo
	3cvxzKv0WEZ2mcafCJHfwnExXS99aAzIyBOAwr5QfsL1
X-Google-Smtp-Source: AMrXdXvADdKXC6vj05HMYsQJGlwOC8HApuBy9VnszhV6VweSNaSMCR6YBR0s19TSr9Nj2+8kj1YKdA==
X-Received: by 2002:ac8:7389:0:b0:3a5:4a20:3096 with SMTP id t9-20020ac87389000000b003a54a203096mr82521348qtp.6.1673128234237;
        Sat, 07 Jan 2023 13:50:34 -0800 (PST)
Received: from localhost ([45.42.73.38])
        by smtp.gmail.com with ESMTPSA id cb15-20020a05622a1f8f00b003a5c60686b0sm2389070qtb.22.2023.01.07.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 13:50:33 -0800 (PST)
From: lists@jade.fyi
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: Patches for the AutoConnect bug I hit in the iwd plugin
Date: Sat,  7 Jan 2023 16:50:20 -0500
Message-Id: <20230107215023.8288-1-lists@jade.fyi>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I did further investigation of the issues I found related to AutoConnect
being set wrong on the iwd backend and found that Connman was wrongly
setting AutoConnect to false after the KnownNetwork is created, causing
a desynchronization with its intended state. I've added some
documentation to make it easier to understand the logic, since it took
some use of rr to figure out what was going on.

Please let me know if I've made any mistakes in operating git
send-email, it's my first time sending patches to Linux Foundation
lists.

Original bug report:
https://lore.kernel.org/connman/CAFA9we9hh9gORA9EB4Sm7opJi_Rfb6c9L8KJz2rC_1zXnUShfA@mail.gmail.com/T/#t


