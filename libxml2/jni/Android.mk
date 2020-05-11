LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
XML_SRC_PATH := ../platform_external_libxml2-master/
LOCAL_MODULE := xml2
LOCAL_CFLAGS := -g0 -DANDROID_NDK -DLIBXML_THREAD_ENABLED=1 -DHAVA_CONFIG_H -DSTATIC_LIBXML
LOCAL_C_INCLUDES := \
		$(XML_SRC_PATH) \
		$(XML_SRC_PATH)include
LOCAL_SRC_FILES := \
		$(XML_SRC_PATH)/buf.c \
		$(XML_SRC_PATH)/c14n.c \
		$(XML_SRC_PATH)/catalog.c \
		$(XML_SRC_PATH)/chvalid.c \
		$(XML_SRC_PATH)/debugXML.c \
		$(XML_SRC_PATH)/dict.c \
		$(XML_SRC_PATH)/DOCBparser.c \
		$(XML_SRC_PATH)/encoding.c \
		$(XML_SRC_PATH)/entities.c \
		$(XML_SRC_PATH)/error.c \
		$(XML_SRC_PATH)/globals.c \
		$(XML_SRC_PATH)/hash.c \
		$(XML_SRC_PATH)/legacy.c \
		$(XML_SRC_PATH)/list.c \
		$(XML_SRC_PATH)/nanoftp.c \
		$(XML_SRC_PATH)/nanohttp.c \
		$(XML_SRC_PATH)/parser.c \
		$(XML_SRC_PATH)/parserInternals.c \
		$(XML_SRC_PATH)/pattern.c \
		$(XML_SRC_PATH)/relaxng.c \
		$(XML_SRC_PATH)/SAX.c \
		$(XML_SRC_PATH)/SAX2.c \
		$(XML_SRC_PATH)/threads.c \
		$(XML_SRC_PATH)/tree.c \
		$(XML_SRC_PATH)/trionan.c \
		$(XML_SRC_PATH)/triostr.c \
		$(XML_SRC_PATH)/uri.c \
		$(XML_SRC_PATH)/valid.c\
		$(XML_SRC_PATH)/xinclude.c \
		$(XML_SRC_PATH)/xlink.c \
		$(XML_SRC_PATH)/xmlIO.c \
		$(XML_SRC_PATH)/xmlmemory.c \
		$(XML_SRC_PATH)/xmlmodule.c \
		$(XML_SRC_PATH)/xmlreader.c \
		$(XML_SRC_PATH)/xmlregexp.c \
		$(XML_SRC_PATH)/xmlsave.c \
		$(XML_SRC_PATH)/xmlschemas.c \
		$(XML_SRC_PATH)/xmlschemastypes.c \
		$(XML_SRC_PATH)/xmlstring.c \
		$(XML_SRC_PATH)/xmlunicode.c \
		$(XML_SRC_PATH)/xmlwriter.c \
		$(XML_SRC_PATH)/xpath.c \
		$(XML_SRC_PATH)/xpointer.c

include $(BUILD_STATIC_LIBRARY)
