//
//  ModalMask.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 20/07/23.
//

import SwiftUI

struct ModalMask: View {
    let onTap: (() -> Void)?
    var body: some View {
        Color.gray
            .opacity(0.3)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap?()
            }
    }
}
