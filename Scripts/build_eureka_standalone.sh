#!/bin/sh
# https://developer.apple.com/documentation/xcode/distributing-binary-frameworks-as-swift-packages
# https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle
# https://developer.apple.com/videos/play/wwdc2020/10147
# https://mustafa-ysf.medium.com/creating-xcframework-from-swift-package-e8af6f44501f
# https://onesignal.com/blog/xcframeworks-guide/

FRAMEWORK_NAME="Eureka"
WORKING_DIR="$(pwd)"
echo "🐳 $WORKING_DIR"
ls -la ../
echo "🐳 $LISTED"

#FRAMEWORK_TAG="5.3.6"
#FRAMEWORK_URL="git@github.com:xmartlabs/Eureka.git"
#CREATE_FRAMEWORK_ARGUMENTS=()
#BUILD_DIR="${WORKING_DIR}/Build"
#CHECKOUT_DIR="${BUILD_DIR}/Checkout/${FRAMEWORK_NAME}"
#SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}/${FRAMEWORK_NAME}-iOS_Simulator.xcarchive"
#IOS_DEVICE_ARCHIVE_PATH="${BUILD_DIR}/${FRAMEWORK_NAME}-iOS.xcarchive"
#CATALYST_ARCHIVE_PATH="${BUILD_DIR}/${FRAMEWORK_NAME}-MacCatalyst.xcarchive"
#XCFRAMEWORK_PATH="${BUILD_DIR}/${FRAMEWORK_NAME}.xcframework"
#XCFRAMEWORK_ZIP_PATH="${BUILD_DIR}/${FRAMEWORK_NAME}.zip"
#ARCHIVE_LIBRARY_DIR="Products/Library/Frameworks/${FRAMEWORK_NAME}.framework"
#ARCHIVE_SWIFT_MODULE_DIR="$ARCHIVE_LIBRARY_DIR/Modules/$FRAMEWORK_NAME.swiftmodule"
#
########################################################################
## Cleans out any old build files
########################################################################
#clean() {
#    echo "🐳 Cleaning old build files"
#    rm -rf $BUILD_DIR
#}
#
########################################################################
## Prepares the build by checking out the
########################################################################
#prepare() {
#    echo "🐳 Preparing build"
#    # 1) Clone Eureka
#    if [ ! -d $CHECKOUT_DIR ]
#    then
#        echo "🐳 Cloning $FRAMEWORK_NAME"
#        git clone --branch $FRAMEWORK_TAG $FRAMEWORK_URL "$CHECKOUT_DIR"
#    fi
#    cd $CHECKOUT_DIR
#
#
#    # 2) Repair the project file by stream editing the build variables
#    xcodeProjectFile="$CHECKOUT_DIR/$FRAMEWORK_NAME.xcodeproj/project.pbxproj"
#    echo "🐳 Repairing the Project file"
#    # Update the deployment target
#    sed -i '' "s|IPHONEOS_DEPLOYMENT_TARGET = 9.0;|IPHONEOS_DEPLOYMENT_TARGET = 11.0;|g" \
#        "$xcodeProjectFile"
#    # Flip the enable bitcode variable (to remove warning noise)
#    sed -i '' "s|ENABLE_BITCODE = YES;|ENABLE_BITCODE = NO;|g" \
#        "$xcodeProjectFile"
#    # Flip the skip install variable and force build for distribution
#    sed -i '' "s|SKIP_INSTALL = YES;|SKIP_INSTALL = NO;\nBUILD_LIBRARY_FOR_DISTRIBUTION = YES;|g" \
#        "$xcodeProjectFile"
#
#    # Edit the Package.swift to make the library dynamic
#    echo "🐳 Updating the library type to be dynamic"
#    TARGET_DECLARATION="name: \"$FRAMEWORK_NAME\", targets"
#    DYNAMIC_TARGET_DECLARATION="name: \"$FRAMEWORK_NAME\", type: .dynamic, targets"
#    sed -i '' "s|$TARGET_DECLARATION|$DYNAMIC_TARGET_DECLARATION|g" "$CHECKOUT_DIR/Package.swift"
#}
#
###########################################################################
## Build platform specific archives
###########################################################################
#buildArchives() {
#    echo "🐳 Building archives"
#
#    cd $CHECKOUT_DIR
#
#    echo "🐳 Building iOS Simulator archive ..."
#    xcodebuild archive \
#        -project "${FRAMEWORK_NAME}.xcodeproj" \
#        -scheme ${FRAMEWORK_NAME} \
#        -destination "generic/platform=iOS Simulator" \
#        -archivePath "${SIMULATOR_ARCHIVE_PATH}" \
#        -sdk iphonesimulator \
#        SKIP_INSTALL=NO \
#        BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
#        -quiet
#
#    echo "🐳 Building iOS device archive ..."
#    xcodebuild archive \
#        -project "${FRAMEWORK_NAME}.xcodeproj" \
#        -scheme ${FRAMEWORK_NAME} \
#        -destination "generic/platform=iOS" \
#        -archivePath "${IOS_DEVICE_ARCHIVE_PATH}" \
#        -sdk iphoneos SKIP_INSTALL=NO \
#        BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
#        -quiet
#
#    echo "🐳 Building Mac Catalyst archive ..."
#    xcodebuild archive \
#        -project "${FRAMEWORK_NAME}.xcodeproj" \
#        -scheme ${FRAMEWORK_NAME} \
#        -destination "generic/platform=macOS,variant=Mac Catalyst" \
#        -archivePath "${CATALYST_ARCHIVE_PATH}" \
#        SKIP_INSTALL=NO \
#        BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
#        -quiet
#}
#
###########################################################################
## Combine the individual frameworks to form a single xcframework file
###########################################################################
#buildXCFramework() {
#    echo "🐳  Combining archives into XCFramework"
#    xcodebuild -create-xcframework \
#        -framework "$SIMULATOR_ARCHIVE_PATH/$ARCHIVE_LIBRARY_DIR" \
#        -framework "$IOS_DEVICE_ARCHIVE_PATH/$ARCHIVE_LIBRARY_DIR" \
#        -framework "$CATALYST_ARCHIVE_PATH/$ARCHIVE_LIBRARY_DIR" \
#        -output "${XCFRAMEWORK_PATH}"
#}
#
###########################################################################
## Zip up the .xcframework
###########################################################################
#zipXCFramework() {
#    echo "🐳 Building XCFramework Zip File"
#    rm -rf "${XCFRAMEWORK_ZIP_PATH}"
#    ditto -c -k --sequesterRsrc --keepParent "${XCFRAMEWORK_PATH}" "${XCFRAMEWORK_ZIP_PATH}"
#
#    # TODO: Upload the zip file to Artifactory and replace the url value
#    #zipUrl="https\:\/\/public_url" # TODO: Need to escape all the special characters
#    #sed -i '' "24s/\".*\"/\"${zipUrl}\"/" "${WORKING_DIR}/../Package.swift"
#}
#
###########################################################################
## Create a checksum of the .zip file and save it to the
## .binaryTarget(checksum:) property
###########################################################################
#computeChecksum() {
#    echo "🐳 Computing Package Checksum"
#    checksum=$(swift package compute-checksum ${XCFRAMEWORK_ZIP_PATH})
#    echo "################################ CHECKSUM ################################"
#    echo $checksum
#    echo "##########################################################################"
#    echo "\n"
#
#    # Update the package checksum
#    sed -i '' "25s/\".*\"/\"${checksum}\"/" "${WORKING_DIR}/../Package.swift"
#}
#
###########################################################################
## Fix for bug that emits an invalid module interface -
## "redundant same-type constraints" warnings
## See: https://bugs.swift.org/browse/SR-14195
###########################################################################
#repairSwiftModuleInterfaces() {
#
#    interfaceFiles="$1/*.swiftinterface"
#    invalidClassExtensions=("SelectableSection" "BaseMultivaluedSection" "GenericMultivaluedSection" "MultivaluedSection")
#    echo "🧹Repairing swiftmodule interfaces"
#    for className in "${invalidClassExtensions[@]}"
#    do
#        LINE="$FRAMEWORK_NAME.$className : $FRAMEWORK_NAME.Taggable"
#        grep -rli "$FRAMEWORK_NAME" $interfaceFiles \
#            | xargs sed -i '' "/$LINE/d"
#    done
#}
#
###########################################################################
## Establish run order
###########################################################################
#main() {
#    clean
#    prepare
#    buildArchives
#    repairSwiftModuleInterfaces "$SIMULATOR_ARCHIVE_PATH/${ARCHIVE_SWIFT_MODULE_DIR}"
#    repairSwiftModuleInterfaces "$IOS_DEVICE_ARCHIVE_PATH/${ARCHIVE_SWIFT_MODULE_DIR}"
#    repairSwiftModuleInterfaces "$CATALYST_ARCHIVE_PATH/${ARCHIVE_SWIFT_MODULE_DIR}"
#    buildXCFramework
#    zipXCFramework
#    computeChecksum
#}
#
#main
