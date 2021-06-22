Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A670
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 18:15:36 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id r5so37498747lfr.5
        for <connman@lists.linux.dev>; Tue, 22 Jun 2021 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MrzuMQPPFad2KKHcS60PtKsyJByQx/uBdk7ms+upbcc=;
        b=m8Y7gPhpsZcMr5MAor9OI0ktVpsoQF6DOsQ0ZFIQGjKzGEZ7MGLT7At7uqO9kLtxcE
         PnrZEQjY8d6DQrQeWAwP9G2HPd/bEPiCm6TaGP+OYmr9R5wMSTV5M3c5pSW+qodYTZPm
         0gNLGAPLX/zOrsS1dHUi91bvdMmmpUwULaw3QuJFuCSOyTU8GSWhMtd+OEBOIJuShWXr
         42NIXMCiv4Z1QGrIepRZ+5r2oVMc8Ruij26a+3epgpT+7w3cwszek1hu79SRQDGDS8TV
         MVL/tD8GaXxJaG3MwpTKoSaOkDbo2z0OznG7+pNc9IgPvLmlR4koRSxt54GDE287V6kD
         6Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MrzuMQPPFad2KKHcS60PtKsyJByQx/uBdk7ms+upbcc=;
        b=OCU80exmS6jFi9mUScdLaw0P22KiKNb0XiqUKaw8UgJa9Uw4JcGU6ppl+ySYrbBmhY
         K32jf7hlC0r/yeXdvfwkXF9i2l5KmnShyAh3bXSTNvsF0Ci7nIOzi+e143jgqWgpFKAs
         WwO9mY1smQfMZMkVRJHz4BXZW16BV9ydlqZW23NQJIyc1czj6MkVxWEgOKOltc3rBET0
         bHYs7Gw7kXppSvSHA2toDUvXEE+BM3ZmtdEu2fvs3lAD5qHVcyFZ3A2f955ss/GTFhsd
         7ZG+AxTts1K0r6/oXTXcp0vroPkjlB0g3t6t1FjjQRSIs1MqFfh8DsjEdCouSwDfCiwt
         O7sA==
X-Gm-Message-State: AOAM5316TXLaaYTs2Xi9I7mzNSJVMbU59FwB2K/WhuURuQPOvfmXi9rA
	gVAZ4sJg+RDnpCjlM/FQEZ+Qk73Sd3ER0gthDXPfvRNiWCk=
X-Google-Smtp-Source: ABdhPJxb0aAilv+KtPHpmTBJ1QDn7IUpFr84RsqcAz8ZlqG72wFDE00O8T8tUg0Mu1zM3Y/uWEyZ41PmtSs54uguT2k=
X-Received: by 2002:ac2:5970:: with SMTP id h16mr3941295lfp.145.1624385735070;
 Tue, 22 Jun 2021 11:15:35 -0700 (PDT)
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Andrei Datcu <datcuandrei@gmail.com>
Date: Tue, 22 Jun 2021 21:15:24 +0300
Message-ID: <CAAmFs7kfnSfLbUo2dvBQD9cGyNz-Bmro144JSxWsALZat3L5uQ@mail.gmail.com>
Subject: Calling Service::Remove will not raise the Service::PropertyChanged event
To: connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I'm having a wifi service with:
State == "idle"
Error == "invalid-key"

Calling Service::Remove() will correctly reset the "Error" property.
There will be no Service::PropertyChanged signal emitted however. Is
this a bug or is this technically not considered a property change
since the property is now missing all together from the property set?

Thanks,
Andrei Datcu
