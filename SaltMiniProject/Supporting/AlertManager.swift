//
//  AlertManager.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import UIKit

class AlertManager {
    private static func showBasicAlert(on viewController: UIViewController, with title: String, and message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}

// MARK: - Message
extension AlertManager {
    public static func showInvalidEmailAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, with: "Invalid Email", and: "Please enter valid email")
    }
    
    public static func showInvalidPasswordAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, with: "Invalid Password", and: "Please enter valid password")
    }
}

// MARK: - Login Error
extension AlertManager {
    public static func showLoginErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, with: "Error Log In", and: nil)
    }
    
    public static func showLoginErrorAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, with: "Error Log In", and: "\(error.localizedDescription)")
    }
}

// MARK: - Fetching User Error
extension AlertManager {
    public static func showFetchingUserErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, with: "Fetching User Error", and: nil)
    }
    
    public static func showFetchingUserErrorAlert(on viewController: UIViewController, with error: Error) {
        self.showBasicAlert(on: viewController, with: "Fetching User Error", and: "\(error.localizedDescription)")
    }
}
