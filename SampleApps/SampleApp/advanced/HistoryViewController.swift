//
//  HistoryViewController.swift
//  SampleApp
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

import UIKit
import BearSDK

final class HistoryViewController: UIViewController {

    @IBOutlet weak var dismissBtn: UIBarButtonItem!
    @IBOutlet weak var unloadBtn: UIBarButtonItem?
    @IBOutlet weak var toolbar: UIToolbar!
    
    private static let reuseIdentifier = "historyReuseId"
    private let recognizedMarkers = UserDefaults.standard.array(forKey: UserDefaultKeys.recognizedMarkers) as? [Int] ?? []
    var hideUnloadBtn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hideUnloadBtn {
            toolbar.items?.removeFirst()
        }
        
        if recognizedMarkers.isEmpty {
            let label = UILabel()
            label.text = "Scanned markers will appear here.\nYou can scan using any of samples"
            label.numberOfLines = 2
            label.sizeToFit()
            view.addSubview(label)
            label.center = view.center
        }
    }
    
    @IBAction func unloadTapped() {
        guard let destroy = unloadBtn, BearSDK.shared.isLoaded else {
            return print("BearSDK is not loaded, nothing to destroy")
        }
        BearSDK.shared.releaseResources()
        destroy.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unloadBtn?.isEnabled = BearSDK.shared.isLoaded
        if let nav = navigationController {
            nav.setNavigationBarHidden(false, animated: animated)
            dismissBtn.isEnabled = false
        }
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recognizedMarkers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryViewController.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "\(recognizedMarkers[indexPath.row])"
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoStoryboardViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.handler.showARSceneWithoutTracking(withMarkerId: recognizedMarkers[indexPath.row])
        show(vc, sender: self)
    }
}
