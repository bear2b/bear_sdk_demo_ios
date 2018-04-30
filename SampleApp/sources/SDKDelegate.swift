//
//  SDKDelegate.swift
//  SampleApp
//
//  Copyright © 2016-2018 BEAR SAS. All rights reserved.
//

import Foundation
import BearSDK

@objc final class SDKDelegate: NSObject, BearDelegate {

    func markerNotRecognized() {
        debugPrint("called \(#function)")
    }
    
    func scannerStateChanged(_ state: BearScannerState) {
        debugPrint("scanStateChanged \(state)")
    }
    
    func recognizedMarker(withId markerId: Int, assetIds: [Int]) {
        debugPrint("callback \(markerId), assets ids \(assetIds)")
        cacheRecognized(markerId: markerId)
    }
    
    func assetClicked(with assetId: Int) {
        debugPrint("assetClicked with id = \(assetId)")
    }
    
    func didFail(withError error: BearError) {
        debugPrint("called \(#function)")
    }
}
