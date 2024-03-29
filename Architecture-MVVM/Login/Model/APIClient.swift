//
//  APIClient.swift
//  Architecture-MVVM
//
//  Created by Nahuel Lalin on 29/03/2024.
//

import Foundation

enum BakendError: String, Error {
    case invalidEmail = "Incorrect email"
    case invalidPassword = "Incorrect Password"
}

final class APIClient {
    func login(withEmail email: String, password: String) async throws -> User {
        // Simulate HTTP request & wait for 2 secs
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        return try simulateBackendLogic(email: email, password: password)
    }
}

func simulateBackendLogic(email: String, password: String) throws -> User {
    guard email == "nahuelglalin@gmail.com" else {
        print(BakendError.invalidEmail)
        throw BakendError.invalidEmail
    }
    
    guard password == "1234" else {
        print(BakendError.invalidPassword)
        throw BakendError.invalidPassword
    }
    
    print("Success")
    return .init(name: "Nahuel", token: "token_1234", sessionStart: .now)
}
