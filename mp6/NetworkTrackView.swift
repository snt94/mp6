//
//  NetworkTrackView.swift
//  naosei
//
//  Created by iOSLab on 28/03/26.
//

import SwiftUI

struct NetworkTrackView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Image(systemName: "arrow.up.circle")
                        .font(.system(size: 24))
                    Spacer()
                    Text("The stars get dark")
                        .fontWidth(.expanded)
                        .font(.system(size: 24))
                }
                HStack {
                    Text("稲葉曇")
                        .fontWidth(.expanded)
                        .font(.system(size: 16))
                    Spacer()
                    Text("03:57")
                        .fontWidth(.expanded)
                        .font(.system(size: 16))
                }
                
            }
            .padding(.bottom, 20)
            
            VStack {
                HStack {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 24))
                    Spacer()
                    Text("Fade to Black")
                        .fontWidth(.expanded)
                        .font(.system(size: 24))
                }
                HStack {
                    Text("Metallica")
                        .fontWidth(.expanded)
                        .font(.system(size: 16))
                    Spacer()
                    Text("06:58")
                        .fontWidth(.expanded)
                        .font(.system(size: 16))
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
    }
}

#Preview {
    NetworkTrackView()
}
