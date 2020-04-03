//
//  SDKDelegate.swift
//  SampleApp
//
//  Copyright © 2016-2020 BEAR SAS. All rights reserved.
//

import Foundation
import BearSDK

@objc final class SDKDelegate: NSObject, ARDelegate {
    
    func recognizedMarker(withId markerId: Int, assetIds: [Int]) {
        print("called \(#function)")
        cacheRecognized(markerId: markerId)
    }
    
    func recognitionTimeoutReached() {
        print("called \(#function)")
    }

    func assetClicked(with assetId: Int) {
        print("called \(#function)")
    }
    
    func viewStateChanged(_ state: ARViewState) {
        print("called \(#function), state - \(state.rawValue)")
    }
    
    func didFail(withError error: BearError) {
        print("called \(#function)")
    }
}
