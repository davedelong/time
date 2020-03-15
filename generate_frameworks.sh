#!/usr/bin/env bash

set -o nounset
set -o errexit


readonly MODULE_NAME=Time
readonly FRAMEWORK_NAME=${MODULE_NAME}
readonly FRAMEWORK_PATH=${FRAMEWORK_NAME}.framework
readonly SWIFT_MODULE_PATH=${FRAMEWORK_PATH}/Modules/${MODULE_NAME}.swiftmodule

readonly XCODE_PROJECT=${FRAMEWORK_NAME}.xcodeproj
readonly SYMROOT=build
readonly IOS_PLATFORM=iOS
readonly WATCHOS_PLATFORM=watchOS
readonly TVOS_PLATFORM=tvOS
readonly MACOS_PLATFORM=macOS

readonly REPOSITORY_NAME=time
readonly CARTHAGE_ROOT=Carthage
readonly CARTHAGE_FRAMEWORK=${REPOSITORY_NAME}.framework


function sdk_for_platform {
    local platform=${1-}
    if [[ -z "${platform}" ]]; then
        echo "${FUNCNAME[0]}:${LINENO}: Missing platform" && exit 2
    fi

    case ${platform} in
    ${IOS_PLATFORM})
        echo "iphoneos"
        ;;
    ${WATCHOS_PLATFORM})
        echo "watchos"
        ;;
    ${TVOS_PLATFORM})
        echo "appletvos"
        ;;
    ${MACOS_PLATFORM})
        echo "macosx"
        ;;
    *)
        echo "${FUNCNAME[0]}:${LINENO}: Unknown platform ${platform}" && exit 2
        ;;
    esac
}

function simulator_for_platform {
    local platform=${1-}
    if [[ -z "${platform}" ]]; then
        echo "${FUNCNAME[0]}:${LINENO}: Missing platform" && exit 2
    fi

    case ${platform} in
    ${IOS_PLATFORM})
        echo "iphonesimulator"
        ;;
    ${WATCHOS_PLATFORM})
        echo "watchsimulator"
        ;;
    ${TVOS_PLATFORM})
        echo "appletvsimulator"
        ;;
    ${MACOS_PLATFORM})
        echo ""
        ;;
    *)
        echo "${FUNCNAME[0]}:${LINENO}: Unknown platform ${platform}" && exit 2
        ;;
    esac
}

function build_path_for_product {
    local product=${1-}
    if [[ -z "${product}" ]]; then
        echo "Cannot generate the buid path for an empty product." && exit 2
    fi

    case ${product} in
    $(sdk_for_platform ${MACOS_PLATFORM}))
        echo "${SYMROOT}/Release"
        ;;
    $(simulator_for_platform ${MACOS_PLATFORM}))
        echo ""
        ;;
    *)
        echo "${SYMROOT}/Release-${product}"
        ;;
    esac
}

function universal_build_path_for_platform {
    local platform=${1-}
    if [[ -z "${platform}" ]]; then
        echo "${FUNCNAME[0]}:${LINENO}: Missing platform" && exit 2
    fi

    echo "${SYMROOT}/Release-universal-${platform}"
}

function create_universal_framework {
    local platform=${1-}
    if [[ -z "${platform}" ]]; then
        echo "${FUNCNAME[0]}:${LINENO}: Missing platform" && exit 2
    fi

    local universal_build_path=$(universal_build_path_for_platform ${platform})

    local sdk=$(sdk_for_platform ${platform})
    local main_product_path=$(build_path_for_product ${sdk})

    cp -RL ${main_product_path} ${universal_build_path}

    local simulator_sdk=$(simulator_for_platform ${platform})
    local simulator_product_path=
    if [[ -n "${simulator_sdk}" ]]; then
        simulator_product_path=$(build_path_for_product ${simulator_sdk})

        cp -RL ${simulator_product_path}/${SWIFT_MODULE_PATH}/* \
            ${universal_build_path}/${SWIFT_MODULE_PATH}
    fi

    local all_products_paths=
    for product_path in ${main_product_path} ${simulator_product_path}; do
        all_products_paths="${all_products_paths} ${product_path}/${FRAMEWORK_PATH}/${FRAMEWORK_NAME}"
    done

    lipo -create ${all_products_paths} \
        -output ${universal_build_path}/${FRAMEWORK_PATH}/${FRAMEWORK_NAME}
}

function archive_product {
    local platform=${1-}
    if [[ -z "${platform}" ]]; then
        echo "${FUNCNAME[0]}:${LINENO}: Missing platform" && exit 2
    fi

    local sdk=$(sdk_for_platform ${platform})
    local xcargs=${2-}
    xcodebuild archive -sdk ${sdk} SYMROOT=${SYMROOT} ${xcargs}

    local simulator_sdk=$(simulator_for_platform ${platform})
    if [[ -n "${simulator_sdk}" ]]; then
        xcodebuild build -sdk ${simulator_sdk} SYMROOT=${SYMROOT} ${xcargs}
    fi
}

function create_carthage_artefacts {
    for platform in ${IOS_PLATFORM} ${WATCHOS_PLATFORM} ${TVOS_PLATFORM} ${MACOS_PLATFORM}; do
        local product_build_path=$(universal_build_path_for_platform ${platform})
        local carthage_build_path=${CARTHAGE_ROOT}/Build/${platform}

        mkdir -p ${carthage_build_path}
        cp -rL ${product_build_path}/${FRAMEWORK_PATH} ${carthage_build_path}
        cp -rL ${product_build_path}/${FRAMEWORK_PATH}.dSYM ${carthage_build_path}
    done

    zip -r -X ${CARTHAGE_FRAMEWORK}.zip ${CARTHAGE_ROOT}
}

function create_universal_frameworks {
    for platform in ${IOS_PLATFORM} ${WATCHOS_PLATFORM} ${TVOS_PLATFORM} ${MACOS_PLATFORM}; do
        create_universal_framework ${platform}
    done
}

function archive_products {
    for platform in ${IOS_PLATFORM} ${MACOS_PLATFORM}; do
        archive_product ${platform}
    done

    for platform in ${WATCHOS_PLATFORM} ${TVOS_PLATFORM}; do
        archive_product ${platform} APPLICATION_EXTENSION_API_ONLY=YES
    done
}

function prepare_environment {
    rm -rf ${SYMROOT}
    rm -rf ${CARTHAGE_ROOT}
    rm -f ${CARTHAGE_FRAMEWORK}.zip
    rm -rf ${XCODE_PROJECT}

    swift package generate-xcodeproj
    xcodebuild clean
}


function main {
    prepare_environment
    archive_products
    create_universal_frameworks
    create_carthage_artefacts
}

main
