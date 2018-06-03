//
//  AppDelegate+ShakeMotion.swift
//  Smogler
//
//  Created by Dominik Bucher on 03/06/2018.
//  Copyright © 2018 vasarhelyia. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let alertController = UIAlertController(title: "Enter your API Token", message: nil, preferredStyle: .alert)
            alertController.addTextField { textfield in
                textfield.placeholder = "Your generated API Token"
            }

            let action = UIAlertAction(title: "OK", style: .default) { [weak alertController] action in
                guard let apiToken = alertController?.textFields?.first?.text else { return }
                kToken = apiToken
            }
            alertController.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
