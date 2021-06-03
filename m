Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775070
	for <connman@lists.linux.dev>; Thu,  3 Jun 2021 12:04:23 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id t7so1291072lff.0
        for <connman@lists.linux.dev>; Thu, 03 Jun 2021 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WPuGEVzKNtkDS4P8ttUybUnW5mg3H1X1XLRz4JgTkmI=;
        b=pTYllL40/mZZ6AafZaq84kdha032g1pYLBGiUeWeYMgGAScbbIg8H7nk1Pew4KoGi/
         u5NlxTLaKLP3OedzkrTuwZd0ecOHKxf4HLqOhCi2Ws7xzMpmorBx7niUJKPK2hzYFyL/
         AoWfDrNSeqeTSnbUm1gUvBuSe9iSYpTOe+dGW1J7feDLR4RQh7zVfJu9Uae6S5vSfr9M
         PsatgzkGfs5aMJVd//RT6/iq+h6ofjSh1jHBI3WdP5p16xAD3sjXM4Tjj/B2zRoxndAe
         vvfvbQ/YILwQkb8as2MAX3nA3VpMZfON8lHIoi86lWGx8w6Aw/MsUJBzBMTGay64/v78
         OMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WPuGEVzKNtkDS4P8ttUybUnW5mg3H1X1XLRz4JgTkmI=;
        b=BjCx65krLCeD64migmOml9bdovf8F5PyjfL547+tWJXMjFYHdf68JKLNR4w71gbJt7
         IWf2XLMWnvTWwFo9ARtV9EAJaHsdhEPV+s2XCOumc9ROD1JugZt3yuM4mxoQ5j09gBUc
         YSrS7NONam1f67T/Qn//CMbQYOXrewiyF5kQSimcCXu/Y0X1yCp0g/C7ztXnrMwW75S0
         OcauTowOixe9ZtLjuJFt0js4xUMVEofpYocKfHljyWQaXzrK66LdWNUELNR1FJZvTDVu
         QV9XgUMty0GPiS1SLX8ta9G2FJywUXoMxRt8yAJ0zOlDr9juIqiuB6TWqZOrwej8LFuc
         bxWQ==
X-Gm-Message-State: AOAM5322OPsp7r7icTurkHBWX2K8H90WLLOYSQLUZX3edAWR9ozDonq/
	LtxMAFnifjGqcxEjyHJZx9QbFcHctSDLeX8M/ZLZr6+hVK09PQ==
X-Google-Smtp-Source: ABdhPJySTMcD46H2ZJV7qyGh1PYigZOtlmWbAwHo9TwsQUN6eYz+bi6pJIdqMrNXD92Yy/mD2e9fOymD1IJs/pJKcas=
X-Received: by 2002:ac2:5493:: with SMTP id t19mr1745025lfk.145.1622721861070;
 Thu, 03 Jun 2021 05:04:21 -0700 (PDT)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Andrei Datcu <datcuandrei@gmail.com>
Date: Thu, 3 Jun 2021 15:04:10 +0300
Message-ID: <CAAmFs7nJNeKJG0Bitgwy4dpautH9hV1pCiSRiHoj8fX_b5ksvg@mail.gmail.com>
Subject: Manager::ServicesChanged properties
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently, the documentation states that

The dictionary with the properties might be empty in case none of
the properties have changed. Or only contains the
properties that have changed.
For newly added services the whole set of properties will be present.


Yet, the final paragraph also says:

This signal will only be triggered when the sort
order of the service list or the number of services
changes. It will not be emitted if only a property
of the service object changes.


Combining the two rules, I understand that the props dictionary is
either empty (for existing services) or it either contains the entire
props dict of the newly added service.

My question:

Since by inspecting the code (service.c::service_send_changed) this
seems to currently be the case, is there any particular reason why the
documentation doesn't state it explicitly? Was there ever the
possibility to get a partial dictionary? If not, would you consider a
patch to the documentation to make it clearer for the future?

Thanks,

Andrei Datcu
