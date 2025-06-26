Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5E13C8FF
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976118; cv=none; b=D3rl9K3lv5E/wD1TK/fOyuo4kD2m60eQf/f8ZmUi+7lB81lDPatct1ioBTBmfXHeI0PvHSJBtFei3cbjiuZngdusYrGlaQRtOngalxLVljWc2riofI/Rc92FTiDYSP0vNatGy2V+wZqCR0g1+HAvCGxRpEACFkSyyZic6XJ/u0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976118; c=relaxed/simple;
	bh=zs/O42WZSa6it2UN6Np8CtVbc/nmvKqoGmaMkMkyT0w=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=jWVoa8H+Jdkf3q0UrW8omI0dLQuCsMBIxAa5glnjYPkolIucfdnPtRlC5g9dUFy/9l4NR9RrdroIRrGiKTdWYh1uIEq95DttjfgeiX8KJyvDvS5d6v+lxAzzEXmQhJ1O60lH7i3asndLlww/Fo8w88aVYvDnLzo25bWKvVSbrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=syq6vfLQ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="syq6vfLQ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CC5DA164A18
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 18:08:03 -0400 (EDT)
Received: from smtpclient.apple (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 940D6124E72
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 18:08:03 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Connection Manager Reports Wi-Fi Signal Strength Lower Than It Should
 Be 
Message-Id: <F6F26623-FAAD-404B-A164-C4CB5ABDEF09@nuovations.com>
Date: Thu, 26 Jun 2025 15:07:52 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3826.600.51.1.1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:content-type:content-transfer-encoding:mime-version:subject:message-id:date:to; s=pair-202401062137; bh=j4jJC5kLfu8ETTjubbx/TPQYnsPr6xUV2ySRumOH7hg=; b=syq6vfLQHfPx6y0nZzIbK1nCjZlJlwHX2a5kyijNHX5l9CSNNUKFse9UTpat8nJHcP1JpyI0/r/xwJ81tdkZtR5WE5StJJyDDst5gjhbZ7wNUNxR0aDbLw3BfaRFKTpzdSFPHSw5LggDl62dh5f/glD2MlRzICdOF1URCLGAE7HAzRUWvCrhHKNSjENvgFCUWouAZ0558BfsTIJYZIjzxAmDLk4zkJpxi6C/SDFXjpiNpVYSrkfNEs87RLW6Vi3DRTDCA+Zb6FQiX/Q8t0hJ+/P6UfAKrhi8+CJAuytRCoSFSkY/fcC1FQAPsMIcTnhUMgraGBH74MwPSs9h5qIVNQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Anyone else run into this, either in the lab or field, running connman =
against wpa_supplicant-2.10 (or some other version thereof):

    https://github.com/Nuovations/connman/issues/142

If so, were you able to establish whether it was wpa_supplicant or =
plugins/wifi.c or gsupplicant/supplicant.c?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
https://www.nuovations.com/

