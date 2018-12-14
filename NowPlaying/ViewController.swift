//
//  ViewController.swift
//  NowPlaying
//
//  Created by ksa on 14/12/18.
//  Copyright © 2018 ksa. All rights reserved.
//

import Cocoa
import ScriptingBridge

class ViewController: NSViewController {
    
    @IBOutlet weak var tuneViewContainer: NSView!
    
    let iTunes: iTunesApplication = SBApplication(bundleIdentifier: "com.apple.iTunes")!
    private var tuneVC: TunesViewController?
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.postsFrameChangedNotifications = true
        let dnc = DistributedNotificationCenter.default()
        dnc.addObserver(self,
                        selector: #selector(update(notification:)),
                        name: NSNotification.Name(rawValue: "com.apple.iTunes.playerInfo"),
                        object: nil)
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        if let window = view.window {
            window.delegate = self
        }
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        timer.invalidate()
        view.window?.delegate = nil
    }
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let vc = segue.destinationController as? TunesViewController else { return }
        tuneVC = vc
        vc.iTunes = iTunes
        tuneViewContainer.setFrameSize(vc.view.frame.size)
    }
    
    @objc func update(notification: NSNotification) {
        updateUI()
    }
    
    @objc func updateUI() {
        tuneVC?.update()
        let size = tuneViewContainer.bounds.size
        let w = view.bounds.size.width > (size.width + 20) ? view.bounds.size.width - size.width - 20 : 1
        let h = view.bounds.size.height > (size.height + 20) ?  view.bounds.size.height - size.height - 20 : 1
        let x = CGFloat.random(in: 0..<w)
        let y = CGFloat.random(in: 0..<h)
        tuneViewContainer.setFrameOrigin(NSPoint(x: x, y: y))
    }
}

extension ViewController: NSWindowDelegate {
    
    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        let w = max(frameSize.width, 800)
        let h = max(frameSize.height, 600)
        return NSSize(width: w, height: h)
    }
    
    
    func windowDidResize(_ notification: Notification) {
        updateUI()
    }
}

