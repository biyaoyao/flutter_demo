#!/bin/sh

create-dmg \
  --volname "Flutter Installer" \
  --volicon "logo_flutter.png" \
  --background "logo_flutter.png" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "build/macos/Build/Products/Release/flutter_demo.app" 200 190 \
  --hide-extension "Application.app" \
  --app-drop-link 600 185 \
  "flutter-demo.dmg" \
  "build/macos/Build/Products/Release/flutter_demo.app"

#"Application-Installer.dmg"是.dmg文件名称。
#"source_folder/"是"flutter build macos --release"结果路径，如：/工程目录/build/macos/Build/Products/Release/xxx.app