Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD63FC0
	for <connman@lists.linux.dev>; Sat, 21 Aug 2021 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1629544883;
	bh=TxwrECj8K9yz0anfXsiAorfjcu3eZ6WVWbjXaFkBKXw=;
	h=X-UI-Sender-Class:Reply-To:To:From:Subject:Date;
	b=Ic8HEUYCuZcB00Ej2s0q9tD8FfrfSO48bn/S+2aWiBJj0MZN5SAemrPpfN3EZkPhL
	 bJ9xDAxOOE8tlvdLQg8L9vZL18Ut9PbiUGY/yiDnOUMVoUzuI9h2vvSpmxMt6Hf7RR
	 1/cbwhOdLZTm3IB/pJxP7SLHFVwmiD6b8+spaLTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.15.223] ([88.151.72.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1mPgWj1R78-008MyH for
 <connman@lists.linux.dev>; Sat, 21 Aug 2021 13:21:23 +0200
Reply-To: mds@gmx.at
To: connman@lists.linux.dev
From: mds@gmx.at
Subject: Status of connman in Debian
Message-ID: <090f3e3b-0499-84e5-0e95-286ed160702e@gmx.at>
Date: Sat, 21 Aug 2021 13:21:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GWcH8fdBTd9/Y7cRtXGAvpD7Z/ufYq9P7pY4vurM0ODvxXFTkOw
 fENqpmXwx8cYBeAjXamVHh/AO8SjNl8lBVI4wpvnzL+6Yp/hmxrdEeaUXjtseWMvR2JXJnc
 SP/ytxxKOp1Q4D9MB6Sydiq5D/v1nKRD8S1B5c0CkusnALcgiOhKFxEeefuYyOS4+NTwX4E
 OPDxMJWBgwbO9ZRkvxBcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZCW87+yLvXo=:0X6++LqEmYRTTJvKgXvZSY
 1/0SeiOouFab0BPOhAuzsBM9AkWWwJ2CUa1Geqt7GjG+vQMRBXOyJSuTJCuDNt0zdhvUEo19z
 axHobHehgsJK1DDtYGnRE5AHgts6sko385i9BX6ZEGzht6cJFwvhIAkNLZU7NFbaKLw+j7xFb
 khNYT2roKwkoHFJPKGKNyaCmqxBBZt/stwkOWpQScXtemzhMZmFoKry7rYqQwNhsIJIFOVBq6
 zOkg0fBuxlJrsqjRsG5FWZ/0OTr6G8dqB2HKG9lFnGKSHsqNqhbNpDo+qkkpLRKXybDXFZo07
 CvmKH3YoMGwWd/G6HMxvb8lbnSleQVLXsLqvgzk6MsCrDNH2oxMrlXpiloTSHtv0vn11ddaY9
 8SkP8v4nCvTEFXjGlKOfwkxo0Tz6dOu+b9cM01WZVedgw59dV+1ep5hnxgIxpATcRwvwbax0S
 YhjjQ11mr19d3TflH+NZT1qRZjYm0Q4+JCPNKb+jbBKvY243TybstFWQFS40qoD9ziiiRLmPV
 MmWwu9BaNtGjA83gm6tAodXkDTTNvFbqPxm8OtlGksM4puZI6LKfNUxA6lAFF0W4KfMJfDWCk
 kGxmaNaHnTa17dapr/Z7d8RUJVJtHNIkj3JhC+goXPIpgS8kMTheTMTsgNs9zkvwEVuOqDuYr
 VYUqvp4Wwh2uxm6pPSNhfRG7bfj8HPrunDKCVglbhHpWSo7oWfdcOa5sjR6cewdifClpxpM4e
 lN3C6FhwvdgBgPNPHGzunV8GqAspEYMj3j96FT9cAABGa1tY0bcVXoaZ3+wD6AWGpKueCRJ/Y
 IRTTP7sNMcC053a2eP8mR8T7Thj/gjG4R+9YH1fVYXxczD/zKFRfRinfMlZsbGwgW3aU86yPv
 WeKJEKWdO3FR3nGdBB5O+5jY6/pyvNK1VCm4Mt3j/tss2J5uPXvqmHZXNSFA1i6TLf9wWOVaO
 F9G4K4nTT0wdo2KIFhXTG5mDcYfBVLGhEPmdHpB9S1Fv9USgh85B6bbo/dxazj2klTC3gV3Cj
 SW9+mbF8YKcw3P6in3gpvot0AjguZDOZL+HlVzmSj12B0Br+bLqNUIF2vTXSL/IethaI53l4Y
 f+QqyVQn5x6zSoftMoU4azIyVT8F0tZvnAk

Hello,

I really like connamn, but I also really like Debian and connman in Debian=
 is rather outdated.
Are there any plans to future support connman in Debian, or will it slowly=
 die in Debian?

Regards,
Robert
