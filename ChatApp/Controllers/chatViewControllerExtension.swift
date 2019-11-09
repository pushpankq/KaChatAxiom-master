//
//  chatViewControllerExtension.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 9/5/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import Foundation
import AVFoundation

extension chatViewController: AVAudioRecorderDelegate{
    func playSound(soundUrl: String)
    {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            
            try! audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let currentRoute = AVAudioSession.sharedInstance().currentRoute
            for description in currentRoute.outputs {
                if description.portType == AVAudioSession.Port.headphones {
                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                } else {
                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                }
            }
            
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        let url = URL(string: soundUrl)
        let item = AVPlayerItem(url: url!)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
        self.audioPlayer = AVPlayer(playerItem: item)
    }
    
    @objc func playerDidFinishPlaying(sender: NSNotification) {
        self.audioButton.setImage(self.play, for: .normal)
    }
    
    func recordAudio(){
        let fileName = self.getDirectory().appendingPathComponent("myRecording.m4a")
        do{
            self.audioRecorder =  try AVAudioRecorder(url: fileName, settings: self.settings)
            self.audioRecorder.delegate = self
            self.audioRecorder.record()
        }catch{
            self.showErrorAlert(message: "Recording Failed")
        }
    }
    
    func setupAudioSession(){
        self.recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission({(hasPermission) in
            if hasPermission{
                print("Permission Granted")
            }
        })
    }
    
    func getDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
