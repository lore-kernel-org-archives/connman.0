Received: from smtpng3.i.mail.ru (smtpng3.i.mail.ru [94.100.177.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04FE4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dark-templar-archives.net; s=mailru;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=F/l9iAQmsLM/W2NcpvH4jcG3YOTPnxuY/A0J+mQ+zLs=;
	t=1661710108;x=1661800108; 
	b=ppHIbfl/MKCpnR+OxbPEF5YJW7/CqN2EAoYHDgKjsI1KZ8fV+qMuoHgylTz0qsych4eXqeSgnROtKkg+rr+/51Jg7Ah0k6zBCzErgDGnj8gRe6gzHUwdWFLn8HTlPeJZIdJr1bmT4B66iDQM1oehT1GpmAPUzkoaKVP1YFJsr+k=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <darktemplar@dark-templar-archives.net>)
	id 1oSMht-0000kq-Cp; Sun, 28 Aug 2022 21:08:25 +0300
Message-ID: <3677d1bf-5dc7-e5b6-eefe-13cc62480465@dark-templar-archives.net>
Date: Sun, 28 Aug 2022 20:08:24 +0200
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: connman HEAD regression
Content-Language: en-GB
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <b4938292-e2a0-e572-77c1-19dda0a16d0c@dark-templar-archives.net>
 <20220828141025.ork74ys4ewhwqgae@beryllium.lan>
 <a64e16a0-14e1-b127-7e7a-50eb62887158@dark-templar-archives.net>
 <20220828154229.pn7a6a2gphztuj5o@beryllium.lan>
 <20220828173340.4jzimv6seuyenffi@beryllium.lan>
 <4ab804a6-883c-ba5d-f495-cc8be368cc1e@dark-templar-archives.net>
 <20220828180311.ccczbttfdmteeyhi@beryllium.lan>
From: "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
In-Reply-To: <20220828180311.ccczbttfdmteeyhi@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng3.m.smailru.net; auth=pass smtp.auth=darktemplar@dark-templar-archives.net smtp.mailfrom=darktemplar@dark-templar-archives.net
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD90FA8EB11E8F64C561C60C778B914DF08ED744C1ECA7554131313CFAB8367EF908E2BE116634AD74D3E01E989D5F1B0CA161851946357D53FED484625FCDB3986DB27B0C6FE75BA93
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75DF2B1F23425CAE5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637204D59D994DFFAD78638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E4B541C82C98CCCFD5F77FDD5E826D53117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC55D5BE2F85BDEC5FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA7E827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B3241B8C6B78F28F975ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B08B38D1BE91256DA73EEEE07A23441A0E5B716ABA81ECD1370E8C97B63CC0041F9C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D346B222596F62B8FA99EBC7FDAA661B780A6D7EA4800AE2656558CE1FE51B131B59EA2AAF5912F5DB41D7E09C32AA3244CCF616EBF3D02D3FD8F1B7A67BCAEC7C48894E9C85370243E729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEnGQ5SRi3Nqi++dnaGBtJg==
X-DA7885C5: 2B65FC66355CB8991A74B191B0171B176EE7C23B82D08DDBC99B23574C6F1680262E2D401490A4A0DB037EFA58388B346E8BC1A9835FDE71
X-Mailru-Sender: 689FA8AB762F7393CC2E0F076E87284E2D788B7D489C29056AD77D2BF059F4BAFC46662C07703AF85C26933BBBA7D932FB559BB5D741EB96CB0DDC60C75065A8DE84130C709110B3AEED54BB88DBBF873453F38A29522196
X-Mras: Ok

28.08.2022 20:03, Daniel Wagner пишет:
> On Sun, Aug 28, 2022 at 07:48:01PM +0200, i.Dark_Templar wrote:
>> I don't do any manual configuration. Hamachi does it on it's own as far as
>> I'm aware. I.e. it connects to network and assigns an address to network
>> interface on it's own after that depending on network it connected to. I
>> guess it might be similar to DHCP.
> 
> Right, so without an manual configuration (static IP) ConnMan starts the
> DHCP client and if this fails it assigns the interface a link local
> address. And we also try to set the GW for such an address. In my test
> setup with OpenVPN I have fixed IPs assigned, hence I don't see this
> problem. No idea how Hamachi is working but if it's assign the IP
> address itself you might want to disable the auto configure method anyway.

It should be replicapable in OpenVPN with DHCP (i.e. non-static addresses).
