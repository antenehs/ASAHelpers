#!/bin/sh

#  BuildPhaseScripts.sh
#  ASAHelpers
#
#  Created by Anteneh Sahledengel on 5/6/17.
#  Copyright © 2017 Anteneh Sahledengel. All rights reserved.

########### SWIFTGEN #############

if which swiftgen >/dev/null; then
swiftgen images "$PROJECT_DIR/EmojiKeyboard/Assets.xcassets" -t swift3 --output "$PROJECT_DIR/EmojiKeyboard/SwiftGen/Images.swift"

swiftgen storyboards "$PROJECT_DIR/EmojiKeyboard/Base.lproj" -t swift3 --output "$PROJECT_DIR/EmojiKeyboard/SwiftGen/StoryBoards.swift"

else
echo "warning: SwiftGen not installed, download it from https://github.com/AliSoftware/SwiftGen"
fi



########## INCREMENT VERSION NUMBER #############

if [ $CONFIGURATION == Release ]; then
echo "Bumping build number..."
plist=${PROJECT_DIR}/${INFOPLIST_FILE}

# increment the build number (ie 115 to 116)
buildnum=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${plist}")
if [[ "${buildnum}" == "" ]]; then
echo "No build number in $plist"
exit 2
fi

buildnum=$(expr $buildnum + 1)
/usr/libexec/Plistbuddy -c "Set CFBundleVersion $buildnum" "${plist}"
echo "Bumped build number to $buildnum"

else
echo $CONFIGURATION " build - Not bumping build number."
fi
