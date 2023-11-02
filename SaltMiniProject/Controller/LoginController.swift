//
//  LoginController.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import UIKit

class LoginController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    private let emailTextField = CustomTextField(fieldType: .email)
    private let passwordTextField = CustomTextField(fieldType: .password)
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    
    private let userListViewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        AlertManager.showInvalidEmailAlert(on: self)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.emailTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 55),
            self.emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 22),
            self.passwordTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 22),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapSignIn() {
        userListViewModel.postLogin(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { success in
            if success {
                DispatchQueue.main.async {
                    let viewController = HomeController()
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: false, completion: nil)
                }
            }
        }
    }
}
