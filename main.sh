#!/bin/bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
locale

curl -o "./$AndroidFileName" -k $AndroidFileUrl

bundle init
mv "$Gemfile" "Gemfile"
bundle install
mv "$Pluginfile" "Pluginfile"
mkdir fastlane
touch fastlane/Fastfile
mv "$FastFileConfig" "fastlane/Fastfile"
mv "$ApiKey" "$ApiKeyFileName"
bundle exec fastlane add_plugin huawei_appgallery_connect
bundle exec fastlane install_plugins
bundle exec fastlane $FastlaneParams --verbose
if [ $? -eq 0 ]
then
echo "AppGallery progress succeeded"
exit 0
else
echo "AppGallery progress failed :" >&2
exit 1
fi