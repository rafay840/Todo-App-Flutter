#!/usr/bin/env bash

time=$(date "+%y%m%d%H")

while getopts v:e:p: opt
do
    case $opt in 
        v) version=${OPTARG} ;;     # 版本
        p) plat=${OPTARG} ;;    # 平台（all, ios, android）
    esac
done

version=${version:-"1.0.0"}
plat=${plat:-"all"}

mkdir ./buildOutput
target="lib/main.dart"

echo "开始打包： v${version} build(${time})，plat: ${plat}，target: ${target}"

### 打包 Android 客户端
if [ "$plat"x = "android"x ] || [ "$plat"x = "all"x ]; then
  # 打包Android
  flutter build apk --build-name=$version --build-number=$time -t $target

  cp build/app/outputs/apk/release/app-release.apk buildOutput/
fi

if [ "$plat"x = "ios"x ] || [ "$plat"x = "all"x ]; then
  # 打包iOS
  flutter build ios --build-name=$version --build-number=$time -t $target
  
  # TODO： need use faselane to upload appstore
fi

open build/app/outputs/apk/release
