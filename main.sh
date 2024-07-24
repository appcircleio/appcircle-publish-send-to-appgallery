#!/bin/bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
locale

curl -o "./$AC_APP_FILE_NAME" -k $AC_APP_FILE_URL

bundle init
mv "$AC_GEM_FILE" "Gemfile"
bundle install
mv "$AC_PLUGIN_FILE" "Pluginfile"
mkdir fastlane
touch fastlane/Fastfile
mv "$AC_FASTFILE_CONFIG" "fastlane/Fastfile"
mv "$AC_API_KEY" "$AC_API_KEY_FILE_NAME"
bundle exec fastlane add_plugin huawei_appgallery_connect
bundle exec fastlane install_plugins
bundle exec fastlane $AC_FASTLANE_PARAMS --verbose
if [ $? -eq 0 ]
then
echo "AppGallery progress succeeded"
exit 0
else
echo "AppGallery progress failed :" >&2
exit 1
fi