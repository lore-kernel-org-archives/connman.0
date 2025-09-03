Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDD2FCBEB
	for <connman@lists.linux.dev>; Wed,  3 Sep 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903869; cv=none; b=YvxfdEAEWMLceU7dmpVyuClb0YtFaRx+xQk2BgTErL4IFA2qxrnegghmx0OrXdY5CGh8/h0dXvjkcnAGuXLxlPCerwbrpKkn5TXF+jBQduJGWkNKayNtqO9OV7lmo+brZd7idy+rsUjL2V7xea46I60y3RGsv0H3JhEakRfeecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903869; c=relaxed/simple;
	bh=xb6zL+cD1tVhR3794S5ktMVLLOSKPlq163MWfj6+85Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sH6TYddb6jB1oNP5Keb7xf0ms1APxxFSVy11ZaiE5SJpOZ3PDFyUZ2MwA1lfSz3pFCimR9JtFKo8Vq8/znmGgVjJxcZb4d3AB+9HhB6FFFF72RHiqCyMI5lJwjSK7g7l6lb7urYbXc7c4EB38QCL4FPBoCi9b1Bxw2RKuhMHfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b=KevVyNrJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b="KevVyNrJ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96c48e7101so5955468276.2
        for <connman@lists.linux.dev>; Wed, 03 Sep 2025 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20230601.gappssmtp.com; s=20230601; t=1756903866; x=1757508666; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMLzvMuSpcLTQ6/gQfyehcKubwyCHfHZT7sJCN7zRZc=;
        b=KevVyNrJSyQdNl1qZ/PZhch83BEZ2fQbwCHJ1iE692ZV9kKEI1qXqeKjml4mdRdEI5
         cQbBX+v8BskehiCYLar7PtwGxxC4KvhDdb3q0im3Y7k5H15LUka2NGmDGmdwuUEwnrwt
         9aPnr0sBHcJ6f5FKT5FLmi1zLzaxDp7J0vCMEgJldw2w+VompZ9txwBsYqFENsaTqTyk
         9XlIYyQLU3Vo1loV2dOejnygfhRWk9med7auvycbvEFGaxfYknk1In82wGOpZvotGiVP
         kyHuEgQSKd5YDbYFxsMKZ1jVAxBzZZrtwHw8o2tRCgNvHG2QO6TPpP5a6/fjlWXMYijI
         Npzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903866; x=1757508666;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMLzvMuSpcLTQ6/gQfyehcKubwyCHfHZT7sJCN7zRZc=;
        b=jmXQT4aADJzQ64UUwKINwePIwOwELsmtpfGw/1/Hc/6ntWL0uNRzdfFDa9UcqqTR7f
         p5/IIRvGqxRwlRiaI8EpiL2Wr1RF1YDpA/rRc0QX5ay5XVy7LFzVB/LhVTWWBGQh42YD
         yfKYfpwyWvBzZlGcADMVa9Dk9u/rVSfw2kVYD+KnySyxTHsQUBgE1s1OcxQZFjEzwhWv
         flS+QIlo8GnoYh+AhVMFPvwk1yGw2A263Rck6n5+iYIomGYw0sM0cKwJ5SH02us6aGe4
         lMPdrVQK880q9cQ+8QVnsrCYWeZxCQAxj8kRclbRhj9J2EWPuZDIS73W3tgjSofsuFMN
         FsBw==
X-Gm-Message-State: AOJu0YyJyLlgREirhAyeJogbhXqYLHFy40FBtyVt3Ni+8p4rsQfjxTFA
	bz5aWT/HhOmMYM6NTyjk6UOo6Y5Pd/YTVJ9iKV+zJAkUjF1MvzIhIU304ja4l8hydbou5wWTKeL
	unuho7aRUi9nT1QqjWvhzvU8ArUTEuW+uu9N0HhVzZMcETbnH8iZdFGE=
X-Gm-Gg: ASbGncsYwAOV6bLOD5FIRRg92VwycxCvfmYU7XrcgRbv6G07jxRH5ZM/KhwgUzzdPvI
	v/kEsexuGmnONs9EI7ti2i3BuDAOHWw9IUJRXaEc5YgTyiXzOnTl17NlbHzGyU6JjQn1TAsKyt/
	ZS2ACY/wYFXe+9sZETZeichuyjtrdbQEU1xB4wj+Indbu/J8NeYb4Hm3wT/zjG1e78qIy4cOyTB
	dAYA8FVmDRi0WBN6A==
X-Google-Smtp-Source: AGHT+IFVa1jWQ1YfK7x/Lprs9yZZYz6K8/1APg90ea5W6quulHeIBcDqWv0aZKQA3MxbSuniTFY8YSWdMYjjY0eZO6I=
X-Received: by 2002:a05:6902:4408:b0:e95:2eea:a269 with SMTP id
 3f1490d57ef6-e98a578757cmr15281934276.20.1756903866053; Wed, 03 Sep 2025
 05:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Johannes Emerich <johannes@dividat.com>
Date: Wed, 3 Sep 2025 14:50:55 +0200
X-Gm-Features: Ac12FXy-lIz2L-ggkIiMw5fzers9KZpiDULMU2yR7q9xGkqIinC1JjY8V3de1Cc
Message-ID: <CAKQ2e6X9BVihgY58OjzwbaqNn5HVHqHDCirsO2+qCBro91sygg@mail.gmail.com>
Subject: Demoting IPv4 link-local services in service list sorting
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am trying to teach ConnMan to give IPv4 link-local services lower
priority than READY/ONLINE services using another ipconfig method (e.g.
DHCP). This seems like a useful heuristic, given that link-local
services are not suitable for configuring the default route.

As far as I can see, two changes would be required:

1. Adding a condition to service_compare(), something like this:

    /* Prefer configured IPv4 address over auto/link-local IP.
     *
     * This just checks for CONNMAN_IPCONFIG_METHOD_AUTO, but other
     * checks could be done.
     */
    bool a_is_link_local = is_ipv4ll(service_a);
    bool b_is_link_local = is_ipv4ll(service_b);
    if (a_connected && !a_is_link_local && b_is_link_local)
        return -1;
    if (a_is_link_local && b_connected && !b_is_link_local)
        return 1;

2. Triggering re-sorting when IP/ipconfig method of a service changes

Currently formerly link-local services are not actually promoted when
DHCP becomes active. This is likely because a service that transitions
from IPv4LL to DHCP just remains in READY state, and no re-sorting
occurs.

To address this, ConnMan would need to trigger re-sorting of the service
list when a service's ipconfig method or IP address changes. I am
currently looking into triggering sorting from service_ip_bound() or
address_updated() and this works in a basic test by just adding:

        SERVICE_LIST_SORT();
        __connman_gateway_update();


I would be grateful for any feedback on the below:

- Is address_updated() an appropriate place to hook into, are there any
  risks/downsides I am overlooking?
- Is there a more natural existing hook to trigger sorting from, or
  should a new one be added?
- Is there any reason not to demote link-local services in the way I
  described?


Context for this change

Our kiosk system built with ConnMan typically uses two simultaneous
Ethernet connections, one to an input device using a link-local address,
one to some network providing Internet access. In most cases ConnMan
reliably uses the Internet-bound network as the default service, but if
the network is slow to respond to DHCP requests for some reason, both
Ethernet services end up with link-local addresses initially. In this
case, ConnMan may choose the local-only connection as default service
and stick with that choice even when the other service receives a good
IP and gateway via DHCP later. Continuous online checks are not
currently a good fit for us and should not be required as it is known a
priori that link-local services are not useful as default services.

Thanks,
Johannes
