//
//  LoginViewModel.swift
//  Architecture-MVVM
//
//  Created by Nahuel Lalin on 29/03/2024.
//

import Foundation

class LoginViewModel {
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func userLogin(withEmail email: String,
                   password: String) {
        // Task to execute async code
        Task {
            do {
                let userModel = try await apiClient.login(withEmail: email, password: password)
                
            } catch let error as BackendError {
                print(error.localizedDescription)
            }
        }
    }
}
