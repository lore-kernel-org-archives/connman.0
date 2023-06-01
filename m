Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2E2107B
	for <connman@lists.linux.dev>; Thu,  1 Jun 2023 14:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnuVqenVx0JMVYJlkVty9kVZuTCCAAUQQBHWN16/YBOnYBYqaPqWBnZSgOOS/TvNKcuuwbvgaUmjAMCV/VePtIFdixz6ldIqBJqUw/qwbW3yXsHwHlfq50Li/GxTTucJlafBew7r5I0v+FQ1aIRsS7MDbclaARpQ8BGqUj+MxzmfYNTcUGzfqMqrNZF0WzH9ZYFhgcgOTgnNQ3oaOl7yIlSINc53/4za5bvss6b+/vOq9WnzwGAL3r+jknHeBq6bM+I75hVe5FL3ErmZPW/6FOQJf1Ipr/op8jX5wjQxpeQhugqN4kdJEolyidf0aH1zamXXs23dhrBCH6fmU4aKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzaDCJYD3ojOouQKuqiaz55D8bRVWJQoGsNkH29Atw8=;
 b=UIKP2mz9h9oCM8nzPYQqSbY9xQQvtuZ/KFsyCEGAZ5tyUUfIlfX5LRUr8QvLdOq0Qvpd7VZkvuOOzzRxPqGMEKg23EWNiHr5nT4+RfA4IOIQXc2CCiq8TjrXDMRr360qhtnyN28HEKW/43y7rrVqt8N4GNs23XNGcr9FXToq76J/R/Gx7okPnhLC7jsWz1XhxcAUriF8VsTryAxP9MV8v1x8qLl0/2+5bWGlq9zZSBLu9VP3O+/QZHpxnIBIMjviJZZ/lngPCNufhHw8krc5pnHN9w6CqMQsa/a24xVKfpXJbT+lHhnkUblxPkJOEgK2IB8T6+2CcpU96PnVjH3e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=monom.org smtp.mailfrom=bshg.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=bshg.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bshg.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzaDCJYD3ojOouQKuqiaz55D8bRVWJQoGsNkH29Atw8=;
 b=kAJoohN3QOxn5BkBSeUq8W+g/yG3ADW/YpFsv8xGzGgcoHhxOva83hApw/punfmt2Ap/wNuYUdebHEd59buba4aLsIRp2FyD6OET3SjffE8piT9Ag1mZNV4TXLz0/+cSdsltVT5TBjoHiQwEihChUJooqjYVa0S53lxXj3ECWEimj6sOFTLFAhl3vxQeWHxN3riQSlGMjXFkdn/qeMdOXS6QhQvY0PIy7miDMa8fJUcszlIvco3SIyMSbqFoeuQZTT7GTUImoftKWNhFglNuKPwe9Rf9iRUhsI3XXqDaCiL9bfQVp3hq6hRirr5rLU5edQArLnrg7I/GpaSioP3m4Q==
Received: from DB7PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:10:36::38)
 by AS2PR10MB7685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:649::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 14:12:00 +0000
