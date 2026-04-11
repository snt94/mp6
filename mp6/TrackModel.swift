//
//  TrackModel.swift
//  naosei
//
//  Created by iOSLab on 28/02/26.
//

import Foundation
import SwiftUI

struct Track {
    let id: UUID
    var name: String
    var artist: String
    var album: String
    var cover: Image
    var fromNetwork: Bool = false
}
