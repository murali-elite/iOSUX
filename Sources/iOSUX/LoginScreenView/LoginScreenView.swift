//
//  SwiftUIView.swift
//  
//
//  Created by Murali moorthy on 7/29/24.
//

import SwiftUI
import IOSUIToolKit

struct LoginScreenView: View {
    var body: some View {
       WelcomeBannerView(title: "Hello", secondaryTitle: "Hai")
            .background(Color.red)
    }
}

#Preview {
    LoginScreenView()
}
