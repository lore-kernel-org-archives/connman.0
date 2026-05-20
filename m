Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381130567F
	for <connman@lists.linux.dev>; Wed, 20 May 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288453; cv=none; b=ouTDbtRz0NzZBc3a7D50AHNl6SekrP+IH7yU1UYAYIFAkIxQ5djbMpeGgUPgn/B4aRots2kYGnfrvsNXD1IlcoAkC7c0ppXPGBUImh+Frz1g6abT2Tj3mdR8BuC94HGqdsq+aeyuuzfPnRjdMfiXqRlWrycr57zxF/XZAgATSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288453; c=relaxed/simple;
	bh=J7qkb6MoeDNv2RwZULRm5zvbQGDxgwmEa3rqbg+Vt4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YUuFCPbjAI858dC5rDoqgaBc3ubT0O/F1q/bsaJH/eeYa345IgjO+RvEMOBC5N1E2CK4x4I4j7SHIPjigBU6nnsM3XbgFWepft9FZ5vyQ8XefQXoHvmfP7sIH8u+Tz+xEh9snKUXs4ArOs+Bs6AxLLOzd+kSqxyK0vG/p0L4x/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Cl6OSwk+; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Cl6OSwk+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qQHskT2hKX07/MeBsnpS3I3V18FM1web1yl1KynyhEc=; b=Cl6OSwk+fatFz+gweETAaHeJjY
	Bhk0+hYH5lzgroZhn8aBl4jDKZc4bGhhDTIT0TQ2MJ3fMY3a/iGQ5VrSgQW5KFzkDFvLMSGMhZjsl
	Dv2L4N+xexZNxCXtRUHLfREvF5WMbktFLXUU3wPs4PBRNCUjZyZBzHPoJgRAXCP4TnZQlol1as3iA
	5Ht9zavlWa+rZdKfMZaRVNI87mIflw71pPdrjkEoAJz8wVF40bPU3RBDftPgdsJIucGQLyzu8U8w+
	kulMGTXAB1sc84dndRq9Kr5c3iPsclQghaH8Cd4jq+TIvndg4PQpvtorhQvYtazs8JcUqc1LMqfvw
	QVdv3kIQ==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGi-002WBi-0e
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:28 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/9] Add conf.d support and restructure settings
Date: Wed, 20 May 2026 16:47:04 +0300
Message-ID: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.960]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-1-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

This set of patches brings conf.d support to ConnMan so main.conf can be
overridden fully or partially by adding new configuration files under
main.conf.d. The files are processed in alphabetical order and the last value
is dominant, following the common approach with conf.d support in general.

This patch set requires the other, previously sent set named as
"[PATCH 0/3] Allow to specify a type for devices that have no uevent file/info"
as a pre-requisite. A full set of patches can be also sent containing both
changes.

Both connmand and vpnd use the same approach for reading configuration files.
The basic version of this has been in Sailfish OS in use for over an year, also
in production release (5.0). The hash table addition to make things cleaner and
easier to add new options is a newer feature backed up with the unit test to
ensure there is no regression.

In order to achieve this, and to make the code reusable, all settings are
moved to setting.c, which has same getters as in main.c had before. The setting
system has been completely reworked and adding of new configuration file
options happens now through a struct in which the name, type and callbacks etc.
can be defined. For example, for BackgroundScanning the entry is:
	{
		.opt_key = CONF_BG_SCAN,
		.opt_value = CONF_BG_SCAN_VAL,
		.opt_type = CONF_TYPE_BOOL,
		.opt_return_type = CONF_TYPE_BOOL,
		.default_val.bool_val = true,
		.check_str_cb = NULL,
		.parse_list_strs_cb = NULL,
		.parse_list_uint_cb = NULL,
		.parse_list_item_cb = NULL,
		.parse_hashtable_cb = NULL,
		.error_cb = NULL,
		.multiplier = 0
	},

The key needs to be added to setting.h, the value needs to be added to the
setting.c option_val enum. The fields are detailed as follows:

opt_key			Option name, used for searching in getters
opt_value		enum value for the option
opt_type		Option type, see enum option_type
opt_return_type		The type of this option returns, supported: str -> uint
default_val		Default value as union option, must match opt_type
check_str_cb		Callback for checking string value: CONF_TYPE_STR
parse_list_strs_cb	Callback for parsing a string list: CONF_TYPE_STRARR
parse_list_uint_cb	Callback for parsing int list: CONF_TYPE_UINTARR
parse_list_item_cb	Callback to handle of strings separate: CONF_TYPE_STRARR
parse_hashtable_cb	Callback for parsing a hash table: CONF_TYPE_HASHTABLE
error_cb		Error callback when check_str_cb fails
multiplier		For CONF_TYPE_UINT and CONF_TYPE_DOUBLE for correlation

The types that are currently supported for settings are: uint (CONF_TYPE_UINT),
uint* (CONF_TYPE_UINTARR), char* (CONF_TYPE_STR), char** (CONF_TYPE_STRARR),
bool (CONF_TYPE_BOOL), double/real (CONF_TYPE_DOUBLE) and GHashTable
(CONF_TYPE_HASHTABLE). The types, except uint* and GHashTable, are read with
their corresponding reading functions - the GHashTable and uint* are parsed
from char** with the defined callbacks (parse_hashtable_cb, parse_list_uint_cb).
If both parse_list_strs_cb and parse_list_item_cb are missing the string list
is saved as is to configuration. The special case of parse_list_item_cb
handling is to not to create a string list but to handle items separately,
for example, using different concatenation to form a one value. The error_cb is
useful in cases where the value needs a complicated setup, e.g, with online
check mode.

The alternative return type, opt_return_type, can be used to define a
conversion type value for a string. Currently accepted conversions are STR ->
UINT and DOUBLE -> UINT only.

The default_val can be used to define the config option default value. All
regular values (BOOL, INT, DOUBLE) will get the value copied to current_val.
STR will get copied only when it is converted to INT at return. Any INTARR,
STRARR or HASHTABLE opt_type needs to be initialized in
initialize_default_values(), and free'd in __connman_settings_cleanup().

The work for making these patches available for ConnMan upstream has been
funded by NLnet foundation grant NGI0 Commons Fund:
https://nlnet.nl/commonsfund.

The NLnet project website is available at:
https://nlnet.nl/project/ConnMan/.

The changes are also available at:
https://github.com/LaakkonenJussi/connman_ng/pull/4

Jussi Laakkonen (9):
  util: Add conf.d support for connmand and vpnd
  main: Support main.conf.d/ files for overriding configs
  vpn-settings: Add callback for processing configs, support conf.d
  vpn: Use util conf.d to read additional configs
  main: Reformat processing of configuration values
  setting: Move settings from main to setting with hash table support
  wispr: Change online check urls to const char*
  unit: Add basic unit test for setting
  doc: Document conf.d support

 Makefile.am           |   14 +-
 doc/connman.conf.5.in |    7 +
 include/setting.h     |   45 +-
 src/connman.h         |    7 +
 src/main.c            | 1031 ++-------------------------
 src/setting.c         | 1574 +++++++++++++++++++++++++++++++++++++++++
 src/shared/util.c     |  179 +++++
 src/shared/util.h     |    7 +
 src/wispr.c           |    4 +-
 unit/test-setting.c   | 1103 +++++++++++++++++++++++++++++
 vpn/main.c            |   15 +-
 vpn/vpn-settings.c    |   83 ++-
 vpn/vpn.h             |    4 +-
 13 files changed, 3051 insertions(+), 1022 deletions(-)
 create mode 100644 src/setting.c
 create mode 100644 unit/test-setting.c

-- 
2.47.3

