LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := init_expand.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/etc/init/

ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
LOCAL_SRC_FILES := init_expand_go.rc
else
LOCAL_SRC_FILES := init_expand.rc
endif

include $(BUILD_PREBUILT)

CUSTOM_MODULES += init_expand.rc

include $(CLEAR_VARS)
LOCAL_MODULE := avc_backtrace.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/etc/init/
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

CUSTOM_MODULES += avc_backtrace.rc
