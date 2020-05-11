LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LIBPNG_SRC_PATH := ../lpng1637/
LOCAL_MODULE := libpng16
LOCAL_CFLAGS := -g0 -DANDROID_NDK
LOCAL_C_INCLUDES := \
		$(LIBPNG_SRC_PATH)
LOCAL_SRC_FILES := \
		$(LIBPNG_SRC_PATH)png.c \
		$(LIBPNG_SRC_PATH)pngerror.c \
		$(LIBPNG_SRC_PATH)pngget.c \
		$(LIBPNG_SRC_PATH)pngmem.c \
		$(LIBPNG_SRC_PATH)pngpread.c \
		$(LIBPNG_SRC_PATH)pngread.c \
		$(LIBPNG_SRC_PATH)pngrio.c \
		$(LIBPNG_SRC_PATH)pngrtran.c \
		$(LIBPNG_SRC_PATH)pngrutil.c \
		$(LIBPNG_SRC_PATH)pngset.c \
		$(LIBPNG_SRC_PATH)pngtest.c \
		$(LIBPNG_SRC_PATH)pngtrans.c \
		$(LIBPNG_SRC_PATH)pngwio.c \
		$(LIBPNG_SRC_PATH)pngwrite.c \
		$(LIBPNG_SRC_PATH)pngwtran.c \
		$(LIBPNG_SRC_PATH)pngwutil.c

LOCAL_EXPORT_LDLIBS := -lz

include $(BUILD_STATIC_LIBRARY)
