//
//  SwiftUIView.swift
//
//
//  Created by Murali moorthy on 7/29/24.
//

import SwiftUI

import SwiftUI

/// A view extension that provides a method to ignore safe area insets.
/// This method ensures that the view extends to the edges of the screen,
/// even in areas typically reserved for system UI elements.
extension View {
    /// Applies a modifier to ignore safe area insets.
    ///
    /// On iOS 15.0 and later, this uses the `ignoresSafeArea()` method to extend
    /// the view into the safe areas. On earlier iOS versions, it uses `edgesIgnoringSafeArea(.all)`.
    ///
    /// - Returns: A view that ignores safe area insets.
    func ignoreSafeArea() -> some View {
        modifier(IgnoreSafeAreaViewModifier())
    }
}

struct IgnoreSafeAreaViewModifier: ViewModifier {
    /// Applies the modifier to ignore safe area insets.
    ///
    /// On iOS 15.0 and later, this uses the `ignoresSafeArea()` method to extend
    /// the view into the safe areas. On earlier iOS versions, it uses `edgesIgnoringSafeArea(.all)`.
    ///
    /// - Parameter content: The content view to which the modifier is applied.
    /// - Returns: A view that ignores safe area insets.
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .ignoresSafeArea()
        } else {
            content.edgesIgnoringSafeArea(.all)
        }
    }
}


extension Image {
        
    init(asset name: String) {
        self.init(name, bundle: .module)
    }
}

