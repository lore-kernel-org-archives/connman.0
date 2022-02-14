Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F43A2C
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 16:33:38 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id m17so3027931edc.13
        for <connman@lists.linux.dev>; Mon, 14 Feb 2022 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=VYeBaEdDe5VuYyrTtd5d/OIyMtXc9usMDiidCRdKmJo=;
        b=eEuNqpcIKLkU2cwexNHUUc/XHR6KnSm/UYt5DI3gPbkwFBhOVOho8AeZDqUfTLDstk
         bHVrLV1XaO2PJ18iRRwOu3rjbbLk6Eo+Y1EPYWatC+BUxYfNZMAnJvDDvDQ2MgmSD42b
         U41zAjvYsg70lUuUuwKVk80Na+XuNgFQppeueEIa47WZpIyBqTc4KV2dBOhtM3FlbCsG
         Ew7ZRSYRIO66ctykDQPETsE4JaObqMaIpiaqJseKD7KYw4ejcTqEtUHFCCUNEb2+2HgY
         vb9pDVVa87xrk1hTdNSWz3IF6kMutt0qaNWqqnXNXbpULzjooCPw6guUSBA0Oj1pBCuv
         NfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VYeBaEdDe5VuYyrTtd5d/OIyMtXc9usMDiidCRdKmJo=;
        b=nNfogPqCrFMJTKkYzxbLHA/9XQqVMSgTVbU5l0InTe83m1vO30iMnaKGC/VE38/WKd
         VousDBRjyUQ/ytynZKBZUpnmXjlz0iItlwvJKl66jyW5gKxEK0TGJYbWdKUXk8VL/ITu
         T4pm2ZfQI4I71AYGntPnwl1v8qiC/rvsg4UftbLMgfiL6YzKUw4xuKx0vUehD7IbFE3G
         KDBFTVRQ1KTg8cet+jIY0+iW1w1wSaHiQPBvxLfp3CQhy3HmqDHkyXVxVirHI5Iqa5F4
         p5QK9+aZIocmi1qkiRmxgObNhcO9RAE12rrO1kQL/8MqoKqIOSU+IdtPbP4fzfAZ8Dew
         XbsA==
X-Gm-Message-State: AOAM532nMWvDPnXhhHjGesYM2xyFJBRQQWvbjxe5iNlk2dtyXT2BXQLH
	BRQRG+qu1HxRYwNntK2nU+6f+5JWDHoUiteLl64IcOTMAzsiUg==
X-Google-Smtp-Source: ABdhPJzQnXgpSBg02wJ+ukYGvvXE51taPtZtzWTMmzCO1vhY5v5EFGnnmFBkwLzP4ZUREB23B6y52kz0WfTi2va8pBg=
X-Received: by 2002:aa7:cb17:: with SMTP id s23mr450649edt.172.1644856416524;
 Mon, 14 Feb 2022 08:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Mon, 14 Feb 2022 17:33:25 +0100
Message-ID: <CA+iibzAqa2-xPiddMfjX-EmsvMt7dYV39mW5WBLnUNN=B9gYAA@mail.gmail.com>
Subject: =?UTF-8?Q?connman_issues_with_enlightenment_since_last_upgrade?=
	=?UTF-8?Q?_to_version_1=2E41_Bo=C3=AEte_de_r=C3=A9ception?=
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have seen your answer on lore.kernel.org/connman but not on my
e-mail. How can I do a log ? by adding /usr/bin/connman -n -d
/home/user/connmanlog.txt in the connman.service file ? I have tried
manually, it has functionned but not written the file.I can reproduce
the problem by just removing the main.conf file with
EnableCheckOnline=true

in both cases (host wifi interface ready or online) when I start a
virtual machine and when I do an upgrade in the VM and reach the repo
server the vnet0 interface on the host get an address 169.254.xxx.xxx

BR

Dania
