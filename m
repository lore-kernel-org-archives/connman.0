Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B31361
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E6F6F73166;
	Thu, 19 Oct 2023 20:48:58 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5907673315;
	Thu, 19 Oct 2023 20:48:58 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Update on Chasing Down a Crash in connman_service_get_nameservers
 on Cellular Service Removal
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <E50A909D-122E-4D14-A330-868A8EF9997F@nuovations.com>
Date: Thu, 19 Oct 2023 17:48:57 -0700
Cc: Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6BF0A08-CDFA-4CF4-A373-B130605030C0@nuovations.com>
References: <E50A909D-122E-4D14-A330-868A8EF9997F@nuovations.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Oct 18, 2023, at 8:00 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> I know some of you (Denis, I believe from git log history) are working =
on clang static and dynamic analysis for connman.
>=20
> To the extent it helps, I have been chasing down an issue in =
top-of-tree (53964711baee916ae163e64d5229e3822935e100) in which when =
Quectel / Nimblelink QMI cellular goes away on my system, I get a =
connman signal 11 abort. Unfortunately, there is no backtrace in this =
case since n_ptrs (0) is less than offset (2) in the print_backtrace =
call.
>=20
> Today, doing some other development and debug work, I was able to =
narrow down the downstream cause of the abort. It seems that things are =
crashing somewhere within =
src/service.c:connman_service_get_nameservers().
>=20
> When name servers are established for the cellular service from the =
provider, there end up being two (2) name servers. The core problem =
seems to be that g_strv_length(service->nameservers) incorrectly returns =
7 (it really only has two (2)) which results in:
>=20
> 		for (i =3D 0; i < len; i++)
> 			nameservers[i] =3D =
g_strdup(service->nameservers[i]);
>=20
> attempting to copy strings that do not exist past the end of the =
actual bounds of service->nameservers. So, it would seem that at some =
point, service->nameservers becomes corrupt with its terminating null =
getting overwritten by something else. I=E2=80=99ve get to zero in on =
the nature of =E2=80=9Cgetting overwritten by something else=E2=80=9D.
>=20
> I also periodically get this in the output after an abort:
>=20
>    malloc(): smallbin double linked list corrupted
>=20
> I am also able to cause the abort, nearly on demand with near 100% =
reproducibility, by issuing =E2=80=98connmanctl disable cellular=E2=80=99.=

>=20
> More as I learn and discover it.

I configured connman as follows:

% configure --disable-bluetooth --disable-debug --disable-dundee =
--disable-gadget --disable-hh2serial-gps --disable-iospm --disable-iwd =
--disable-l2tp --disable-neard --disable-nmcompat --disable-openconnect =
--disable-optimization --disable-pacrunner --disable-polkit =
--disable-pptp --disable-selinux --disable-session-policy-local =
--disable-test --disable-tools --disable-tist --disable-vpnc =
--disable-wireguard --disable-wispr --enable-client --enable-datafiles =
--enable-ethernet --enable-loopback --enable-ofono --enable-openvpn =
--enable-stats --enable-wifi --with-dns-backend=3Dinternal =
--with-firewall=3Dnftables --with-openvpn=3D/usr/sbin/openvpn =
--with-systemdunitdir=3D"" --prefix=3D/usr --sysconfdir=3D/etc =
--localstatedir=3D/var

and then ran clang/LLVM scan-build-11 on it and yielding the following =
60 potential issues. I=E2=80=99ll dive in on the most promising leads =
relative to the corruption / failures I am seeing.