Received: from DBAEUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::a8) by DB7PR05CA0025.outlook.office365.com
 (2603:10a6:10:36::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 14:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=bshg.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bshg.com;
Received-SPF: Pass (protection.outlook.com: domain of bshg.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 DBAEUR03FT022.mail.protection.outlook.com (100.127.142.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 14:12:00 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.23; Thu, 1 Jun
 2023 16:11:59 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:58 +0200
Received: from FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) by
 FE-HUB2000.de.bosch.com (10.4.103.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:58 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:58 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) by
 FE0SWIEXMB4C.bsh.corp.bshg.com (10.49.78.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 16:11:58 +0200
Received: from FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3]) by
 FE0SWIEXMB4C.bsh.corp.bshg.com ([fe80::49c1:3bea:4800:a3b3%6]) with mapi id
 15.01.2507.023; Thu, 1 Jun 2023 16:11:58 +0200
From: "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
To: "wagi@monom.org" <wagi@monom.org>, "connman@lists.linux.dev"
	<connman@lists.linux.dev>
CC: "Ryll, Jan (GDE-EDS9)" <Jan.Ryll@bshg.com>, "Dembianny, Sven (GDE-EDSO)"
	<Sven.Dembianny@bshg.com>
Subject: [PATCH 1/1] Add connman get and remove known services methods
Thread-Topic: [PATCH 1/1] Add connman get and remove known services methods
Thread-Index: AQHZlJMGrWzFeLcJOEm2WtlqPGdgmA==
Date: Thu, 1 Jun 2023 14:11:58 +0000
Message-ID: <20230601141143.3275285-2-sven.dembianny@bshg.com>
References: <20230601141143.3275285-1-sven.dembianny@bshg.com>
In-Reply-To: <20230601141143.3275285-1-sven.dembianny@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.25.1
x-originating-ip: [10.49.85.185]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT022:EE_|AS2PR10MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d42f7ba-e794-4ab3-8815-08db62aa2af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4mvpn0+ACiLGlHoOV7QLB3o7pDqhhJJ1hEcA3p44liIzWl/4nP4VVS7EqEswN30zRXIf1OV1ToH7VDSke/MM1WIgh3gtgAu7ND1oaC35o51/ENHA1okGlAUt6N1NdSz1TT5TM5LV3ZddFPnKAa4ZXQFqYSj20e3ELCt5WKNVfZ7B4veaAWjlecg/sjerDpw+4fGvj8HcwLv6Z/2tSlRPc3hqGez7IKVMngBkzIdRR3I25fBmq/IQ/ojpwT5VFfAtSdM4xrQec3+EaIdq+M1aGEkBAlGSPX+C9TqCdEnonHkQerjVMwy/joneyFO8JSXrul7jGL2HL+WAgmFwGBi501rpdIX+iR3Vm0wwRl4J5fWTBV3JFJQXNjx5+I4QbvXt7Epm1JqTkPTLCKZESg8e4bVvpAcVR4O12hvdqE+eJC1/xwvzfQ29qbwQHon8neOWZ2uw6vI4AjrpLYSsNijSPvDrFr1NBsH55MKqR4ybhCb13xTnhegHGuQ3fYmDLyt21dYW1mVnzEfY8247y7/Glqu4b0NGahaN0OpvwFhtqxsxLzITyE62ooARqUea2Kp1ShbqDyNsS1UFUYr6p35CovzvUcfDovIXVvLaMkCG+c5bk5JT1v8+cnXlPKWtMxP4ju6GemTUIV0dYruTveYrJo7Czar5al5Q9TYHkDxmIoYNaFSw5P5DGSyYViZZtP8bz4m+G7fjrk/tt7wpk2W2aZhxOx4oJ05RJTXVBIeQXGdqmVUNJrmXqanrG/ULVCXYa4AVoAmxzSxrikriySKRxQ==
X-Forefront-Antispam-Report:
	CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(41300700001)(30864003)(5660300002)(478600001)(2906002)(82310400005)(40480700001)(8676002)(8936002)(86362001)(316002)(426003)(336012)(83380400001)(47076005)(36860700001)(36756003)(4326008)(2616005)(107886003)(70206006)(70586007)(81166007)(82960400001)(40460700003)(356005)(7696005)(82740400003)(186003)(110136005)(54906003)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: bshg.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:12:00.6529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d42f7ba-e794-4ab3-8815-08db62aa2af3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DBAEUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7685

---
 client/commands.c   | 51 ++++++++++++++++++++++++++++++++
 doc/manager-api.txt |  9 ++++++
 src/connman.h       |  2 ++
 src/manager.c       | 56 +++++++++++++++++++++++++++++++++++
 src/service.c       | 70 ++++++++++++++++++++++++++++++++++++++++++++
 tools/manager-api.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 259 insertions(+)

diff --git a/client/commands.c b/client/commands.c
index 53cc14c8..4b1212ca 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -420,6 +420,53 @@ static int cmd_services(char *args[], int num, struct =
connman_option *options)
 			object_properties, path, NULL, NULL);
 }
=20
+static int cmd_known_services(char *args[], int num, struct connman_option=
 *options)
