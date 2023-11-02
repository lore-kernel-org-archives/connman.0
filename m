Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB91CF8C
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D8DB0731A6
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 19:10:39 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A3D36731B3
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 19:10:39 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] service: Document service compare and sort functions.
Message-Id: <46D3640C-0231-40BE-9192-7219A8A0502A@nuovations.com>
Date: Thu, 2 Nov 2023 16:10:38 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the service compare and sort functions.
---
 src/service.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/src/service.c b/src/service.c
index 9c77be08..919621b9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5443,6 +5443,33 @@ static gint service_compare_vpn(const struct =
connman_service *a,
 	return service_compare(transport, service);
 }
=20
+/**
+ *  @brief
+ *    Compare two network services against the @a
+ *    PreferredTechnologies priority list.
+ *
+ *  This compares the two specified network services, by their
+ *  technology type, against the @a PreferredTechnologies priority
+ *  list.
+ *
+ *  @param[in]  service_a  A pointer to the first immutable service
+ *                         to compare by its technology type with the
+ *                         @a PreferredTechnologies priority list.
+ *  @param[in]  service_b  A pointer to the second immutable service
+ *                         to compare by its technology type with the
+ *                         @a PreferredTechnologies priority list.
+ *
+ *  @retval   0  If the @a PreferredTechnologies configuration is empty
+ *               or if neither service type matches a technology type
+ *               in the @a PreferredTechnologies list.
+ *  @retval  -1  If @a service_a type matches a technology type
+ *               in the @a PreferredTechnologies list and should sort
+ *               @b before @a service_b.
+ *  @retval   1  If @a service_b type matches a technology type
+ *               in the @a PreferredTechnologies list and should sort
+ *               @b before @a service_a.
+ *
+ */
 static gint service_compare_preferred(const struct connman_service =
*service_a,
 					const struct connman_service =
*service_b)
 {
@@ -5462,6 +5489,33 @@ static gint service_compare_preferred(const =
struct connman_service *service_a,
 	return 0;
 }
=20
+/**
+ *  @brief
+ *    Compare two network services against one another.
+ *
+ *  This compares the two specified network services.
+ *
+ *  Services are compared with the following sort criteria:
+ *
+ *    1. State
+ *    2. Favorite status
+ *    3. Type
+ *    4. Strength
+ *    5. Name
+ *
+ *  @param[in]  a  A pointer to the first immutable service
+ *                 to compare.
+ *  @param[in]  b  A pointer to the second immutable service
+ *                 to compare.
+ *
+ *  @retval    0  If service @a a and @a b are equivalent.
+ *  @retval  < 0  If service @a a should sort @b before service @a b.
+ *  @retval  > 0  If service @a b should sort @b before service @a a.
+ *
+ *  @sa service_compare_preferred
+ *  @sa __connman_service_compare
+ *
+ */
 static gint service_compare(gconstpointer a, gconstpointer b)
 {
 	const struct connman_service *service_a =3D (const void *) a;
@@ -5570,6 +5624,20 @@ static gint service_compare(gconstpointer a, =
gconstpointer b)
 	return g_strcmp0(service_a->name, service_b->name);
 }
=20
+/**
+ *  @brief
+ *    Sort the network services list and schedule a "ServicesChanged"
+ *    D-Bus signal.
+ *
+ *  This attempts to sort, if non-null and has more than one element,
+ *  the network services list. On completion of the sort, a D-Bus
+ *  "ServicesChanged" signal is scheduled.
+ *
+ *  @sa service_compare
+ *  @sa service_compare_preferred
+ *  @sa service_schedule_changed
+ *
+ */
 static void service_list_sort(void)
 {
 	if (service_list && service_list->next) {
@@ -5578,6 +5646,26 @@ static void service_list_sort(void)
 	}
 }
=20
+/**
+ *  @brief
+ *    Compare two network services against one another.
+ *
+ *  This compares the two specified network services.
+ *
+ *  @param[in]  a  A pointer to the first immutable service
+ *                 to compare.
+ *  @param[in]  b  A pointer to the second immutable service
+ *                 to compare.
+ *
+ *  @retval    0  If service @a a and @a b are equivalent.
+ *  @retval  < 0  If service @a a should sort @b before service @a b.
+ *  @retval  > 0  If service @a b should sort @b before service @a a.
+ *
+ *  @sa service_compare
+ *  @sa service_compare_preferred
+ *  @sa service_list_sort
+ *
+ */
 int __connman_service_compare(const struct connman_service *a,
 					const struct connman_service *b)
 {
--=20
2.42.0


