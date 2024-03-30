//
//  LoginViewModel.swift
//  Architecture-MVVM
//
//  Created by Nahuel Lalin on 29/03/2024.
//

import Foundation
import Combine

class LoginViewModel {
    @Published var email = ""
    @Published var password = ""
    @Published var isButtonEnabled = false
    @Published var showLoading = false
    @Published var errorMessage = ""
    @Published var userModel: User?
    
    var cancellables = Set<AnyCancellable>()
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        
        formValidation()
    }
    
    func formValidation() {
        // Add validations for email & password
        Publishers.CombineLatest($email, $password)
            .filter {email, password in
                return email.count > 5 && password.count > 3
            }
            .sink { value in
                self.isButtonEnabled = true
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func userLogin(withEmail email: String,
                   password: String) {
        errorMessage = ""
        showLoading = true
        
        // Task to execute async code
        Task {
            do {
                userModel = try await apiClient.login(withEmail: email, password: password)
            } catch let error as BackendError {
                print(error.localizedDescription)
                errorMessage = error.rawValue
            }
            showLoading = false
        }
    }
}
