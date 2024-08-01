//
//  SplashScreenView.swift
//  CalixIOSUX
//
//  Created by labmacuser3 on 7/29/24.
//  Copyright © 2024 Calix Inc. All rights reserved.
//

import SwiftUI
import IOSUIToolKit

/// A view that displays the splash screen for the app.
public struct SplashScreenView: View {
    // MARK: - Constants
    private enum Constants {
        static var buttonTopPadding: CGFloat = 40
    }

    /// An array of LandingBannerItem objects used to populate the landing animation view.
    private var items: [LandingBannerItem] = [
        LandingBannerItem(title: SplashScreenStrings.gloablNetworkTitle.localized(),
                          description: SplashScreenStrings.gloablNetworkDescription.localized(),
                          image: Image("Landing-Global-Image", bundle: .module)),
        LandingBannerItem(title: SplashScreenStrings.homeNetworkTitle.localized(),
                          description: SplashScreenStrings.homeNetworkDescription.localized(),
                          image: Image("Landing-Home-Image", bundle: .module)),
        LandingBannerItem(title: SplashScreenStrings.securityNetworkTitle.localized(),
                          description: SplashScreenStrings.securityNetworkDescription.localized(),
                          image: Image("Landing-Security-Image", bundle: .module))
    ]

    /// The main view body of the SplashScreenView.
    ///
    /// This property conditionally uses NavigationStack or NavigationView based on iOS version
    /// and provides the layout and content for the splash screen, including a welcome banner,
    /// landing animation, and a navigation link to the login screen.
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }

    /// The content view of the splash screen, including background color, scrollable content,
    /// and navigation elements.
    ///
    /// This view contains the welcome banner, landing animation view, and a navigation link
    /// to the login screen. It is used within the body property to build the overall layout.
    private var content: some View {
        ZStack {
            Color.appPrimaryColor
                .ignoreSafeArea()
            ScrollView {
                VStack {
                    WelcomeBannerView(title: SplashScreenStrings.welcom.localized(),
                                      secondaryTitle: SplashScreenStrings.appName.localized(),
                                      assets: LoginContainerAssets())

                    LandingAnimationView(items: items)

                    NavigationLink {
                        // Your destination view here
                    } label: {
                        Text(SplashScreenStrings.letsGetStarted.localized())
                            .foregroundColor(.appPrimaryColor)
                            .buttonStyleViewModifier(backgroundColor: .white)
                            .padding(.top, Constants.buttonTopPadding)
                    }
                }
            }
            .padding()
        }
    }

    public init() {}
}

#Preview {
    SplashScreenView()
}
