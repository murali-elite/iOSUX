//
//  SwiftUIView.swift
//
//
//  Created by Murali moorthy on 7/29/24.
//

import SwiftUI

extension Image {
    init(asset name: String) {
        self.init(name, bundle: .module)
    }
}

@available(iOS 15.0, *)
extension View {
    ///
    public func showLoader(_ isShow: Binding<Bool>, perfom: @escaping () -> Void = {}) -> some View {
        modifier(LoaderView(isShow: isShow, perform: perfom))
    }
}

/// Loading view
@available(iOS 15.0, *)
public struct LoaderView: ViewModifier {
    enum Constants {
        static var colorOpcity: CGFloat = 0.4
        static var loaderPadding: CGFloat = 50
        static var loaderCornorRadius: CGFloat = 8
    }

    @Binding var isShow: Bool
    var perform: () -> Void
    /// Loading view
    public func body(content: Content) -> some View {
        ZStack {
            content

            if isShow {
                ZStack {
                    Color.black.opacity(Constants.colorOpcity)
                        .ignoresSafeArea()

                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(Constants.loaderPadding)
                        .background(.background)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.loaderCornorRadius))
                }
                .onTapGesture {
                    perform()
                }
            }
        }
    }
}
