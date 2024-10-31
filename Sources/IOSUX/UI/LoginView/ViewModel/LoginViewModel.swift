//
//  SwiftUIView.swift
//  
//
//  Created by Murali moorthy on 8/7/24.
//

import SwiftUI
import IOSServices

//@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var location: String = "USA"
    @Published var resetEmail: String = ""
    @Published var resetLocation: String = "USA"
    @Published var isValidEmail: Bool = false
    @Published var isLoginSuccess: Bool = false
    @Published var isShowAlert: Bool = false
    @Published var isShowLoader: Bool = false
    var errorMessage: String = ""

    /// A list of available locations for selection.
    var locations: [String] = ["USA", "Canada", "France", "Germany", "Africa"]

    var services: CalixIOSServisable

    init(services: CalixIOSServisable = CalixIOSService()) {
        self.services = services
    }

    func sendRequest() async throws {
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "mobileDevice": [
                "id": "",
                "notificationToken": "",
                "os": "ios",
                "msisdn": "",
                "locale": "us",
                "packageName": ""
            ]
        ]
        let value = try await services.sendRequest(parameters: parameters)

        if value.errorDesc == nil {
            isLoginSuccess = false
            isShowAlert = true
            errorMessage = value.errorDesc ?? "Error"
        } else {
            isLoginSuccess = true
        }
    }

    func checkValidation() {
        if email.isEmpty && isValidEmail(email) {
            errorMessage = "Enter valid email address"
            isShowAlert = true
        } else if password.isEmpty {
            errorMessage = "Enter valid password"
            isShowAlert = true
        } else {
            Task {
                do {
                    isShowLoader = true
                    try await sendRequest()
                    isShowLoader = false
                } catch {
                    print("Error", error)
                }
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
