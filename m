Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18145688
	for <connman@lists.linux.dev>; Wed, 16 Aug 2023 05:40:05 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2680a031283so3538216a91.3
        for <connman@lists.linux.dev>; Tue, 15 Aug 2023 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692164405; x=1692769205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzf3eqgL4MQNAgL9rgaROVhZjSsNawoy/BRhPHRjxz4=;
        b=AF4BsHd7qDmie734SK71IAkn7uLp63Ssi3dgkc+KOZx8aXHHbigDpg3OHnFFKk/0oz
         elxDOBBQbHz8XaabjGwgPtspwdOGwmGvm3odBRLv07+si5C1z97ih9w6AtgZ3NAp2dxp
         pZJqDtNehQGU6uCUBlAfQfheLA5xEFQHy/F1kqQ3DK7TsktX3IuKx933t+IBdg21OD+3
         +6uess+cFsJXEtk29QApBt94EL4JluesJojsklVDfJIW4j6gnAu+TUxv4eP5lTLAFIuj
         tTxciVofluzx+6fKgUV1rnLktBAa7Wo0bKSQTI0bTlMGuBFqoi/eRspwui9nU8P7zg/H
         H5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692164405; x=1692769205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzf3eqgL4MQNAgL9rgaROVhZjSsNawoy/BRhPHRjxz4=;
        b=YUOXR5BK9okgRp7XqbU9teMC+dLqSfoV6Ay4ki84+Gq02TAph5l9yN3hFiOTLa3Z8i
         5QY6hwg5UnFS3BSkMO83WdC0vr+uJx4yEMKxoz2XHHMHDh4tuXfV197RJNzkdEG5j2O0
         U/8nbxwY7ASeMaGCAMQ1iJaKChtbEyhNDu2J95LMQxHifTrXtKrs2owGI8S+oM+6+DNq
         h406FFifoxfxNg2AzqX+HE4USIVgw9bawbg3C40xMb8/hUVAW7nPbaPRwggopPnOerYY
         9nYaomYJfMhXoAnECbnfUMMy4VK9FsM5XgCTHiV6F+vNiymouab8uBcgWcE2GLCSZe9a
         ARZQ==
X-Gm-Message-State: AOJu0Yz8d7EDMjW1omYPGvTVWVUGswD8v4AEL69alkdWW2BSlRWHpWMT
	ZacEoaguz5j2XEnXjXtPhVUv5qj8ynwEI9vJCzA=
X-Google-Smtp-Source: AGHT+IEUnEmZbxE8AJ3wmrvXPRwOqst91t4BvqAoqohBqGByWSdIAT1rUPh5PtD6G+sCw+/tbAz21S2A/+wqqDhL2mQ=
X-Received: by 2002:a17:90a:1f42:b0:269:38c2:dbd8 with SMTP id
 y2-20020a17090a1f4200b0026938c2dbd8mr437611pjy.25.1692164404870; Tue, 15 Aug
 2023 22:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <56htxwyywekx6sjsq2akitcj6xmqmggkv4uo6wnhmlxmxyzo23@5crxfr5suvpk>
In-Reply-To: <56htxwyywekx6sjsq2akitcj6xmqmggkv4uo6wnhmlxmxyzo23@5crxfr5suvpk>
From: KeithG <ys3al35l@gmail.com>
Date: Wed, 16 Aug 2023 00:39:53 -0500
Message-ID: <CAG17S_O3fNuw3faU=griTL+mKGJKgH8g6OPSzcDia3WipoV7Vw@mail.gmail.com>
Subject: Re: connman 1.42 build failure due to missing header
To: Jan Palus <jpalus@fastmail.com>
Cc: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can confirm this as well

On Sat, Aug 5, 2023 at 1:03=E2=80=AFPM Jan Palus <jpalus@fastmail.com> wrot=
e:
>
> It appears that connman 1.42 dist tarball is missing
> scripts/libppp-compat.h header resulting in compilation failure of
> scripts/libppp-plugin.c.
>