% scan-build-11 --status-bugs -v make
scan-build: Using '/usr/lib/llvm-11/bin/clang' for static analysis
scan-build: Emitting reports for this run to =
'/tmp/scan-build-2023-10-19-172229-1594519-1'.
  GEN      include/connman/log.h
  GEN      include/connman/plugin.h
  GEN      include/connman/notifier.h
  GEN      include/connman/service.h
  GEN      include/connman/resolver.h
  GEN      include/connman/ipconfig.h
  GEN      include/connman/device.h
  GEN      include/connman/network.h
  GEN      include/connman/inet.h
  GEN      include/connman/storage.h
  GEN      include/connman/provision.h
  GEN      include/connman/session.h
  GEN      include/connman/ipaddress.h
  GEN      include/connman/agent.h
  GEN      include/connman/inotify.h
  GEN      include/connman/peer.h
  GEN      include/connman/machine.h
  GEN      include/connman/acd.h
  GEN      include/connman/tethering.h
  GEN      include/connman/version.h
  GEN      include/connman/rtnl.h
  GEN      include/connman/task.h
  GEN      include/connman/dbus.h
  GEN      include/connman/provider.h
  GEN      include/connman/vpn-dbus.h
  GEN      include/connman/utsname.h
  GEN      include/connman/timeserver.h
  GEN      include/connman/proxy.h
  GEN      include/connman/technology.h
  GEN      include/connman/setting.h
  GEN      include/connman/backtrace.h
  GEN      src/builtin.h
  GEN      src/connman.service
  GEN      src/net.connman.service
  GEN      vpn/connman-vpn.service
  GEN      vpn/net.connman.vpn.service
  GEN      src/connman-wait-online.service
  GEN      scripts/connman
  GEN      scripts/connman_resolvconf.conf
  GEN      vpn/builtin.h
make --no-print-directory all-am
  CC       client/dbus_helpers.o
  CC       client/services.o
  CC       client/commands.o
../client/commands.c:2146:5: warning: Value stored to 'res' is never =
read [deadcode.DeadStores]
                                res =3D -EINVAL;
                                ^     ~~~~~~~
1 warning generated.
  CC       client/input.o
  CC       client/agent.o
  CC       client/peers.o
  CC       client/tethering.o
  CC       client/vpnconnections.o
  CC       client/main.o
  CC       gdbus/mainloop.lo
  CC       gdbus/watch.lo
../gdbus/watch.c:238:3: warning: Attempt to free released memory =
[unix.Malloc]
                g_free(l->data);
                ^~~~~~~~~~~~~~~
1 warning generated.
  CC       gdbus/object.lo
  CC       gdbus/client.lo
  CC       gdbus/polkit.lo
  CCLD     gdbus/libgdbus-internal.la
  CCLD     client/connmanctl
  CC       src/backtrace.o
  CC       src/log.o
  CC       src/dbus.o
  CC       src/error.o
  CC       src/ippool.o
  CC       unit/test-ippool.o
  CCLD     unit/test-ippool
  CC       gdhcp/src_connmand-common.o
  CC       gdhcp/src_connmand-client.o
../gdhcp/client.c:2050:4: warning: Value stored to 'i' is never read =
[deadcode.DeadStores]
                        i +=3D sizeof(addr);
                        ^    ~~~~~~~~~~~~
../gdhcp/client.c:2378:7: warning: Dereference of null pointer (loaded =
from variable 'message_type') [core.NullDereference]
                if (*message_type !=3D DHCPOFFER)
                    ^~~~~~~~~~~~~
