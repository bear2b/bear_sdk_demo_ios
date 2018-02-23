//
//  HistorySampleVC.swift
//  SampleApp
//
//  Copyright © 2018 BEAR SAS. All rights reserved.
//

import UIKit

final class HistorySampleVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "history" {
            let vc = segue.destination as! CustomSDKViewController
            vc.enableHistory = true
        }
    }
}
