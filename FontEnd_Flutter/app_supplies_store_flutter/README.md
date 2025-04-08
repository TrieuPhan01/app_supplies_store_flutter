This project initialized in Flutter version 3.10.2

Dart version required >=3.0.2 <4.0.0

# Basic using project (non FVM)
### Run the app first time, need to upgrade library by:
`
flutter pub upgrade
`

### Change the kotlin version to newest by change file android/app/build.gradle:

Can get newest_version of kotlin here: https://kotlinlang.org/docs/gradle.html#targeting-the-jvm

`
buildscript { ext.kotlin_version = '<kotlin_newest_version>'
... }
`

### Run the application on each platform

`flutter run -t lib\main-dev.dart`

or

`flutter run -t lib\main-prod.dart`

# Use this project with Installed FVM (follow the under introduction)

1. fvm list
2. fvm install {version} - # Installs specific version (optional)
3. fvm use {flutter right version}
4. In intellij, Ctrl + Alt + S to open settings, Languages & frameworks, Flutter/Dart, change path to

```
   DartSDK: <root>\.fvm\flutter_sdk\bin\cache\dart-sdk
   FlutterSDK: <root>\.fvm\flutter_sdk
```

5. fvm flutter pub get
6. fvm flutter run

# FVM installation on Windows

1. install choco on Windows:

cmd:

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('[https://community.chocolatey.org/install.ps1](https://community.chocolatey.org/install.ps1)'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

powershell:

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

2. choco install fvm
3. dart pub global activate fvm
4. flutter pub global activate fvm
5. fvm install [version]
6. fvm use [version]
7. In intellij, Ctrl + Alt + S to open settings, Languages & frameworks, Flutter/Dart, change path to

```
   DartSDK: <root>\.fvm\flutter_sdk\bin\cache\dart-sdk
   FlutterSDK: <root>\.fvm\flutter_sdk
```

8. Later command must be use keyword "fvm" at first:
    - fvm flutter pub get
    - fvm flutter run
    - …
