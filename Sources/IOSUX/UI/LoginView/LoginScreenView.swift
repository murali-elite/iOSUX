//
//  LoginScreenView.swift
//  CalixIOSUX
//
//  Created by labmacuser3 on 7/29/24.
//  Copyright © 2024 Calix Inc. All rights reserved.
//

import SwiftUI
import IOSUIToolKit

/// A view that presents the login screen with options for logging in, signing up, and resetting the password.
///
/// It also handles the presentation of a reset password sheet.
public struct LoginScreenView: View {
    // MARK: - Constants

    /// A struct to hold constant values used within the view.
    private enum Constants {
        static let verticalPadding: CGFloat = 20
    }

    // MARK: - Properties

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var location: String = "USA"
    @State private var resetEmail: String = ""
    @State private var resetLocation: String = "USA"
    @State private var isPasswordHidden: Bool = true
    @State private var isPopupPresented: Bool = false
    @State private var detentHeight: CGFloat = 0
    @State var isActiveSignUpPresentation: Bool = false

    /// A list of available locations for selection.
    private var locations: [String] = ["USA", "Canada", "France", "Germany", "Africa"]

    // MARK: - View

    /// The body of the view, which includes conditional navigation and the main content.
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
                    .navigationDestination(isPresented: $isActiveSignUpPresentation) {
                        Text("Sign Up")
                    }
            }
        } else {
            NavigationView {
                content
                NavigationLink(LoginPageString.signIn.rawValue, isActive: $isActiveSignUpPresentation) {
                    Text("Sign Up")
                }
            }
        }
    }

    /// The main content of the view, including the login form, reset password sheet, and buttons.
    private var content: some View {
        ZStack {
            // Background color for the view
            Color.appPrimaryColor
                .ignoreSafeArea()
            ScrollView {
                VStack {
                    /// Welcome banner displayed at the top of the screen.
                    WelcomeBannerView(title: SplashScreenStrings.welcom.localized(),
                                      secondaryTitle: SplashScreenStrings.appName.localized(),
                                      assets: LoginContainerAssets())

                    /// Title and description for the login section.
                    LoginTitleView(title: LoginScreenStrings.logIn.localized(),
                                   subTitle: LoginScreenStrings.logInDescription.localized(),
                                   assets: LoginTitleAssets())
                    .padding(.vertical, Constants.verticalPadding)

                    /// Input fields for login credentials
                    LoginContainerView(email: $email,
                                       password: $password,
                                       location: $location,
                                       isPasswordHidden: $isPasswordHidden,
                                       isPopupPresented: $isPopupPresented,
                                       locations: locations,
                                       assets: LoginContainerAssets())

                    .sheet(isPresented: $isPopupPresented) {
                        resetPasswordSheetPresentation()
                    }

                    /// Buttons for login and sign-up actions
                    LoginSignUpButtonContainerView(assets: LoginSignUpButtonAssets(),
                                                   primaryAction: loginAction,
                                                   secondayAction: signUpAction)
                    .padding(.top, Constants.verticalPadding)
                }
            }
            .padding()
        }
    }

    // MARK: - Views

    /// Provides the content for the reset password sheet, with conditional presentation based on iOS version.
    ///
    /// - Returns: A `View` that presents the reset password content with height adjustments and drag indicators.
    @ViewBuilder
    private func resetPasswordSheetPresentation() -> some View {
        if #available(iOS 16.0, *) {
            resetPasswordSheetContent()
                .presentationDetents([.height(detentHeight)])
                .presentationDragIndicator(.visible)
        } else {
            resetPasswordSheetContent()
        }
    }

    /// Creates the content for the reset password view.
    ///
    /// - Returns: A `View` for resetting the password, including form fields and actions.
    @ViewBuilder
    private func resetPasswordSheetContent() -> some View {
        ResetPasswordContainerView(email: $resetEmail,
                                   location: $resetLocation,
                                   locations: locations,
                                   assets: ResetPasswordAssets(),
                                   submitAction: resetPasswordSubmitAction,
                                   cancelAction: resetPasswordCancelAction)
        .readHeight()
        .onPreferenceChange(HeightPreferenceKey.self) { height in
            if let height {
                detentHeight = height
            }
        }
    }

    // MARK: - Actions

    /// Handles the action for logging in.
    private func loginAction() {
        // Handle login action
    }

    /// Handles the action for signing up.
    private func signUpAction() {
        isActiveSignUpPresentation.toggle()
    }

    /// Handles the action for submitting the reset password form.
    private func resetPasswordSubmitAction() {
        // Handle Submit Action
    }

    /// Handles the action for canceling the reset password form.
    private func resetPasswordCancelAction() {
        // Handle Cancel Action
    }
}

#Preview {
    LoginScreenView()
}
