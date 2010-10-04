LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES	:=			\
	xdgmime.c			\
	xdgmimealias.c			\
	xdgmimecache.c			\
	xdgmimeglob.c			\
	xdgmimeicon.c			\
	xdgmimeint.c			\
	xdgmimemagic.c			\
	xdgmimeparent.c

LOCAL_MODULE := libxdgmime

LOCAL_C_INCLUDES :=			\
	$(LOCAL_PATH)			\
	$(LOCAL_PATH)/android		\
	$(LOCAL_PATH)/android/gio	\
	$(LOCAL_PATH)/android-internal	\
	$(GLIB_TOP)/gmodule		\
	$(GLIB_TOP)/gobject/android	\
	$(GLIB_TOP)/android-internal	\
	$(GLIB_C_INCLUDES)

LOCAL_CFLAGS :=				\
	-DHAVE_CONFIG_H			\
	-DXDG_PREFIX=_gio_xdg

include $(BUILD_STATIC_LIBRARY)
