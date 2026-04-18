//
//  TrackModel.swift
//  naosei
//
//  Created by iOSLab on 28/02/26.
//

import Foundation
import SwiftUI

struct Track: Identifiable {
    let id: String
    let name: String
    let artist: String
    let duration: String
}

func formatDuration(_ ms: Int) -> String {
    let totalSeconds = ms / 1000
    let minutes = totalSeconds / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
