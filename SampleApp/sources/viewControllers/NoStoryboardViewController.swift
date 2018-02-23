//
//  NoStoryboardViewController.swift
//  SampleApp
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

import Foundation
import BearSDK

final class NoStoryboardViewController: BearViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(type: .custom)
        btn.setTitle("dismiss", for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        btn.frame.origin = CGPoint(x: 20, y: UIApplication.shared.statusBarFrame.height)
        view.addSubview(btn)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        handler.cleanView()
        super.viewDidDisappear(animated)
    }
    
    @objc func dismissTapped() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension NoStoryboardViewController: BearDelegate {
    func recognizedMarker(withId markerId: Int, assetIds: [Int]) {
        debugPrint("called \(#function)")
        cacheRecognized(markerId: markerId)
    }
    
    func markerNotRecognized() {
        debugPrint("called \(#function)")
    }
    
    func assetClicked(with assetId: Int) {
        debugPrint("called \(#function)")
    }
    
    func scannerStateChanged(_ state: BearScannerState) {
        debugPrint("called \(#function), state - \(state.rawValue)")
    }
    
    func didFail(withError error: BearError) {
        debugPrint("called \(#function)")
    }
    
    func reachabilityStatusChanged(_ reachable: Bool) {
        debugPrint("called \(#function)")
    }
}
