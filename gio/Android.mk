LOCAL_PATH:= $(call my-dir)

GIO_TOP := $(LOCAL_PATH)

include $(CLEAR_VARS)

LOCAL_SRC_FILES	:=			\
	gappinfo.c			\
	gasynchelper.c			\
	gasyncinitable.c		\
	gasyncresult.c			\
	gbufferedinputstream.c		\
	gbufferedoutputstream.c		\
	gcancellable.c			\
	gcontenttype.c			\
	gcharsetconverter.c		\
	gconverter.c			\
	gconverterinputstream.c		\
	gconverteroutputstream.c	\
	gcredentials.c			\
	gdatainputstream.c		\
	gdataoutputstream.c		\
	gdrive.c			\
	gdummyfile.c			\
	gdummyproxyresolver.c		\
	gemblem.c			\
	gemblemedicon.c			\
	gfile.c				\
	gfileattribute.c		\
	gfileenumerator.c		\
	gfileicon.c			\
	gfileinfo.c			\
	gfileinputstream.c		\
	gfilemonitor.c			\
	gfilenamecompleter.c		\
	gfileoutputstream.c		\
	gfileiostream.c			\
	gfilterinputstream.c		\
	gfilteroutputstream.c		\
	gicon.c				\
	ginetaddress.c			\
	ginetsocketaddress.c		\
	ginitable.c			\
	ginputstream.c			\
	gioerror.c			\
	giomodule.c			\
	gioscheduler.c			\
	giostream.c			\
	gloadableicon.c			\
	gmount.c			\
	gmemoryinputstream.c		\
	gmemoryoutputstream.c		\
	gmountoperation.c		\
	gnativevolumemonitor.c		\
	gnetworkaddress.c		\
	gnetworkservice.c		\
	goutputstream.c			\
	gpermission.c			\
	gpollfilemonitor.c		\
	gproxyresolver.c		\
	gresolver.c			\
	gseekable.c			\
	gsimpleasyncresult.c		\
	gsimplepermission.c		\
	gsocket.c			\
	gsocketaddress.c		\
	gsocketaddressenumerator.c	\
	gsocketclient.c			\
	gsocketconnectable.c		\
	gsocketconnection.c		\
	gsocketcontrolmessage.c		\
	gsocketinputstream.c		\
	gsocketlistener.c		\
	gsocketoutputstream.c		\
	gproxy.c			\
	gproxyaddress.c			\
	gproxyaddressenumerator.c	\
	gproxyconnection.c		\
	gsocketservice.c		\
	gsrvtarget.c			\
	gtcpconnection.c		\
	gthreadedsocketservice.c	\
	gthemedicon.c			\
	gthreadedresolver.c		\
	gunionvolumemonitor.c		\
	gvfs.c				\
	gvolume.c			\
	gvolumemonitor.c		\
	gzlibcompressor.c		\
	gzlibdecompressor.c		\
					\
	gfiledescriptorbased.c		\
	gunixconnection.c		\
	gunixcredentialsmessage.c	\
	gunixfdlist.c			\
	gunixfdmessage.c		\
	gunixmount.c			\
	gunixmounts.c			\
	gunixresolver.c			\
	gunixsocketaddress.c		\
	gunixvolume.c			\
	gunixvolumemonitor.c		\
	gunixinputstream.c		\
	gunixoutputstream.c		\
					\
	gvdb/gvdb-reader.c		\
	gdelayedsettingsbackend.c	\
	gkeyfilesettingsbackend.c	\
	gmemorysettingsbackend.c	\
	gnullsettingsbackend.c		\
	gsettingsbackend.c		\
	gsettingsschema.c		\
	gsettings-mapping.c		\
	gsettings.c			\
					\
	gdbusutils.c			\
	gdbusaddress.c			\
	gdbusauthobserver.c		\
	gdbusauth.c			\
	gdbusauthmechanism.c		\
	gdbusauthmechanismanon.c	\
	gdbusauthmechanismexternal.c	\
	gdbusauthmechanismsha1.c	\
	gdbuserror.c			\
	gdbusconnection.c		\
	gdbusmessage.c			\
	gdbusnameowning.c		\
	gdbusnamewatching.c		\
	gdbusproxy.c			\
	gdbusprivate.c			\
	gdbusintrospection.c		\
	gdbusmethodinvocation.c		\
	gdbusserver.c			\
					\
	glocaldirectorymonitor.c	\
	glocalfile.c			\
	glocalfileenumerator.c		\
	glocalfileinfo.c		\
	glocalfileinputstream.c		\
	glocalfilemonitor.c		\
	glocalfileoutputstream.c	\
	glocalfileiostream.c		\
	glocalvfs.c			\
	gsocks4proxy.c			\
	gsocks4aproxy.c			\
	gsocks5proxy.c			\
					\
	gdesktopappinfo.c		\
					\
	android-internal/gio-marshal.c	\
	android-internal/gioenumtypes.c

LOCAL_MODULE := libgio-2.0

LOCAL_C_INCLUDES :=			\
	$(GIO_TOP)/android		\
	$(GIO_TOP)/android/gio	\
	$(GIO_TOP)/android-internal	\
	$(GLIB_TOP)/gmodule		\
	$(GLIB_TOP)/gobject/android	\
	$(GLIB_TOP)/android-internal	\
	$(GLIB_C_INCLUDES)

LOCAL_CFLAGS :=				\
	-DHAVE_CONFIG_H			\
	-DG_LOG_DOMAIN=\"GLib-GIO\"	\
	-DGIO_MODULE_DIR=\"\"		\
	-DGIO_COMPILATION		\
	-DG_DISABLE_CONST_RETURNS	\
	-DG_DISABLE_DEPRECATED

LOCAL_LDLIBS :=				\
	-lz

ifeq ($(GLIB_BUILD_STATIC),true)
LOCAL_STATIC_LIBRARIES := libgobject-2.0 libgmodule-2.0 libglib-2.0 libgthread-2.0
LOCAL_STATIC_LIBRARIES += libasyncns libxdgmime libinotify

include $(BUILD_STATIC_LIBRARY)
else
LOCAL_SHARED_LIBRARIES := libgobject-2.0 libgmodule-2.0 libglib-2.0 libgthread-2.0
LOCAL_STATIC_LIBRARIES := libasyncns libxdgmime libinotify

include $(BUILD_SHARED_LIBRARY)
endif

include $(GIO_TOP)/xdgmime/Android.mk
include $(GIO_TOP)/inotify/Android.mk
include $(GIO_TOP)/libasyncns/Android.mk
