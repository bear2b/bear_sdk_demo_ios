# BearSDK iOS

Augmented reality simple and powerful.

* [Introduction](#introduction)
  * [Requirements](#requirements)
  * [How to run sample apps](#how-to-run-sample-apps)
  * [Sample markers](#sample-markers)
* [Setup](#setup)
  * [Carthage](#carthage)
  * [CocoaPods](#cocoapods)
  * [Manual](#manual)
  * [Bitcode](#disable-bitcode-in-build-settings)
  * [Valid architectures](#setup-valid-architectures)
  * [Info.plist](#infoplist)
* [Initialization](#initialization)
* [Implementation](#implementation)
  * [`ARViewController`](#arviewcontroller)
  * [`ARHandlerProtocol`](#arhandlerprotocol)
* [Delegate](#delegate)
* [Advanced](#advanced)
  * [Show Marker Without Scanning](#show-marker-without-scanning)
  * [Release resources](#release-resources)
  * [Pause/Resume camera](#pauseresume-camera)
  * [Push Notifications](#push-notifications)
* [API Reference](https://bear2b.github.io/private_bear_sdk_ios/)

## Introduction

Welcome to the Bear SDK. This document is designed to help you from your very first steps with the Bear SDK all the way through to advanced concepts and examples for developing your augmented reality project.

### Requirements

* iOS 11.0 and higher
* Xcode 11.4 and higher
* Swift 5.2 and higher (or Objective-C)
* 64 bits architecture (iPhone 5S and newer)
* A valid [iOS Development Certificate](https://developer.apple.com/programs/)

For Xcode 11.3 and below, [use BearSDK 2.X.X](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.2.2).

> **Warning:** `ARViewController` supports portrait orientation only. In fact, you can still use it in landscape-only application, but it is not officially supported.

### How to run sample apps

The BearSDK is already integrated in the project.

* Download [sample apps repository](https://github.com/bear2b/bear_sdk_demo_ios);
* Bootstrap dependencies.

``` bash
carthage bootstrap --platform iOS
```

* Open `BearSDK.workspace` in Xcode;
* Setup certificates;
* Run `SampleApp` or `SampleAppObjc` scheme.

> **Warning:** Starting version 3.0 BearSDK also supports iOS simulator. AR features are not available in the simulator, but you can continue develop and test all non-AR features in the simulator.

### Sample markers

Once you compiled and installed the application on a physical device, you can scan the markers located in the [markers](https://github.com/bear2b/bear_sdk_demo_ios/tree/master/markers) folder.

These examples of augmented targets are prepared using [ARGO Manager/Editor](https://manager.ar-go.co)

## Setup

BearSDK supports [Carthage](https://github.com/Carthage/Carthage) and [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html).
Example of `Cartfile` included in sample app.

### [Carthage](https://github.com/Carthage/Carthage)

Add this to your `Cartfile` file:

```bash
github "Alamofire/Alamofire" == 5.2.1
github "ReactiveX/RxSwift" == 5.1.1
binary "https://s3.eu-west-1.amazonaws.com/mobile-dev.bear2b.com/bearsdk-ios/BearSDK.json" == 3.0.3
```

``` bash
carthage bootstrap --platform iOS
```

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

Add this to your `Podfile` file:

``` ruby
platform :ios, '11.0'
use_frameworks!

target `YourApp` do
    pod 'BearSDK', '3.0.3'
end
```

``` bash
pod install
```

### Manual

* Download [zip archive](https://s3-eu-west-1.amazonaws.com/mobile-dev.bear2b.com/bearsdk-ios/3.0.1/BearSDK.framework.zip);
* Add to *Frameworks, Libraries, and Embedded Content* section in your project `BearGL.framework` and `Vuforia.framework` together with `BearSDK.framework`.
* Integrate dependencies as you wish - [Carthage](https://github.com/Carthage/Carthage) or [CocoaPods](https://cocoapods.org) or [Swift Package Manager](https://github.com/apple/swift-package-manager) or manually.

```bash
"Alamofire/Alamofire" == 5.2.1
"ReactiveX/RxSwift" == 5.1.1
```

### Disable bitcode in *Build Settings*

``` xml
ENABLE_BITCODE = NO;
```

### Setup valid architectures

``` xml
VALID_ARCHS = $(ARCHS_STANDARD_64_BIT);
```

### Info.plist

#### Required

* Add camera usage description to describe how app will use camera.

``` xml
<key>NSCameraUsageDescription</key>
<string>Camera will let you scan pages</string>
```

#### Optional

* if you want to use facebook assets with deeplinks to go from your application to facebook app directly - setup this key to your app info.plist.

``` xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fb</string>
</array>
```

* Add location usage description if you want to use geolocalized markers.

``` xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Allows you to scan geolocalized markers</string>
```

* Add photo library usage description if you want to provide ability to save images or screenshots to camera roll.

``` xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Save images and screenshots</string>
```

* [Apple Transport Security (ATS)](https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14).

By default BearSDK supports content only through `https`. Thats why you have to use only `https` in ARGO Platform.

If you want to support `http` at your own risk - you are able to specify `NSAllowsArbitraryLoads` key to `true` in `NSAppTransportSecurity`.

``` xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## Initialization

The SDK must be configured with secret key before starting BearSDK usage.

``` swift
try BearSDK.setSecretKey("key")
```

You have to call the `BearSDK.setSecretKey("key")` method using a secret key as parameter. You can check the sample app and use its secret key during your development cycle. However you have to use your own secret key before submitting your application to production (this secret key will be provided by [ARGO](https://support.ar-go.co/hc/en-us/requests/new)).

## Implementation

You can display and use the augmented reality view using `ARViewController` class and it's handler `ARHandlerProtocol`.

### `ARViewController`

The `ARViewController` provides an infrastructure for your application to manage `BearScanner`.
You can create instances of `ARViewController` or its subclasses and use these objects to provide
the specific behavior and visual appearance you need.

* `recognitionTimeout` - The time after that scanner will be paused. The default value of this property is 8 seconds;
* `scanlineColor` - Customize scan line color. The default value of this property is purple color;
* `handler` - The object conforms to `ARHandlerProtocol` to control Bear scanner features;
* `delegate` - Use your own `ARDelegate` implementation. Delegate provides a mechanism for your application to take action on events that occur in the `ARViewController`.

To get more information about `ARDelegate` or `ARHandlerProtocol` take a look on [special `ARDelegate` article](#delegate) or [special `ARHandlerProtocol` article](#ARHandlerProtocol).

> Note: You can create multiple instances of `ARViewController` or its subclasses, but you can 't show them simultaneously. And keep in mind that each instance of `ARViewController` or its subclass uses the same view for rendering. Be careful with the view states.

### `ARHandlerProtocol`

The `ARHandlerProtocol` provides a mechanism for your application to handle features of `ARViewController(Objc)`.

* Take screenshot of camera view, ignoring any overlapping UI elements;
* Get the current state of the scanner;
* Start/stop scanning;
* Clean augmented reality view and destroy all loaded data;
* Enable/disable and check current state of flash;

The `ARHandlerProtocol` should not be used before `ARViewController` view will be loaded. It will not trigger crash or an unexpected behavior, but triggered action will not have any effect. You will receive warning message in debug output.

## Delegate

The `ARDelegate` protocol provides a mechanism for your application to take action on events that occur in the `ARViewController(Objc)`. You can use these callbacks by assigning an object to the `ARViewController` delegate property directly or connect through Interface Builder.

* `recognizedMarker(withId markerId: Int, assetIds: [Int])`  - Function will be executed when marker has been recognized;
* `recognitionTimeoutReached` - Function will be executed when timeout is reached and no one marker is recognized;
* `assetClicked(with assetId: Int)` - Function will be executed on click of any asset;
* `viewStateChanged(_ state: ARViewState)` - Function will be executed when BearSDK Scanner has changed state;
* `didFail(withError error: BearError)` - Function will be executed when an error occurs while the BearSDK is loading content;

## Advanced

This section will provide more advanced features available in the BearSDK. Sample code is also available in our sample application.

### Show Marker Without Scanning

The BearSDK also provides a method to display a marker without scanning it: `showARSceneWithoutTracking(withMarkerId id: Int)`. Obviously you need the marker id to call this method.

The behavior is the same as when a marker is recognized from scan, but without tracking assets on the marker:

* The marker and its assets will be displayed in the augmented reality view;
* The scanner status will be changed to `processing` and after that to `rendering` or `didFail(withError:)` will be called if an error occurs.

### Release resources

You may need to release the memory used by BearSDK, so you have to use `releaseResources` method. Resources will be acquired again when the new `ARViewController` or its subclass is initialized.

* `isLoaded` - The status of the BearSDK resources;
* `releaseResources` - Releases all BearSDK support resources. Ex.: default textures, initialized trackers and etc.

> Note: once loaded Bear SDK resources will be kept until `releaseResources` is called. You should only release resources when user finishes enjoying augmented reality and switches to other app features.

### Pause/Resume camera

In most cases BearSDK will control pause/resume camera automatically. But if you are need very specific behavior, you can disable automatic camera control and do it manually.

* In `ARViewController` you have to change `automaticCameraControl` property to `false`;
* Manage manually pause/resume camera using `ARViewController` `handler` object functions `resumeCamera(animated: Bool)` and `pauseCamera(animated: Bool)`.

### Push Notifications

ARGO Manager provides feature to manage application notification. This section explains how to enable this feature in BearSDK by linking it to Firebase.

The Firebase integration is handled application side and not inside BearSDK. Don't hesitate to check [Firebase instruction](https://firebase.google.com/docs/cloud-messaging/ios/client) for adding Firebase to your application and setup your Firebase cloud messaging client.

For the notifications to work with BearSDK, you must provide to ARGO your Apple Push Notifications Authentication Key.
You can create it in [Developer Apple](https://developer.apple.com).

Finally you need to call `BearSDK.shared.registerDevice(withFcmToken token: String)` with the FCM token. The FCM token can be retrieved in the `func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String)` method:

``` swift
extension AppDelegate: MessagingDelegate {

    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        BearSDK.shared.registerDevice(withFcmToken: fcmToken)
    }
}
```

To request APN token you have to execute:

``` swift
UNUserNotificationCenter.current()
    .requestAuthorization(options: [.badge, .alert , .sound]) { (granted, error) in
        guard granted else { return }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
}
```

This way the FCM token will be linked to the device id assigned at ARGO Backend. You can retrieve this device id in your application by calling `BearSDK.shared.deviceId` method.
