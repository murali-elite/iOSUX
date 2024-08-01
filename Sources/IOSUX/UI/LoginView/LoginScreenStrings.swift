//
//  SwiftUIView.swift
//  
//
//  Created by Murali moorthy on 7/30/24.
//

import SwiftUI

/// Enum for representing localized strings related to the login screen.
public enum LoginScreenStrings: String {
    /// The log in label text.
    case logIn = "Log In"

    /// The description text for the log in screen.
    case logInDescription = "Everything you need to secure and control your home network and connected devices."

    /// Returns the localized string for the enum case.
    ///
    /// - Parameter bundle: The bundle to search for the localized string. Default is `.main`.
    /// - Returns: The localized string for the enum case.
    func localized(bundle: Bundle = .module) -> String {
        // swiftlint:disable nslocalizedstring_key
        NSLocalizedString(self.rawValue, bundle: bundle, comment: "\(self.rawValue) label")
        // swiftlint:enable nslocalizedstring_key
    }
}
