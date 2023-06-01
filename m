Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93BFC1D
	for <connman@lists.linux.dev>; Thu,  1 Jun 2023 14:36:18 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so1447776a12.1
        for <connman@lists.linux.dev>; Thu, 01 Jun 2023 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685630176; x=1688222176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4YlJEQQnIt82V4qNZWaZ/G5o3ahnK41VIRduF+ouCs=;
        b=pFUDhsvcqf+y7Da5KJWdgj7fce966jl9kA8hetfqZ6Zd5h3b1xsKo4ST1vUrv+RDzx
         3ehjmm/6wS+HcbxVysQF/M/xr3o93v4sP7QMwKXkmrP4SSq2Y5RKChQJv1tKzw4WTTgD
         PdyYOi44Ys1p+jOAfbJRYoPBBpVpAuHu/E0yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630176; x=1688222176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4YlJEQQnIt82V4qNZWaZ/G5o3ahnK41VIRduF+ouCs=;
        b=Gm7Mup1CZXYENW+h4hLuhlWXe3rnR18w72YqnWYUd2+Bs+KCkydZIRLQiY/rIvalm3
         w6M2+ap0trtXKaYUgYmd5J1sh9OltBah/rBvS2Vr2vv1zDCp9Pv895j0UkQZteiqdfW3
         JJIiqDMVifXNP2MU5WoLFACRgooJEMgQOFSthYTVBPxqZgRl8mBS7tGWnEcrKBz54OKF
         IBKpMazOBWujLxahfcJW3es6aLN31zzih1HotOY/3nCd301H4UXqYIHa/U5SPv2soe+/
         v8SjUczxfYE2v24opPNPeDiBlw2DnqkAHJlpsuXRDImw8bfM7ijz2hZDlOErVfHoS+h3
         EIkQ==
X-Gm-Message-State: AC+VfDzDhIyxUNwH2/YPOospA5nwrzZY3+kHADuWxZOIvIL5LFLqTJPQ
	0hUmq8APcJDWtvF9vAjepklnSa83G7ICTBm5RnsC7znbYg/gzoNY
X-Google-Smtp-Source: ACHHUZ5wF9MLJNuBe2LfMHDdjMNJ48xB0Ttgj8G/0H5UVCgFhQ4CTVPQkRYCqN4b2dC4BlcXXpkJBY0peGNcgEnNYGA=
X-Received: by 2002:a50:ee96:0:b0:510:e790:48fe with SMTP id
 f22-20020a50ee96000000b00510e79048femr94768edr.6.1685630176519; Thu, 01 Jun
 2023 07:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230601141143.3275285-1-sven.dembianny@bshg.com>
In-Reply-To: <20230601141143.3275285-1-sven.dembianny@bshg.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 1 Jun 2023 16:36:05 +0200
Message-ID: <CAOf5uwnkk-ygu0mCRnaAUe1xqy0KKpMMY5waAuWWsm-Kx3bJOA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Add support to get or remove known services via
To: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
Cc: "wagi@monom.org" <wagi@monom.org>, "connman@lists.linux.dev" <connman@lists.linux.dev>, 
	"Ryll, Jan (GDE-EDS9)" <Jan.Ryll@bshg.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven

On Thu, Jun 1, 2023 at 4:12=E2=80=AFPM Dembianny, Sven (GDE-EDSO)
<Sven.Dembianny@bshg.com> wrote:
>
> Hi Daniel,
>
> picked up a patch from Jan Ryll that was already provided to connman
> mailing list 2020-05-27 and tried to insert all your remarks.
>
> Unfortunately I can't find the mailing list entry to keep the old thread
> alive.
>
> This patch (without adaptions for your remarks) is now running in product=
ion
> for years without issues.
>
> Best regards, Sven
>
> Dembianny, Sven (GED-EDSO) (1):
>   Add connman get and remove known services methods
>
>  client/commands.c   | 51 ++++++++++++++++++++++++++++++++
>  doc/manager-api.txt |  9 ++++++
>  src/connman.h       |  2 ++
>  src/manager.c       | 56 +++++++++++++++++++++++++++++++++++
>  src/service.c       | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  tools/manager-api.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 259 insertions(+)
>
> --

I think I sent it some months ago too.

Michael

> 2.25.1
>
