//
//  NoStoryboardSampleVC.swift
//  SampleApp
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

import UIKit
import BearSDK

final class NoStoryboardSampleVC: UIViewController {
    
    @IBAction func showBearScanner() {
        let vc = NoStoryboardViewController()
        vc.delegate = vc
        vc.scannerColor = UIColor.black
        vc.timeToPause = 5
        
        show(vc, sender: self)
    }
    
    @IBAction func goBack() {
        dismiss(animated: true, completion: nil)
    }
}
