//
//  NoStoryboardViewController.swift
//  SampleApp
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

import Foundation
import BearSDK

final class NoStoryboardViewController: ARViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanlineColor = .green
        recognitionTimeout = 8
        
        let btn = UIButton(type: .custom)
        btn.setTitle("dismiss", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        view.addSubview(btn)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        let buttonOffset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: buttonOffset),
            btn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: buttonOffset)
        ])
    }
    
    @objc func dismissTapped() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension NoStoryboardViewController: ARDelegate {
    
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