../gdhcp/client.c:2433:7: warning: Dereference of null pointer (loaded =
from variable 'message_type') [core.NullDereference]
                if (*message_type =3D=3D DHCPACK) {
                    ^~~~~~~~~~~~~
../gdhcp/client.c:2478:7: warning: Access to field 'message' results in =
a dereference of a null pointer (loaded from variable 'packet6') =
[core.NullDereference]
                if (packet6->message !=3D DHCPV6_REPLY &&
                    ^~~~~~~~~~~~~~~~
../gdhcp/client.c:2562:7: warning: Access to field 'message' results in =
a dereference of a null pointer (loaded from variable 'packet6') =
[core.NullDereference]
                if (packet6->message !=3D DHCPV6_REPLY)
                    ^~~~~~~~~~~~~~~~
5 warnings generated.
  CC       gdhcp/src_connmand-server.o
  CC       gweb/src_connmand-gweb.o
../gweb/gweb.c:630:4: warning: 2nd function call argument is an =
uninitialized value [core.CallAndMessage]
                        g_string_append_len(buf, (char *) body, length);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
  CC       gweb/src_connmand-gresolv.o
../gweb/gresolv.c:147:8: warning: Access to field 'resolv' results in a =
dereference of a null pointer (loaded from variable 'query') =
[core.NullDereference]
        debug(query->resolv, "query %p timeout %d", query, =
query->timeout);
              ^~~~~~~~~~~~~
../gweb/gresolv.c:122:9: note: expanded from macro 'debug'
        _debug(resolv, __FILE__, __func__, format, ## arg)
               ^~~~~~
1 warning generated.
  CC       gweb/src_connmand-gionotls.o
  CC       src/connmand-stats.o
../src/stats.c:238:2: warning: Argument to g_free() is the address of =
the local variable '_history_file', which is not memory allocated by =
malloc() [unix.Malloc]
        g_free(file);
        ^~~~~~~~~~~~
1 warning generated.
  CC       src/connmand-backtrace.o
  CC       plugins/src_connmand-loopback.o
  CC       plugins/src_connmand-ethernet.o
  CC       plugins/src_connmand-wifi.o
../plugins/wifi.c:491:4: warning: Null pointer passed to 2nd parameter =
expecting 'nonnull' [core.NonNullParamChecker]
                        memcpy(params->service, spec, spec_length);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../plugins/wifi.c:495:3: warning: Null pointer passed to 2nd parameter =
expecting 'nonnull' [core.NonNullParamChecker]
                memcpy(params->query, query, query_length);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../plugins/wifi.c:499:3: warning: Null pointer passed to 2nd parameter =
expecting 'nonnull' [core.NonNullParamChecker]
                memcpy(params->response, spec, spec_length);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../plugins/wifi.c:504:4: warning: Null pointer passed to 2nd parameter =
expecting 'nonnull' [core.NonNullParamChecker]
                        memcpy(params->wfd_ies, spec, spec_length);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../plugins/wifi.c:3387:10: warning: Potential leak of memory pointed to =
by 'ap' [unix.Malloc]
                return NULL;
                       ^~~~
/usr/lib/llvm-11/lib/clang/11.0.0/include/stddef.h:89:24: note: expanded =
from macro 'NULL'
#  define NULL ((void*)0)
                       ^
5 warnings generated.
  CC       gsupplicant/src_connmand-supplicant.o
../gsupplicant/supplicant.c:2140:3: warning: Potential leak of memory =
pointed to by 'bss' [unix.Malloc]
                return;
                ^~~~~~
1 warning generated.
  CC       gsupplicant/src_connmand-dbus.o
  CC       plugins/src_connmand-ofono.o
  CC       plugins/src_connmand-vpn.o
../plugins/vpn.c:439:16: warning: Null pointer passed to 1st parameter =
expecting 'nonnull' [core.NonNullParamChecker]
                prefix_len =3D atoi(netmask);
                             ^~~~~~~~~~~~~
../plugins/vpn.c:475:12: warning: Potential leak of memory pointed to by =
'nameservers' [unix.Malloc]
                        return -ENOMEM;
                                ^~~~~~
/usr/include/asm-generic/errno-base.h:16:17: note: expanded from macro =
'ENOMEM'
#define ENOMEM          12      /* Out of memory */
                        ^~
2 warnings generated.
  CC       src/shared/connmand-util.o
  CC       src/shared/connmand-arp.o
  CC       src/connmand-main.o
  CC       src/connmand-log.o
  CC       src/connmand-error.o
  CC       src/connmand-plugin.o
  CC       src/connmand-task.o
  CC       src/connmand-device.o
  CC       src/connmand-network.o
  CC       src/connmand-connection.o
  CC       src/connmand-manager.o
  CC       src/connmand-service.o
../src/service.c:3122:13: warning: Potential leak of memory pointed to =
by 'servers' [unix.Malloc]
                                return -ENOMEM;
                                        ^~~~~~
/usr/include/asm-generic/errno-base.h:16:17: note: expanded from macro =
'ENOMEM'
#define ENOMEM          12      /* Out of memory */
                        ^~
1 warning generated.
  CC       src/connmand-clock.o
  CC       src/connmand-timezone.o
  CC       src/connmand-agent-connman.o
  CC       src/connmand-agent.o
../src/agent.c:139:7: warning: Access to field 'msg' results in a =
dereference of a null pointer (loaded from field 'pending') =
[core.NullDereference]
        if (!agent->pending->msg)
             ^~~~~~~~~~~~~~~~~~~
1 warning generated.
  CC       src/connmand-notifier.o
  CC       src/connmand-provider.o
  CC       src/connmand-resolver.o
  CC       src/connmand-ipconfig.o
../src/ipconfig.c:353:11: warning: Assigned value is garbage or =
undefined [core.uninitialized.Assign]
                enabled =3D !disabled;
                        ^ ~~~~~~~~~
../src/ipconfig.c:377:2: warning: Undefined or garbage value returned to =
caller [core.uninitialized.UndefReturn]
        return value;
        ^~~~~~~~~~~~
../src/ipconfig.c:401:2: warning: Undefined or garbage value returned to =
caller [core.uninitialized.UndefReturn]
        return value;
        ^~~~~~~~~~~~
3 warnings generated.
  CC       src/connmand-detect.o
  CC       src/connmand-inet.o
  CC       src/connmand-dhcp.o
  CC       src/connmand-dhcpv6.o
../src/dhcpv6.c:946:3: warning: Use of memory after it is freed =
[unix.Malloc]
                ref_own_address(user_data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
../src/dhcpv6.c:2087:4: warning: Undefined or garbage value returned to =
caller [core.uninitialized.UndefReturn]
                        return err;
                        ^~~~~~~~~~
../src/dhcpv6.c:2529:3: warning: Undefined or garbage value returned to =
caller [core.uninitialized.UndefReturn]
                return ret;
                ^~~~~~~~~~
3 warnings generated.
  CC       src/connmand-rtnl.o
../src/rtnl.c:616:7: warning: The left operand of '&' is a garbage value =
[core.UndefinedBinaryOperatorResult]
                if (IN6_IS_ADDR_LINKLOCAL(&ipv6_address))
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/netinet/in.h:430:36: note: expanded from macro =
'IN6_IS_ADDR_LINKLOCAL'
      (__a->__in6_u.__u6_addr32[0] & htonl (0xffc00000)) =3D=3D htonl =
(0xfe800000); }))
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
../src/rtnl.c:656:7: warning: The left operand of '&' is a garbage value =
[core.UndefinedBinaryOperatorResult]
                if (IN6_IS_ADDR_LINKLOCAL(&ipv6_address))
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/netinet/in.h:430:36: note: expanded from macro =
'IN6_IS_ADDR_LINKLOCAL'
      (__a->__in6_u.__u6_addr32[0] & htonl (0xffc00000)) =3D=3D htonl =
(0xfe800000); }))
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
../src/rtnl.c:855:3: warning: Value stored to 'addr' is never read =
[deadcode.DeadStores]
                addr =3D *((struct in_addr *) RTA_DATA(attr));
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.
  CC       src/connmand-proxy.o
  CC       src/connmand-utsname.o
  CC       src/connmand-timeserver.o
  CC       src/connmand-rfkill.o
  CC       src/connmand-storage.o
  CC       src/connmand-dbus.o
  CC       src/connmand-config.o
