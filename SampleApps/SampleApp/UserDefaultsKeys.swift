//
//  UserDefaultsKeys.swift
//  SampleApp
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

import Foundation

struct UserDefaultKeys {
    private init() {}
    static let recognizedMarkers = "recognizedMarkers"
}

func cacheRecognized(markerId: Int) {
    let userDef = UserDefaults.standard
    var recogArr: [Int]
    if let cached = userDef.array(forKey: UserDefaultKeys.recognizedMarkers) as? [Int] {
        guard !cached.contains(markerId) else { return }
        recogArr = cached
        recogArr.append(markerId)
    } else {
        recogArr = [markerId]
    }
    userDef.set(recogArr, forKey: UserDefaultKeys.recognizedMarkers)
}
