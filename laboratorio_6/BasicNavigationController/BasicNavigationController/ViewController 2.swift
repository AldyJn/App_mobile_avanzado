//
//  ViewController.swift
//  BasicNavigationController
//
//  Created by Tecsup on 20/04/26.
//

import UIKit

class SecondViewController: UIViewController {
    
    var receivedMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Message Received"
        messageLabel.text = receivedMessage
    }

    @IBOutlet weak var messageLabel: UILabel!
    
}

