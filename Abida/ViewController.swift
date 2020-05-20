//
//  ViewController.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/2/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import UIKit
import AudioToolbox

/*class randomly picks new name and meaning
 plays sound on button click
 
 sound reference: textbook
 */
class ViewController: UIViewController {
    
    var soundID: SystemSoundID = 0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    var randomValue = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Allah"
        meaningLabel.text = "The God"
        self.view.backgroundColor = color1
        
        loadSoundEffect("bell.wav")
    }
    
    /*when button is pushed get random name and meaning and play sound*/
    @IBAction func nextButton(_ sender: Any) {
        NextSelected()
        playSoundEffect()
    }
    
    func NextSelected(){
        randomValue = Int.random(in: 0...98)
        updateLabels()
    }
    
    func updateLabels(){
        nameLabel.text = names[randomValue]
        meaningLabel.text = meanings[randomValue]
    }
    
    func loadSoundEffect(_ name: String) {
        if let path = Bundle.main.path(forResource: name,
                                       ofType: nil) {
            let fileURL = URL(fileURLWithPath: path, isDirectory: false)
            let error = AudioServicesCreateSystemSoundID(
                fileURL as CFURL, &soundID)
            if error != kAudioServicesNoError {
                print("Error code \(error) loading sound: \(path)")
            }
        } }
    
    func unloadSoundEffect() {
        AudioServicesDisposeSystemSoundID(soundID)
        soundID = 0 }
    
    func playSoundEffect() {
        AudioServicesPlaySystemSound(soundID)
    }
    
}

