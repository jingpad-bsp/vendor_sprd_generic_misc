#
# config launcher & wallpaperpicker package
#
USE_PLATFORM_LAUNCHER3 ?= true
LAUNCHER_DEXPREOPT_SPEED ?= true
$(warning  "config begin, TARGET_BOARD_PLATFORM:$(TARGET_BOARD_PLATFORM) USE_PLATFORM_LAUNCHER3:$(USE_PLATFORM_LAUNCHER3)")
$(warning  "config begin, PRODUCT_GO_DEVICE:$(PRODUCT_GO_DEVICE) TARGET_BUILD_VERSION:$(TARGET_BUILD_VERSION) CHIPRAM_DDR_CUSTOMIZE_SIZE:$(CHIPRAM_DDR_CUSTOMIZE_SIZE)")

#####config wallpaper begin#####
PRODUCT_PACKAGES += WallpaperPicker2
#####config wallpaper end#####

#####config launcher package begin#####
ifeq ($(strip $(USE_PLATFORM_LAUNCHER3)),true)
# config launcher package
    ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
        ifeq ($(strip $(CHIPRAM_DDR_CUSTOMIZE_SIZE)),0x20000000)
            $(warning  "this is 512M Go devices, use the Launcher3GoIconRecents for launcher app")
            LAUNCHER_PACKAGE_NAME := Launcher3GoIconRecents
        else
            # LAUNCHER_PACKAGE_NAME := Launcher3QuickStepGo
            # In order to save memory, use Launcher3GoIconRecents for Go devices
            LAUNCHER_PACKAGE_NAME := Launcher3GoIconRecents
        endif
    else
        ifeq ($(strip $(TARGET_BUILD_VERSION)),gms)
            LAUNCHER_PACKAGE_NAME := SearchLauncherQRef
        else
            LAUNCHER_PACKAGE_NAME := Launcher3QuickStep
        endif
    endif

# config dex speed apps
    ifeq ($(strip $(PRODUCT_GO_DEVICE)),true)
        ifeq ($(strip $(CHIPRAM_DDR_CUSTOMIZE_SIZE)),0x20000000)
            $(warning  "this is 512M Go devices, don't dexpreopt speed launcher.")
            LAUNCHER_DEXPREOPT_SPEED := false
        endif
    endif

    ifeq ($(strip $(LAUNCHER_DEXPREOPT_SPEED)),true)
        PRODUCT_DEXPREOPT_SPEED_APPS += $(LAUNCHER_PACKAGE_NAME)
    endif

# config native launcher partner apps
    ifneq ($(strip $(TARGET_BUILD_VERSION)),gms)
        # PRODUCT_PACKAGES += NativeLauncherLayout
        $(warning "remove NativeLauncherLayout from jingos")
    endif

    PRODUCT_PACKAGES += $(LAUNCHER_PACKAGE_NAME)
    $(warning  "config done, launcher package is: $(LAUNCHER_PACKAGE_NAME)")
endif
#####config launcher package end#####
