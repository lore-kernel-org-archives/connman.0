Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69DC2ED
	for <connman@lists.linux.dev>; Thu,  4 Jul 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720126063; cv=none; b=SguvYXxY7zeXrwlDZzjma7zJDg4Lj9Amgf9cd8GGnUfOse8Evl2gDbNDYsa2NW/yOj0pS7R5Pkz0/LHu+aPbUnxuEyTrOSlsiOm25HgQyt56S9oeRuUcilA5fJ0uszuwbRUZQ5OxYqv+8eQiS6yr6WO9eSFXqb6BgSAPm3IbvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720126063; c=relaxed/simple;
	bh=bhFZW98s3s2v06aZASJ/B65kABHbhVueZ6xJVZcxctw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IB7dDczrNgfX9IgTtobx4vmJ4/YnlvRvDRq1E2O16dKW+PM/MG7QIUccm+coMt2Q7zNejFm0sgR3k3af60gP0GSI6whC2qa0sc0WUiBN6iqYXdA1GYYiWFEf05XZYQioYL1nOzkygs/ZsEEXzF+q3KkM7tm1CmQyr7C4cr7p6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=nOmBkQfI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="nOmBkQfI"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso11845691fa.0
        for <connman@lists.linux.dev>; Thu, 04 Jul 2024 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1720126056; x=1720730856; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zHpNJmEjaXpwa9b1t4k4XaraWUeStwphyvGiGqBZFc=;
        b=nOmBkQfIFG+DACsjKdg7Jdp7nngMeLRG1noobJlN62DQuBBAYbYf0BVmXfH17I6Jqb
         d6tyz5UeSCmGz/8xUZ2WSj+qgpbiatllNKY7IeGCnkV6CR3nmpkAemcx/+voHvq3t34S
         r8oyVhid9uvjaIwuW3X6Xun9f2CNrGfBfv/vlE6rfBhCepIfoXyrmFMFLI7UYB3szB2z
         7f6C9wTcY27vjOVu6YApqEwh+drshiXtc++COWr46XejZxQjQNQVyV55MOPnfeVarUBW
         fqV9uhgrA4D8F+y1R1jwozxS3b1uxtSlnkZOaxTGtoSIKUK6vE2SK2k7Z1XYcFD8iiAb
         7P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720126056; x=1720730856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zHpNJmEjaXpwa9b1t4k4XaraWUeStwphyvGiGqBZFc=;
        b=Ke3oBkfD8NVHuwuf0Ow6Mhq+XYly8mZEM0TrEJGWXiishHzUCggMlKeFp3FEY7sMzS
         lcaH9rAcNHPxVraFzET+5mOSmsGd3JVHI/gEDdMKSkYavu8Pgi9RdT5Rksh96lh6wovk
         Zvn8Yg1qNHMaTaPqjxdU/81lpfZKWIWSKzaP60SPyeiz69qy7fFB3HM/Y3xA794JZJvg
         5l7g7KN2dh4RRXMG3O6twumLUXESwOt3rsah7DWLJFcdLWYkNnNKQ6Y/DeKBx2TZJj5C
         HK2lb2vqusYHM4ZW2GEPqhVsFRFwJ9wSvPHdy2R45cYx+BNt8N91R5jb9QCXrHmpx20X
         umAg==
X-Gm-Message-State: AOJu0YxGlqnNvvqXfjy2ON8n1wB50nDV0wPd6Fi8b0GMJIuJuZwXn5Yt
	rfXmtaehzakM8cy+Ts0RcDa3AO0LFBeZaU7CAaznrTjx9HJ3LV7L4TRmlrOXjDGmEdqg4RjuKB7
	efE/YWw==
X-Google-Smtp-Source: AGHT+IEJfSo2kqayCR0kKyQLlaljMXwXnS4czWnICUBCRfMZzjGcRCvj+b9d2X/UrrTcRHPQ0PWDrw==
X-Received: by 2002:a2e:730a:0:b0:2ec:1810:e50a with SMTP id 38308e7fff4ca-2ee8edfabecmr16351061fa.32.1720126055618;
        Thu, 04 Jul 2024 13:47:35 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d510bsm36778765e9.3.2024.07.04.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:47:35 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: connman@lists.linux.dev
Cc: Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] manager: add support for changing 'PreferredTechnologies' over DBus
Date: Thu,  4 Jul 2024 23:47:32 +0300
Message-ID: <20240704204732.56553-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change adds support for reading/modifying the 'PreferredTechnologies'
over DBus.
This can be extended to 'DefaultAutoConnectTechnologies',
'DefaultFavoriteTechnologies' & 'AlwaysConnectedTechnologies' as well.
However the interest (so far) was in changing the 'PreferredTechnologies'
order (at runtime) between cellular and wifi.
Also, 'PreferredTechnologies' was the only that was tested.

Changing 'PreferredTechnologies' seems to yield the desired result, as the
switch between cellular/wifi does not need to be super-fast.
And it changes the routing table (as desired) when cellular is preferred
over WiFi (and vice-versa).

On some boxes that have both cellular & WiFi, it's often desired to prefer
cellular (over WiFi) in case WiFi is not able to connect to the internet.
The logic (for this switching) can be determined outside of connman.
Setting 'PreferredTechnologies' helps in this case.
---
 doc/connman.conf.5.in |   2 ++
 doc/manager-api.txt   |  13 ++++++++
 include/setting.h     |   2 ++
 src/main.c            |  22 ++++++++++++++
 src/manager.c         |  67 ++++++++++++++++++++++++++++++++++++++++++
 tools/ip6tables-test  | Bin 0 -> 71344 bytes
 6 files changed, 106 insertions(+)
 create mode 100755 tools/ip6tables-test

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 3eb240f5..c8ce8eb6 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -101,6 +101,8 @@ with state 'ready' or with a non-preferred type; a service
 of a preferred technology type in state 'online' will get
 the default route when compared to either a non-preferred
 type or a preferred type further down in the list.
+This property can be read and set over DBus as well, on
+the 'net.connman.Manager' DBus interface.
 .TP
 .BI NetworkInterfaceBlacklist= interface\fR[,...]
 List of blacklisted network interfaces separated by ",".
diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 6eaa0a38..3be9cffc 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -319,3 +319,16 @@ Properties	string State [readonly]
 			and does not affect ConnMan in any way.
 
 			The default value is false.
+
+		array{string} PreferredTechnologies [readwrite] [experminental]
+
+			This property is the same one that is defined in
+			/etc/connman/main.conf. It controls the order of
+			preferred technologies (e.g. wifi, cellular) at
+			runtime.
+			Changing it here will not have an immediate effect.
+			It's only when connman gets triggered via service changes
+			that this gets taken into consideration. Or, when it's
+			triggered via manual connect/disconnect of services.
+
+			The default value is defined in /etc/connman/main.conf.
diff --git a/include/setting.h b/include/setting.h
index 920e6754..6a575dc4 100644
--- a/include/setting.h
+++ b/include/setting.h
@@ -33,6 +33,8 @@ unsigned int connman_setting_get_uint(const char *key);
 char *connman_setting_get_string(const char *key);
 char **connman_setting_get_string_list(const char *key);
 unsigned int *connman_setting_get_uint_list(const char *key);
+int connman_setting_set_uint_list(const char *key, const unsigned int *lst,
+                                  int len);
 
 unsigned int connman_timeout_input_request(void);
 unsigned int connman_timeout_browser_launch(void);
diff --git a/src/main.c b/src/main.c
index f5da979b..7858b967 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1122,6 +1122,28 @@ unsigned int *connman_setting_get_uint_list(const char *key)
 	return NULL;
 }
 
+int connman_setting_set_uint_list(const char *key, const unsigned int *lst,
+				  int len)
+{
+	unsigned int *new_list;
+
+	new_list = g_try_new0(unsigned int, len + 1);
+	if (!new_list)
+		return -1;
+
+	memcpy(new_list, lst, sizeof(unsigned int) * len);
+
+	if (g_str_equal(key, CONF_PREFERRED_TECHS)) {
+		g_free(connman_settings.preferred_techs);
+		connman_settings.preferred_techs = new_list;
+		return 0;
+	}
+
+	g_free(new_list);
+
+	return -1;
+}
+
 unsigned int connman_timeout_input_request(void)
 {
 	return connman_settings.timeout_inputreq;
diff --git a/src/manager.c b/src/manager.c
index 892d3a42..62f34c50 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -34,6 +34,27 @@
 static bool connman_state_idle;
 static dbus_bool_t sessionmode;
 
+static const char *tech_property_names[] = {
+	"PreferredTechnologies",
+	NULL,
+};
+
+static void append_tech_list(DBusMessageIter *iter, void *user_data)
+{
+	unsigned int *tech_list = user_data;
+	int i;
+
+	if (!tech_list)
+		return;
+
+	for (i = 0; tech_list[i]; i++) {
+		const char *s = __connman_service_type2string(tech_list[i]);
+		if (!s)
+			continue;
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &s);
+	}
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -41,6 +62,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter array, dict;
 	dbus_bool_t offlinemode;
 	const char *str;
+	int i;
 
 	DBG("conn %p", conn);
 
@@ -64,6 +86,13 @@ static DBusMessage *get_properties(DBusConnection *conn,
 					DBUS_TYPE_BOOLEAN,
 					&sessionmode);
 
+	for (i = 0; tech_property_names[i]; i++) {
+		const char *name = tech_property_names[i];
+		unsigned int *lst = connman_setting_get_uint_list(name);
+		connman_dbus_dict_append_array(&dict, name, DBUS_TYPE_STRING,
+						append_tech_list, lst);
+	}
+
 	connman_dbus_dict_close(&array, &dict);
 
 	return reply;
@@ -110,6 +139,44 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&value, &sessionmode);
 
+	} else if (g_str_equal(name, "PreferredTechnologies")) {
+		unsigned int techs[MAX_CONNMAN_SERVICE_TYPES] = {};
+		DBusMessageIter entry;
+		int cnt;
+
+		if (type != DBUS_TYPE_ARRAY)
+			return __connman_error_invalid_arguments(msg);
+
+		dbus_message_iter_recurse(&value, &entry);
+
+		cnt = 0;
+		while (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING) {
+			enum connman_service_type type;
+			const char *val;
+			dbus_message_iter_get_basic(&entry, &val);
+			dbus_message_iter_next(&entry);
+			int i;
+
+			if (!val[0])
+				continue;
+
+			type = __connman_service_string2type(val);
+			if (type == CONNMAN_SERVICE_TYPE_UNKNOWN)
+				return __connman_error_invalid_arguments(msg);
+
+			if (cnt >= MAX_CONNMAN_SERVICE_TYPES)
+				return __connman_error_invalid_arguments(msg);
+
+			/* check for duplicates */
+			for (i = 0; i < cnt; i++) {
+				if (type == techs[i])
+					return __connman_error_invalid_arguments(msg);
+			}
+
+			techs[cnt++] = type;
+		}
+
+		connman_setting_set_uint_list(name, techs, cnt);
 	} else
 		return __connman_error_invalid_property(msg);
 
