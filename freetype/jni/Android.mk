LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
FREETYPE_SRC_PATH := ../freetype-2.9/
LOCAL_MODULE := freetype
LOCAL_CFLAGS := -g0 -DANDROID_NDK -DFT2_BUILD_LIBRARY=1
LOCAL_C_INCLUDES := \
		$(FREETYPE_SRC_PATH)include \
		$(FREETYPE_SRC_PATH)src
LOCAL_SRC_FILES := \
		$(FREETYPE_SRC_PATH)src/autofit/autofit.c \
		$(FREETYPE_SRC_PATH)src/base/basepic.c \
		$(FREETYPE_SRC_PATH)src/base/ftapi.c \
		$(FREETYPE_SRC_PATH)src/base/ftbase.c \
		$(FREETYPE_SRC_PATH)src/base/ftbbox.c \
		$(FREETYPE_SRC_PATH)src/base/ftbitmap.c \
		$(FREETYPE_SRC_PATH)src/base/ftdbgmem.c \
		$(FREETYPE_SRC_PATH)src/base/ftdebug.c \
		$(FREETYPE_SRC_PATH)src/base/ftfstype.c \
		$(FREETYPE_SRC_PATH)src/base/ftgasp.c \
		$(FREETYPE_SRC_PATH)src/base/ftglyph.c \
		$(FREETYPE_SRC_PATH)src/base/ftinit.c \
		$(FREETYPE_SRC_PATH)src/base/ftstroke.c \
		$(FREETYPE_SRC_PATH)src/base/ftsynth.c \
		$(FREETYPE_SRC_PATH)src/base/ftsystem.c \
		$(FREETYPE_SRC_PATH)src/bdf/bdf.c \
		$(FREETYPE_SRC_PATH)src/cache/ftcache.c \
		$(FREETYPE_SRC_PATH)src/cff/cff.c \
		$(FREETYPE_SRC_PATH)src/cid/type1cid.c \
		$(FREETYPE_SRC_PATH)src/gzip/ftgzip.c \
		$(FREETYPE_SRC_PATH)src/lzw/ftlzw.c \
		$(FREETYPE_SRC_PATH)src/pcf/pcf.c \
		$(FREETYPE_SRC_PATH)src/pfr/pfr.c \
		$(FREETYPE_SRC_PATH)src/psaux/psaux.c \
		$(FREETYPE_SRC_PATH)src/pshinter/pshinter.c \
		$(FREETYPE_SRC_PATH)src/psnames/psnames.c \
		$(FREETYPE_SRC_PATH)src/raster/raster.c \
		$(FREETYPE_SRC_PATH)src/sfnt/sfnt.c \
		$(FREETYPE_SRC_PATH)src/smooth/smooth.c \
		$(FREETYPE_SRC_PATH)src/truetype/truetype.c \
		$(FREETYPE_SRC_PATH)src/type1/type1.c \
		$(FREETYPE_SRC_PATH)src/type42/type42.c \
		$(FREETYPE_SRC_PATH)src/winfonts/winfnt.c
include $(BUILD_STATIC_LIBRARY)
