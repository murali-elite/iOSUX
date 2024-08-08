//
//  SwiftUIView.swift
//  
//
//  Created by Murali moorthy on 8/7/24.
//

import SwiftUI
import IOSServices

class LoginViewModel: ObservableObject {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var location: String = "USA"
    @State private var resetEmail: String = ""
    @State private var resetLocation: String = "USA"
    @State private var isPasswordHidden: Bool = true
    @State private var isPopupPresented: Bool = false
    @State private var isValidEmail: Bool = false
    @State var isLoginSuccess: Bool = false
    
    var services: CalixIOSServisable
    
    init(services: CalixIOSServisable = CalixIOSService()) {
        self.services = services
    }
    
    
    func fetchData(email: String, password: String) async throws {
        let parameters: [String: Any] = [
            "email": "jessicasmb@calix.com",
            "password": "12345678",
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
        
        if let email = value.email {
            isLoginSuccess = true
        } else {
            isLoginSuccess = false
        }
    }
}
