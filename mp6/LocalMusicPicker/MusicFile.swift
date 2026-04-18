//
//  MusicFile.swift
//  mp6
//
//  Created by iOSLab on 18/04/26.
//

import Foundation

struct MusicFile: Identifiable {
    let id = UUID()
    let url: URL
    let title: String
    let artist: String
    let album: String
    let duration: TimeInterval
    let fileSize: Int64

    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var formattedSize: String {
        let mb = Double(fileSize) / 1_000_000
        return String(format: "%.1f MB", mb)
    }
}
