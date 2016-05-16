//
//  ViewController.swift
//  MiniMapTimer
//
//  Copyright © 2016. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var timer : NSTimer?
    var backgroundTask: UIBackgroundTaskIdentifier!
    @IBOutlet weak var playButton: UIButton!
    
    private struct Settings {
        static let REMINDER_TIME = 10.0;
    }

    @IBAction func toggleTimer(sender: AnyObject) {
        guard let startTimer = timer else {
            playButton.setTitle("Stop", forState: .Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(Settings.REMINDER_TIME, target: self, selector: "triggerReminder", userInfo: nil, repeats: true)
            registerBackgroundTask()
            
            return
        }
        
        playButton.setTitle("Play", forState: .Normal)
        startTimer.invalidate()
        timer = nil
        endBackgroundTask()
    }
    
    func triggerReminder() {
        // https://github.com/TUNER88/iOSSystemSoundsLibrary
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound (systemSoundID)
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
            [unowned self] in
            self.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        UIApplication.sharedApplication().endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }

}