diff --git a/tools/ip6tables-test b/tools/ip6tables-test
new file mode 100755
index 0000000000000000000000000000000000000000..1fd564e36a6d1988dde34b0ae15b1c21167f30db
GIT binary patch
literal 71344
zcmeFa3v?7k_CMZv42%TQgMwrgb<{zFf+j#T0irW713fT-2mvFYNyvjlLoy~a5)?Et
z6PLCbH@dE}eqBY^2fIENA1jCmK_mf1MSP*CMAt_*0mWBDe9Z52tGZ`8A+x*x-~as1
z`JMA)bW&ZnZr!?d>(;GXx2lJmJiaN(NlAk7Nf9m)DA$(DAx^zuU3whHDdY-+1gBsZ
z&Jg;cJQZI9uXnmP8HM;5sg-Ai6r@xygC6=whjXxCq(<wMQoTf<)gyR`kqS1Rr+OB8
z%;Ndp>7Y6eH&Syw*4`SuUaz$HbPhLCb3Kxc|21CTJKd4a;e~dd8udtARBx?buXifw
z@-$LIp2Q=4b9H(4PMs*DkCXisgx>X<^m@Hhw~lY5)CPTKe;%m#-)XN<uUGLTr_($A
zMIUG*HQKuj^++!N?MEMWVV2%rZ}}VfR$ZP(YUtU8wKWSb8h2rB#pv3ax?t1jrre80
zUo`H5#`+7!Fcyd}QYF%<sWavX$<0C=!HoJzLK4fL02qCe^}JC|xI^$Iu~U8f(s@le
z-RI3uJ>d_&`R-S?%y+)HiEyYNREKcrLooUpAF6*jzJx>aNxo$;9@A|EE5>&|zWM#O
z6c@d8)5Td22O76N^W%wQUjFgKXCD0VL=+|bYzN`K5XL}WeZhx<slMPBCx8zJmwn+^
zgQLFS{S)x>SOR!yf_7aA+PxzIKFQVIhm=l9K<B0e{9lv+|7Zevu1`S6m7u?0C!q6q
zf_AS>(BG~E`0pp+r!oOQ^$GYP<?U;Hhb5qMa{_!@0{q((z&}m^zbiq%&Q8$o6$#*E
z&id-tlmzhe63~exfZvsX|D*(Ro|9l4YZK5Jo}k?U3E<HL?Ou@pen$d+?o9xnlAzr$
z640NOK+dNDZpXLxXI29GOA^3;P9V2y6Tp`y=-1i={I?{4PfI}ORdlE?eY-gUKW8SO
zb0`6wlN0cBX99R;f_5tsv^zZk{(}kl*_(jQ=LzWiJ^{WZ0sQ9#?OvAv{$hf5a}vNu
zfsP&D-k<Ra@V`v}e<=a~Zvg+S-o%mLoM6046VSgR0sIZn87!PClzzw?G5p63;D_MO
zUU09D-`WeFh51GJt93ZC?6Y6TukHnZ2>cL!b1ynViMObrq@uE+a#2lVpt7N;U~+AJ
zU1d?(!rDrqq-4?J`nr<FKv_eeq=cjPiMR+j4dwN9<z)e3QAu@KV|7V@D3sJyE-9%B
z*46@A3;HExet%_M1#-Zz2>S8hFAJdAx{}3Zf%58-#+t=`G^}ISmNgPRR<o+1lHiR2
zf4P4t9!!liR4%T+jtT<}OF^f$w!S>8Cq`|3{WYvLMk<EiCvHQfzqYKL$mvb8IyH5T
zl@P+h%BuPX&PPL|zqW?h<5ci~K2eqH_#-PWX{_uek%~&7)l(0UURP3ES+^)q&2y|z
z{IPtopSr-MRN`-_sS8x;NR`(H%W8$D03_E?wzv^bB<aSIdVin>g9Z6O0x@V+O<e_-
zZ46`}R`o#S(8iLcs)ofe)bjep7@ry%$%e}7Y8uf%tPIUJR)V$qKz(_Ayg}&7qRPNA
zY%T7|md?ZCo;*Ovi|Z?5Eim3Wy%=n9CCKZ2jW<$LR|DNLb(?8ZWurjtK;IUYHCEP@
zEv^(W9F6tm*8nW|gW!_J=jz3Np}e-fv9h*)kx)@vR#DLa&4<#LUsF<EeN9PKSxqef
zd=LmCR5oGYE1N3IYyCoF&7!h$k~~l_a~6Rb!=Yv{_E48=1Pmj_S!k#%s{mFFipGqk
zu?;|OB_-E2)|qHyR*Yf5rH$Z+kpj06D$%c5SWb*V5f_)$)S-8kb;NW{U1gx8E>Q0W
zPI*&V2?SSGTXQ|Si&<ICdK0GxSY<;)eS>gK4Ft9jy$m!keUFO<16Wyiov^raG4zlU
z(qbke5-4h;ogPd>2$hTdfu)2;wP=P`2FjOEcY$7457EFjkd&4*)C4Ly$Nm8FzynPt
zI>BG#XFS(Yv*_$1d`FMDAd9w(Sp?8^o$}dZ2vAOs7YS2+-bs^7#$1q{9eW&`8+*(i
z7ki99jWs=95Pu$XK@RLFcA5C5=xM5+VlT@6<E8vBLHLseDPhJ-sU#UYTaH7|RA%HT
z?Z;sKbtpknV$bwsWjRhEUe9QQ(<eB8g6YRoe}Oi<#=iab+wa15)+)5?unjEVUwBi`
z-^ud*gb(%nkeZr7v>X3Y&p*q`Q-yEzeBgIA*ovnJzv%hkDU?qZtSl%LkJA|I+PXZx
zE;Z?K7z19a!<&1-yC35CD|^9{9_H}YUhw`pe049lsKeLvf}gCzSMK5T41SFKhF);{
zTO6+~0enYqxSQi2=?&NE2zqL?YtXm$hU;`<<(#arP?wLh7k-TnFYN`tR);tDf;Z{#
zHND_r9p2UpuITX2Uhq~OF1+1Sp7-c*doTC{I^5X{{-h2s?FHYc!<&1-J9PM(UhrKy
zysZ~}j}Gtb1@F}1!aF_r|5AtBd%+Ls@X}uJjy1e~buaj9I=s0T{8JsiIstrL0{D&u
z@XiGABMIQPcR9a?9vb{)CV)E=z>5>W{R!YJ6TsIbfNw|u-<<%iCV&g?_1)i$1n{f`
za47-2Gy%LR0lYN<d~E`FTLSpr1n|QN;MTo;%fX%io|^z(m;hd#0N$JczB&PXT>|)y
z1n|xT@FNM}HVVYybBz8cfIAbwixa^83E(Rez}F;zZ%6>&odB*TfD0e=-QSD^@T>%I
zDFM7R0lX;zyfp!QZ31{(0{Gqp@WTn<)_r};!JYt~n*d&z0A8H{-kbowIstrL0{D&u
z@XiGABMIQPUU7h!{Z9a2`v#XAosAfCh9K)q@PQnK{oP=K4>7^pOz?3g_zn}?Yl81K
z!DpJ_drk1!CirgM??O05aGBsX-EZj)H{vZ8;1-+kjra_~FE_!BxC+7No8U%Vh2RTJ
za3gL*@GDGkBW^?Rc_z59n`inXAzqD-)dVL$-}u-}aD;ebp9~W`H3k&~y9rKh8=p)Q
zoW|JrWSQW^lkv$l!Hu&yDs!6P0}N!Ok_nz>f)|?LgG}&Z6I?&yWu>JixM;$!Ho<Ks
zxZeaHY=SqL;3t~k%_jIsCiqGde5eWDYJ#6^g0D8ghne7OOz;d7e60!oI}?1J34V$R
zzQF`P)dX)d!H1jRJ4|qj<r|;fCb)hC&x-b%;Aa@fNIOk%y9utE;AfiPhfVOaOz<Nn
z_}M17@FvfYt~pF_s|h~B1h<*s=a}FbCiuA~xZMQLG{G}X@R25XmI;2I37%_$pKpRY
zO>l};8z0F8A8i1U7MkD}nBc`G_=P5TsR^ECf>)d1*(SK(1RrC9H<{pLP4H$DJjVoI
zX@Xy5g14IB7n|U#P4HY3e2od7XM(Ra!N;56>rC(oCin&ue4+{7W`gIN;5$t4OHA<H
zCitZ$_+As-X@Yl};FC;n)dZhxf*&@)-6r@E6Wn8h3;Oy+`ai`4x0>KnO>mnDE}7sN
zCipZH+-`zTH^DPaaGwdDWr7!&;JGIF3=`aGf)|?Lk_mp930`P|&oaS_P4FTUywn7r
zV}e(k;B!sz<B!KBa9je%C2(8<$0cxF0>>qATmr`>@P9%A--)Lml|l!tl45!4euO((
z+5*YZ-BRdf>o(S0H0Kq7qa$|VuXu(NPn55wGOaU;&xn^OPaz*|H_LCNJcW9+HkN;y
z@)Y9H*0KEGDNmstZ4JvmNO=nBXss-N59KM8qcyYq9h9eSh304ZTPaVWJgt=FS5Tfp
zIa(phUr%`o;b=~lZ=gJdZnP|xznbzC^3&`rzmW12!qIFjKacVhy3qudpGA2J*=UD<
z17O57%G)U4$?}sZKbZ2nS$;g_Po#Vs%a5Tvg=DmKEPo#5DYU4qVfnKtPoWvDmE}*N
zJcVSmW|lvZ@)U~E{476!@)Uy6N?AUc@)UZ}3R(W>eaKVDMRT(Jx0I()i<ZUm2PjV=
z7R}D`pHiMeE1HevKcM{Slowcj59QCG{NZ1z|F2NqPWeuje~I!GI?;Bs{6@-C$V6*n
z`KKvQp%QH!%m1D76e7{qu>6CRr_hMj%JTP6o<bs8Gt1vWc?yMSewM$L@)QEmN?Cpd
z<tg-`6|(&Gl&6q~=4AN>%2TLA%VPPfDNi8|&Cc=*DNmsd&BpTcC{G~`O<?(1l&4UJ
zcK8=I{*<Q>hStgQlPI4}`Q0o(p7LWT-^TJ|C{LjZZ5_*>M|lb%Yin5kEXq^JLThFD
zQz%cN3ay#tPozABC^SFI51>4SCbUwPPo_MDB(y@7Kl&HsDHNeOS^itfQwT!KV)+A<
zr_h6DXZcSlpHF!k%YQ)mODHd}{2t0*O8LV-v+<|Alk%M`{}Sb0l;6$r8!1mA2Ca?d
zpQb#87PNIN|98q$NI_e}@()s;LJ3+c%ilwJ3L$9CEPn^(DRiLuS^ieaQ^-IoW%(79
z_fo!)<*%nag$^_)%QsM-LIzqE%U?}-3KeK}mS0GD3K3{F<i+PwN09Ln)2hTXz@_VQ
z*IZvD=f`?H&hbS?Pi(?Nk!uqfpgEHK!)*Cyn9qz3%hX2!!AI&yCFMryb`X-l>3Fi+
zvUmFAZzcIFdB1uQBpW&s4g4;ox<W_BE*b1Ccee<>BsJP8p3zLTB*o{jN)b!$Vlv7*
zCDF50l0i`_w><TTAVdnId2flg)qvHJ+obY6p6qTZX`3&y>>a@usr^Xkx=^R%le?uz
z{^@msklp4Dby(G((X>zgQIfZ*yN^brUissKysrbpy~?nHmhRwgNq&!^RbcLW<#v<>
zKU2S~LZ?H&SjFG(gQ1rqL;FDr)5=pHl#+HwJF#?J1eO?k+7PG+03!f!Z6d2K$*B(Q
zH&6pqWKdcQ7*yrZpB^UMR0Fz)L;uB~w5~ARO&t0fgZ49^k8tRE2Bl$RxUC%e0HB`i
z&lqSqK(0+}6=`6l%OR&h<47z!v-kKSmh<r_MRLX>QTJlCkd%PKx`mbz^>0uvd7CcJ
zmVM&NMI?lHxx9eNTiV2xnJ9p4)g?bgqw1_GV1-`J$Znf|rE7ufO4n7cl5LVQ#KEfi
z<Zn3jYi3jJu1Ak8*@`$3N+QRWte;6GY(0z>a%zhiui9KT3VKt#q#P=bIunmASqkMx
z$yw%-7<<bQ3`3y>h0rnW8<<4sQ#!O#-Fk#QkMZOApZxhMdj1=KzLlQ;!k-_Z=iBkT
z<p2n&=RybNjvx1{m*4?X|DYD4l3&_Fqn+KRR%0Gwk|Yt<eqd#AtiN%ruDw+kh-ZX>
zin-NF{!8{Dul(j!lKiO@`s{FF5u0jY(uHc#q1)~fgzw`u0I#_htwk&gDakt$7z)LF
z1W4rioDiFT#&`oikKyNxp=9K5l6+X&`qib<)*~rWQoHo#Z-F5o(4rHtMmza@H|i6A
z&H34X1+&4ibEHuILSUk^p9cm>N`AjT!?zk*2#{J1X4@@RASPY8Eza+@s`xYcUqnw^
z1YBJo$v(N}xQgb?mTo?{;cOy3(NQ5OsUv8Kl;p5uEr8i=QcHK>9QiFTv~%f?B=lvD
z(#_>Skw5av+tn7peC3C|d0#b-mK0v8LOP#Q5nFD;+>&m7ndqC8nfM_>g=#+xZA)9z
zcFGm2M?j3G1FqKzssbYe!!?QkA^>9eV*FL8RvYl}us~hUILiNhB^&-LFulEz8Br<k
zH8He;=32z<$nuu|Ajv+5jVv8AgpnypzQ`s=a|(6S?Z}YifWzL^pvz@5O<kY-wfb{6
zdW*)x=doE^<giQ1I7d4#-24LyVQDkmFq2Br!P1sC4ES{LQ4nztLj6w)M9+4p<aP^M
zQQQt&<eDT`s69!NyQIABV(4EaWM$dGQZ}j8IyB}}d<RRj+kA5LdGhi$l2UJ`Cs>)S
z6_AMbJr@rx80dbHRKD9M|E4|-UPwr-4D}($8gvZB#T%n=zI^f*>L(x$Ava2^_0E0S
z9!@1JK|PswGT^0tMXHmkZr;S|UwWz7@-6IL^CriGgebOr#;hNDO5M&vx1k!5{AtA3
zCosX<Fs52g$UHv-Ky>{TfEm(sLLxg2u10Mpk62CTBUq&V0OpBV^&lR!jj$5>H~?6v
zzQ;?8)Yqx>UX)^zgh4=8g!M-Gll-AreV9KiQ17K0SEGjdEyM<DMXGEdHS>qU>~7Vf
z<8LNut3LwOlfAP*KEfCuQI0{13>wOkp@UhHGYE<LB=~1mN4*nIq|Y>s>>z?EG+duT
z_c}62b+FLOU#h#%P?cDp>d4-+g_e_!u)|7i;v)_YJ60k^F%*SztBssplJ9jiBPT_8
zN~LR!(kw~-m;f6LfRl1Nj9ek*_8PfT%Be=qPq`z=sk6U}Mzi;T(iV)6pt@sOD`j(H
zS=tGy=ftv@Yl1o~mK{V{E3#w+sM|3k5Ig|}fFv`2o4N=H`uIwDKZ>C!YPsfOX1eBh
z<sV$Iz@Nc4`gOK=hS2S?C5vPop~9WM6Ap_lf5$T|%ZkPRBm@GhJ3~@(rIu)5O7^~1
zNeKeh9k8jBz9n@JP66VNPXJK~TB!imc4CG)f)|cN;RjS0+J+tM#0*dgz9@yZXZZ3C
zHG~aQ1zRkH3T#Pwfw+R~XV)jpzw;@TRv)#=D~T(nQ`z>IeoD%6D^0#<(PhlemPsg<
zLd$6?jmM);4hmW}9t?XA^`W66W0Wb$MGlOu&ynkcfpYrrB!$}o7mFj^jzV#y&rvFl
zEOPk8k-AQde8@qQUmW?kV+~86b*y9QCPy1mlU0YgBh3ywIsupDqmujyGm1?8$z0mE
z(7+PR27i=P0PbjN7E<+Uh>lEIMto?k7+T_bn;Q8B>K$Kks#^cA=?`gjpZ&Q9EGO*G
zi--Sj?N3Ug{=5Q~6ZYrO*S-70VmCuS$E=cnW7e+iDh%>aQd1?r9pH^vZZUguUc$5b
zTFl`66>5Na@qf+uk}>Ubd^e)Y3FYz8SH0x{JCa6rqMud<H?p<2{{(+Yeh)5_{JLvS
zf&7}Qs6c+1*(yo?ZZo}oz=C0N{+)lrV<dk$95hu$Ba&=cN}!f~fee`0NKWIG#P5D}
z0<kAsiWq**=c`$@es`eSC-8h+p=i?Y_J#gs4{bZagZ)*Z1eatrs>mO2%wRq4P)~pY
z7sx7{4I00pr-Lw?$7~9#kC8frUbgnwM#N_*c>IZ0M>n<{T@O~Z&dzSbLKPYM#eyDG
zDnUhEa}YLcUl0~F|KYVT<l6mUM7QJFQ8fu9P;@IR3bP_7_PWL{_vVA0u>O*Kr^Ct8
zRSpTM4<2SAOIJCHk;1+?#gSo0DW1iVs~moo-sxy&>Aj9tmcqMX>En)dEPd9|#?noW
z-AGM_F6^K^Rd!pI_;nkZO*{R`qCaSbSy4AxQ8!u9u%j6grIcIIuw#v$=T<b#tSFW5
z*5RFcdRR{d#zfd*LmK+oy5uYfazX`W)?TSRbp_k(c3V#PBV2T`B?r@r<`0Z8`MJJG
zg~Ps?2zX_c>9J4#(idTy_^=}j@aL(Jd4m)gu%St$1GA74dWJd%T1IZ;7Z}pP7(Mke
z=x?{>R;-;#fl<x*gUMfn8*|QlY$Yawvp+AQe9my>*~I@I59%mvdYbb;e+0OJOS&!3
z-j3SAVe-cy`VD~UDAMJ~pbzH>Le~o*vVaqL4|zspBN6!$EqA?&Dpe%}Ry)Xt->>>n
zx7)ImNQ&VUvM`aM!+HI?jrvZi|0wEfpTg7Zwru0r?~vOW8TwTfW4Xq_z8??jQo??g
zVK3*{k8<objy=J^mI-@0Vc){AFXq@wIrbeKdys)0Anel!yO?2r)5`ds&ao>v_WmpM
zelH;GuhCEKJcd1i(>{%3U&OJWGO*X<LETE&zhLrpTb6U$Un7HFS~+&ez&@F1|B<j?
z=Llb7gMpD-Xdv83<QfR!2_W=be-+E~cLE!3(lGK*JDN9OXz3#<PB=tu!9(zY+I5tn
zt<tdw2Z1n$5R@jnG@&UYa6Z{Mb&m>W70U!xQkc=fiOPj`7W_B-a}M4X^M_`G?@aUu
z?y$NBn|bi%251xm?N=illn2lSI_P>1x(J}X=qK6CMI3Y<Y?|RWZGfPo^S8BbK!P;Z
z-Uiyl&)>EI<4EAvIXvKI?Y3wU8qb#h0pE&cyDSKKdjr`Bss$&8eohX!UL-=Hp9cib
zV7nzK^Hac44|YM7x3?S$UM!#13PAQD>aMKLzY?6dfuMj95D0FeH>WX5`5UR)KlN&X
zootpoUkun&SW6N2Loqd_&LUMYXvO%Ke}Y2%gKs$+F4vW<o~p0Fo>?Pzvd4J4iZ&88
zGP)4hqmbcjbuW#S+(99`7qw_KQkWEJN|xuOO65^$>z6623ZNu=NE-r$Td-4w4SHGK
z^99%w@B(IayE7G#REOe84IN3k@pN*fBNB`a*)L_tHu$OSRw>k$B<1Z0enkWH9P07~
z2Zj69C1_v+_EgcXgRUa4{0o8&%1u_a6ksp5WH$8{;L}rvx{N)+P!lu5C1t}pu%lMR
zpdHNwppREs02dkS(a^3-OzW94AN|-DI7d>>my{P-?M&2`@)lczpVI1i3gtLf@B>Z+
zELP~eWYHGj#I6iOf7PzfNjUo@<qT@;u(}WV`LNB1$!Txk*(80MU(~<1naiXPfi{<h
zU^`JkkNlDXkN&_GrW+WKU%#Y4Zc-qFsT;{^ItGi>$+Z9q<%E21K!2ivbF;fQ4nVKf
zE>^?7<n_Q1c`F<1w+_g=f7~tZ=(1uwnEtykSZ8{mn_W*Zx?NAk^a-L59mLLJ8A8F>
zW7ueqfo;#8fCs87J|GC~7Ih6KhWamv2@GG_ZK+m}51cM<g(eojphK_JB3%=oAj@+E
zd)ju(Q>Z3n?}G}1{9a=|AS!}JXlOT+$EprQ_u4HjgbRHnzs#x#p(DuwOX$deV4I{&
z&Xgk6b{eS5&{Ihc(GZg89;%WvC8g0OL3!1OAy4tS$#zM3fy!4-Jp(nJghr>2ajFui
ziY?VpJxTfFN}{CXoNx>EL4lisT>f`0M1D`;M)d(2BiV9*0kBmYLkgR3>{Daa2lS}^
zy<Yutbs?|bWmNx;<}+tcedJ$w&YN!)TlNtY!#oZU?R8{g^k@6k3n6oDDVjCwGvLDj
z@A@mVFEo7U^;BpPCJwFqn0XjXj9b?I7$=OP7inOsdKUPBJg)1ul)%Io12_@hAqMbV
zM2(pxItZJhUW~c90X7vQ(}mL@_^>bA$+D6?+xHof3C^T=4+e56CT2A79@-tQ7NQRj
z_3(DfKh3q8K>?Co0M4Mi>OAVZlEPSJN34u)x8*4e2kdVZNqI#~KUpMF{thgz1B=vI
zcypulNJ=e5>E2<pOKtoVWGOCp7Th8>t3F_XYBF7qf@hjlV_pDp?6JR8e*mQCCO~ZY
zPVXrxD`p#5K!3>!(S#GjPovnFbl0JJelq||o*++Ben}je>Y&CUY9TTyD!&<NI1=hS
z68fb7$aZEI^Ii!!LI<qvsi`pPZAp3G(mI>!py^=kIwwB9&s#x3T0Qd3jZr+j_36qX
zsWCiBo`Xq>dE6Gq7oRJ#2=*Z<%-n{K*n(eW@6%2}FLga4_BJ+y6mh7Pp#TR*d%B)w
zlF)vF!l~LPP%y*3VgE*MH<<yOaw2qUI7J?uD+7)TA^22X@L}ewXSaopCX3;%zz-cA
z5O6?&lsj1oLIFb<s@U=rOdG-hL=+l?ks%`!xzn)*JUvgx)HosfPI^pSKP9({BuGCP
zRV9ZVcBJiL$Jt1dXr!QPPAGXyzs2xIs*DnAbCV6>6Ks)?g%1;IY64L#8De+_Y7>eb
z$~s(WrYWAc<ECpYB-^|l%NAmGoR2VkyCoHWlhi0AK|z_D^lCO{io|dS@??%MTwnwm
zG29o?cLUEAIWDBBV3!oXRec=<+AZtJhltH%;#gq}=`&MonSx<3`h@v|UT-BcK#Ysw
zNob6-N=)bN5dZKH3U!vnRd*9+BtL*Q+ARh6o1{vN?LeU0@)sBzV`i@)=O~g>fU_Mo
zvrmMLR<Fdqt=)1mF~}ykHVx$1x)MQb>G^cP`FJq)#P!Zx8jEItwI#qr{3g^SLD=L`
zv-=KQBFth}kciIa6(N>PLq;SoNs+jO9>+9oxBTfIqPPpr>4uSbs*<PVvIi}hv4eRB
ze=Ll?h%H%=mFC4CJ|E5Gv2*J|yAZUoXJzwN=kpojvjXkJ^qWQylg4qOk4^#D&~YLd
zKCu(n6H!Hd=VPh@KFGSAt@NiA$wB=a23w2uu`OT|*SD?$@7TqWUT3#)`-oy26@MeH
zFD$0A-u{4ox&o4&KN8jS>_hV<S=Ep9umaZmz4G@sA|7)+?E*)?FoT#l6uhwOT{ccw
zE7<ad#ge$7)z2q?rB>``);(8J7Q<W}3j9q{t`wy5$yP-8U-c>z+bQUHDMJdrU~bUR
z)5r~WLK)6cHt1(UIHYD4IPN2ib97to3bCQF(bQHZI-q5h;8N{`&}jNJ(e%M)lmZe$
zyW260{+vup(dN~pwRhuhl6nWj4$gIp&(%6kb`Pj^3=_kjqbhR@fczy6+0}c&4;+Jb
z%R*FwAoc|YlM3ig!etnefY0P)(7`AM!U_F(e?@#Q+y<u$T)J>($>u`8%Ru_FL!^oW
zh;G-WxPDBA;+8@dU$Xuf4u`y*#Qmo#w`?bod%}mrmO|<$4u8~hKZ3UWXYWG{&qWQe
zEVfWoIPQV`emSvccp%qOu4RuHUJY#ZRM3VOQo(=_?qF7vc{ysyKIki*g~!(e95c{(
z97IpattdckvM-B)1n>bJe31^G%fYQW_zWF<DS<I7u-bgAPWu%ZqVYZrK&Z*eY*_{k
zsUZFdqpO__^tk*6qWz(#;j9_$?VhF!{AU`=PHcL#S3!=g0}~x=N2G2<qZncBcc23M
z63O}63*5KSwdQ4LBDfsMFxW-f(bLdpFe9%BiZfOA*tNf~#xV|tJ9qsuYT6KH1?Aw*
zEmHS@A_O^~0U*d7U_^VG)uwrVjJ^umbm}?uTfH0+HEJuHVK+k#Xb*naA3g+$5&+He
z2Yd<OU4LZu1EE1WOAQ^&Rnpx`f8Eg@=Wyq34NT~^JaiK&>2OHwB$#J({yub`sp$XE
zjCvAI7_-yxz;fB~!&SOp68Z@%?@e%_Lq81&ez*m`lb~jySvLOiWHM1=_<EFgSbl{e
zrB8=toBl)|MfN_nxY47e46@untq-ljcuAsr&_&4N*qhcgr72Z??|t&0-~)X{4IV+X
z<{eD^Na4MqqvDdGn5ws8K1t<6?v|2{Mn7f!7N7f$SfO3!2kN8P*@liB5W{55m6Ys#
zT`h5a!9J3f4>5chBR)V3?*?&rF;@W@`j9W*Nk(HK{wAqce!%tl;{LQm%(yW=#owC6
z<ad>%%kS(0NTd$CxOU6As4B3CP*tl>8S#FI!i-<4TlbPeY$pkTgI~p)6voCWIvXwI
zc>6HDu|;?URlLfS3{3q(axF5|aS(}DnVS*uBuO0|z>G?(rN}ftHW*eh)GrmkxSJ}r
z`1*k<*o}ehll;-OIJlZg0MJzWh4+c!Wl$XnM6&la-%3N1tX<7C%uPs`$I8&rXqeB$
zNMn{dla5;Cb~d)3Gv&M?QyuUg0VijYTv@P*uUksaH!y&#u6prNY6k>m?2wp+Ml;%9
zL4oA46L=(#rx>BQJj6fHlFwvPhY?|Rs}c}hCU>BkE)yroBtx}Bpnb@sl*{B($dzQ`
zuz)QtlTs#=5(30zQqB4mmr0T~7m&Dr%14Xzh3pYyYB#Gg3i8VT^=6_K#6Zo>l0xk^
zbrU;hQ#>$LFWKJ`!zVCYlI`r6*lpT(hzc40h2?qBXwE%TY<UOJW-Ml6%d2>5C(5ag
z7hseHg<r;l9ovFwE2z(rDschR>Myq3f(k6cp-sXQvv-WYE93mxRXaZe{8O8Ko7hqY
z@qkUOx(EJfj*n%2?m+Y>RehXd{VxHL7KrzNOM29eQIV86w&rQGZJLIR*&eZWKW}Do
zAv#vI+Dzk*I*k=bbsAPJh>Rf**uT4B|1=7#()=0cfS-VY2Q9?^Fz|Nu+;`c)+j>m~
zCm;B0Au$?w`bk!O;GJyXX8-{9TV_MMNVJe@2n{p+?b#07*xJ-B@ATOYM*4`gaTK+2
zKat|fmBrfV27uc55KQQ8j3pK5m_)V+KKDzxF#SnKc;?e1(#SWZq#Y9WZbY=<WeI^T
zuiUnoZOb~68QNAY#mhE#2ynGGK7i|V&=sODPaFdSKL&n&yUmx^-tbjd7!CRLhMN9O
zL*j}rAm0Djm>AkZXw)Fvqa4$qc0bCQpV%?UskbZr+jegt-T6<Q6hlRXM(w@{eLuFN
z+BlT!?Uw58R{z^}2avw~=XU>P^cSa%eYLyI=r1$WQ*6!B>?Eb1Hj}EwLCFAR8b(l=
zoYB0J%&nD~%pWoKn{7nBW0I9v$H<8*euoFG1e$Ve(NJ_%Tia*RHB>Yl4INvHMnfA4
zwsg&d(m?`%T?I<|V8vixpr~UK6J!kbKFI3I6oWnW6Xqmx)a=8i=SNWAfd6KC{u7fy
z{(JC&)H`;Qh=x1bE&UPsrW>GD^5opA(9vIUEfWj2auRm;*z_EQyZS2fd_|g_(R^zN
z=t))bie{wRI#x8>RwYj=)c%T0j}4E&e4h;UpKRr#tuXl|RFS-B_&do?8rE&<Lwjgp
z589RK_K2%r=%=INiZYr~k)d_)h+@ZO<PR)eMgG7n{7q5|ST!+R3EXbWeM{s1z;yCy
zBRMlbpZQZKdC=#p*#3MNs=||fIRin-Zp$ZBNo;ur6v$3T@_&cocFVUE<x~&7$^8vZ
ze=ea0*R)&SK_S~TpwZ`9qaEOMFPvO7x$jcFNv8`<c6GuR{9A1O>b6|L@b3oxT8{si
zfj^P(UjV*#9TbDx-)_sbjK6R>K&TVob(R=)wxfUQ@2Sots?&=8G*N%TV>!N?<4-m4
zzasq03I9YL|IZvhh2sz5_`?kRw+R1S!l&~$_~*3w(vLE#lPN5F6e4Q3Y`YZ_p$IOG
z?|OPxoW*2`hjm-tTS8)6&aSkv1Iz3vg0d|9c^!z-J|*XMv`~YLvH3fYk9O~8q^k|m
zoMLc&m+3wuL{dghYb2-Q5?$<_;9U*u2f+(LP~YE@4h+4RV~z(V#(6k(%?CV$ii?@I
ziSh5YxQJUZ{2{FpvW8koyjH3~|4pJlgy?SoP7ifQydU=`z4C8c><|I%ow1k46p-J-
z4#2AZfu<Y@=qf0iOG)?29WrJFR`5drAWDwYBc+gqi<CPkjxDY~QA&CTRf1o-Ud#lb
zpyji`Kril6QK?&8pUL(CGf^A+0I}saK&M4Ejb4jXJrk{YWfrXv!=C{H-^^BZ^Y*p4
z^jV)Q4yI%h?v*)h^kBz>ogT9AkVOx;HRg2E11^j?3+VxO#hj(|fNNq-zogvJ460S~
zTAEMpq(hS2ssnBV0DZv$iA$r=i~A!mC&3Ia#Zcr|q{yaB#_5k3eGCFR&Q5bA<y3J!
z0xQ^Z@1x6HldUcVahG*mBIz(o!3`h*rvN0DW%||idi}1=t+*zsO1tQ~9y>hq$w!P^
zTevNa@g)I%K}cug@Y$>I8&N*_0M5fyKge|L<nwM?WZ7uH`Y|97A&cld4Dne*+x_VO
ze=9s?R$-M~T@2C4h4eH}`;uuS{QK-f%vW!f8*l}`+da~~-i_roV3(96soZHr)MlU*
zN&UThq_Y@bx1@NXC_96l$HbH9KE<!I)rSzw;M0#JR!mwInC**<ST+%cYII!w>iL9-
zc}eaYB1d1S=e<TIE`V({KPfv+QYKK;>uY5yvGF=PyotrbaevKE64g>5WU`kO8vi|p
zSU<>9ZnCvRmtITfXnx}1Vk5qU<2Qt*PC<Q}`sgb(-pe!8`{)5S<Sqta?FZlCbzu}b
z!5NFctJk621rLz|W+N!(lW!ckEkFtR9qP7MF?cImF~+2WEN-8nUV>7hU{}Y*C=3X0
zBT%M#re2t(4#Sf{Fb&V9Ijx-vyJ*Tw@)2}7ILc@z^xJ^oiIOr48}2=U6U6m*km@JB
zNihnSETxj9b9@N@=5++dVQwReeWEf(nU)&*Ejfr_-z=!sp1_;p`dRa+O46HprQoaj
zK0kYB*E6Q(TXp+FrlmmM#a7qq3ZF8NMce5{V6jhG<yZqI*vJ&XGRQx=l#2@F4m2r-
z!(=LcgQ*yc2ey49dvp#m1<F-6*NfPT2^jo=p6o;4xy4OiyTup2mIIC~pS-}~ByV3T
zpb`H8XxaOG6g0*e!6;l3`pAbP1FIYNnAr&;I6({zM?@N~x0vQX9e8BOdpAR>(Y#SB
zf)@E>m;4b6!%i4=bAuhr%cvI^6K#Q$viE%_ZrUrpuovx);`0)>q3I|9u_+f_ar((E
zA8<wAhMrcTW)|D5%4iTe5<H34Dv3q_<I>E=WjpHR9cdg7fj}C8Su}blcvG;kr=Ep=
zP8DyN55_`2TQ(36j7zuZR=ZZl;}vd4ar~y^G`JDfCJWOFVr;YG?0QPyhvRAy@z8=`
z`n;s=+V!AMb_mig!2I|Jje!=1Sy0P%U_b7fOD8t5sB4xo`UAWwr1Y<V`=uYg&@s3C
zvp5(RFhidwQEFrTuA!kta4}2~P27lWL5T7%fMF<cmA2c`1VV6h9zkihWj4?3Lq<uF
z*~}8d^lvhe<Oad!VpG+Ib|~H!u}m3E%hQ*%h{<0S!d&8Imv7UdGq{5*f1@tKI#>(^
zMqnf+8l0Dc8pM-jh=;{xC1rZ1a+zIm75XAI4qxQjTw-%G*l@`&%kOks_SCWEcOJy#
zQam<~;z`9?{p$qKiVS^Z61t-lU_B_HCI8xs@WVmC8d!)+MJwKmMoV19=qINzf>D@a
z!#WGpDL@5*N=9IY)uT)yvLAyi2uxuFTp*yNTyd2y4R+BTg0LHcuxWJlJ!a3QXK3VO
z>3O%}^|2n1jG&rm>n9h8qv=<3sOkJ<v;{WzVXy4E!ZlB$y+Tzhu9frg$v#AHbal0<
z^V$KAy^-RY1M!D0Cj07Q7bQXmq0-$w)FBsl4H3258;T|eW`?4e+~?3%Tgg9T1rmgC
zJGPUVr3khdK9v=@9l55FYJjq1q$Hd}@WG1TmjRVeZst^Oj!_A2CM9LZt8`b+Mt|(;
zQ!m4PYs5&>ea8Gw5;)r2P~+#nfv=xj%D8q7mQvA6yeQIbxw@8V<=fb&yAgz{{g64_
zEfvV)v=u4@DqpKP2(e)j4eGX>#qobZITb8GqdFeFoiQke_vtl^?&H9tf^opx0#8>^
z2LQzo#&4jHh(0@Oh39D{7Tj_LZlH|AWRyKNNNnX!Ah9qHURi?$eF+rR?O-1r!UXAH
zQhgXW=oa0?V*#O|BrByL6RRDaGg&t}(e&n#)c&m~BC<ZJqIfbDgcL&^nQ8+knPrfi
z#Yw8KfO7<9GJ%@~hXNO>5dC2jz73qvgl{=lCxsTXsJVd~U1$kyvlbO+A*M2B@<26R
zZ+i-qpu>|3BqUBsc;D_LsS;0^<8vm$({bjCgFSAg5J%5Nlyx9mtT@NXo@(O9m>QV|
zOHb%5g<r-4y$XjYGG4I3YdkiZ7%&?zoPZY{)f{YAoAa-`2`v}T!=XR0)w1`gqs!sC
zL<1Hz^b$#Uzj{6s3;Z+ON0Qq)o4mjIPE=RB&?W7B7$Egb)WF4mY$h*89c3((@Gf)_
zFM?s(6=9>u;uFvX3A<GFJA~|DhvA2PMH^(pzB9#616wA=-n$h#Mz2DEVstD~WNLj8
z(`&BQ9iIO9w+94u^fso}nga|m`|p+ax^bC4GBi!!KICl528BreP7qRG2UnVfb`eJV
zKDOof7`q=>j@yCCHm`Ls0O|vTOz#}?e$dwBIgVFj;7uXCrG(dsPBA<s|I8Z!d>LA#
zr7~bMdMBtUq*k&AD<9Y3f59A?HF!43Un$6d7G-zGby$5Ba8lo4T<0<j^?e3C2R*w%
z?~k0Gn#SnNfqUt(bM@6GvOZ7*2EA0kf>K~-YMb4S*0}D*b#@*IXj2V&68?XwoiW30
z*RJFuhTly#V>Kc^T7*%g_U&%PX=il(c0{CdrAVPe^Ri+mm1pVYnTn}=q+YH*wgtLo
zMP%%@#~@wyGLm{X!I&mK0jV%e{EQX>rirh-0kj~htNu1z%%iiR41U1eh{+sC*8>x=
zbw=O7k$kIe-auQewa|@~v~i+$L9Bt-*`B<)DOm_?gJR9Qfx;JK@i$4m0GbQ4d40EK
zLN)S1SG(mD6p*o};0O8d`gwK#s!&t0Kd?g2i{Z&Mo}o5Bxd7I#dky_$x4xp|K_Zg#
z?FG7et|whi#&)ya@&Zn+g|7Q!`pkIC-qRyukbx0xx7<#c`j(}}h!#k=54?yt#eOdU
zvk4^=C|aO>!IoYpn+`*7;_Ww}eRMdIh1SE6Di-VFt`6=eQg{K5ISj}LFPhiWZc7r;
z7sG#I`bm>0n^SWby(u7i<7kww1&+!2ruoF~um3t*nVO3$i~f+BgvD44-vu_6ld%j_
z$gGGi!(1$Ta^ZuiyD-L>7T7G`U{n7AR`8IaK0*)R?LMS#xsw)M-QTC<AledKtZyY;
z^4nb}v2mKqwhCv^Rsq0~bDWs1XhgjlEyTwMZQ^>*Co%a0BfFaznXEHnG^gtq^E9RM
zuV(w?SII(?@wG8^6vM6P6{+Mk9=Xk%w<B=A`qjta8@I(EDjzm<*g?|uDs?kySrC^z
z8m(TKdb=z74m2$GiUH|a%b})&@MNyM0z(Eg9IL9wV$uB6uUD+nU3OPeo3@;}S%$q}
zyKym0mmtWcCWHkHp&9J5_zU_(Z(``77xq5Af>0H<Cv4fIe@cs%&2T61v0|rEJzpe$
z$@yp=A&U_j?PqoQ<h{}`5So}e@>?vtY#jJ5c@f<wg)RB;BQp4OBp3LM@2G!M_hM8b
zkGJ7i+CxWv6(f&=Ug*ft<u6f<zoQ1B|5GWnyRe%{#a)8n>by4_AEFHH!joR1Thrj=
ze<<FDt&Vyf)!{cjPNh~b20PD#me%o>`Xg$J;K6)8tz$2TbNi3!YjhH`49W#3Fr5jH
z?TIkGQ~4bNwqAwWlIei=mLb5<3gU9*e0=pG=lw2a7-OB(eL1OnarT}_(cnz*y)hG=
zt&*|alZi3$VvJu;ekimehHu0~qrqg%uvur=8)gQu_$t?d^X|Ys;`+PD1a{pXvyU(n
ztQ?du6De{kuAf`1EoQv)UGR8}IK8Oz23{(J55Zq5#JyY!ooum#92sG&dU%r|Wid=I
zR~Sys4q!lGf;V_+vBKdxwjA&jaS>Pk01*_o+&B<^i(gJrUk8PdCpSr<*@;OncPJ@L
z=l-OVD29!qAqdPgwxqjdj}t+u;AC#M<k_iM@iBRN$j%8viT5R*kKYF9T~2W=#5Kk_
zvUk#n`wzdME8t1>;jAyat?LOxp6G%NU9f4nx_p$$Gz5VyY<p@j^PCnyF~6dH2fKh^
z#5-Jb*!~oo5f;~^$(74?r|~<PnLhb7wmZc}%GjL-ZX!c+9>2?g5CH8Hhv+v1NjB(l
zZhY&Z+W~Bhh&3zXoNI3b68Z7I7if%VSIYdBKq;(A1~#PXGaF$_6%STj49F+su6?aW
ze}!pm)%W33@v1kYX92zHc|<IVIz$W-Atxw+h(V)`h*hDW>nZh(4aO<1#H0njT$g)E
zja)L`O=a(UdGNlM{0>6ABnqoyIjJ1V(urjOK@?>eO^^jNK`w-vx7^QrYW2{z`6u}R
zy(KR1_hHwCZD4G!&~FC74qndIfgNCLm!v$shN>#Ju0|rRUqRC7I*rfo%h|fH26zui
zN(0>TX{F-&N%M#skNgR?qI0pvjUcx*lH)vA5H7=#`N(Kw<@agZJRKVyNZ+oNql;v3
zQb$;+k=XB*c<KGN0(!sAt6Nn`ewSj})Zt9*`Ag|-R4cwi)YHj@2PYC<Ku6EuD68{v
z=?5S-W&wnezQm7~(1o?PRFXXt`%uKkVEZyKQv&BQ%S<r}_2%cGy2KlHSv{k;TtArJ
zzVAaQz@xaV9>jnaitGLJyyb04fsh-H8y2&+fJ65O6q{5&%i6N1X@C?N^2elx;-m)P
z@K;_w#TBC=La?7Sp~e=xjkzptS#Wi@tdI%6fo;qmR@fmhcp3ic>y;QLTWRLyU2*+7
z8YZn41?K&{ejli*!W_}5hB(z$1R%h&7`~eJ<K<srZN(}ehMTcF((MSH6VOb`;!Cm^
zeh2^<3{0tN)07&^H}p;Vl!89_lxs2y5P(f{iR)X4FRYtxxlPL3DuzozgVt?YR($6`
z^263MA3uC48b)|#C7r5wTbi#V$Ek(><xR3ilYXE9+^?SU8C+a$<=z7xjbF>vOfs-^
z5y^?``-S3jPG^{H-^Z3PB0pdQ+Pob1(y^nra?nPAlnIDoh~Y1Z4#hFfVssiap1%Mb
z(+_gUpR2Dt!=x0rfJ`a9CYPm5VC6oPNBnm6Z#n`<S6;<h+Xd2uts~-v3n1FmW{xO^
zU%>LyH?=HvzJYWXkh(2DGa-a!WDxw~2Sj@><bH6@CugG_yyZqR{EjwU3xUS<59fFb
znBO^*+KLR_g*p)TKTre17s)>`0(G`foeQW=EdB$wn4b67eI1Ou4_C+5VLWZxRG{kX
zpgsbNF*w+AV-SL;`q1M7%zzUy<ju5bdT(x9O9>8EB9^yiQuvPiUl*~W3`EE($Id$t
zMW6zvA&b}<%-RqPeH(`nfr$Vaj5LOd)(JM`OJHk#xS5}U675N3jDDBRXZ^k$Ae~7S
zDE|eMUcBvS2a6=1q4z=qz~D`1F$rG)2G!fKLt($EMRu^;vU475r!3yi2AUf?NftPE
zm=1HgGcZ_Oe=~_fx_PTE3cM)`^7)*+9pu??jGzXxsDZ(t$Lul2AtK>hZHG47w9y<6
zAtR29Ir}%r34(SOd$DPPh_%%;j<_$QmtO!u^(a3L0J67@HnVmgTo>1FgpPV^w^e;r
zM}T&(XOe9hN)r;z^w929^+6!gNe*~h$Gm~boStc}3{;ov)K2KOTt?J_{gnyY&4eDw
zzaPrLb)1dBx1-ny{A!0}PR0%nh{ZrO{4l0UuXCLDfy2a@2NJ4=O{jJjLv>;dhyINt
zJ!>FY2<c@)I)LjD20dju^nRxpUO@V{-c>AxwlcB$kY`*`P~|F+qK0x7ff!hRALFMk
zB~pXXUJUJG1I@|No+h+eg!VG1@r&@!AH|ORV~C^2hR^hyTzEzB$vGq<2Q6%0sS6K4
zN_+v!Q9W4AzzFl(Se)A{A7-!WjWU|veg@<4N^1H&+Oj>*+U<I^XM1$MLwhm`_Tt?Z
zEVJKXnU%0ur0U^+gl@Cjx-A2U7qR6a4Zi#_g-+kZWk<eA5X0L6c7;Csk+nfVv%opD
zMo`e#aJ!Zzqb7pBJseH^*a%*X#*xAh`eX05oWy2T%RfQSt(=X1!{qY_=@=Z&lXkU?
zBtps!e)aG_h=EiG57Ir&Soj52JQq(}Xws{<J;lOfOeqIaHFynpzpItzBK_RQ7JBGl
z#%isgVnnZ}HE9Ehj<#>=W@-Wbus-huB5@O`b>Qj=*7WP`>Kax$1lJsiOBbBCXcR6p
z#<lx9wxG4pS+py1c_tAP*B@n!w&a05^?RBvfPyuzj5V<wKsvv&OA)6Z`)6GIZc?k{
z!UJr7!>ICRXse?Paq!kUoa{H?sG?Q98I96$m6fI-?QneZ8|vdvQ2M3%5KDhl?`7%N
z>YYgWg+aP$6}SIfIq8=dxjn@%Q$e+$`eR|CNW*e!PlF`z>pFJy;>OL;=|iwgKsNSU
z)2;Ldd1UCPnfhFrz$^R)sj3B3!F+#v3mvknUqF)juC}_vS?m|qp@~As;gD;KpGh9d
zp<M~C)E5{k9F?}f7!sfl;qy$mvr>e;ZbNeW408KI+eUq8-S9QWgZ=WNdM&yP$pV+%
zE#b!??1bDjC1@`2otpmBc$kJiUdB}a0WiX+;(K4jHNOkcZj1YJhVmpb*rAb|62eiw
z5%%vOu#$;w9F2{<A&&J#Cv}{9BZi4SJVcw6=fR75e`H9cSn82OK!W3oZNq-NX{M^k
zvk9>OleiUNZz5E+^6`>?VkY!bxZfDDji<5^yZdxVde<h1<08l;X7?m3>=r}sgdYKP
zg`>|P^uG}Lc?_M8FE=8qV&l!N2ZcV!ddNTHy}CjsihuD=g8jdJ9`EA_sCl<#%3OwW
zm^v(fMd~@{wYWr+fTM$N+fP;bLDB&xp0Ok$w{ji)@9w4sDQ{a~EM7Am7~@A$#)2M2
zHPo&6xrn6g-U(OQf*P=w;x_`9IsEG1A@cZ-Q5gG7EZ7JVorJpB!C;@HzV$H)ohmFv
zg|63P@<KcYZ)(4YhPqmM$@?bwDG=baQz*&51bVM7!2VJD9;z6tFVXy9^3LMur*ia<
zhXZ{yq0{dQ@_9HHk~b+Q`~tIfc3VcnsY(i-&$ZG8$5>w=E~SeWNw_gV(<D!S6IwqX
zp!uxp#~&Pw-+O+?_`Qu7c${{k|KOv%lfBg5^^%E$*4VC$f*J8CvT6n!(fcq)oSA3;
z6(3MC#od;zvl+@`$k1N65o?mXJ#^$Zam5Y>VzZ_Iw<_3Vcos0c#)b_OrpC%g;utr4
zq+{ss-@zIpF7k%D4fiOhw>M6xwg>umxCTOWQMuY~tdf1rj}mwS7_WQaLt?ycgWju;
z!_;bdsA?K7_=Lt38N_SQ@7JQn-DJ|Pry6{UV4rx*{J5OOFK|Z-8+fn$4t8U>K7%DT
z7q=)JY>8zS%q#C=CqNQnXLj^fQ1@&B|M*$PrYT#Tlz-{(G#B{c$pK6eIkVgHtB=X_
z3}mqbhVs7fJy=(lK(-JCW<pd=gWI8Aw;95L1)(qqU)RN!2WXlh48mVO)qmfyRsI^k
zxcR~XqVf%_3%6i_=h*(bL%k2vlz0k0>{9v{D2wdimI?Yhmsmg5R-i1&qVNW-<r&?U
zVR%IXF2gtA9y@RfkZj&ZB>APiWNJS`Z)YNMfFF-R9OP>Ff8PL)4rhj|-@tUkHWtrA
ztVs;N1uFWL95MVZGVrqlWi&%=oZXim;S)AP-GC=DD(jGHN7&p$PY+tjWz2cvWVR2X
z>nyaa4L?(N9UsLcP@lv`^opz44;|~{@5Rf_8A9N0+~2ohZ5_z0``3K+RYh1B5=Y>6
z#)sBq)|&#@Raytnv+L{NShNhK>4xs89yG+39>%*i8%*l!Ep-UNoZxNR2pWV<=mQ&6
z_MTuB?&JLL>eGrBd+Jle+PFT^xisn1pQiPxPv=5?41Ib5&+0i?7JBOwxorPdpB~tM
zj6Ti4bpP-5=^te6#Fn4p`gA%wTj%<8VjudHWY(t#Xc>*^6Rl4%efpvgeQJ2f(5GrV
zkv^3oJw~6d9MV&tuxgTV&%bsUhWV<0CekO;rO;2&U@E%?Cx5^-iffm;9-cMRE1Bz+
zzc0PI1Ir7wl(X+7rdRhtz0^a`g2nwz<@tKe^=tAm`X#np52D&&(y?Oni|be>;l-Un
zT5rtyX4)o%4$?I+9)$JDwT@y0>&SpP$$-HF055~Fmbv5(STKoOFaf%3%>EPlv6~Rs
zS4eD7hoqnr^2b;iTw9n8dj_?ka~G2XG!^QmJ`FodIv2kUg?l^}rgPQqUI9BNU95m1
zQ%7U9F#IcxZ2&&T5~;qsLuW0x20K~0hKk)bb`nYonJ(HTI04UMK}0+tAn10$5j+|1
zctHWJj92Ej{N-h$&m9z*(P!Xy-vzJa(*@(O28POCrn)K)evD8-o}w;d*h2;ABz%!^
z4hcUu7#_<Y^dlLFm^syfZ)4v8#<sKDb?2av-L4yi2OmybSZIKL&q)eRbO>U2B0ZwR
z4<od|f2V<V8!h7i&fe)&E@5{rm!=lLp`vE-7Kz^`hX0HX(yD}L$oGiE()eZ;D0s04
zm+}w@f7OjUc;j4oLA<Fn3bT%}ayCdZR!#w=0GBOs9FVbbB@}_J9m^cK>fs0ZuILDW
zbiR{|_{8s5Aybvd60zlDWC(a02T~%o?8INzoj?OQ4j&*EV621WZ{ug5#qh&~!w;(L
zHtI69*M{~mKSThqWDW5~ZcJ7m=dhnef(6cGY^ZnZjImuT4$)kBQ|-YyJdV$P+(Hc3
zqkD7=!-7!1r%ofxGsdgnq5)1%M@l!pw3b-F4ZG9C^(j?($-$v`L-&l_NoVkvjN|(w
zNV!0%pb;*#dGp@Ju^>p3bnz>WB-7xB+GA`2H-jKsxA=vQ6<DCMaZ}Gr-UybioPVJY
zFf?aj`l~-+J2~$PZR0P-I^tr#RIF_Vfb|2)L2;u1?$j~G$R}$F#aIRRAg&nUFR_>N
zVh1Y8TeXkyOdBg*0`&I0mv6GDbPKYu4_?}E8V>Ci<`(5l<BSbD5sWPWW7->x3)UZK
z20S+0x}a-IG0k{)4cCm1(Q!jFrWRM_O)VB%UI7d`F?AlYxVl5JQ)9~se+wgknS*!J
z{z_FtFZs15j^D4!mDgWvSw&#dHE-m)Wc5kC9eND_G%rP<UkZJlSrs~xDTXQXn2q0)
z?K%<t!msnvn~!-%#1Q>HolAVq*U#?C_4T(0KGQA+W?V8YuOh2Gfj&x+M#K*gL%@DN
zS9R%)oq%E%3=!9lkuY+huk2{h9ykN{mD<GTmZjL8xyzF6VoN6)in!43Rw?gr!{-Iq
zNa9*^hEKut^Fd{BaRl>@euSNbC=YR{um6Qe<6`r6dcfp(kpak>AVwhN6=E`f3#v>)
z8Xj;QCn(icoQ^~H-U+4^;Prii$<_E3(J^c)y+ruRBzBmA-<Hl|o1o{RE*P$F)q!vd
zVOVK7EW>&ZLPNc{Ac<kXg~~R*nOluW4XdSI@)jgB9+57+Bj^L`4eN-OLyONoaLi4<
zb~+ICc$ECBer!Rj%sAam4$vyotv-)64p$$suAJ9xdB(*|@=#bTSLoN|z@_+$qxO8t
zZz4A~=EwJ3IjZ{8+<F-+2fGcSyT244%`dxxy4tNKfiu2#1fErzoVYYss^;HMa_06v
z3nW|!K{)9bojag=rD`2@27@#aziXAM+8DB@m|6CtSn#|!*@yl7T7p4EaCG@7^-5O3
z?U-2Q66@%PRwGwBJw#J{E@x*k&F?v-vZsi4|M-pPIhnXQR3+B6(Q;HJF5FrrzU#4*
z?~TskrranO@Ty&Sfq=u@fH?_<@ZMybaYtSZ&jK%W!5X~0Nk6q>Cx&p03af<J2e*54
z-QW$p+KS(um^+W_7hTwgZsJ6j4hN*9t#oJLU5V6Fd=6A_AmZZ+3qo#OA#{ej#g-K`
z6p#t7b$KF_N^yj-(FtWz8~%sQ`IW=<@?4S`yP3F`37+qCI<dmX+_XQW!UT51@`_=q
zMcbR<_mac|nBS0^KYOQ3UV^I(dxF_rm8>764tPCxYiFvIGPziO153R?4NbyAe`zKz
z#9KpKad^5XaFK*N8|BV{P%DizDY%_i@}Lr-85M!9*F`I@w#ImS1`H8rEe$Z|?8ik|
zr?-BQilbL{$IKm>k}0>--Iyi!@UBPoPV`5f+7!dfNf^ZPxlqL2bGagBqL@||92ehE
ztbXuk*!cK)4JQ2#K*&vML#irdaMOP^)`9FczRyX;D&b}upvO;O%f|C*7=z8&Q?iCz
zw!?gB(YT#P^Oxz({{*sz549E;#$3pT=nZ#{F17TU3k#`JvAK}SkSFuGkOXX+3-GJ<
zlTU%UaKk9|GFHJn7v{(2!i$JLOOe^7@?<s_GTrj*KIQ^EIb$wN?qe=YHqV7xdSB#_
z7|vy55T6UNX+Vr&Vs!C+8M}T%^C1H_LdY*spQcfXO$mV6^%i|r?3Uz@Xih-GK&98j
zn9U~!#krV{@M-Zrn-=`e?%dT(LFCUMZuR-QA#->u;%)ST_>X&G`}mlt7-el9sF0t|
zj2$}&V|vfTt9^h9oPS(9<VNG`w(Nb(QKvs}Bw=gtJ3f~(D=I;Cai5)M_JA<%?ek0!
z864t0$*liTkG$I_zfTTn7Tdf>2F=+YjTVx1Q(r}hpm-kF=Kj<}W{*FI#B>(v_dVkJ
z3-8<Di+GW6Wda)rG7#)WY!>d%F%H5Nu;p%Lx+D7#SuQ)Z%YtYp!Mk(Ka+86CPxJ;X
z8+@X3(viS3vAaPtQ+@AIs3PvblXb!(3TIjy3UYLgm))inaUq4NP1MRSo6V=)Q+Ls{
zgNm#M0#?~#wFD6DRzi=>KW5UkhMx^Nvjg-K8LzW5HTwBYU4MwsQDn(3Y6p)RaCP6G
z2xf<8_v442me1Vc%uY=OIep!7;h>E=L7n@Sb~}-wXTrU5DQO;xSVr;{%wvx-ITf!J
zOh$A9icGgGKF3z;imO;xsna%%eqx3C>%#p@onC$hs)F8|5EfO$yAM<Gl0uGxW<1JF
zy!0S~=v4Nu!k<77FFTkBeu7~n`yS3CEu<eYV!0F1Gwm*b+)9B%y9{9UC-jhflQWUJ
zHqquzt2;uV{c1WuU0pixD5~Op6tDa)Ik`WuNEvyQ?6y?aG2t@xT1*lOhET`~ioA_}
zag4>#d~&H({o~^_g_;&2@`ScWyg_4$4OScI$)g<PD%6sl#j7V$mK3=RrU*h-Y;=KU
z5nZ6UF@Bqzzlegn<d?n|jm}oJS2**R-HFZ(e+=rL-G-M@%$JOU*TA<hzlZ|8!VgmE
z&DdBo!9QaMU`IGR!>vrRo9_B{-G=#$vMiKk_A1lrAwH7a+kez!#9b}wYA|B#FUW1`
zwzTA8J_pO89_PYIQO^Z3dLQWDZfV5c9KUZidf6D#_0w9A;H|w|cEa`DgCHC~V^Z5O
zF0mZlZL;`KPyGkL^RGniBIH~P@EcUE(4VCPNsV%fU`Scy<1x%ZwE{5(Z5f#D5l(Qj
z{Y<yzHQXCdqTlYy|9&Qrr_xMQ@;mVixmmS~kvIG{yw}3iH0OI5Cq{od(N6{at}TK<
z|DFih0;;zSV|)Db|CR)j5bPLTDU7ZXMo$*XDk>Vr)YjBh3g_z|`@*vFYXS{r<&|~=
zB#iJ65IhYH^$qr#I#YR7eZ%6ifN<%h!r3E6j|tjG_^EtEW3O!HNPAg;zy`fOQo*&b
zz9CRkx5%E^ShJ|EtkyoFVx)ck2>j;y_)&IYM5Fz>%7(_8dPd&UR1**?f{Pa~6&f4L
zFRZO!bV0cgXb4scRb{n}l?+(p50ov$3m+&M(KvoYBbb<3Bzb0)6waDC$>%AEK?_~8
zTm_z@K1$|#X3h4_oN-KzS)SQ5=ggYyIi{evXiCY<8NMs<XR;^O06}NWEb-0&y`mn_
zNiKKET$gW7Pu!U^JS8qTZ8K*GMknkI!P-iDC5^y%I|OO;$n;oVR*PX=WUsBSTXgke
zf9A+IQiZ^3Vr*&xHD$Fm*Are77mskE;F&dR=ByZY06!mG$wq7R_=@p0<Lk#aj$b_f
z>hb>ZF_aT@oLQctIkRRQ19nZG>?w?Q)WCMnnpt=Z?qzd4rrsN<vy05A)8-Tu+D8PB
zscY)IQBkO>sSQ*%KyDYY?v)r4EQ!?~QDHY%g#MOSlYVg(If3WR7@oQcdwrFCvgGob
z`pWe@R;@nBL>9|KEz!({W;zv(gklDPmC*#VkM_kFh{I-}BnD=^A=L8fvYt)HD-@e6
z#KBYg2D^xwsfBn2Z^9CHuM%PM%o#HZTr*0%g+(q*s@WxO&!jn1g)+atvaUiXuV3sh
zYp4_|Dr+kPn47i1#_G|m142z*V`W1?sI6%X2z8Z9bf~|+wx)ckj<3TiDjQ)I$^w}B
zs5QE#4&z$|<0M=iT<jOva0!sUsi3hw*nn~-GQr<aAE+;{uN4Ysd1lR=Q{<g7Rq)Oz
zoKqxBnK|onc)<dIlr5Y&yU0Ko?HcbL?;c+`e#ZFX@l(e80^^13m`*j04uB=$JfWbb
zv5{sHy1BRv-DL)nrsn`*N?A>9WraOZ&kAb-G;DQ?DjRvJzT8y8irE)dmX`$^D@ns*
zlby}h_?l!WRbyp<O>8?&bx>cpG(OqwOKJku_Up=OgOxCxyslBNJkT`ylE6|wmDnrl
zD;w=~^#MCqbS9)&Y0rAl4-l-WD5<Wmzos!it7$}5Zqq1xU2t(pWnG}5rm``AL~xY7
zvF7?pJP3l(9u+RNQ>F2Ce?#SkHFXzOEvdK=gLI+4o+d%Xg{J@G^@4R37~0zUCFAY?
zpX!0n#q||rAZzQ(DriI&)m(>Oa-+8pGZXv}xU6pJlCq_SNoce;2K|04I`+l-K=KL@
zQs#(8T-`B@$bUlY*>9|YtnaW`c8qEjMvXm^nAn3K%WGu-bFUT%3ztHf=n<kf=$tTT
zwr3W%H;fZ~sEDv(oc%OXF??p45~IfOX3g<=?1`ww=^bNh?0jBAvzdYz^m^)to$H6)
ztRLo%<6p37EL&7L9%{~QGoMHH`7nX3#VhSMjCL&>?Oit7y<9hQwCV|hoqzsay&20!
z7cUz<MX$%W{4eUk?9%5y(jQ%@^TWljlTVm*B1-q%U+_j8(%<flMn~a!9=<E_{fyv%
zeTa}#_{pB%QGlhI;4lA!mk&p}%Y^$lo;Tqzd=<V6@I8p{C`zA;Mv1AClJfexI+&yq
z!=jXw*H)I*1)0|LSx%k-IaL0VhDv`eSy$7iFM2R}sKGz6R=Axn;iDEO&_{iJMd($Z
zFAD!neSP`pRi7_A$JDRF@=;q-UR_y!O-WOrgxd<P%8UTksK&}ZN?^Na`NAv2<PpXD
zW5AgOt!xx{ed={dqrbAeFZt^WVlRIAqEMo*da(xjkXHgsUZoFwbh!dOhN}RS*!Zvo
zI0pWA?e)Nn)z`<@pc^C5>!A;Rden^3!`|aqZu-<uxCn7fe*>HVwgfF@Ei=8X@pJt(
z4HkoQ2O*Bf7AMXyE9YJU1He)T{m=upZ2%<3Cz~C-4*l(`f8>jlW5!{Dj@P3F9{AOA
zG@7}Re`o2>6HTylOwTvy&o(_hs@F5>_f9|i59Ph_|NrLSLVK@+w+r$0;#-byGrsrW
z`z*fCq5M0fNvEbvID$~-CFuXAn_-_2iFo{$XtW5C^i4<~LO^c8t<mTZz!xZhQ~7Ox
zBmM9Xuy;rgwxS#nl1;ZqqghB--GK-T(gg_3(7!H!FVba5YZ1#?P31@*r#wO~N04qp
zIvip1i3rBypF<ILAuUGgLlk-y(owL_FB2T;_edXyUA7~T=Yx&*Asu*sG}?spAkv4B
zE_fgs-HWsqag^_oZbE8BV5Rn9&_(+A+GzAnN^ygFH`05bjYfY#x(jw$LQH8O*=wX^
zx9>z+yCE9wM7j*=_eg(1YPF*O8$l20!A+opbQezVheK}5UXDg<k^1m+3J)P2-i~@m
zN9_Rq0F>{HMt4w(U|T8zK()9jREl)dF35%Q_|X9s>4!*%AOLmn9h4&-{$4bCFVa<e
zu`VGU_&)d;1i5{HkR;MoAEG|eUp_`X1U_qVIW<5jE(cjLj*owZ_L0(ij4P22p-F;I
z()F{1q$XR^sRR34TcHaC$9+k`2^~3y5ZwK3lsNDmhwsXpqS3<`2O-@yB|T%Bn6|{)
zEL?iZg!9Ha&H_~M;k$qypkJg1!lZQDACf1fXWW)DDcv4Pos^!r%Hm4Tx}~2hJvY>U
zYWm@+$)y9*a{+RtX95MNs4^+t>VXt^yN}bus%Ug1_!C^|wovla^mWN8rz8zXx4F`-
zE<$wU`!>GTNHlr^;Z0As-InZ0&xoXW((S8K-RYUPSlsDZp?=BD1JW~HriR>U$))Mm
zZSA{WdtDGHE;}6ccZ1G0JPT9PJCl;18$iua8QsATV-ECHR)n%#%!}S-BtSpP4x%id
zXu8vFM2mhyDg*PUFZ?wq+l8{hgpZGe@3VmI1&nT!aJiy?w^9EhsUDIm`gcn|H_6qP
z?o7TDVx4@9Sf{56cB+rLTZ=hM<Hcoq4f^Oyo0$$}#>bAY130UJ)0lz`24z*UD?Q_u
z6nDBkl<G}yP9<HTqm}P5r+<%UA^D1Q+g0h-EIgJHea!6}3C_kWc_tc=(x%|=B=&b2
z`|C=ZLQRrx-HAFIQ0FbZ&MnklC}m2zJ$c4}^o+@Dw5OycPl{!xrHukE*`ZQ|R@YEH
z#wS$smXztlXY%zxM*C1GrYD&|`33m9f&XR<-%a??3E*!@&%p2iT@VO26MYZg9gW@{
z!}Z2!H^fML(g>F##Yce4e%csq>ioMg79~IhS!nB&G)A`>xT|36-Xpq9J{Y{@3a-&p
z((3txlt!{7d+CHdT!isAjRWI%28fppNViWmdO0<X>2N3NEQ8HVLrOZFoID4Dcc+mq
z{sNf)J{(%$nLeZgHnOdNJwX7-@HU#W5t_5BQZX@ap*b7sSAeO5;g8KxS6XsaFOZZb
zAV@Eig5E&b<O$S1=tYR$Dw6RnL@xwgElgg+>td9F!KXacy%%+DxVrQ$#vsN^&$^|_
zE<TH6b<uAcgT1KxHco#(!5EWVV`Gq&d^aC1ZZRYjr(%6r{RGxY!UYGqothT2Q*1uz
zcFLL32z!$YP%k^hWm*VY%l?7W29Tl;>2n2OYXMtM0MIwjAEpspFQ=wq8uLd!&+kP&
zdI#toss}r^D%qr;H3POmmD(Y%UFlYDn#3%ZM5=pB%BtiBQz8AUnSu&h;dS_TPly&i
zZ2XaF1}wlqeEhKn(mQkebsf`X!E6h&*>PF8)7K=WG?OrnHQJNN78Bi4&|CI&G}=#>
z?QO}JlgH?jJH0gd_Vnt>>HfLt)vol?;sH#&X6x)pOP-Zp?Me4b>D80cOB>kpG=>e8
zs-B+iznm4IO&Zg^Xm<$K^iJw9(>u)9Rb;bbdgo8RqL<!HOG}xNoZcj*HzyUOH@VXN
zeEb|(@7F#bjXpp!>7h%7F;$Y%lIO)T?liW3lK)V+JQ~F^k99IDlyXZl(}w`y))%7D
zodoZ#53r895=>1?t~8$6*gTGUYfSaba|!EO$TAhC!-qaiPPfPAgF6j;^?<<gU|jJ1
z1@!FjTj+A7N$=VE9A8Ity)R5Y(C0{FT$cA);7zNgb})B$y$Ju4WCtDo1Fgl!tW{oG
ztH?gy)+Z@X+GPpg$@BFU`wfsMn?XL<<C~+=pYhDc9r|V-_o+~|smI!kVxSL%f9Bs3
zjULeJ_RZ^L?yopu@N#FRXF>2iy%ls&nwnlXGrf3vdg=6ZC)dYn&`xcOMyJH)RWCVU
z>|(x9X>uiqA8TSTa@5CXLCd-|8htRP+sD|{HA%FFkb7fNgiO>ujJnI<i!P)-GF^sE
zVQVY;Ly8BpNFEo>q2W;6HsD%x+kK4x#%uxeGp1t7B+u`2klbm+b2Vs%;q#uW_g~jt
zHXoVpPJ!+|+>7POX~IO*eF$}%;3qHC>zdajlRx(uuN_;IumbV5`!m#E3;&wgIX2&z
z9cBK@;@EVX!uYhI(l5Y`^NDfN^(V&XgU9k&fwp|8dl>%vjM#jF?wNI+`MXSi-0A-0
zl@Qmle%Yk7<R#n$6)_W(ETuQifON0m28r5v7VYeP9rE};*be#b!v_jN=k93K4_nIZ
zL%cunwSbL3tp&+SpGxaVOWBp2zBXw_`nsffNL@e`gjSGT2KtBJjYgxeLw(vGCNE}x
z7=1WTeN2kUX({6@peup?G@U*S=h~#{08}8IM7({3hiL#v2F4^jcys_^fCV4EHtd}i
zVDCi!J@I7TJ23x8BL9chtDDoSrF8#nTD3}xj$N;?28;rUQqc45k4A6DGttx6e&(|!
zU&WQrOAZ-|Gw^K%{wCnhAbfa=*b~7U=kt;Fb+#qgkM^98Uh-4C<o7ch!p37tdSS|`
z$$csqbAO5Y@y~Gy9GAdx2^^QeaS0rkz;Ov2m%woe9GAdx2^^QeaS8lCD}i-+yz8ZU
z+WipECq2y5{(36v>B)LZ;R5>HgL4P^82QI~<u~bhgg*EuiznFH^Ur-e`JJBizs4W%
z+b!&a@Fx4<H+9&jNiV0fTKX8}Kl~Q0r+gd53h=S;MA)D=Od%ci(fL7$jD3dah!l^Y
z55*+tGn6N>zdBh#rNApb6pErxA;og=8Nw4m&kFdp2=<Xq=cxg={;&3~J~*!Gx?el4
zV<2|c5R4HGQHbMllV-E4Z)Nf!f8dYCU>A&`f%a*oT}c~jrS<Mg$fX6fgN;j@shBo~
z5NMT|)G=wHnsn+=l1??D7-+*(H67P&Db+B8>!gNpKgM;Y4C(LO`#W#nUiP+`{?q*7
zJ0qR@e)rsS&pr3^y}j?etK7Bf-N%CQn9>F<|G$3d>I2ZSzRl~ycnMnqo+8=$s@>1?
z`n&w$^as2yI`$vC|Hs&lzG7YMA6rTHk`9qhk{%*GLVA?+IOz$}Q>14|FOV+h4_0eP
z*OPXUZYAAIIz&22dWiH0=~2?-q$fyEk)9#FK)M_+>PT2ax}LO)bSvpz(jn4G(nF+2
zNRN^pCp|%Wiu4TW1=8j1ET42eX&32M(!HcZq?4qFNRN;nB|T1hg7g&W8PW@+%R5*;
z>3Y&G(ygR>Nry-$Ne_`8Aw5cZob&|gDbh2f7f6?Py7EK+51(`?7-#m}Vu(-i)|Xu@
zrdu@SN275*l@rK6@Kq;I$GuA5$Vf4ezM1L!1L<1aR3LpT^WPsx-@)`>XS&Xhgzd9t
ziO&S`+vmSXe>9N3n}WU)NWX*WPX*HROn)YjuJh#cf%MNa|91oFC8nPYq}$0FJd1(!
zD)awyAic))Hv;KprvGo``B}&D5~<%#uMu}#_5YV}XNyaAxMYX=s4(VIf4I~iF7=0`
z1^$2f!?w+vKhe5j+s(KARBN^)olR$3+cIq(na)hN2_?00EBsF7fyn-9nfcdu?EU0+
za*1g%nbR(t-mk4A-ug--F6UmCnCr~^Ifv`M?M92I%pFfUT<-^e*5WPZustAIzaN$T
ziO5-`oEKa+Bm0IWINjDyIXL=k!+jQSF|(eWhl#KC^#4QR#>1Z{e%6!oPsA5I{6C3r
z_vE}66&Jfb?eWXGlci>rncaqr2oE@7I*DhtJHVc&MRXhSIpW+do7*V=kyDOe+eJQT
zu*6(zX1JeUM)|*J@swHX+3gVJ&u~LKOa4cRXMV;3e@%Rjc<Qqbc$oNih|dwXXJe5j
zURcBqeV!e}1FW=T-|ssCDayG(Ipv!iz-&g&u!)?DUVT4o@sv6Lb;o}V<z&de=<&-r
zX0iWnZor38o`k!I&+l^A_B<`3CCW*8`X97-%A~0OYM0GCME(sP{}YtIaEoKyNd9Mu
zx8CXiHjjDP%DLK1zvS=@<o`#NLw<Yi7HQ`!e~T%5<u1d69I@LS9xnc;#Qqzo|9dH4
z&OwWPQnx$6p3Oy6+zg4F7d(6JrkvegJKjb9Igh`l^81~9dwv(uY4WH3-r?Gx<y{id
z^YkA$T;?MQUnT!xkN?}mH+cBp5TEt%bHvLYz6=9L>ie{Z%R4OAo*v#oywAgT5?}l~
zr?=KCPyC{X{}OPqzZrD=_RKP(@{Ww)nS#UlSjBvec$v68gAA5$5<gGeo-qdg9Px!A
zC+8;|F(-*H64(2$v&8#{9iu%rjOY)E_wh#3p8o}YIRuJ*TD^MRKzxOVe}edVZ~nXm
zxYW1x9#^hC3yJ8@6JMNi`1c(#MJp#|R&W4aL41PzyZ1T3o)<>+KFfcdnR~<GE6D$w
z#Gm%?M=joBW;{K=L43-?|AKhGhyMv4%u2l$?{)>+bF7HI#&VCbTuw{oyu~q2Sub7h
z-U4p>!+s~no?S-t-H>m`sb}X8SUd#>;f`PJ^HK88dHkD+KjPtc0+(`Ae4cc<6KD1j
zU#vLbMdJ4opOb|fLGc;l)9h&Wj55;ah|f$~c6@xt(Px26y;gYpjaMw5GV|X2aF%iw
z4!HdGTrQ$lzT3&!?bYie#JB&0<6rBD*+e|!;h!UZ)*J5?;tL-Bpv6;WfqH6xJ3{_x
zPoJmAf6;5NXUIR|@t-8#<Kf>YzSh%!DHITU8V_$FKJCrhZ5GFR&3>r%`84@QJpR4J
zPkZvmDQA}TdOz)a5AkW@R}p`Ja&~+2f0y{YC;w^6>8G4l%K3BR8RBb*%XxCKLysr_
zEb;T6{3VwOKh}N9`2gjtBz~Ujp#Gk6t;I1Pdh)a6Um!n!HZh+f{|b-)HsbxBJ|)VT
zrJN5^p993FiC;tfAmyCrf}rjAIPqhi{Nt3<PdVr@HhhQp0{2~7-<K%ov?u>{;xnH7
zw<%|ia#a3hm{`QlGoJkSS-i!}d-8vp_>?Dq3+0q4N9FG#zMHt}|2d1dm}8#&3i&hS
zS2@2-{?pz(|3%{S9{wcpV;=sT#j!vCy0h;}+IfNeGoC(Y$#2N7?fCEHpYr&xxWd_U
z@d+pRI?7*T@oSAfkMF}iQo=gm&F%*~1Gt<zZpM$-wcL6kH--rI-A>Rw#QQ#NVPoIr
zL{#2mlKZ~da}LKaw4qG?d2XC3&fEuF_~$(S-ynX>!@op)mg@+*m<_WQZ!!Iz-6XMD
zz2uDk60^qmzw7-eaAQ`R{8K{fVZrjRjek$olrzAu)QbdtD}Z11p62}Pfv<)g`dBZu
zTPDE&*#Lf50ROy|f32D2ePs`Il{5a$^nWOTKNZ0L(&DR3{}-HK`%VI)uLt<w4B$&K
za9XKblDvv`ZpD4^H1*fC>%rel{|^W7PX_R90sM{tJ{rJ(HGqG~;;YPjuhZPVbB*W|
z0scP*F8!h3>krQb`2Uvj%_b-RSsLhd;3-)jb-WNiNB;5y4zTajAi5G8)GKA*-sf<Y
z(_(RlCI4rDi=HEtkJ}0xHV61`7knx1R(~fc1@{G(f0bFF{(3)N3CKAZz`sm6yYF}M
zwO-!}@Qd@&X8q?}0AB{x#XjfzoP4#<l@@QTlU%I};GF?{JMh%I-q~KaTYj|57FULS
z*BjA7K+gUEem~`;9(Qsca>P7FeD<&d>^oA39uLTQF@T>8;IC5t!e%FbC(Heh0RM7~
z_h#*KO#uJ6#nFF$%L%scEFroh!2b&YycEFi4d4$2@M8h|+X4J!0DlE|s>!_fy#W6Y
zfXjHC_U4WEU_dpq=ehviYjN1~%g&zmeJe!o4Djy<-s)Hz{!go%X$KE5^%3B!mtJf1
z+=6EMy@3303coD&vyM~enG*s2R|5DO0el6F)670=ERN@mpK;~tc>hp<znA=dzvB4q
zyP1gY1)f5?%)jAq{eLI$)o9<vlMc~!`8C_VST6{yXNFNLUvt;#Jpues0RQa(J{Q2B
z3*awXe3hBwd~!2YdNaU(Ic^Na4!Y0L8ms}1Ebj;(u{h>it_!b{<5R?2I~`!(xkGeQ
zK+c^3yd1!PEr5S9fFBFse`fJjX8NGh)4n5%=&J$#?*;I;fy=m_@y7M4_cgcM+5rAR
zi^HCWoIZSfV?Gn$zcqm8fv;X#-)}o<ct0C>t6n7Ng8?~@2k>tM@E0r&{U3C~?K`%J
zz6M;@P2K-%(f<bg2E9noZn5)HY(g^$5Yd%aH@D~Y0sP~@rClEJ_CK2f{INqTxYDir
zzRDK{CWa$;=NwFTbu`DbnJxo|SP>j+fnjK3Y%q$_?d{E(JG)I`Y%;3Wa&Q$|=MISO
z>}f8gD<HkAEx?}*;F$p4*&OfeHI)MD8M_a2e#oNQcm%)2`Ql*BG`bgSYRHamGdNMH
zz(-jm{yI^V8Z84yrp_B3T+xk}YY}|XRSn(xMa}~qy#Cb+Q#JadE0!ZTC5=kC>b^Ly
zdaP?&c&C_}<z?I8Nw=xjyyjWOip<&@Fc4~B{p=OXlU)hTeBXP`<xA_SYJryNY>)e?
z^9>ilQtG>}?hh{-Ddh4-oRf~_N(DIYYjpD0y!fs_ouo6UTG{`>4`5=fbclU4PoT4Q
z^fdUgYpPREqP5xr`t=0bq9@RadjqEJ2@JO0z~JfWZf>uhke-3T+0!n*fvrEsbg^2=
zr89I598Hw-m?oTKT1`r{aSiTwo&Vq1^JS$_8lMzjj_?U?nB942t*U?`JPV6dI=59g
z;U=(YOLPaOsO~`PcDK3Kb)E>5&J5#@(bj8R=M`nG%F#%!Is$*5lU<4H=2q?sv{qN3
zRl2%hRhi2RV`7|qy??f6ou<x*V$;g^Bu0K)pn#r0x9aXqh)=^ua~^YOy_M+UQCr1&
zovcQK1KN6ShONS5=}-Yv=3qe^EcV+d{w1B2o9dp;B*t%BM?4i+PoBlGLAa}i(`hI+
zR;|H}bUB^T5}JzZ4)pHcfLVG&{DFSco0tUK0wcIv+McsZTc96w2lVL<$m|W_fqvg1
z^`Z{#fsx%2keSU$<+TFIct}t{iEJimtz;(+bjFT=)w7wzM4L@c-U0J=Bnr+3Ox+Qf
zIC~S#mra;48!%T#pfcG^qQ==o1p+#^2NsHKMhakaNL?5W^xXD<_}+xsq$ZRSXu9@9
zL4ii;4%n|dV2`eZ0)dXyo-{XfR2RyLrMo?$d#1kGz;3LHtE5wFY?R}VXdv#sPvJgm
zA)8@1Vy+i}M9#cvY>;YL<H!h)@%hn01=G^_a3u$y>r?P8tQX~6Z3G*R+6ed~?80UK
zhOhQqHNtX*&tgPde(vUtH|^MrL>$<QZrmPim9Jbx+qc|eqHQ~OZQ8gq+O>7-tvBw8
ztml4wC}9lSr7`R+`?l@ev1xPEmTpUT8hXR!4l{P9kJSmAb&pe+a-}MYtd7}bZ3sSl
z_r*-@=?*hgDHLKr<PS&k34n<Hkz*@H!=vK^_>>2BxZ~9VOw^DmLZ*R1xmBpZoim&q
z$Eoeor{KnYY&;qrAG9A0h|{FFy4mAJg085CA!rnNOtn@S8!R<iA=<I$CK$O=7>2Ti
z%AT7x<0~75J$5fK97&~65wr%<#vlh@l!&UuQW=Z)Ftn^x%cF1vT%M>^8<ZJ#i@ICi
z-O49zpBt2K9W-#F&s4_;_o1gXz;5pl_cT{nRM<a}8;u)IxBPcku#h(7Zs_4ADqu&I
zYi6KE-_x4w?p$RoE(D4}<)}6^2pbx?8p}77)lk(@Y`$d(V8d2S6j&b!(gvf2MiXd9
zWKktoRIokiEjqSMgEr`(H8|my-Wd&Hs~9JC$hHe5p!1A1b~&xK`!qv-R6d&%XG5>c
zPn6r@Yw2mI!r(}q#dW?aghw2%^$EnfiRM5U&EeA$r9ufU-XN|?MXgurCOF3uYBG4Y
z-wN2s43-bLj)E#-gm?|0j^gdOYtW!vEI0O_D4MJus7k9PM|pBmkH?sNAp;|zu??%y
z)KI0A7$NpKK?S#G4ducZ{%}OqnhgiZkH-xSxf_d&N@d$a?WlxQJ9nbnyQ##ff|iWj
z>?Iu;x7iKyFg^>Va_xZMJ_ETbw$CNsLfUO&OEm6gQKH?~yD32Kb%rJ|fTC!)gyH1o
zw<ys<u^7200iLgpLx3z3(r3`Jv97Y{@7M(q_#Q@t?~CN!{9dkkGt0i>XubQpPFjR*
z+uD(}QX8+QVQsfon~X3rhq3s?RT~=`k6X4>fUEq-jZs+$VkUl!DXKei$D#+N6xaD)
z+Y1i<;iumfDf8<jqWFpjCuwQ7$>1Wxp~SBV3>5H{Dw&AwLc?jciDugKRRjC+npzQe
zM7YD4EXu6_N*$<H*;$m&-gdfskwk@MSl9t7%M<Xxdf3qZ@}--~IM!}E{m6r}<iN^i
zwGMW@X((QA(0<hMm~`)NTh(?$$WQb}{Sbr}#M><}xrH)=81%((NmM&-&-%?cMp0qR
zU%_R{i~FkUc34!S8*kncp})&&+jOm!EzoG=0EY^8PHvE<I&-nWq$lfAlSb!vB<zBK
zy@XE9;GD|I`XnFAY8=xlS{fHSu2F;DRo~-CRZu82YS2e!D{n$K>FR+J#yuzonx!Ke
zv)?!>n>0StQ%DbwO{C@S6Q4^ukbnjzilh0D74w8PZrbs&T5i}_c4<YE&L0><5sua>
zE`{GvYq*GzRw<0;Bm-mR(V9uy?whtx6w`L8PFKe59wA*A!JY?`T{MzMUcGWT@L;ln
zZ|v9{8kbyB1O!-ha;4%RR2WAg_?Nb&ara?&vL=mTW^m(OD&h9M@nQG>;Y!XOEy3SX
z=3V<P7g73?#FYqdGJFUZIMNvBmviY7l=j)H`aeAfqevGb$^28yuXLR<lIrh-3h(gp
zKgRq@Ta}U2&o9U7FThuU)?fWMDE%b!;rOZzzWzC&a>PjU<8YD-q;mdIg49uLr}_1K
zSP_`0tohYngi`en0Tvs4`|k%Tz8EyW`d?7`4D+e}%BS>Rq>FC{y;lDYN~f9M*PpQY
z0wPjX%^&-h!0#~<)W3w5@7Mof@JRkm!i=E)DwL{!3&}4w^YecNnAk++$G`vZcOX4i
z2NoN&dGz`*M3VVinNO+x=7KVV;%8hNlzt6Y$^3c_Tj`r4%s`^~6n)amAD^S)c^Vw+
zX$Zdlf5iN1fBijOX&&cZlA$$uf%v!ZC;DrCJtwF1ElErSzx)@GmdxKj=a`jV^eUk3
zry^fQL{#LkHR^vwsn4(1O65H;965>etA7@y$_Ex3^jhh^02TeUe0{%1=?0fA{@)tM
zT;w8%^gYe5=MR;tVP*VC&~mjOEJ5MP@{j$M<5SAx0uD^%S2@eQ{OTV@>0xbHO3-{t
z-FtC${ijblMx~2h{#MFSa<x~!{$8t8{K6-LmaEwNkzX*ipPnPo^KH{O-;oTh$qU49
zVEGvj*Zi`+Bm>xONK&tgHoeT>f9E-YTo3dp{#1XRzb^x(y4#HWmywQva2tL%P6jPk
TF{xg&{0CP$&X0N-yi4=nAA-p|

literal 0
HcmV?d00001

-- 
2.45.2

