//
//  TunesViewController.swift
//  ViewsTess
//
//  Created by ksa on 12/12/18.
//  Copyright © 2018 ksa. All rights reserved.
//

import Cocoa

class TunesViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var artistLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var imageView: NSImageView!
    
    weak var iTunes: iTunesApplication!
    let df = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        df.dateStyle = .none
        df.timeStyle = .short
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        update()
    }
    
    func update() {
        let track = WPTrack(using: iTunes.currentTrack)

        titleLabel.stringValue = track.title 
        artistLabel.stringValue = track.artist
        timeLabel.stringValue = df.string(from: Date())
        imageView.image = track.image
    }
    
}
