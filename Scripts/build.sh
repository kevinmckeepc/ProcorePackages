#!/bin/sh
# https://developer.apple.com/documentation/xcode/distributing-binary-frameworks-as-swift-packages
# https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle
# https://developer.apple.com/videos/play/wwdc2020/10147
# https://mustafa-ysf.medium.com/creating-xcframework-from-swift-package-e8af6f44501f

FRAMEWORK_NAME="Eureka"
CREATE_FRAMEWORK_ARGUMENTS=()
WORKING_DIR="$(pwd)"
CHECKOUT_DIR="${WORKING_DIR}/${FRAMEWORK_NAME}"
BUILD_DIR="${WORKING_DIR}/Build"
ARCHIVES_DIR="${BUILD_DIR}/archives"
XCFRAMEWORKS_DIR="${BUILD_DIR}/xcframeworks"

rm -rf "$BUILD_DIR" && rm -f "$FRAMEWORK_NAME.zip"

#######################################################################
# XCFramework destinations
#######################################################################
DESTINATIONS=(
    "generic/platform=iOS"
    "generic/platform=iOS Simulator"
    "generic/platform=macOS,variant=Mac Catalyst"
)

#######################################################################
# Fix for bug that emits an invalid module interface
# See: https://bugs.swift.org/browse/SR-14195
# (caused by https://bugs.swift.org/browse/SR-898)
#######################################################################
fixInvalidModuleInterfaces() {

    interfaceFiles="$1/*.swiftinterface"
    invalidClassExtensions=("SelectableSection" "BaseMultivaluedSection" "GenericMultivaluedSection" "MultivaluedSection")

    echo "🧹Fixing generated swiftmodule interfaces"
    for className in "${invalidClassExtensions[@]}"
    do
        LINE="$FRAMEWORK_NAME.$className : $FRAMEWORK_NAME.Taggable"
        grep -rli "$FRAMEWORK_NAME" $interfaceFiles \
            | xargs sed -i '' "/$LINE/d"
    done
}

#######################################################################
# 1) Clone Eureka
#######################################################################
if [ ! -d $CHECKOUT_DIR ]
then
    echo "🐳 Cloning $FRAMEWORK_NAME"
    git clone --branch 5.3.6 git@github.com:xmartlabs/Eureka.git
fi
cd $CHECKOUT_DIR

#######################################################################
# 2) Create platform specific framework files
#######################################################################
for index in "${!DESTINATIONS[@]}"
do
    destination="${DESTINATIONS[$index]}"
    platformName="${destination##*=}"
    archiveName="${FRAMEWORK_NAME}-${platformName// /_}"
    archivePath="${ARCHIVES_DIR}/${archiveName}"

    # For each platform, create an archive
    echo "🐳 Building Archive for Platform [${platformName}]"
    xcodebuild archive \
        -project "${FRAMEWORK_NAME}.xcodeproj" \
        -scheme "${FRAMEWORK_NAME}" \
        -destination "${destination}" \
        -archivePath "${archivePath}" \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
        ONLY_ACTIVE_ARCH=YES \
        -quiet
#        OTHER_SWIFT_FLAGS="-verify-emitted-module-interface" \

    # Add the archive to the list of arguments
    CREATE_FRAMEWORK_ARGUMENTS+=" -archive ${archivePath}.xcarchive -framework ${FRAMEWORK_NAME}.framework"
#    if [$index == 0]
#    then
#        CREATE_FRAMEWORK_ARGUMENTS+=" -debug-symbols ${archivePath}.xcarchive/dSYMs/${FRAMEWORK_NAME}.framework.dSYM"
#    fi

    # Fix https://bugs.swift.org/browse/SR-14195 (caused by https://bugs.swift.org/browse/SR-898)

    swiftModuleDirectory="${archivePath}.xcarchive/Products/Library/Frameworks/$FRAMEWORK_NAME.framework/Modules/$FRAMEWORK_NAME.swiftmodule"
    fixInvalidModuleInterfaces $swiftModuleDirectory

done

########################################################################
## 3) Combine the individual frameworks to form a single xcframework file
########################################################################
cd $WORKING_DIR
echo "🐳 Building XCFramework"
xcodebuild -create-xcframework \
    $CREATE_FRAMEWORK_ARGUMENTS \
    -output "$XCFRAMEWORKS_DIR/${FRAMEWORK_NAME}.xcframework"

########################################################################
## 4) Zip up the Framework
########################################################################
cd ${XCFRAMEWORKS_DIR}
echo "🐳 Creating XCFramework Zip"
zip -r -X ../../${FRAMEWORK_NAME}.zip "${FRAMEWORK_NAME}.xcframework"

########################################################################
## 5) Create a checksum of the .zip file and save it to the
## .binaryTarget(checksum:) property
########################################################################
cd $CHECKOUT_DIR
echo "🐳 Computing Package Checksum"
checksum=$(swift package compute-checksum ../${FRAMEWORK_NAME}.zip)
echo "################################ CHECKSUM ################################"
echo $checksum
echo "##########################################################################"
echo "\n"
echo "📦 Package: ${WORKING_DIR}/${FRAMEWORK_NAME}.zip"

#######################################################################
# 6) TODO: Upload the zip file (Artifactory?) and save the file url to
# .binaryTarget(url:) property
#######################################################################
