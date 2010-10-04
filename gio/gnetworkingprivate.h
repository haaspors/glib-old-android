/* GIO - GLib Input, Output and Streaming Library
 *
 * Copyright (C) 2008 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General
 * Public License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifndef __G_NETWORKINGPRIVATE_H__
#define __G_NETWORKINGPRIVATE_H__

#ifdef G_OS_WIN32

#define _WIN32_WINNT 0x0501
#include <winsock2.h>
#undef interface
#include <ws2tcpip.h>
#include <windns.h>
#include <mswsock.h>

#ifdef HAVE_WSPIAPI_H
/* <wspiapi.h> in the Windows SDK and in mingw-w64 has wrappers for
 * inline workarounds for getaddrinfo, getnameinfo and freeaddrinfo if
 * they aren't present at run-time (on Windows 2000).
 */
#include <wspiapi.h>
#endif

#else /* !G_OS_WIN32 */

/* need this for struct ucred on Linux */
#ifdef __linux__
#define __USE_GNU
#include <sys/types.h>
#include <sys/socket.h>
#undef __USE_GNU
#endif

#include <sys/types.h>
#include <arpa/inet.h>
#include <arpa/nameser.h>
#if defined(HAVE_ARPA_NAMESER_COMPAT_H) && !defined(GETSHORT)
#include <arpa/nameser_compat.h>
#endif

#ifndef C_IN
#define C_IN 1
#endif

#ifndef T_SRV
#define T_SRV 33
#endif

#ifndef HEADER
typedef struct {
    unsigned  id :16;   /* query identification number */
#if BYTE_ORDER == BIG_ENDIAN
        /* fields in third byte */
    unsigned  qr: 1;    /* response flag */
    unsigned  opcode: 4;  /* purpose of message */
    unsigned  aa: 1;    /* authoritive answer */
    unsigned  tc: 1;    /* truncated message */
    unsigned  rd: 1;    /* recursion desired */
        /* fields in fourth byte */
    unsigned  ra: 1;    /* recursion available */
    unsigned  unused :1;  /* unused bits (MBZ as of 4.9.3a3) */
    unsigned  ad: 1;    /* authentic data from named */
    unsigned  cd: 1;    /* checking disabled by resolver */
    unsigned  rcode :4; /* response code */
#endif
#if BYTE_ORDER == LITTLE_ENDIAN || BYTE_ORDER == PDP_ENDIAN
        /* fields in third byte */
    unsigned  rd :1;    /* recursion desired */
    unsigned  tc :1;    /* truncated message */
    unsigned  aa :1;    /* authoritive answer */
    unsigned  opcode :4;  /* purpose of message */
    unsigned  qr :1;    /* response flag */
        /* fields in fourth byte */
    unsigned  rcode :4; /* response code */
    unsigned  cd: 1;    /* checking disabled by resolver */
    unsigned  ad: 1;    /* authentic data from named */
    unsigned  unused :1;  /* unused bits (MBZ as of 4.9.3a3) */
    unsigned  ra :1;    /* recursion available */
#endif
        /* remaining bytes */
    unsigned  qdcount :16;  /* number of question entries */
    unsigned  ancount :16;  /* number of answer entries */
    unsigned  nscount :16;  /* number of authority entries */
    unsigned  arcount :16;  /* number of resource entries */
} HEADER;
#endif

#ifndef NS_GET16
#define NS_GET16(s, cp) do { \
	register const u_char *t_cp = (const u_char *)(cp); \
	(s) = ((u_int16_t)t_cp[0] << 8) \
	    | ((u_int16_t)t_cp[1]) \
	    ; \
	(cp) += 2; \
} while (0)
#endif

#ifndef NS_GET32
#define NS_GET32(l, cp) do { \
	register const u_char *t_cp = (const u_char *)(cp); \
	(l) = ((u_int32_t)t_cp[0] << 24) \
	    | ((u_int32_t)t_cp[1] << 16) \
	    | ((u_int32_t)t_cp[2] << 8) \
	    | ((u_int32_t)t_cp[3]) \
	    ; \
	(cp) += 4; \
} while (0)
#endif

