Received: from contabo.bokomoko.de (contabo.bokomoko.de [95.111.247.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900C10A12
	for <connman@lists.linux.dev>; Sat, 23 Sep 2023 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bokomoko.de
	; s=contabo; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lTsDWXfiyvmD/77CQCt6zayeJ63LhAuYGSEi8OgK8gs=; b=aAR+2e4A81yxJCRwy/8XrN3yPD
	ij1ZnGTTApLwc0iOtxWhKxoEExffJB5SFoDG2QXNQSWqiYv0GPw9+/S405VeaPkdFWGaLBFWEg1R7
	ewPCK1enB4WZkvxegRj4pClkVYB4SKvKm129Vf5aUhqCZVLwHtkc0sjI4xKsp4Wu/YW8i2rop4Vs7
	OQZdfgjqaRGXOaRoAYTHDbt53CvAPZQpMuzxQuQ19G8TdxfjPt9VhoDEZvOwYlXsMedp5+vfSkU8C
	67YYceqGlDe1/ZW1idPYpg0ZNrkALIZyBszkQES1kUTFA4eNaVlBNxhAfp93Om6yV/ZsXH9MhyMzw
	6w/nzgxg==;
Received: from [2a02:8070:8982:4ee0:1a31:bfff:fe52:1b1c] (helo=h370.localnet)
	by contabo.bokomoko.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ml@bokomoko.de>)
	id 1qk47k-006Yhr-WE
	for connman@lists.linux.dev; Sat, 23 Sep 2023 17:00:48 +0200
From: Rainer Dorsch <ml@bokomoko.de>
To: connman@lists.linux.dev
Subject: default route
Date: Sat, 23 Sep 2023 17:00:45 +0200
Message-ID: <2928343.uEfu3JUVZN@h370>
Organization: @home
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

is there a way to configure a default route with connman in a system with 
multiple (VLAN) network interfaces.

I have a libreelec installation, at least it seems that the default route is 
not entirely deterministic. Is it always the first interface which comes up or 
is there a configuration option somewhere?

See also https://forum.libreelec.tv/thread/27553-configure-default-network-route/#post183982 for reference.

Any hint or advice is welcome.

Thanks
Rainer


-- 
Rainer Dorsch
http://bokomoko.de/