+{
+	if (num > 1)
+		return -E2BIG;
+
+	return __connmanctl_dbus_method_call(connection, CONNMAN_SERVICE, CONNMAN=
_PATH,
+					"net.connman.Manager", "GetKnownServices",
+					services_list, NULL, NULL, NULL);
+}
+
+static int remove_known_service_return(DBusMessageIter *iter, const char *=
error,
+		void *user_data)
+{
+	char *path =3D user_data;
+
+	if (!error) {
+		char *str =3D strrchr(path, '/');
+		str++;
+		fprintf(stdout, "Removed %s\n", str);
+	} else
+		fprintf(stderr, "Error %s: %s\n", path, error);
+
+	g_free(user_data);
+
+	return 0;
+}
+
+static int cmd_remove_known_service(char *args[], int num, struct connman_=
option *options)
+{
+	char *path_of_service_to_remove;
+
+	if (num > 2)
+		return -E2BIG;
+
+	if (num < 2)
+		return -EINVAL;
+
+	if (check_dbus_name(args[1]) =3D=3D false)
+		return -EINVAL;
+
+	path_of_service_to_remove =3D g_strdup_printf("%s", args[1]);
+
+	return __connmanctl_dbus_method_call(connection, CONNMAN_SERVICE,
+			CONNMAN_PATH, "net.connman.Manager", "RemoveKnownService",
+			remove_known_service_return, path_of_service_to_remove, NULL, NULL);
+}
+
 static int cmd_peers(char *args[], int num, struct connman_option *options=
)
 {
 	char *peer_name =3D NULL;
@@ -2808,6 +2855,10 @@ static const struct {
 	  "Display tethering clients", NULL },
 	{ "services",     "[<service>]",  service_options, cmd_services,
 	  "Display services", lookup_service_arg },
+	{ "known-services", NULL,         NULL,            cmd_known_services,
+	  "Display known services", NULL },
+	{ "remove-known-service", "<service>", NULL,       cmd_remove_known_servi=
ce,
+	 "Remove known service", NULL },
 	{ "peers",        "[peer]",       NULL,            cmd_peers,
 	  "Display peers", lookup_peer_arg },
 	{ "scan",         "<technology>", NULL,            cmd_scan,
diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 6eaa0a38..9cc3fb17 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -80,6 +80,15 @@ Methods		dict GetProperties()
=20
 			Remove a VPN specified by the object path.
=20
+		array{object,dict} GetKnownServices()
+
+			Returns a sorted list of tuples with known service
+			object path and dictionary of service properties.
+
+		void RemoveKnownService(object path)
+
+			Remove a Known Service specified by the object path.
+
 		void RegisterAgent(object path)
=20
 			Register new agent for handling user requests.
diff --git a/src/connman.h b/src/connman.h
index b955d98b..1ac6b5db 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -686,6 +686,7 @@ int __connman_service_move(struct connman_service *serv=
ice,
 				struct connman_service *target, bool before);
 int __connman_service_load_modifiable(struct connman_service *service);
=20
+void __connman_known_service_list_struct(DBusMessageIter *iter);
 void __connman_service_list_struct(DBusMessageIter *iter);
=20
 int __connman_service_compare(const struct connman_service *a,
@@ -755,6 +756,7 @@ int __connman_service_disconnect(struct connman_service=
 *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason re=
ason);
 bool __connman_service_remove(struct connman_service *service);
+bool __connman_service_remove_known_service(const char *path);
 bool __connman_service_is_provider_pending(struct connman_service *service=
);
 void __connman_service_set_provider_pending(struct connman_service *servic=
e,
 							DBusMessage *msg);
diff --git a/src/manager.c b/src/manager.c
index 892d3a42..ca4a01b5 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -175,6 +175,11 @@ static const struct connman_notifier technology_notifi=
er =3D {
 	.idle_state	=3D idle_state,
 };
=20
+static void append_known_service_structs(DBusMessageIter *iter, void *user=
_data)
+{
+	__connman_known_service_list_struct(iter);
+}
+
 static void append_service_structs(DBusMessageIter *iter, void *user_data)
 {
 	__connman_service_list_struct(iter);
@@ -195,6 +200,51 @@ static DBusMessage *get_services(DBusConnection *conn,
 	return reply;
 }
=20
+static DBusMessage *get_known_services(DBusConnection *conn,
+				   DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	__connman_dbus_append_objpath_dict_array(reply,
+				 append_known_service_structs, NULL);
+
+	return reply;
+}
+
+static DBusMessage *remove_known_service(DBusConnection *conn,
+				   DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *path;
+	int err;
+	char *str =3D strrchr(path, '/');
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID);
+
+	if(!str)
+		return __connman_error_failed(msg, -ENOENT);
+
+	str++;
+	if(!strlen(str) > 0)
+		return __connman_error_failed(msg, -ENOENT);
+
+	DBG("Service to remove [%s]", str);
+
+	if (!__connman_service_remove_known_service(str))
+		return __connman_error_failed(msg, -ENOENT);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static void append_peer_structs(DBusMessageIter *iter, void *user_data)
 {
 	__connman_peer_list_struct(iter);
@@ -534,6 +584,12 @@ static const GDBusMethodTable manager_methods[] =3D {
 	{ GDBUS_DEPRECATED_METHOD("RemoveProvider",
 			GDBUS_ARGS({ "provider", "o" }), NULL,
 			remove_provider) },
+	{ GDBUS_METHOD("GetKnownServices",
+			NULL, GDBUS_ARGS({"knownServices", "a(oa{sv})" }),
+			get_known_services) },
+	{ GDBUS_METHOD("RemoveKnownService",
+			GDBUS_ARGS({ "path", "o" }), NULL,
+			remove_known_service) },
 	{ GDBUS_METHOD("GetServices",
 			NULL, GDBUS_ARGS({ "services", "a(oa{sv})" }),
 			get_services) },
diff --git a/src/service.c b/src/service.c
index 06d02322..5ca7c307 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2712,6 +2712,71 @@ static void append_struct(gpointer value, gpointer u=
ser_data)
 	append_struct_service(iter, append_dict_properties, service);
 }
=20
+void __connman_known_service_list_struct(DBusMessageIter *iter)
+{
+	struct connman_service *service =3D NULL;
+	gchar **services =3D NULL;
+	gchar **serviceid_parts =3D NULL;
+	int i =3D 0;
+
+	DBG("");
+
+	services =3D connman_storage_get_services();
+	if (!services)
+		return;
+
+	for (i =3D 0; i < g_strv_length(services); i++) {
+		service =3D connman_service_create();
+
+		if (!service) {
+			connman_error("connman_service_create() allocation failed");
+			return ;
+		}
+
+		service->identifier =3D g_strdup(services[i]);
+		serviceid_parts =3D g_strsplit(services[i], "_", -1);
+
+		if (!serviceid_parts) {
+			g_free(service);
+			g_strfreev(services);
+			return
+		}
+
+		service->type =3D __connman_service_string2type(serviceid_parts[0]);
+		service->path =3D
+			g_strdup_printf("%s/service/%s", CONNMAN_PATH, service->identifier);
+
+		if (service->type =3D=3D CONNMAN_SERVICE_TYPE_WIFI)
+			service->security =3D
+				__connman_service_string2security(serviceid_parts[g_strv_length(servic=
eid_parts) - 1]);
+
+		if (service->path) {
+			if (find_service(service->path))
+				service->state =3D (find_service(service->path))->state;
+
+			if (service->type =3D=3D
+					CONNMAN_SERVICE_TYPE_ETHERNET &&
+				find_service(service->path))
+
+				service->name =3D (find_service(service->path))->name;
+
+			if (0 !=3D service_load(service)) {
+				connman_error("service_load() returned error");
+				g_free(service);
+				g_strfreev(serviceid_parts);
+				g_strfreev(services);
+				return;
+			}
+
+			append_struct_service(iter, append_dict_properties, service);
+		}
+
+		g_strfreev(serviceid_parts);
+	}
+
+	g_strfreev(services);
+}
+
 void __connman_service_list_struct(DBusMessageIter *iter)
 {
 	g_list_foreach(service_list, append_struct, iter);
@@ -4686,6 +4751,11 @@ bool __connman_service_remove(struct connman_service=
 *service)
 	return true;
 }
=20
+bool __connman_service_remove_known_service(const char *path)
+{
+	return __connman_storage_remove_service(path);
+}
+
 static DBusMessage *remove_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
diff --git a/tools/manager-api.c b/tools/manager-api.c
index e082962d..c62168bd 100644
--- a/tools/manager-api.c
+++ b/tools/manager-api.c
@@ -64,6 +64,77 @@ static DBusMessage *set_property(DBusConnection *connect=
ion,
 	return reply;
 }
=20
+DBusMessage *manager_get_known_services(DBusConnection *connection)
+{
+	DBusMessage *message, *reply;
+	DBusError error;
+
+	message =3D dbus_message_new_method_call(CONNMAN_SERVICE, CONNMAN_MANAGER=
_PATH,
+						CONNMAN_MANAGER_INTERFACE, "GetKnownServices");
+
+	if (!message)
+		return NULL;
+
+	dbus_error_init(&error);
+
+	reply =3D dbus_connection_send_with_reply_and_block(connection,
+				  message, -1, &error);
+	if (!reply) {
+		if (dbus_error_is_set(&error)) {
+			LOG("%s", error.message);
+			dbus_error_free(&error);
+		}
+		else
+			LOG("Failed to get known services");
+
+		dbus_message_unref(message);
+		return NULL;
+	}
+
+	dbus_message_unref(message);
+
+	return reply;
+}
+
+DBusMessage *manager_remove_known_service(DBusConnection *connection,
+								const char *service_path)
+{
+	DBusMessage *message, *reply;
+	DBusError error;
+	DBusMessageIter array;
+
+	DBG("Service path to remove [%s]", service_path);
+
+	message =3D dbus_message_new_method_call(CONNMAN_SERVICE, CONNMAN_MANAGER=
_PATH,
+						CONNMAN_MANAGER_INTERFACE, "RemoveKnownService");
+
+	if (!message)
+		return NULL;
+
+	dbus_error_init(&error);
+	dbus_message_iter_init_append(message, &array);
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_OBJECT_PATH,
+				&service_path);
+	reply =3D dbus_connection_send_with_reply_and_block(connection,
+				  message, -1, &error);
+
+	if (!reply) {
+		if (dbus_error_is_set(&error)) {
+			LOG("%s", error.message);
+			dbus_error_free(&error);
+		}
+		else
+			LOG("Failed to get known services");
+
+		dbus_message_unref(message);
+		return NULL;
+	}
+
+	dbus_message_unref(message);
+
+	return reply;
+}
+
 DBusMessage *manager_get_services(DBusConnection *connection)
 {
 	DBusMessage *message, *reply;
--=20
2.25.1
