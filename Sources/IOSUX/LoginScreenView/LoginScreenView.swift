//
//  SwiftUIView.swift
//
//
//  Created by Murali moorthy on 7/29/24.
//

import SwiftUI
import IOSUIToolKit

struct LoginScreenView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var location: String = "USA"
    @State var resetEmail: String = ""
    @State var resetLocation: String = "USA"
    @State var isPasswordHidden: Bool = true
    @State var isPopupPresented: Bool = false
    @State private var detentHeight: CGFloat = 0
    private var locations: [String] = ["USA", "Canada", "France", "Germany", "Africa"]

    var body: some View {
        VStack {
            WelcomeBannerView(title: "Welcome", secondaryTitle: "ComandIQ")
            LoginTitleView(title: "Log In",
                           subTitle: "Everything you need to secure and control your home network and connected devices.")
            LoginContainerView(email: $email,
                               password: $password,
                               location: $location,
                               isPasswordHidden: $isPasswordHidden,
                               isPopupPresented: $isPopupPresented,
                               locations: locations, handler: {_, _ in})
        }
        .background(Color("AppPrimaryColor", bundle: .module))
    }
}

#Preview {
    LoginScreenView()
}
