Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752955;
	b=gGRTkyduBafAAYZ5yvvn8bNgZ3okbfCc5OdN5c+KARJrxfID21TWK0kmsmjJIPILzq6S
	 n5E7Ndjodg4Hf3eVqbb43cu2xQoLPBaSP1vCB63mmyyR25RDIxfiFlN0yMvq72SFMDk7U
	 N+E9a3XeDDvYT9gl5qHpfDPT2qSJPVqVQKtCGdPDhziap+RmNg85cxN+Fg0+9k8fhq7He
	 aFM9zRIcOTJJ6cRTPwSIkKfzKtZ15X9D0yPvTurFfqeAuznuIW2Cb63GONn0ADlIMGU5I
	 fFS9Ed32PjFZNiVktkZrMc9ljcBc1P0P99rwPNBD8Hi8oUQZ52v7O32GIjBPPJIze/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qUTJByfVpLMmMOC9EN4qgnskkYo5uAd0uodW/8uJ2h0=;
	b=huxDTgzuCPvHuMitzhXXDklvFxtN6C12BLX/dyL8MKjt3YThCtwvkI2uZq+9/m3hAwti
	 yz02B3JZ9Lizv1owwzyz5g207lofeZNGcpvLmCbLfhOiDjnxjBwrculygBU1Kylu2YLZy
	 rSMEPJTIeeQHez2VuZNo4pWkjpkF6OYisfph8qlPXlQTnCa7H7nnlQkP+4/XKTZY6EpdR
	 R3Dj/vc7HY38gZhG54M0dm5pToCgkoxf8WMMQdA4EyceSmBz9Px9nBGwctR1tfWwAG7Oo
	 5wUiwBTIfeEtD7Vt5hW00RrJgkh5bT15bbk3p2mIYGi52k/uzwz1gTqZJTUJOqt2IcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SNLii5yM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA38606A31B
	for <connman@lists.linux.dev>; Fri, 23 Oct 2026 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SNLii5yM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590271F01825;
	Fri, 23 Oct 2026 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792752954;
	bh=qUTJByfVpLMmMOC9EN4qgnskkYo5uAd0uodW/8uJ2h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SNLii5yMOyAIeEMthYLDIB4NNipK/TYuymKApMt7P3TVdXxJ6TIyKrCdlrJSplaZl
	 9IMXj8FcuRLs6bURcBbTtMgZ2pLWyVS2/4Ia5R8JuGdOUNJl0cIAOT9teL+c0gXPBy
	 7hHVVY6Jlx9eY4Svxc0GbwDxlfO+emR+JQCifT/0=
Date: Fri, 23 Oct 2026 12:54:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrei Miu <andimiu@pm.me>
Cc: connman@lists.linux.dev, cve@kernel.org
Subject: Re: [PATCH] gdhcp: fix stack buffer overflow in get_domains()
Message-ID: <2026102330-marxism-democrat-1d75@gregkh>
References: <179274561161.81299.4579745057858200074@pm.me>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179274561161.81299.4579745057858200074@pm.me>

On Fri, Oct 23, 2026 at 08:53:35AM +0000, Andrei Miu wrote:
> gdhcp: fix stack buffer overflow in get_domains()

<formletter>

Please see:
        https://www.kernel.org/doc/html/latest/process/cve.html
for how kernel CVEs are assigned.

</formletter>
