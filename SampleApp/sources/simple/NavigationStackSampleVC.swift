//
//  NavigationStackSampleVC.swift
//  SampleApp
//
//  Copyright © 2017 BEAR SAS. All rights reserved.
//

import UIKit

final class NavigationStackSampleVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "withNavigationSample" {
            let vc = segue.destination as! CustomSDKViewController
            vc.hideNavBar = false
        }
    }
}
