# Migrate to BearSDK 3.0

Latest release of BearSDK brings many improvements and better practices to make your integration smoother.

## General changes

* Starting from version 3.0 BearSDK supports iOS 11+.
If you need to support iOS 9+ - check [BearSDK versions 2.X.X](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.2.2);
* Unified secret key. Now you can use the same key for Android and iOS SDK;

## Secret Key

Secret key has been improved to be more secure and robust. This means that previously provided secret keys will no longer be
working with SDK version 3.0 and new one has to be provided by ARGO.

 This section describes what steps you need to follow to update your application with the version 3.0 of the BearSDK.

## Update dependency version

### Carthage example

``` bash
github "Alamofire/Alamofire" == 5.0.5
github "ReactiveX/RxSwift" == 5.1.1
binary "https://s3.eu-west-1.amazonaws.com/mobile-dev.bear2b.com/bearsdk-ios/BearSDK.json" == 3.0
```

* Add to *Frameworks, Libraries, and Embedded Content* section in your project `BearGL.framework` and `Vuforia.framework` together with `BearSDK.framework`.

## Breaking API Changes

### `BearSDK`

* Changed:
  * `set(secretKey: String) throws` to `setSecretKey:(_ secretKey: String) throws`;
  * `registerDevice(withDeviceToken token: Data)` to `registerDevice(withFcmToken: String)`;
* Removed:
  * `preload(_ bearDidLoad: (() -> Void)?)`.

### `CameraViewController`

`CameraViewController` has been renamed to `ARViewController`.

* Changed:
  * `timeToPause` to `recognitionTimeout`;
  * `scannerColor` to `scanlineColor`;
  * `disableCameraAutoHandling` to `automaticCameraControl`.

### `BearDelegate`

`BearDelegate` has been renamed to `ARDelegate`.

* Changed:
  * `markerNotRecognized` to `recognitionTimeoutReached`;
  * `scannerStateChanged(_ state:)` to `viewStateChanged(_ state: ARViewState)`;
* Removed:
  * `reachabilityStatusChanged(_ reachable:)`.

### `BearHandlerProtocol`

`BearHandlerProtocol` has been renamed to `ARHandlerProtocol`.

* Changed:
  * `scannerState` to `viewState: ARViewState { get }`
* Removed:
  * `isNetworkReachable`.

### `BearScannerState`

`BearScannerState` has been renamed to `ARViewState`.

* Changed:
  * `rendering` to `tracking`.
