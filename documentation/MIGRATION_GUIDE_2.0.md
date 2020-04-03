# Migrate to BearSDK 2.0

Latest release of BearSDK brings many improvements and better practices to make your integration smoother.

## General improvements

* https support.
* removed the most part of external dependencies.
* reduced size of sdk approximately twice.
* optimized unloading resources.
* removed unnecessary debug logs.
* reworked sdk initialization process.

 This section describes what steps you need to follow to update your application with the version 2.0 of the BearSDK.

## Update dependency version

* Update your dependency manager file

### Carthage example

before:

``` bash
github "Alamofire/Alamofire" "4.5.1"
github "Hearst-DD/ObjectMapper" "3.0.0"
github "ReactiveX/RxSwift" "3.6.1"
github "Swinject/Swinject" "2.1.1"
github "Swinject/SwinjectStoryboard" "1.1.2"
github "marketplacer/keychain-swift" "9.0.2"
github "onevcat/Kingfisher" "4.1.0"
github "realm/realm-cocoa" "v2.10.2"
```

after:

``` bash
github "Alamofire/Alamofire" "4.6.0"
github "ReactiveX/RxSwift" "4.1.1"
```

* update manually `BearSDK.framework` file and remove `BearGL.framework` from embedded binaries.
Starting version 2.0 `BearSDK` and `BearGL` merged together to simplify integration process.

Embedded Binaries section after update:
![Embedded Binaries](https://developer.bear2b.com/wp-content/uploads/2018/01/embeddedbinaries.png)

## Change your application Info.plist

### `NSAllowsArbitraryLoads` not required starting version 2.0

* [Apple Transport Security (ATS)](https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-SW14).

By default BearSDK supports content only through `https`. Thats why you have to use only `https` in BEAR Frontend.

If you want to support `http` at your own risk - you are able to specify `NSAllowsArbitraryLoads` key to `true` in `NSAppTransportSecurity`.

``` xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## AppDelegate class

The `config1.1.data` asset resource file is not used anymore. You have to use the secret key instead which is provided by BEAR (for development process you can use the [sample application one](https://github.com/bear2b/bear_sdk_demo_ios/blob/808c59f36678f219b50703ac1be3377d90daaba9/SampleApp/sources/AppDelegate.swift#L15-L28)). Use this secret key as parameter in the [`BearSDK.set(secretKey: String)`](https://github.com/bear2b/bear_sdk_demo_ios/blob/808c59f36678f219b50703ac1be3377d90daaba9/SampleApp/sources/AppDelegate.swift#L32) method.

You only need to initialize the BearSDK in your [`AppDelegate`](https://github.com/bear2b/bear_sdk_ios/blob/master/SampleApp/sources/AppDelegate.swift) class:

``` swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    try! BearSDK.set(secretKey: secretKey)
    return true
}
```

## `BearSDK` class

The `BearApp` class renamed to `BearSDK`:

* added:
  * `shared` - Shared instance of BearSDK.
  * `set(secretKey:) throws` - Setup secret key to configure BearSDK.
  * `destroy` - Destroys all loaded BearSDK resources.
  * `preload(_ bearDidLoad: (() -> Void)?)` - Preloads BearSDK resources to reduce loading time of `BearViewController`.
  * `isLoaded:` - The status of BearSDK resources.
* changed:
  * `registerDevice(_ deviceToken: Data?)` to `registerDevice(withDeviceToken token: Data)`
  * `getDeviceId` to `deviceId`
* removed:
  * `init?(withUserConfig:)`  - use `shared` instead.
  * `getCameraViewController(onDismiss:, bearLoaded:)`  - use `BearViewController` instead.
  * `getHandler:` - use `handler` property of `BearViewController` instead.
  * `setMarkerCallback(_ callback:)` - use `delegate` property of `BearViewController` instead.

## `BearConfigProtocol`

The `BearConfigProtocol` does not exist anymore, to setup `timeToPause` and `scannerColor` you have to use the same properties in `BearViewController`.

## `CameraViewController` class

Since `BearApp` was removed and hence `getCameraViewController` method too, you are able to create `BearViewController` the way you want.
You are able to create instances of `BearViewController` subclasses programmatically or using Interface Builder and use those objects to provide the specific behaviors and visual appearances that you need.

> Note: You are able to create multiple instances of `BearViewController` or it subclasses, but you are not able to show them simultaneously. And keep in mind that every instance of `BearViewController` or it subclass uses the same view for render. Be careful with view states.

## `MarkerCallback`

The delegate of BearSDK moved from `BearApp` class to `BearViewController`. Since version 2.0 it is acceptable using `delegate` property of `BearViewController`.

`MarkerCallback` has been renamed to `BearDelegate`.

* added:
  * `assetClicked(with assetId:)` - Function will be executed on click of any asset.
  * `scannerStateChanged(_ state:)` - Function will be executed when BearSDK Scanner has changed state.
  * `reachabilityStatusChanged(_ reachable:)` - Function will be executed on change of reachability status.
  * `didFail(withError error:)` - Function will be executed when an error occurs while the BearSDK is loading content.
* changed `noMarkerFound` to `markerNotRecognized`.

## `BearHandlerProtocol`

The handler of BearSDK features moved from `BearApp` class to `BearViewController`. Since version 2.0 it is acceptable using `handler` property of `BearViewController`.

Changed `BearHandlerProtocol`:

* added:
  * `scannerState`
  * `resumeCamera(animated:)`
  * `pauseCamera(animated:)`
  * `isFlashEnabled`
  * `isNetworkReachable`
* changed:
  * `showShare(fromRect rect: CGRect)` to `takeScreenshot` - now this function takes screenshot of camera view, ignoring any overlapping UI elements.
  * `startScan` to `startScanning`.
  * `stopScan` to `stopScanning`.
  * `showMarkerInFreezedMode(id:)` to `showARSceneWithoutTracking(withMarkerId id:)`.
* removed:
  * `dismiss` - use native dismiss functions instead.
  * `clearView` - use `cleanView` instead.
  * `showMarkerInFreezedMode(targetId:)` - use `showARSceneWithoutTracking(withMarkerId id:)` instead.

## New classes

* `BearError` exposes short description, type and in some cases reason of occurred error.
  * `type`
  * `shortDescription`
  * `reason`
* `BearErrorType`  describes type of occurred error.
  * `invalidSecretKey`
  * `network`
  * `decoding`
  * `backend`
  * `specific`
  * `unknown`
* `BearScannerState` is used to describe possible BearSDK scanner states.
  * `idle`
  * `scanning`
  * `processing`
  * `rendering`
* `BearViewController`  provides a infrastructure for your application to manage BearScanner.
  * `timeToPause` time after that scanner will be paused.
  * `scannerColor` scanning line color.
  * `disableCameraAutoHandling` disables automatic camera handling.
  * `handler` object to control Bear scanner features.
  * `delegate` used to receive scanning callbacks.
* `BearViewControllerObjc`  the same as `BearViewController` for Objective-C support. Because swift forbids subclasses from swift classes.
