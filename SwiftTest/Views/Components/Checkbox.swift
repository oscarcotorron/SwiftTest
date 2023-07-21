//
//  Checkbox.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 20/07/23.
//

import SwiftUI

struct Checkbox: View {
    let label: String
    let onChange: (Bool) -> Void
    
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: onCheckChange) {
            HStack {
                ZStack {
                    Rectangle().fill(Color.white).cornerRadius(5).frame(width: 50, height: 50)
                    if isChecked {
                        Image(systemName: "checkmark").resizable().frame(width: 50, height: 50).tint(Color.black)
                    }
                }
                Spacer()
                Text(label).font(.largeTitle)
                Spacer()
            }
        }
    }
    
    func onCheckChange() {
        isChecked.toggle()
        onChange(isChecked)
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(label: "Label", onChange: {b in}, isChecked: .constant(true))
    }
}
