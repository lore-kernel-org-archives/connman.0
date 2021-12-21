Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBA173
	for <connman@lists.linux.dev>; Tue, 21 Dec 2021 17:59:13 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id q74so41002806ybq.11
        for <connman@lists.linux.dev>; Tue, 21 Dec 2021 09:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Q2rXFYMmn3FmeSMT+AyqbMRq3KXrvVy3kUp7KPMZsZ4=;
        b=eLC4hT8s0BW7xJ6X8xpcD496+mp2sIjDZS51weeeUcZrAT4Pw26MvEPF7PQYqruXLP
         hmE13iB0B1sGQNAdRtq6JLrkHovtPKzZeXQs4X+ItyW6Ahe4wOPDdiNpeaImitWDq/ZV
         57Z+lTE8j4eREmV+1VxLhQP2eTz1BnFVYYFaHilsTACrBZI/aXhl/CJK1FYMSRHSX4EM
         dA8DxWQ+exp207QhTrFsPkkZt8znEBvr7JnJF6cyK4jY3hbSzeMhKooeUQMALTp3wnk1
         xOgxulo4JP+4u//tGgdywanRRML2/tgDxcbL4BSuU3lp9XBjklLv9BrbYt965U5nwl8I
         Milg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Q2rXFYMmn3FmeSMT+AyqbMRq3KXrvVy3kUp7KPMZsZ4=;
        b=PJ8EIJEMyD46PTMLfAUBni+TTrKvWa/HyIckfKTcQ1bg+NLfzVHFGhvs1szaqxNELN
         F6Sc7y7e6WO0eRDppJuYtfbUDJrjLpU+0Q9ZvGuAFOE3/n/kAnQpu5VINLTXj6KNuv2d
         Tp6B+PsgPhRYbYfmbVbksvNg3ysbVWGEbFjo53n445fIzpEm2knJKhAA6cAitjngyvbm
         nAvlo5wvCyEP1Pq+Kf5q1TpzrNqg7GhiyAAjTZSJDhNRbK/9vCg6FoExjVZOYrsCYVmM
         +FH9Kz07y1jxFSzFxJuPTboYxnfI1YBmLvUNbfhASUa37+8NLmnh7jNIVuTHeD85jbi9
         iFSw==
X-Gm-Message-State: AOAM530CxYTLUsj+nTZappnF8jtnyauwon4bUMG1ht/hn8nstXVAdGjo
	1TDMnD56MAoxw+/NXPtcnltQ6LtfCqtGCEERKPbigGgnjhf5Vw==
X-Google-Smtp-Source: ABdhPJwANJwN9t9JknDc6g4n7sXe7Zb1xLC77VBmujrPoEj4qk6uBo72xoTFsbAxzJkCFRWBOps9OIWmxuo5/cxMkR8=
X-Received: by 2002:a25:acd4:: with SMTP id x20mr5997209ybd.416.1640109552050;
 Tue, 21 Dec 2021 09:59:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20211216102249.502964-1-Emmanuel.VAUTRIN@cpexterne.org> <20211219174059.c62hjgjym6frrnln@beryllium.lan>
In-Reply-To: <20211219174059.c62hjgjym6frrnln@beryllium.lan>
From: Emmanuel Vautrin <emmanuel.vautrin@gmail.com>
Date: Tue, 21 Dec 2021 18:59:00 +0100
Message-ID: <CAGYU+QVC9-RwGYXQMtpx6iJNOhQCJkbZsQckaZHqE0rou2_xmg@mail.gmail.com>
Subject: Re: [PATCH] service: Fix native connection with wrong passphrase
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

> There is whitespace damaged and a pretty idention.
Indeed, you are right. I am trying to follow your advice and using
send-email now, via gmail.
When displaying my original message via the gmail client, the
formatting seems to be
the expected one, so it seems not to be related to git send-email
command itself.
Unfortunately, I have not found how to prevent gmail post-formatting the mail,
and I doubt it can be configured. Do you have any idea how I can move
on this subject?

> I was about to fix this, but stopped because the 'report_error_cb()' doesn't make sense
> with the commit message. If you want to properly report you need
>
>                        connman_agent_report_error(service, service->path,
>                                                error2string(service->error),
>                                                report_error_cb,
>                                                get_dbus_sender(service),
>                                                NULL);

> IMO. report_error_cb() doesn't do any agent stuff.
In fact, the connman_agent_report_error is well called, but the report_error_cb
is not. As my solution is probably far from a clean one, the best is
to explain the issue.

I am focusing on 2 close cases, connection to a secured network via iwd with
rejected (wrong length / content) passphrases.

**Connection with a wrong passphrase length **
The error is directly managed in request_input_cb, due to a failing call to
__connman_service_check_passphrase (length < 8 || length > 63):
#0  connman_agent_report_error at ../git/src/agent.c:437
#1  service_indicate_state at ../git/src/service.c:6139
#2  __connman_service_ipconfig_indicate_state at ../git/src/service.c:6492
#3  __connman_service_indicate_error at ../git/src/service.c:6183
#4  request_input_cb at ../git/src/service.c:5875
#5  request_input_passphrase_reply at ../git/src/agent-connman.c:204
#6  agent_finalize_pending at ../git/src/agent.c:121
#7  agent_receive_message at ../git/src/agent.c:208

then the reply pending is done, as expected:
#0  reply_pending at ../git/src/service.c:3963
#1 service_complete at ../git/src/service.c:3980
#2 report_error_cb at ../git/src/service.c:5752
#3 report_error_reply at ../git/src/agent.c:369
#4 agent_finalize_pending at ../git/src/agent.c:121
#5 agent_receive_message at ../git/src/agent.c:208

**Connection with a wrong passphrase**
The error is managed in native cm_network_connect_cb:
#0 connman_agent_report_error  at ../git/src/agent.c:437
#1 service_indicate_state  at ../git/src/service.c:6139
#2 __connman_service_ipconfig_indicate_state  at ../git/src/service.c:6492
#3 __connman_service_indicate_error at ../git/src/service.c:6183
#4 set_invalid_key_error at ../git/src/network.c:1582
#5 connman_network_set_error at ../git/src/network.c:1655
#6 in cm_network_connect_cb at ../git/plugins/iwd.c:245
#7 in method_call_reply at ../git/gdbus/client.c:831

But, unfortunately, the native __connman_network_disconnect is called,
canceling the request, what prevents the report_error_cb to be called:
#0  send_cancel_request at ../git/src/agent.c:166
#1  connman_agent_cancel at ../git/src/agent.c:547
#2  __connman_service_disconnect at ../git/src/service.c:6817
#3  service_indicate_state at ../git/src/service.c:6022
#4  __connman_service_ipconfig_indicate_state at ../git/src/service.c:6492
#5  set_disconnected at ../git/src/network.c:1044
#6  __connman_network_disconnect at ../git/src/network.c:1848
#7  connman_network_set_error at ../git/src/network.c:1665
#8  cm_network_connect_cb at ../git/plugins/iwd.c:245
#9  method_call_reply at ../git/gdbus/client.c:831

I hope having clarified the problem.


Best Regards,

Emmanuel
