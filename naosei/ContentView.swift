//
//  ContentView.swift
//  naosei
//
//  Created by iOSLab on 28/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        VStack() {
            Label("Na Fila", systemImage: "list.triangle")
                .fontWidth(.expanded)
                .font(.system(size: 20))
            VStack {
                Spacer()
                Text("mp6")
                    .font(.system(size: 45))
                    .fontWidth(.expanded)
                Text("Seu player de músicas!")
                    .font(.system(size: 26))
                    .fontWidth(.expanded)
                Spacer()
            }
            HStack() {
                Label("Local", systemImage: "externaldrive")
                    .fontWidth(.expanded)
                    .font(.system(size: 24))
                Spacer()
                Label("Rede", systemImage: "network")
                    .fontWidth(.expanded)
                    .font(.system(size: 24))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

#Preview {
    ContentView()
}
