# Installation Manual
## Required Software
* NodeJS version 6.11.4 LTS You can download it from [here](https://nodejs.org/en/download).
* Android Studio (Version 2.3). You can download it from [here](https://developer.android.com/studio/index.html).
* Java JDK Version 8. you can download it form [here](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).
* Make sure you have installed the correct Platform SDK through Android Studio.
* Enabled developer options on your phone to enable USB Debugging. You can do so by following this [guide](https://www.howtogeek.com/129728/how-to-access-the-developer-options-menu-and-enable-usb-debugging-on-android-4.2/).
* Git you can download it from [here](https://git-scm.com/download/).

## Install React Native and the React Native CLI
```bash
npm install -g create-react-native-app
npm install -g react-native-cli
```

## Install the packages
```bash
cd Week 1/poc
```

```bash
npm install
```

```bash
react-native run-android
```
if you get an error "SDK not found" use the following [commands](https://stackoverflow.com/a/32640154)
```bash
export ANDROID_HOME=/Users/<username>/Library/Android/sdk/
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```