LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES	:=			\
	asyncns.c

LOCAL_MODULE := libasyncns

LOCAL_C_INCLUDES :=			\
	$(GLIB_TOP)/android-internal

LOCAL_CFLAGS :=				\
	-DHAVE_CONFIG_H

include $(BUILD_STATIC_LIBRARY)
