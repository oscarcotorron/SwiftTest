//
//  ViewExtensions.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 20/07/23.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