../src/config.c:1723:14: warning: Branch condition evaluates to a =
garbage value [core.uninitialized.Branch]
        for (i =3D 0; entries[i]; i++) {
                    ^~~~~~~~~~
1 warning generated.
  CC       src/connmand-technology.o
  CC       src/connmand-counter.o
  CC       src/connmand-ntp.o
  CC       src/connmand-session.o
  CC       src/connmand-tethering.o
  CC       src/connmand-wpad.o
  CC       src/connmand-wispr.o
../src/wispr.c:775:3: warning: Use of memory after it is freed =
[unix.Malloc]
                wispr_portal_context_ref(wp_context);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:102:2: note: expanded from macro =
'wispr_portal_context_ref'
        wispr_portal_context_ref_debug(wp_context, __FILE__, __LINE__, =
__func__)
        =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:781:7: warning: Use of memory after it is freed =
[unix.Malloc]
                if (wp_context->wispr_msg.message_type >=3D 0)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:805:4: warning: Use of memory after it is freed =
[unix.Malloc]
                        wispr_portal_context_ref(wp_context);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:102:2: note: expanded from macro =
'wispr_portal_context_ref'
        wispr_portal_context_ref_debug(wp_context, __FILE__, __LINE__, =
__func__)
        =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:814:28: warning: Use of memory after it is freed =
[unix.Malloc]
                wp_context->redirect_url =3D g_strdup(redirect);
                ~~~~~~~~~~~~~~~~~~~~~~~~ ^
../src/wispr.c:824:34: warning: Use of memory after it is freed =
[unix.Malloc]
                __connman_service_online_check(wp_context->service,
                                               ^~~~~~~~~~~~~~~~~~~
../src/wispr.c:829:3: warning: Use of memory after it is freed =
[unix.Malloc]
                wispr_portal_context_ref(wp_context);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:102:2: note: expanded from macro =
'wispr_portal_context_ref'
        wispr_portal_context_ref_debug(wp_context, __FILE__, __LINE__, =
__func__)
        =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:838:2: warning: Use of memory after it is freed =
[unix.Malloc]
        free_wispr_routes(wp_context);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:841:37: warning: Use of memory after it is freed =
[unix.Malloc]
        wp_context->wispr_msg.message_type =3D -1;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
../src/wispr.c:901:2: warning: Use of memory after it is freed =
[unix.Malloc]
        wispr_portal_context_unref(wp_context);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/wispr.c:104:2: note: expanded from macro =
'wispr_portal_context_unref'
        wispr_portal_context_unref_debug(wp_context, __FILE__, __LINE__, =
__func__)
        =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=

9 warnings generated.
  CC       src/connmand-6to4.o
  CC       src/connmand-ippool.o
  CC       src/connmand-bridge.o
  CC       src/connmand-nat.o
  CC       src/connmand-ipaddress.o
  CC       src/connmand-inotify.o
  CC       src/connmand-ipv6pd.o
  CC       src/connmand-peer.o
../src/peer.c:584:4: warning: Value stored to 'err' is never read =
[deadcode.DeadStores]
                        err =3D -EINVAL;
                        ^     ~~~~~~~
../src/peer.c:590:3: warning: Value stored to 'err' is never read =
[deadcode.DeadStores]
                err =3D -EINVAL;
                ^     ~~~~~~~
2 warnings generated.
  CC       src/connmand-peer_service.o
  CC       src/connmand-machine.o
  CC       src/connmand-util.o
  CC       src/connmand-acd.o
  CC       src/connmand-dnsproxy.o
../src/dnsproxy.c:2239:12: warning: Potential leak of memory pointed to =
by 'reply' [unix.Malloc]
                        return -ENOMEM;
                                ^~~~~~
/usr/include/asm-generic/errno-base.h:16:17: note: expanded from macro =
'ENOMEM'
#define ENOMEM          12      /* Out of memory */
                        ^~
1 warning generated.
  CC       src/connmand-firewall-nftables.o
../src/firewall-nftables.c:520:8: warning: 1st function call argument is =
an uninitialized value [core.CallAndMessage]
        err =3D rule_cmd(nl, rule, NFT_MSG_DELRULE, NFPROTO_IPV4,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:640:15: warning: 1st function call argument =
is an uninitialized value [core.CallAndMessage]
        err =3D rule_cmd(nl, rule, NFT_MSG_NEWRULE, NFPROTO_IPV4,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:645:2: warning: 1st function call argument is =
an uninitialized value [core.CallAndMessage]
        mnl_socket_close(nl);
        ^~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:733:15: warning: 1st function call argument =
is an uninitialized value [core.CallAndMessage]
        err =3D rule_cmd(nl, rule, NFT_MSG_NEWRULE, NFPROTO_IPV4,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:738:2: warning: 1st function call argument is =
an uninitialized value [core.CallAndMessage]
        mnl_socket_close(nl);
        ^~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:899:9: warning: 1st function call argument is =
an uninitialized value [core.CallAndMessage]
                err =3D rule_cmd(nl, rule, NFT_MSG_NEWRULE, =
NFPROTO_IPV4,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:912:9: warning: 1st function call argument is =
an uninitialized value [core.CallAndMessage]
                err =3D rule_cmd(nl, rule, NFT_MSG_NEWRULE, =
NFPROTO_IPV4,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:919:2: warning: 1st function call argument is =
an uninitialized value [core.CallAndMessage]
        mnl_socket_close(nl);
        ^~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:1000:15: warning: 1st function call argument =
is an uninitialized value [core.CallAndMessage]
        err =3D table_cmd(nl, table, NFT_MSG_NEWTABLE, NFPROTO_IPV4,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:1065:2: warning: 1st function call argument =
is an uninitialized value [core.CallAndMessage]
        mnl_socket_close(nl);
        ^~~~~~~~~~~~~~~~~~~~
../src/firewall-nftables.c:1090:8: warning: 1st function call argument =
is an uninitialized value [core.CallAndMessage]
        err =3D table_cmd(nl, table, NFT_MSG_DELTABLE, NFPROTO_IPV4, =
NLM_F_ACK);
              =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
11 warnings generated.
  CCLD     src/connmand
  CC       src/connmand-wait-online.o
  CCLD     src/connmand-wait-online
  CC       vpn/plugins/connman_vpnd-vpn.o
../vpn/plugins/vpn.c:468:12: warning: Potential leak of memory pointed =
to by 'list' [unix.Malloc]
        *gid_list =3D list;
        ~~~~~~~~~~^~~~~~
../vpn/plugins/vpn.c:503:3: warning: Potential leak of memory pointed to =
by 'gid_list' [unix.Malloc]
                connman_error("error setting gid list %s", =
strerror(errno));
                ^~~~~~~~~~~~~
2 warnings generated.
  CC       src/vpn_connman_vpnd-backtrace.o
  CC       gweb/vpn_connman_vpnd-gweb.o
../gweb/gweb.c:630:4: warning: 2nd function call argument is an =
uninitialized value [core.CallAndMessage]
                        g_string_append_len(buf, (char *) body, length);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
  CC       gweb/vpn_connman_vpnd-gresolv.o
../gweb/gresolv.c:147:8: warning: Access to field 'resolv' results in a =
dereference of a null pointer (loaded from variable 'query') =
[core.NullDereference]
        debug(query->resolv, "query %p timeout %d", query, =
query->timeout);
              ^~~~~~~~~~~~~
../gweb/gresolv.c:122:9: note: expanded from macro 'debug'
        _debug(resolv, __FILE__, __func__, format, ## arg)
               ^~~~~~
1 warning generated.
  CC       gweb/vpn_connman_vpnd-gionotls.o
  CC       vpn/connman_vpnd-main.o
  CC       src/vpn_connman_vpnd-log.o
  CC       src/vpn_connman_vpnd-error.o
  CC       src/vpn_connman_vpnd-plugin.o
  CC       src/vpn_connman_vpnd-task.o
  CC       vpn/connman_vpnd-vpn-manager.o
  CC       vpn/connman_vpnd-vpn-provider.o
  CC       vpn/connman_vpnd-vpn-ipconfig.o
  CC       src/vpn_connman_vpnd-inet.o
  CC       vpn/connman_vpnd-vpn-rtnl.o
../vpn/vpn-rtnl.c:549:3: warning: Value stored to 'addr' is never read =
[deadcode.DeadStores]
                addr =3D *((struct in_addr *) RTA_DATA(attr));
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
  CC       src/vpn_connman_vpnd-dbus.o
  CC       src/vpn_connman_vpnd-storage.o
  CC       src/vpn_connman_vpnd-ipaddress.o
  CC       src/vpn_connman_vpnd-agent.o
../src/agent.c:139:7: warning: Access to field 'msg' results in a =
dereference of a null pointer (loaded from field 'pending') =
[core.NullDereference]
        if (!agent->pending->msg)
             ^~~~~~~~~~~~~~~~~~~
1 warning generated.
  CC       vpn/connman_vpnd-vpn-agent.o
  CC       src/vpn_connman_vpnd-inotify.o
  CC       vpn/connman_vpnd-vpn-config.o
  CC       vpn/connman_vpnd-vpn-settings.o
  CC       vpn/connman_vpnd-vpn-util.o
  CCLD     vpn/connman-vpnd
  CC       scripts/openvpn-script.o
  CCLD     scripts/openvpn-script
  CC       vpn/plugins/openvpn_la-openvpn.lo
../vpn/plugins/openvpn.c:131:36: warning: Access to field =
'failed_attempts_privatekey' results in a dereference of a null pointer =
(loaded from variable 'data') [core.NullDereference]
                data->failed_attempts_privatekey =3D 0;
                ~~~~                             ^
1 warning generated.
  CCLD     vpn/plugins/openvpn.la
  GEN      doc/connmanctl.1
  GEN      doc/connman.conf.5
  GEN      doc/connman-service.config.5
  GEN      doc/connman-vpn.conf.5
  GEN      doc/connman-vpn-provider.config.5
  GEN      doc/connman.8
  GEN      doc/connman-vpn.8
  GEN      src/connman.conf
  GEN      vpn/connman-vpn-dbus.conf
scan-build: Analysis run complete.
scan-build: 60 bugs found.
scan-build: Run 'scan-view /tmp/scan-build-2023-10-19-172229-1594519-1' =
to examine bug reports.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

