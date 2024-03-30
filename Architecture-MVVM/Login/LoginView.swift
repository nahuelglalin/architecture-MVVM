//
//  ViewController.swift
//  Architecture-MVVM
//
//  Created by Nahuel Lalin on 29/03/2024.
//

import UIKit
import Combine

class LoginView: UIViewController {
    private let loginViewModel = LoginViewModel(apiClient: APIClient())
    
    var cancellables = Set<AnyCancellable>()
    
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Add Email"
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Add Password"
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        configuration.imagePadding = 8
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] action in
            self?.startLogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBindingViewWithViewModel()
        [emailTextField, passwordTextField, loginButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func startLogin() {
        loginViewModel.userLogin(withEmail: emailTextField.text?.lowercased() ?? "",
                                 password: passwordTextField.text?.lowercased() ?? "")
    }
    
    
    func createBindingViewWithViewModel() {
        emailTextField.textPublisher
            .assign(to: \LoginViewModel.email, on: loginViewModel)
            .store(in: &cancellables)
        
        passwordTextField.textPublisher
            .assign(to: \LoginViewModel.password, on: loginViewModel)
            .store(in: &cancellables)
        
        loginViewModel.$isButtonEnabled
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)
        
        loginViewModel.$showLoading
            .assign(to: \.configuration!.showsActivityIndicator, on: loginButton)
            .store(in: &cancellables)
    }
}

// Extension to publish a notification when value in textfield changes
extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { notification in
                return (notification.object as? UITextField)?.text ?? ""
            }
            .eraseToAnyPublisher()
    }
}
