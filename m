Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78919DF62
	for <connman@lists.linux.dev>; Wed, 29 Jul 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329329; cv=none; b=R4evnrbJkH/YUwsu+5DuvgMnJLEUQMU2w3C+Oh9y+rj4LIUcJNlzhi9NK5TUs7Ib7A1N/bCst6rM4qm8Kkxmed8Te+5r6hXwxf9o97hmMl4mhOGtfAtWv8pAQwJ/omNA3RS8BxqY3B5/qYFgJ6lX1Vn6J998yozeug1rGyMi7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329329; c=relaxed/simple;
	bh=Frxa8/dKFq0zYexN+z6Numwcfwk5c63CIhg7llcPe8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obO/dt3ARW3yhjg4ReE6NlyaVDBS9xkBm3GDZzcoAtE5QaVAezpS1xcPZxW8/3rVk++tsf42ROGTGbN1ZQ9YBRzzYSiwonsGQAU6caUaCgqfexhNc+96K0afOv05chZOfZSIg66Uk99xO7H3L9myczkIylMiV1j6LtGrbyvVinA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=IsDaowIM; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="IsDaowIM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WPRPfvQG6ypSGOYqEDbWxIl9mjC9zWWZheu5ejJRLY0=; b=IsDaowIMb7fV/f2C46F67Q4gLW
	qjnT76yeGQHSPW/K6e0nQ/0NgVN/SqpCF10F3P0PUZrjXj0wOfP1JaNGCSv3ZEQBzbhYappXVbVNq
	hKNeEHy8f75iuDagHXsIdpMfJfTBJzjTLXQ4n7MIldBpN4Dpb9P+Z9yOsIGoo9MhhqYxIoiUQ3lPo
	T/qBr/kBgZNtN/Urdc6CAgNYnb8ssH+tRcdZjHWdLRaG5DNgy0BJ1axDr5daopfpEGYJq0Chi24Qs
	5xe7/2hxYjj+2SCyOcVBBcUl6wgZiUZNGSlghbUWuRyyjDR136KVyZ8KR0YLC7fUkV/3vQMQZYVzP
	CTo9SGNw==;
Received: from 109-204-176-126.cust.valoonet.fi ([109.204.176.126] helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wp3iC-00BL5u-1C
	for connman@lists.linux.dev;
	Wed, 29 Jul 2026 15:48:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCHv2 0/9] Add conf.d support and restructure settings
Date: Wed, 29 Jul 2026 15:48:14 +0300
Message-ID: <20260729124833.74681-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
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
 Symbol: BAYES_HAM(-3.00)
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
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:109.204.176.0/22, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260729124833.74681-1-jussi.laakkonen@jolla.com
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
parser			Union for parser callbacks, contains:
	parse_str_cb		Check string value: CONF_TYPE_STR
	parse_list_cb		Parse a string list: CONF_TYPE_STRARR
	parse_uint_list_cb	Parse int list: CONF_TYPE_UINTARR
	parse_hashtable_cb	Parse a hash table: CONF_TYPE_HASHTABLE
error_cb		Error callback when check_str_cb fails
multiplier		For CONF_TYPE_UINT and CONF_TYPE_DOUBLE for correlation

The types that are currently supported for settings are: uint (CONF_TYPE_UINT),
uint* (CONF_TYPE_UINTARR), char* (CONF_TYPE_STR), char** (CONF_TYPE_STRARR),
bool (CONF_TYPE_BOOL), double/real (CONF_TYPE_DOUBLE) and GHashTable
(CONF_TYPE_HASHTABLE). The types, except uint* and GHashTable, are read with
their corresponding reading functions - the GHashTable and uint* are parsed
from char** with the defined callbacks (parse_hashtable_cb, parse_list_uint_cb).
If parse_list_strs_cb is missing the string list is saved as is to
configuration. The error_cb is useful in cases where the value needs a
complicated setup, e.g, with online check mode.

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
 v1 the original: https://github.com/LaakkonenJussi/connman_ng/pull/4
 v2 additions: https://github.com/LaakkonenJussi/connman_ng/pull/5

Changes in v2:
 Patch 0:
    - Updated the description after changes.
 Patch 6: setting.c
    - Moved all parser callbacks into an union, a new opt needs to define
      only one cb. Dropped the list item callback.
    - Fixed memory usage issues potentially causing leaked memory.
      Allocating options is now more consistent and less complex.
   - Fixed the service type and nameserver list parsing to not to clear
     the list if the new list read from config is invalid.
   - Removed the unnecessary enum for each config option.
   - Improved the commit message.
 Patch 8: test-setting.c
   - Added invalid config test for checking lists with invalid separators.

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
 src/main.c            | 1031 ++-----------------------------
 src/setting.c         | 1339 +++++++++++++++++++++++++++++++++++++++++
 src/shared/util.c     |  179 ++++++
 src/shared/util.h     |    7 +
 src/wispr.c           |    4 +-
 unit/test-setting.c   | 1147 +++++++++++++++++++++++++++++++++++
 vpn/main.c            |   15 +-
 vpn/vpn-settings.c    |   83 ++-
 vpn/vpn.h             |    4 +-
 13 files changed, 2860 insertions(+), 1022 deletions(-)
 create mode 100644 src/setting.c
 create mode 100644 unit/test-setting.c

-- 
2.47.3

