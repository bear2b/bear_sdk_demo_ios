//
//  CustomSDKViewController.swift
//  SampleApp
//
//  Copyright © 2017-2020 BEAR SAS. All rights reserved.
//

import Foundation
import BearSDK
import UserNotifications

final class CustomSDKViewController: ARViewController {
    
    @IBOutlet weak var startStopBtn: UIButton!
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var screenshotBtn: UIButton!
    @IBOutlet weak var splashScreen: UIView!
    @IBOutlet weak var historyBtn: UIButton!
    
    var enableHistory: Bool = false
    var hideNavBar: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        historyBtn.isHidden = !enableHistory
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hideNavBar {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashScreen.isHidden = true
    }
    
    @IBAction func dismiss() {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func startStopTapped() {
        switch handler.viewState {
        case .idle:
            handler.startScanning()
        case .scanning:
            handler.stopScanning()
        default:
            return
        }
    }
    
    @IBAction func enableDisableFlash() {
        if !handler.isFlashEnabled {
            flashBtn.isSelected = handler.enableFlash()
        } else { 
            handler.disableFlash()
            flashBtn.isSelected = false
        }
    }
    
    @IBAction func showARSceneWithoutTracking() {
        handler.showARSceneWithoutTracking(withMarkerId: 226620)
    }
    
    @IBAction func takeScreenshot() {
        guard let screenshot = handler.takeScreenshot else {
            print("Failed to take screenshot")
            return
        }
        presentShare(withScreenshot: screenshot)
    }
    
    @IBAction func cleanView() {
        handler.cleanView()
    }
    
    @IBAction func registerNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.badge, .alert , .sound]) { (granted, error) in
                guard granted else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HistoryViewController {
            vc.hideUnloadBtn = true
        }
    }
    
    private func presentShare(withScreenshot screenshot: UIImage) {
        
        let activityVC = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceRect = screenshotBtn.frame
        activityVC.popoverPresentationController?.sourceView = view
        
        present(activityVC, animated: true, completion: nil)
    }
}

extension CustomSDKViewController: ARDelegate {
    
    func recognizedMarker(withId markerId: Int, assetIds: [Int]) {
        print("called \(#function), markerId = \(markerId), assetIds = \(assetIds)")
        cacheRecognized(markerId: markerId)
    }
    
    func recognitionTimeoutReached() {
        print("called \(#function)")
    }
    
    func assetClicked(with assetId: Int) {
        print("called \(#function), assetId = \(assetId)")
    }
    
    func viewStateChanged(_ state: ARViewState) {
        switch state {
        case .idle:
            print("idle")
            flashBtn.isSelected = false
            startStopBtn.isSelected = false
        case .scanning:
            print("scanning")
            startStopBtn.isSelected = true
        case .processing:
            print("processing")
            flashBtn.isSelected = false
        case .tracking:
            print("tracking")
            startStopBtn.isSelected = false
        }
    }
    
    func didFail(withError error: BearError) {
        print("called \(#function)")
        showAlert(withTitle: error.shortDescription, message: error.reason)
    }
    
    private func showAlert(withTitle title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

