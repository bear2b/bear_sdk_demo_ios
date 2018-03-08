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
    @IBOutlet weak var preloadAndDestroy: UIBarButtonItem?
    @IBOutlet weak var toolbar: UIToolbar!
    
    private static let reuseIdentifier = "historyReuseId"
    private let recognizedMarkers = UserDefaults.standard.array(forKey: UserDefaultKeys.recognizedMarkers) as? [Int] ?? []
    private let preloadTitle = "preload", destroyTitle = "destroy"
    var hidePreloadBtn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if hidePreloadBtn {
            toolbar.items?.removeFirst()
        }
        
        if recognizedMarkers.count == 0 {
            let label = UILabel()
            label.text = "Scanned markers will appear here.\nYou can scan using any of samples"
            label.numberOfLines = 2
            label.sizeToFit()
            view.addSubview(label)
            label.center = view.center
        }
    }
    
    @IBAction func preloadTapped() {
        guard let preloadDestroy = preloadAndDestroy else { return }
        if BearSDK.shared.isLoaded {
            BearSDK.shared.destroy()
            preloadDestroy.title = preloadTitle
        } else {
            BearSDK.shared.preload {
                preloadDestroy.title = self.destroyTitle
                preloadDestroy.isEnabled = true
            }
            preloadDestroy.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preloadAndDestroy?.title = BearSDK.shared.isLoaded ? destroyTitle : preloadTitle
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
        return recognizedMarkers.count
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
        vc.handler.showARSceneWithoutTracking(withMarkerId: recognizedMarkers[indexPath.row])
        show(vc, sender: self)
    }
}
