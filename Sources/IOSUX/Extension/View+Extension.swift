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

