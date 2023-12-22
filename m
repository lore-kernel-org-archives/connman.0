Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC32E83E
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctGzzhCz"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b7fb34265fso90829939f.3
        for <connman@lists.linux.dev>; Fri, 22 Dec 2023 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703276512; x=1703881312; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbBVzqYvA7fR+jqDXxKbjFE+HAtFqOgJj0gII/jWfEY=;
        b=ctGzzhCzYuC7q704M3A8Cdi/0eS3OyIzif6l53yYHgTaDMKDTjUxSWsfycsMfljVao
         IkKP1w8ofyw6iOMtDZ72tiEmk3ypVzAPNPAi3vWJ5CZUHdYBlePGSeeLtxp9RC77V9EM
         Nr1IBeOyV3VuHHFULLBAUh5SQ8YJRqmNkqb/0ilJfzHH/I1+jeJ+UWhRtVSq+MoO+KK7
         UKKDSjSr3NlPIwmDYltbtzyn9DJGdklWASaxVM3dNCBwvQMI/B06RjhAIJnc5Pfjl7oj
         T77Si/OiH5+KfP+S8LwL+/g97I1wdeefJyzFYQGJjs7VNvCL4mINofLb3BkiTnboBe3j
         NGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703276512; x=1703881312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbBVzqYvA7fR+jqDXxKbjFE+HAtFqOgJj0gII/jWfEY=;
        b=lW8ljOgW2PFvR7r2zkyuCB426VsXu5LONCVXkaIdPPqYwQq3T62gGYGejZiBQ6L7wW
         8K/zSxx09tOVCuJB5OuPzNBFx29sIWpGZ+Y6tzg18Uc9eQphyS9OnIYLc56uRFTFyUu0
         J02IksyzfXUoXucVhqrAQx782C1TwRGUJ3ymgkOOmtdKx1Tn6qa+FphynoYuIu12ctde
         G48/byKMtZW9VSlXUiK/qrAie7//Oo3xZuaU57mz1voCXBwW7weD4knDiXb47aKGYvzY
         I+uiXeAQZUSekntpFOd+VbtlwEN7mpL10zap0QQhLmjwahOn8zdZ1m/6TmSb7Zo4UUsM
         nc5Q==
X-Gm-Message-State: AOJu0Yzax8enpE4lOx/8+uNmubH85uBgGtrSOWG/Hc+AnDWdzlr+8x2e
	PvAYrirvuLpHfefjaR2WdO18RlTTLb0=
X-Google-Smtp-Source: AGHT+IFWtDJJ+40stLe2XLeIza+joMih4UwiJDk1JykeAYpiYKX0nuzNAbZTz22wfG82cjf9b69ZSg==
X-Received: by 2002:a05:6602:3f81:b0:7ba:a635:55cd with SMTP id fb1-20020a0566023f8100b007baa63555cdmr1463701iob.24.1703276512714;
        Fri, 22 Dec 2023 12:21:52 -0800 (PST)
Received: from [172.16.49.130] ([136.33.23.24])
        by smtp.googlemail.com with ESMTPSA id n10-20020a05663831ca00b00469967ab901sm1215571jav.108.2023.12.22.12.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 12:21:52 -0800 (PST)
Message-ID: <3f26fcea-3b09-490b-bfae-85f41a728249@gmail.com>
Date: Fri, 22 Dec 2023 14:21:51 -0600
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] main: Use static global rather than 'General' string
 literal.
Content-Language: en-US
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
References: <20231221070523.2354507-1-gerickson@nuovations.com>
 <e18f7683-5cf0-41bf-9a10-930d7a76b848@gmail.com>
 <B6F60FC9-6B09-4258-BE67-2327604660BF@nuovations.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <B6F60FC9-6B09-4258-BE67-2327604660BF@nuovations.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Grant,

>>   Since this is something that makes sense to make into the accepted (and encouraged) pattern, would it make sense to document this in doc/coding-style.txt and avoid replicating this verbiage across the project?
> 
> I think so. I’d probably phrase something to the effect of:
> 
>      If there are no preprocessor requirements (such as concatenation), string constants should be declared at the narrowest
>      possible scope as declared as 'const char *const' to effect an immutable pointer to an immutable null-terminated character
>      string such that it ends up in .text, not .data (which would otherwise be the case for a 'const char *’ declaration).
> 
>      Unless the scope is cross-module, they should also be declared with the ‘static' storage/scope qualifier such that the
>      compiler can locally optimize its use within the scope as it sees fit.
> 
>      If there are preprocessor requirements (such as concatenation), string constants should be declared as preprocessor
>      definitions.
> 

Yeah, that sounds reasonable to me.  I think this change should be added to 
connman/ell/iwd/ofono

>>> +static const char *const general_group_name = "General";
>>
>> Given doc/coding-style.txt, item M3, should this be 'static const char * const'?
> 
> Unfortunately, checkpatch.pl would be in conflict with M3 and insists they be declared as I did.
> 

Hmm, that seems counter to what the linux kernel seems to prefer by a 8x margin:

[denkenz@archdev linux]$ grep -R 'const char \*const' * | wc -l
1595
[denkenz@archdev linux]$ grep -R 'const char \* const' * | wc -l
13650

> I run checkpatch.pl as:
> 
>      checkpatch.pl --max-line-length=80 --no-signoff --no-tree --ignore SPLIT_STRING,INITIALISED_STATIC

Which version of checkpatch are you running?  I see no warning when I run latest 
linux git version against such a diff:

diff --git a/src/main.c b/src/main.c
index 3ce8340fc90b..c41668a6de35 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,6 +54,8 @@

  #include "src/backtrace.h"

+static const char * const foobar = "sdf2434";
+

> 
> since that seems to embody most of the style deviations I see in connman relative to what checkpatch.pl expects by default for the kernel. Ideally, there’d be a local wrapper in the project for checkpatch that specifies the desired options that reflect the project’s preferred style. As I’ve mentioned previously, in the future, I’d like to see a script in the project that uses clang-format to both verify and enforce project syntactic style.

Yes, agreed.  I was hoping to play with CI over the holidays.

> 
>> Also, since you're using this somewhat like a #defined constant, should this be capitalized for clarity?
> 
> Personally, I like to reserve all capitalized symbol names for the preprocessor as a convention.

Okay, no strong feeling here.  Linux coding style doesn't really say much except:
"Names of macros defining constants and labels in enums are capitalized."

Having constants capitalized is a pretty general pattern though, and in ConnMan 
as well.  For example, gdchp/common.h:

static const uint8_t MAC_BCAST_ADDR[ETH_ALEN] __attribute__((aligned(2))) = {

static const uint8_t MAC_ANY_ADDR[ETH_ALEN] __attribute__((aligned(2))) = {

iwd did something pretty similar to what you're doing in this patch and 
approached it this way:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/knownnetworks.c#n69

Regards,
-Denis
