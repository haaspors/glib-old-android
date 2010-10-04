LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES	:=			\
	inotify-kernel.c		\
	inotify-sub.c			\
	inotify-path.c			\
	inotify-missing.c		\
	inotify-helper.c		\
	inotify-diag.c			\
	ginotifyfilemonitor.c		\
	ginotifydirectorymonitor.c

LOCAL_MODULE := libinotify

LOCAL_C_INCLUDES :=			\
	$(GIO_TOP)/android		\
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

include $(BUILD_STATIC_LIBRARY)
