# BearSDK iOS

Augmented reality simple and powerful.

- [Introduction](#introduction)
- [How to add BearSDK to your application](#how-to-add-bearsdk-to-your-application)
- [Initialization](#initialization)
- [Implementation](#implementation)
    - [`BearViewController` ](#bearviewcontroller)
    - [`BearHandlerProtocol` ](#bearhandlerprotocol)
- [Delegate](#delegate)
- [Advanced](#advanced)
    - [Show Marker Without Scanning](#show-marker-without-scanning)
    - [Preload/Destroy resources](#preloaddestroy-resources)
    - [Pause/Resume camera](#pauseresume-camera)
    - [Push Notifications](#push-notifications)
- [API Reference](https://bear2b.github.io/private_bear_sdk_ios/)

## Introduction

Welcome to the Bear SDK. This document is designed to help you from your very first steps with the Bear SDK all the way through to advanced concepts and examples for developing your augmented reality project.

### SDK and sample apps requirements:
+ iOS 9.0 and higher
+ Xcode 9.2 and higher
+ Swift 4.0 and higher (or Objective-C)
+ A valid [iOS Development Certificate](https://developer.apple.com/programs/)

### How to run sample apps:
The BearSDK is already integrated in the project.

* Download [sample apps repository](https://github.com/bear2b/bear_sdk_demo_ios).
* Bootstrap dependencies

``` bash
carthage bootstrap --platform iOS
```

* Open `BearSDK.workspace` in XCode.
* Setup certificates.
* Run `SampleApp` or `SampleAppObjc` scheme on your device (**running on simulator is not available with the SDK**).

### Sample markers:

Once you compiled and installed the application on a physical device, you can scan the markers located in the [markers](https://github.com/bear2b/bear_sdk_demo_ios/tree/master/markers) folder.

These are examples to show you preview of augmented targets using [Bear Go](https://go.bear2b.com)

## How to add BearSDK to your application:

### Download [sample apps repository](https://github.com/bear2b/bear_sdk_demo_ios).

### Bootstrap dependencies:

You can download dependencies using any of your favorite dependency manager like: [Carthage](https://github.com/Carthage/Carthage) or [CocoaPods](https://github.com/CocoaPods/CocoaPods) or [Swift Package Manager](https://github.com/apple/swift-package-manager).
Example of `Cartfile` included in sample app.

#### [Carthage](https://github.com/Carthage/Carthage):
Add this to your `Cartfile` file:

```
github "Alamofire/Alamofire" "4.6.0"
github "ReactiveX/RxSwift" "4.1.2"
```

``` bash
carthage bootstrap --platform iOS
```

#### [CocoaPods](https://github.com/CocoaPods/CocoaPods):
Add this to your `Podfile` file:

``` ruby
platform :ios, '9.0'
use_frameworks!

target `YourApp` do
    pod 'Alamofire', '4.6.0'
    pod 'RxCocoa', '4.1.2'
    pod 'RxSwift', '4.1.2'
end
```

``` bash
pod install
```

### Copy manually BearSDK framework from bear_sdk_demo_ios folder to your project folder.

### Add BearSDK and other dependencies to your project into *Embedded Binaries* section.

![Embedded Binaries](https://developer.bear2b.com/wp-content/uploads/2018/01/embeddedbinaries.png)

### Change the application Info.plist file:

#### Mandatory:

* Add camera usage description to describe how app will use camera.

``` xml
<key>NSCameraUsageDescription</key>
<string>Camera will let you scan pages</string>
```

#### Optional:

* if you want to use facebook assets with deeplinks to go from your application to facebook app directly - setup this key to your app info.plist.

``` xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>fb</string>
</array>
```

* Add locatiion usage description if you want to use gelolalized markers.

``` xml
<key>NSLocationWhenInUseUsageDescription</key>
<string></string>
```

* Add photo library usage description if you want to provide ability to save images or screenshots to camera roll.

``` xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Save images and screenshots</string>
```

* And add this new key for the same thing for iOS 11.

``` xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Save images and screenshots</string>
```

* [Apple Transport Security (ATS)](https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14).

By default BearSDK supports content only through `https`. Thats why you have to use only `https` in BEAR Frontend.

If you want to support `http` at your own risk - you are able to specify `NSAllowsArbitaryLoads` key to `true` in `NSAppTransportSecurity`.

``` xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### Disable bitcode in *Build Settings*:

![Bitcode](https://developer.bear2b.com/wp-content/uploads/2018/01/bitcode.png)

## Initialization

The SDK must be configured with secret key before starting BearSDK usage.

``` swift
try? BearSDK.set(secretKey: "")
```

You have to call the `BearSDK.set(secretKey: "")` method using a secret key as parameter. You can check the sample app and use its secret key during your development cycle. However you have to use your own secret key before submitting your application to production (this secret key will be provided by BEAR).

## Implementation

You can display and use the augmented reality view using `BearViewController` class and it's handler `BearHandlerProtocol`.

### `BearViewController`

The `BearViewController` provides a infrastructure for your application to manage BearScanner.
You are able to create instances of `BearViewController` subclasses and use those objects to provide the specific behaviors and visual appearances that you need.
You are able to specify these scanner properties in subclass or Interface Builder:

* `timeToPause` - The time after that scanner will be paused. The default value of this property is 10 seconds.
* `scannerColor` - Customize scanning line color. The default value of this property is purple color.
* `delegate` - Use your own `BearDelegate` implementation. Delegate provides a mechanism for your application to take action on events that occur in the `BearViewController`.

To get more information about `BearDelegate` take a look on [special `BearDelegate` article](#delegate).

> Note: You are able to create multiple instances of `BearViewController` or it subclasses, but you are not able to show them simultaneously. And keep in mind that every instance of `BearViewController` or it subclass uses the same augmented reality view for render. Be careful with view states.

### `BearHandlerProtocol`

The `BearHandlerProtocol` provides a mechanism for your application to handle features of `BearViewController(Objc)`.

* Take screenshot of camera view, ignoring any overlapping UI elements.
* Get the current state of the scanner.
* Start/stop scanning.
* Clean augmented reality view and destroy all loaded data.
* Enable/disable and check current state of flash.
* Check the current network reachability status.

>  Note: The `BearHandlerProtocol` should not be used before `BearViewController` view will be loaded. It will not trigger crash or an unexpected behaviour, but triggered action will not have any effect. You will receive warning message in debug output.

## Delegate

The `BearDelegate` protocol provides a mechanism for your application to take action on events that occur in the `BearViewController(Objc)`. You can make use of these calls by assigning an object to the `BearViewController` delegate property directly or connect through Interface Builder.

* `recognizedMarker(withId markerId: Int, assetIds: [Int])`  - Function will be executed when marker has been recognized.
* `markerNotRecognized` - Function will be executed when timeout is reached and no one marker is recognized.
* `assetClicked(with assetId: Int)` - Function will be executed on click of any asset.
* `scannerStateChanged(_ state: BearScannerState)` - Function will be executed when BearSDK Scanner has changed state.
* `reachabilityStatusChanged(_ reachable: Bool)` - Function will be executed on change of reachability status.
* `didFail(withError error: BearError)` - Function will be executed when an error occurs while the BearSDK is loading content.

## Advanced

This section will provide more advanced features available in the BearSDK. Sample code is also available in our sample application.

### Show Marker Without Scanning

The BearSDK also provides a method to display a marker without scanning it: `showARSceneWithoutTracking(withMarkerId id: Int)`. Obviously you need the marker id to call this method.

The behavior is the same as when a marker is recognized from scan, but without tracking assets on the marker:

* The marker and its assets will be displayed in the augmented reality view
* The scanner status will be changed on `processing` and after that on `rendering` or `didFail(withError:)` will be called if an error occurs.

### Preload/Destroy resources

To reduce loading and appearing time of `BearViewCotroller` you could preload the BearSDK resources. At the same time you may need to release the memory used by BearSDK you have to use `destroy` method.

* `preload(_ bearDidLoad: (() -> Void)?)` - Preloads the BearSDK resources, `bearDidLoad`  closure will be executed when all resources will be loaded.
* `isLoaded` - The status of the BearSDK resources.
* `destroy` - Destroys all loaded BearSDK resources.

> Note: once loaded Bear SDK resources will be kept until `destroy` is called.

### Pause/Resume camera

In most cases BearSDK will handle pause/resume camera automatically. But if you are need very specific behaviour, you can disable automatic camera handling and do it manually.

* In `BearViewCotroller` you have to change `disableCameraAutoHandling` property to `true`.
* Manage manually pause/resume camera using `BearViewController` `handler` object functions `resumeCamera(animated: Bool)` and `pauseCamera(animated: Bool)`.

### Push Notifications

BEAR frontend provides feature to manage application notification. This section explains how to enable this feature in BearSDK.

For the notifications to work with BearSDK, you must provide to BEAR your Apple Push Services certificate (*.pem file).

Finally you need to call `BearSDK.shared.registerDevice(withDeviceToken token: Data)` with the APN token. The APN token can be retrieved in the `UIApplicationDelegate.didRegisterForRemoteNotificationsWithDeviceToken` method:

``` swift
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    BearSDK.shared.registerDevice(withDeviceToken: deviceToken)
}
```

To request APN token you have to execute:

``` swift
if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert , .sound]) { (granted, error) in
        guard granted else { return }
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
} else {
    let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
    UIApplication.shared.registerUserNotificationSettings(settings);
    UIApplication.shared.registerForRemoteNotifications();
}
```

This way the Apple Push Notifications token will be linked to the device id assigned at BEAR backend. You can retrieve this device id in your application by calling `BearSDK.shared.deviceId` method.
