//
//  Color+Extension.swift
//
//
//  Created by Murali moorthy on 7/30/24.
//

import SwiftUI

extension Color {
    /// A static color representing the primary color of the app.
    ///
    /// - Returns: A `Color` instance initialized with the color named "AppPrimaryColor" from the module's asset catalog.
    public static var appPrimaryColor: Color {
        Color("AppPrimaryColor", bundle: .module)
    }
}
