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
    @ObservedObject var viewModel = LoginViewModel()

    @State private var isPasswordHidden: Bool = true
    @State private var isPopupPresented: Bool = false
    @State var isActiveSignUpPresentation: Bool = false
    @State private var detentHeight: CGFloat = 0

    // MARK: - View

    /// The body of the view, which includes conditional navigation and the main content.
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
                    .navigationDestination(isPresented: $isActiveSignUpPresentation) {
                        Text("Sign Up")
                    }
                    .navigationDestination(isPresented: $viewModel.isLoginSuccess) {
                        Text("Dashboard")
                    }
            }
            .showLoader($viewModel.isShowLoader)
        } else {
            NavigationView {
                content
                NavigationLink(LoginScreenStrings.signUp.rawValue, isActive: $isActiveSignUpPresentation) {
                    Text("Sign Up")
                }
                NavigationLink("Dashboard", isActive: $viewModel.isLoginSuccess) {
                    Text("Dashboard")
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
                    AuthHeaderView(assets: AuthHeaderAssets(),
                                   title: LoginScreenStrings.logIn.localized(),
                                   subTitle: LoginScreenStrings.logInDescription.localized())
                    .padding(.vertical, Constants.verticalPadding)

                    /// Input fields for login credentials
                    LoginContainerView(email: $viewModel.email,
                                       password: $viewModel.password,
                                       location: $viewModel.location,
                                       isPasswordHidden: $isPasswordHidden,
                                       isPopupPresented: $isPopupPresented,
                                       isValidEmail: $viewModel.isValidEmail,
                                       locations: viewModel.locations,
                                       assets: LoginContainerAssets())

                    .sheet(isPresented: $isPopupPresented) {
                        resetPasswordSheetPresentation()
                    }

                    /// Buttons for login and sign-up actions
                    AuthButtonContainerView(assets: AuthButtonAssets(),
                                            primaryAction: loginAction,
                                            secondayAction: signUpAction)
                    .padding(.top, Constants.verticalPadding)
                }
            }
            .padding()
        }

        .alert(isPresented: $viewModel.isShowAlert) {
            Alert(title: Text("CommandIQ"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("Ok")))
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
        ResetPasswordContainerView(email: $viewModel.resetEmail,
                                   location: $viewModel.resetLocation,
                                   locations: viewModel.locations,
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
        viewModel.checkValidation()
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


public enum SplashScreenStrings1: String {
    /// The label for the welcome message.
    case welcome = "splash_welcome"

    /// The application name.
    case appName = "splash_appName"

    /// The application button name.
    case letsGetStarted = "splash_let_get_start"

    /// The title for the global network section.
    case globalNetworkTitle = "splash_control_network"

    /// The description for the global network section.
    case globalNetworkDescription = "splash_manage_connectivity"

    /// The title for the home network section.
    case homeNetworkTitle = "splash_manage_home"

    /// The description for the home network section.
    case homeNetworkDescription = "splash_device_people"

    /// The title for the security network section.
    case securityNetworkTitle = "splash_secure_your_network"

    /// The description for the security network section.
    case securityNetworkDescription = "splash_access_wireless_password"

    /// Returns the localized string for the enum case.
    public var localized: String {
        // swiftlint:disable nslocalizedstring_key
        NSLocalizedString(self.rawValue, bundle: .main, comment: "\(self.rawValue) label")
        // swiftlint:enable nslocalizedstring_key
    }
}
