//
//  WPTrack.swift
//  WhatsPlaying
//
//  Created by ksa on 9/12/18.
//  Copyright © 2018 ksa. All rights reserved.
//

import AppKit
import ScriptingBridge

struct WPTrack {
    let title: String
    let artist: String
    let image: NSImage?
    
    
    init(using track: iTunesTrack?) {
        title = track?.name ?? ""
        artist = track?.artist ?? ""
        if let trackArt = track?.artworks!() as? [iTunesArtwork],
            let art = trackArt.first, let data = art.rawData {
            self.image = NSImage(data: data)
        } else {
            self.image = nil
        }
    }
}

extension WPTrack: CustomStringConvertible {
    var description: String {
        let hasImage = image != nil ? "has" : "doesn't have"
        return "Track - Title: \(title) \t Artist: \(artist) \t and \(hasImage) an image"
    }
}
