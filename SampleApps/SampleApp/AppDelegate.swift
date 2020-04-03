//
//  AppDelegate.swift
//  Sample App
//
//  Copyright © 2016-2020 BEAR SAS. All rights reserved.
//

import UIKit
import BearSDK
// required only if you want to use Push Notifications
// ******************************************
//import Firebase
// ******************************************

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let secretKey = """
    VD8L/DzF+CP7nWyTkW59mnVAT2asg3hC4e1SyfWdHY4R7Hphw34kB/q5v3e12cYivlAijX6p9s4DvfDHfjYuifrXgkESQD7KL1wjDWfTl5plzi/XDSNTOAyYVazyKL6U+PU5lWL2H2dfAGDJjGevfGlCiLyhhyMHZCt0zWdmvpBFTq1dp2rD/g3XMpx5dNinYDNIMdrSEg4RDACsULmTMgt2bVVkNRTUlb0CTEO2krZll1uCtzTpGa6VmMo8KNvnqF2NGZUxC4yxS/rqwSAVclaUL6E5Qi6p06s6gseAfbkW2h5mnbdNjfqPvt51BzutD2nCFLs+bolqYzOAv6O3W4h7Xm20TE1YmCESzShmlsaYDAOWv69UELBr2OxP7fn1UH+xy/ulZLTPUBV0b78Nkmwgnrq6mmzlxWiYMnI3zBxxfrWMMJ3v/yN9Xb+g5zxVHPc+P+ZQk2ESNINVSukVz9aZYJKGEz8w2kkErCpBSiE6KtHJ/cEKKu0E3nvS6T/FAliC1Xj4NcUrFlbFTnk8Dmzz2bVnMMkE7dC8SvqgLNqmdybckJ2sDI8I+pcsKNH6QBDP0Nbo5jH+vQtqAuWKErEH/rqhjcBWoL8OrbM2dJptaCivbtQw4ZCXkEeoWMtWvgD2QJnBWWqDo3VVCsD7aCHyhtP1f59z4iGLBw1qu9JsWrO2TRyz6kcLVggC6/wPU1eecYUTRLsXHf4iYgmJ4R2QbHy826BvDKAdBqcsxkPpK1kk22h9hWCiiKtz72ji6Ml2IXI0T4hjWJuMDSlBXRrcmaVCn+WLoMe+00dm5fZGQgpyKEYYC+ID9cUCNiqrEfInjA5yiPveTsRCTpTKO3jiHrV3tMS+Po/aFRUos3OdGewFfulpkCNOJZE0cKZjCEec0igyHzacsAbSLZoPyoDYeVdjFxV1J97CgNxv9ERR5yOjWZyev3X80rLwtWQeeOIetXe0xL4+j9oVFSizc8tUq6e0/MK+fVZyMO3rvgbtzZxh5V+avwK9oVgxT9Fj
    """
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
// required only if you want to use Push Notifications
// ******************************************
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
// ******************************************
        
        try! BearSDK.setSecretKey(AppDelegate.secretKey)
        
        print("device id \(BearSDK.shared.deviceId)")
        return true
    }
}

// required only if you want to use Push Notifications
// ******************************************
//extension AppDelegate: MessagingDelegate {
//
//    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        print("Device successfully registered for Firebase Cloud Messaging with token: \(fcmToken)")
//        BearSDK.shared.registerDevice(withFcmToken: fcmToken)
//    }
//}
// ******************************************
