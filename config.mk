# Copyright (C) 2020 The Brain Repo Project
# Copyright (C) 2020 The Code Aurora Forum Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := vendor/cafstyle

# Prebuilt Packages
PRODUCT_PACKAGES += \
    SafetyHubPrebuilt \
    NexusLauncherRelease \
    Fonts

ifeq ($(CUSTOM_BUILD_TYPE), OFFICIAL)
PRODUCT_PACKAGES += \
    Papers
endif

ifeq ($(TARGET_GAPPS_ARCH),arm64)
PRODUCT_PACKAGES += \
    MatchmakerPrebuiltPixel4
else ifeq ($(TARGET_GAPPS_ARCH),x86)
PRODUCT_PACKAGES += \
    IntelLegacyPrebuilt
endif

TARGET_MINIMAL_APPS ?= false

# Intel PVC
ifeq ($(TARGET_GAPPS_ARCH),arm64)
ifeq ($(TARGET_INTEL_PVC_SUPPORTED), true)
PRODUCT_PACKAGES += \
    IntelPVCService
endif
endif

# Files
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/etc,$(TARGET_COPY_OUT_PRODUCT)/etc)

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.theme=glif_v3_light \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=false

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false

# OPA configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.opa.eligible_device=true

# Google legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# Inherit from fonts config
$(call inherit-product, vendor/cafstyle/config/fonts.mk)

# Inherit from CarrrierSettings config
$(call inherit-product, vendor/cafstyle/carriersettings/config.mk)
