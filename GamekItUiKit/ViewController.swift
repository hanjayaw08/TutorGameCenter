//
//  ViewController.swift
//  GamekItUiKit
//
//  Created by Hanjaya Putra Wijangga on 24/08/22.
//

import UIKit
import GameKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet weak var onlineButton: UIButton!
    @objc private func authenticationChanged(_ notification: Notification) {
      onlineButton.isEnabled = notification.object as? Bool ?? false
    }
    @IBAction func onlineButton(_ sender: Any) {
        GameCenterHelper.helper.presentMatchmaker()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onlineButton.isEnabled = GameCenterHelper.isAuthenticated

        GameCenterHelper.helper.viewController = self
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(authenticationChanged(_:)),
          name: .authenticationChanged,
          object: nil
        )
        
    }


}

