//
//  ViewController.swift
//  EggTimer
//
//  Created by Aaraiz Wasim on 27/08/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 300,"Medium": 420,"Hard": 720]
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    
    var player: AVAudioPlayer?
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressView.progress = 0
        secondsPassed = 0
        let hardness = sender.currentTitle ?? " "
        totalTime = eggTimes[hardness] ?? 0
        titleLabel.text = "Cooking \(sender.currentTitle ?? " ") Boiled Egg"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if(secondsPassed < totalTime) {
           let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressView.progress = Float(percentageProgress)
            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
            progressView.progress = 1
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

