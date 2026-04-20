//
//  ViewController.swift
//  BasicNavigationController
//
//  Created by Tecsup on 20/04/26.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Modal Screen"

    }

    @IBAction func dismissButtonTapped(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
}

