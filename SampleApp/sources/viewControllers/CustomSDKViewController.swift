//
//  CustomSDKViewController.swift
//  SampleApp
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

import Foundation
import BearSDK
import UserNotifications

final class CustomSDKViewController: BearViewController {
    
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
        if handler.scannerState == .idle {
            handler.startScanning()
        } else if handler.scannerState == .scanning {
            handler.stopScanning()
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
        if let screenshot = handler.takeScreenshot {
            presentShare(withScreenshot: screenshot)
        }
    }
    
    @IBAction func cleanView() {
        handler.cleanView()
    }
    
    @IBAction func registerNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert , .sound]) { (granted, error) in
                guard granted else { return }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings);
            UIApplication.shared.registerForRemoteNotifications();
        }
    }
}

extension CustomSDKViewController: BearDelegate {
    func recognizedMarker(withId markerId: Int, assetIds: [Int]) {
        debugPrint("called \(#function), markerId = \(markerId), assetIds = \(assetIds)")
        cacheRecognized(markerId: markerId)
    }
    
    func scannerStateChanged(_ state: BearScannerState) {
        switch state {
        case .idle:
            debugPrint("idle")
            flashBtn.isSelected = false
            startStopBtn.isSelected = false
            return
        case .scanning:
            debugPrint("scanning")
            startStopBtn.isSelected = true
            return
        case .processing:
            debugPrint("processing")
            flashBtn.isSelected = false
            return
        case .rendering:
            debugPrint("rendering")
            startStopBtn.isSelected = false
            return
        }
    }
    
    func markerNotRecognized() {
        debugPrint("called \(#function)")
    }
    
    func assetClicked(with assetId: Int) {
        debugPrint("called \(#function), assetId = \(assetId)")
    }
    
    func reachabilityStatusChanged(_ reachable: Bool) {
        debugPrint("called \(#function), reachable = \(reachable)")
    }
    
    func didFail(withError error: BearError) {
        debugPrint("called \(#function)")
        showAlert(withTitle: error.shortDescription, message: error.reason)
    }
    
    private func showAlert(withTitle title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentShare(withScreenshot screenshot: UIImage) {
        
        let activityVC = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceRect = screenshotBtn.frame
        activityVC.popoverPresentationController?.sourceView = view
        
        present(activityVC, animated: true, completion: nil)
    }
}

