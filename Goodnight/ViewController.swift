//
//  ViewController.swift
//  Goodnight
//
//  Created by admin on 25/08/2024.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var imageIndex: Int = 1
    var isAnimating: Bool = false
    var timer: Timer?
    
    var audioPlayer : AVAudioPlayer?
    var audioName : String = "sleep-lofi"
    var audioType : String = "mp3"
    
    func setupBackgroundMusic(){
        guard let path = Bundle.main.path(forResource: audioName, ofType: audioType) else{
            print("Can't find audio file")
            return
        }
        let url = URL(fileURLWithPath: path)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: audioType)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
        }catch{
            print("There is an error during starting \(error.localizedDescription)")
        }
    }
    func audioStart(){
        audioPlayer?.play()
    }
    
    func audioStop(){
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
    
    func audioPause(){
        audioPlayer?.pause()
        
    }
    
    
    @IBOutlet weak var btnToggleAnimation: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnNextImage: UIButton!
    @IBOutlet weak var imgGoodnight: UIImageView!
    
    
    func updateImage(){
        imgGoodnight.image = UIImage(named: "goodnight-images/goodnight\(imageIndex)")
        print("goodnight-images/goodnight\(imageIndex)")
    }
    
    
    @IBAction func click(_ sender: UIButton) {
        if imageIndex >= 37{
            imageIndex = 1
        }else{
            imageIndex += 1
            updateImage()
            
        }
        updateImage()
    }
    
    
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in self.click(self.btnNextImage)
        }
    }
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    func startAnimation(){
        startTimer()
        audioStart()
    }
    func pauseAnimation(){
        stopTimer()
    }
    
    @IBAction func pauseAnimation(_ sender: Any) {
        pauseAnimation()
        btnReset.isHidden = true
    }
    
    @IBAction func resetAnimation(_ sender: Any) {
        pauseAnimation()
        imageIndex = 1
        updateImage()
        btnToggleAnimation.setTitle("Animation", for: .normal)
        btnToggleAnimation.tintColor = .systemGreen
        pauseAnimation()
        btnReset.isHidden = true
        audioStop()
    }
    
        
        
        @IBAction func toggleAnimation(_ sender: Any) {
            if(isAnimating){
                isAnimating = false
                btnToggleAnimation.setTitle("Pause", for: .normal)
                btnToggleAnimation.tintColor = .systemOrange
                startAnimation()
                btnReset.isHidden = false
                audioStart()
            }else{
                isAnimating = true
                btnToggleAnimation.setTitle("Animation", for: .normal)
                btnToggleAnimation.tintColor = .systemGreen
                pauseAnimation()
                audioPause()
            }
        }
        
        
        

        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            imageIndex = 1
            updateImage()
            
            
            isAnimating = true
            
            btnToggleAnimation.tintColor = .systemGreen
            
            btnToggleAnimation.setTitle("Animation", for: .normal)
            btnReset.tintColor = .systemRed
            btnReset.setTitle("Reset", for: .normal)
            btnReset.isHidden = true
            setupBackgroundMusic()
        
        }
        
        
    }
    
    // "images/goodnight" + String(imageIndex)
    //"images/goodnight\(imageIndex)"
    
