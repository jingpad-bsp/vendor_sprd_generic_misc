#
# config launcher and wallpaper features
#
USE_PLATFORM_LAUNCHER3 ?= true
LAUNCHER_FEATURES ?=
WALLPAPER_FEATURES ?=

$(warning  "config begin, TARGET_BOARD_PLATFORM:$(TARGET_BOARD_PLATFORM) USE_PLATFORM_LAUNCHER3:$(USE_PLATFORM_LAUNCHER3)")
$(warning  "config begin, PRODUCT_GO_DEVICE:$(PRODUCT_GO_DEVICE) TARGET_BUILD_VERSION:$(TARGET_BUILD_VERSION) CHIPRAM_DDR_CUSTOMIZE_SIZE:$(CHIPRAM_DDR_CUSTOMIZE_SIZE)")

#####config wallpaper begin#####
# config wallpaper features
ifeq ($(strip $(WALLPAPER_FEATURES)),)
    ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
        ifeq ($(strip $(CHIPRAM_DDR_CUSTOMIZE_SIZE)),0x20000000)
            WALLPAPER_FEATURES += \
                ro.lockwallpaper.enable=false \
                ro.wallpaper.mem.maxsize=64
        else
            WALLPAPER_FEATURES += \
                ro.wallpaper.mem.maxsize=96
        endif
    endif
endif

ifneq ($(strip $(WALLPAPER_FEATURES)),)
    ADDITIONAL_BUILD_PROPERTIES += $(WALLPAPER_FEATURES)
    $(warning  "config done, wallpaper features is: $(WALLPAPER_FEATURES)")
endif
#####config wallpaper end#####

#####config launcher begin#####
ifeq ($(strip $(USE_PLATFORM_LAUNCHER3)),true)
# config launcher features
    ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
        ifneq ($(strip $(CHIPRAM_DDR_CUSTOMIZE_SIZE)),0x20000000)
            LAUNCHER_FEATURES += \
                ro.launcher.badge=true
        endif
    else
        LAUNCHER_FEATURES += \
            ro.launcher.multimode=true \
            ro.launcher.dynamic=true \
            ro.launcher.desktopgrid=true \
            ro.launcher.notifbadge.count=true
    endif

    ifneq ($(strip $(LAUNCHER_FEATURES)),)
        ADDITIONAL_BUILD_PROPERTIES += $(LAUNCHER_FEATURES)
        $(warning  "config done, launcher features is: $(LAUNCHER_FEATURES)")
    endif
endif
#####config launcher end#####
