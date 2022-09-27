Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8480C
	for <connman@lists.linux.dev>; Tue, 27 Sep 2022 13:49:35 +0000 (UTC)
Message-ID: <89685598-3419-33a4-52a3-d452374a0c68@gentoo.org>
Date: Tue, 27 Sep 2022 08:49:25 -0500
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] gresolv: add missing include to fix clang-16 build
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev
References: <20220922154517.2326482-1-bkohler@gentoo.org>
 <20220926062121.3pzyqaurugbfqfko@beryllium.lan>
Content-Language: en-US
From: "Kohler, Benjamin" <bkohler@gentoo.org>
In-Reply-To: <20220926062121.3pzyqaurugbfqfko@beryllium.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, I had a working patch but then submitted a different one based on 
gcc's warning message recommendation.  This should work better:

---
  gweb/gresolv.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 954e7cfe..7c58e055 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -36,6 +36,7 @@
  #include <arpa/inet.h>
  #include <arpa/nameser.h>
  #include <net/if.h>
+#include <ctype.h>
  
  #include "gresolv.h"
  
-- 2.37.3

On 9/26/2022 1:21 AM, Daniel Wagner wrote:
> On Thu, Sep 22, 2022 at 10:45:17AM -0500, Ben Kohler wrote:
>> Current compilers gcc-12 and clang-15 warn about an implicit function
>> declaration in gresolv.c, and this turns into a fatal error in clang-16
>> and eventually in future gcc.
>> ---
>>   gweb/gresolv.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/gweb/gresolv.c b/gweb/gresolv.c
>> index 954e7cfe..7c58e055 100644
>> --- a/gweb/gresolv.c
>> +++ b/gweb/gresolv.c
>> @@ -36,6 +36,7 @@
>>   #include <arpa/inet.h>
>>   #include <arpa/nameser.h>
>>   #include <net/if.h>
>> +#include <cdefs.h>
> I use a gcc-12 compiler locally and don't get any warning. I suppose you are
> passing additional build flags.
>
> Anyway, this gives me:
>
> gweb/gresolv.c:39:10: fatal error: cdefs.h: No such file or directory
>     39 | #include <cdefs.h>
>        |          ^~~~~~~~~
>
> Is this supposed to be
>
> #include <sys/cdefs.h> ?
>
