# Change Log

---

## [3.3](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.3) Xcode 13.1 / Swift 5.5.1

### Changed

* recompiled with Xcode 13.1, Swift 5.5.1;

### Dependencies

* Alamofire 5.4.3 -> 5.4.4;
* RxSwift 5.1.2 -> 5.1.3;

## [3.2.1](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.2.1) Xcode 12.5 / Swift 5.4

### Fixed

* media player from marker wasn't playing sometimes;
* GLView wasn't adapting its frame to parent changes;

## [3.2](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.2) Xcode 12.5 / Swift 5.4

### Added

* disable using IDFA by default and add ability to re-enable it in config;

### Changed

* recompiled with Xcode 12.5, Swift 5.4;

## [3.0.8](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.0.8) Xcode 12.4 / Swift 5.3.2

### Changed

* recompiled with Xcode 12.4, Swift 5.3.2 [#9](https://github.com/bear2b/bear_sdk_demo_ios/issues/9);

### Fixed

* carthage issue for Xcode 12

## [3.0.5](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.0.5) Xcode 11.6 / Swift 5.2.4

### Added

* support binding for Xamarin;

## [3.0.3](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.0.3) Xcode 11.5 / Swift 5.2.4

### Fixed

* fatal error in SystemApp fetching if framework is build for debug, #6;

## [3.0.1](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.0.1) Xcode 11.4 / Swift 5.2

### Fixed

* threading issue (cocoapods only), #4;

## [3.0](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/3.0) Xcode 11.4 / Swift 5.2

### Added

* support for iOS simulator;
* ability to play in loop 3D object animation;
* audio on texture;
* video on texture with alpha channel;

### Changed

* recompiled with Xcode 11.4, Swift 5.2;

### Removed

* iOS 9 support;
* 32-bits support;

### Fixed

* error with determining the size of the video frame;

## [2.2.2](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.2.2) Xcode 11.3 / Swift 5.1.3

### Changed

* recompiled with Xcode 11.3, Swift 5.1.3;

### Fixed

* wrong viewport for landscape only orientation;

## [2.2.1](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.2.1) Xcode 11.2 / Swift 5.1.2

### Changed

* recompiled with Xcode 11.2, Swift 5.1.2;

## [2.2.0](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.2.0) Xcode 11.0 / Swift 5.1

### Changed

* recompiled with Xcode 11.0, Swift 5.1;
* dependencies to latest available versions;

## [2.1.0](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.1.0) Xcode 10.2.1 / Swift 5.0.1

### Changed

* recompiled with Xcode 10.2.1, Swift 5.0.1;
* dependencies to latest available versions;

## [2.0.11](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.11) Xcode 10.1 / Swift 4.2

### Changed

* recompiled with  Xcode 10.1, Swift 4.2;
* dependencies to latest available versions;

## [2.0.10](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.10) Xcode 9.4.1 / Swift 4.1.2

### Fixed

* improved video streaming stability;

## [2.0.8](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.8) Xcode 9.4.1 / Swift 4.1.2

### Fixed

* bug with video which contains mp3 audio;
* memory usage overhead with long videos;

## [2.0.7](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.7) Xcode 9.4.1 / Swift 4.1.2

### Fixed

* possible to choose scan line color when using preload method;

## [2.0.6](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.6) Xcode 9.4 / Swift 4.1.2

### Changed

* recompiled with  Xcode 9.4, Swift 4.1.2;
* dependencies to latest available versions;

## [2.0.5](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.5) Xcode 9.3 / Swift 4.1

### Changed

* all `BearDelegate` functions are made optional;

### Deprecated

* `BearHandlerProtocol` - `isNetworkReachable`;
* `BearDelegate` -  `reachabilityStatusChanged(_ reachable:)`;

## [2.0.4](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.4) Xcode 9.3 / Swift 4.1

### Changed

* recompiled with Xcode 9.3, Swift 4.1;
* dependencies to the latest available versions;

## [2.0.3](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.3) Xcode 9.2 / Swift 4.0.3

### Changed

* reduced sdk size;

### Fixed

* reduced memory usage;
* flash issue;

## [2.0.1](https://github.com/bear2b/bear_sdk_demo_ios/releases/tag/2.0.1) Xcode 9.2 / Swift 4.0.3

* minor bugfixes.
