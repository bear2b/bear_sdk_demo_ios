//
//  NoStoryboardSampleVC.swift
//  SampleApp
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

import UIKit
import BearSDK

final class NoStoryboardSampleVC: UIViewController {
    
    @IBAction func showBearScanner() {
        let vc = NoStoryboardViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = vc
        vc.scanlineColor = .black
        vc.recognitionTimeout = 5
        
        show(vc, sender: self)
    }
    
    @IBAction func goBack() {
        dismiss(animated: true, completion: nil)
    }
}