#ifndef NS_PUT16
#define NS_PUT16(s, cp) do { \
	register u_int16_t t_s = (u_int16_t)(s); \
	register u_char *t_cp = (u_char *)(cp); \
	*t_cp++ = t_s >> 8; \
	*t_cp   = t_s; \
	(cp) += 2; \
} while (0)
#endif

#ifndef NS_PUT32
#define NS_PUT32(l, cp) do { \
	register u_int32_t t_l = (u_int32_t)(l); \
	register u_char *t_cp = (u_char *)(cp); \
	*t_cp++ = t_l >> 24; \
	*t_cp++ = t_l >> 16; \
	*t_cp++ = t_l >> 8; \
	*t_cp   = t_l; \
	(cp) += 4; \
} while (0)
#endif

#ifndef GETSHORT
#define GETSHORT NS_GET16
#endif

#ifndef GETLONG
#define GETLONG NS_GET32
#endif

#ifndef PUTSHORT
#define PUTSHORT NS_PUT16
#endif

#ifndef PUTLONG
#define PUTLONG NS_PUT32
#endif

/* We're supposed to define _GNU_SOURCE to get EAI_NODATA, but that
 * won't actually work since <features.h> has already been included at
 * this point. So we define __USE_GNU instead.
 */
#define __USE_GNU
#include <netdb.h>
#undef __USE_GNU
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <resolv.h>
#include <sys/socket.h>
#include <sys/un.h>

#ifndef IN6_IS_ADDR_MC_NODELOCAL
#define IN6_IS_ADDR_MC_NODELOCAL(a)				\
	(IN6_IS_ADDR_MULTICAST(a) &&				\
	(IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_NODELOCAL))
#endif

#ifndef IN6_IS_ADDR_MC_GLOBAL
#define IN6_IS_ADDR_MC_GLOBAL(a)				\
	(IN6_IS_ADDR_MULTICAST(a) &&				\
	(IPV6_ADDR_MC_SCOPE(a) == IPV6_ADDR_SCOPE_GLOBAL))
#endif

#ifndef _PATH_RESCONF
#define _PATH_RESCONF "/etc/resolv.conf"
#endif

#ifndef CMSG_LEN
/* CMSG_LEN and CMSG_SPACE are defined by RFC 2292, but missing on
 * some older platforms.
 */
#define CMSG_LEN(len) ((size_t)CMSG_DATA((struct cmsghdr *)NULL) + (len))

/* CMSG_SPACE must add at least as much padding as CMSG_NXTHDR()
 * adds. We overestimate here.
 */
#define ALIGN_TO_SIZEOF(len, obj) (((len) + sizeof (obj) - 1) & ~(sizeof (obj) - 1))
#define CMSG_SPACE(len) ALIGN_TO_SIZEOF (CMSG_LEN (len), struct cmsghdr)
#endif
#endif

G_BEGIN_DECLS

extern struct addrinfo _g_resolver_addrinfo_hints;

GList *_g_resolver_addresses_from_addrinfo (const char       *hostname,
					    struct addrinfo  *res,
					    gint              gai_retval,
					    GError          **error);

void   _g_resolver_address_to_sockaddr     (GInetAddress            *address,
					    struct sockaddr_storage *sa,
					    gsize                   *len);
char  *_g_resolver_name_from_nameinfo      (GInetAddress     *address,
					    const gchar      *name,
					    gint              gni_retval,
					    GError          **error);

#if defined(G_OS_UNIX)
GList *_g_resolver_targets_from_res_query  (const gchar      *rrname,
					    guchar           *answer,
					    gint              len,
					    gint              herr,
					    GError          **error);
#elif defined(G_OS_WIN32)
GList *_g_resolver_targets_from_DnsQuery   (const gchar      *rrname,
					    DNS_STATUS        status,
					    DNS_RECORD       *results,
					    GError          **error);
#endif

gboolean _g_uri_parse_authority            (const char       *uri,
					    char            **host,
					    guint16          *port,
					    char            **userinfo);
gchar *  _g_uri_from_authority             (const gchar      *protocol,
					    const gchar      *host,
					    guint             port,
					    const gchar      *userinfo);

G_END_DECLS

#endif /* __G_NETWORKINGPRIVATE_H__ */
