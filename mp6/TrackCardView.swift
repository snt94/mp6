//
//  MusicCardView.swift
//  mp6
//
//  Created by iOSLab on 11/04/26.
//

import SwiftUI

struct TrackCardView: View {
    
    var tracks: [Track]
    
    var body: some View {
        ForEach(tracks) { track in
            VStack {
                HStack {
                    Image(systemName: "arrow.up.circle")
                        .font(.system(size: 24))
                    Spacer()
                    Text(track.name)
                        .fontWidth(.expanded)
                        .font(.system(size: 24))
                }
                HStack {
                    Text(track.artist)
                        .fontWidth(.expanded)
                        .font(.system(size: 16))
                    Spacer()
                    Text(track.duration)
                        .fontWidth(.expanded)
                        .font(.system(size: 16))
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .padding(.horizontal, 10)
            )
        }
    }
}

#Preview {
    let mockTracks = [
        Track(id: "1", name: "The stars get dark", artist: "稲葉曇", duration: "03:57"),
        Track(id: "2", name: "Roller Hero",        artist: "稲葉曇", duration: "04:12"),
        Track(id: "3", name: "Flyingfish",         artist: "稲葉曇", duration: "03:28")
    ]

    ScrollView {
        VStack(spacing: 12) {
            ForEach(0...20, id: \.self) { index in
                TrackCardView(tracks: [mockTracks[index % mockTracks.count]])
            }
        }
        .padding()
    }
}
