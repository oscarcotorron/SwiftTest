//
//  CommentsView.swift
//  SwiftTest
//
//  Created by Oscar Hernandez on 19/07/23.
//

import SwiftUI

struct CommentsView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            HStack {
                Button(action: onBackPressed) {
                    Image(systemName: "arrow.backward").resizable().frame(width: 50, height: 50)
                }
                .padding()
                Spacer()
            }
            Image("foto").resizable().cornerRadius(100).frame(width: 200, height: 200)
            Spacer()
            VStack {
                HStack {
                    Text("Nombre:")
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    Spacer()
                }
                Text("Oscar Hernández Ortiz")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                HStack {
                    Text("Comentarios:")
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                    Spacer()
                }
                Text("Aunque la aplicación parece sencilla, sin duda requiere del uso de diversos conceptos.\n\nTomando como referencia otros proyectos pasados, fue muy fácil la parte de la navegación.\n\nMe resultó un poco complicado implementar la parte de la vibración y el acelerómetro, ya que no contaba con un iphone, para probar estas características.").font(.callout)
            }
            .padding()
            .font(.system(size: 30))
            Spacer()
        }
        .foregroundColor(Color.black)
        .background(Rectangle().fill(Color.orange).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}

extension CommentsView {
    func onBackPressed() {
        coordinator.pop()
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
