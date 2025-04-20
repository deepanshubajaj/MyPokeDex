//
//  SplashViewController.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 18/04/25.
//

import UIKit
import Lottie
import AVFoundation

class SplashViewController: UIViewController {
    let animationView = LottieAnimationView(name: "pikachu")
    let splashImageView = UIImageView(image: UIImage(named: "pokemonText"))
    let splashImageView2 = UIImageView(image: UIImage(named: "PokedexText"))
    
    var audioPlayer: AVAudioPlayer?
    
    var showTabBarController: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        setupImageView()
        playSplashAudio()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.audioPlayer?.stop()
            MusicManager.shared.playBackgroundMusic()
            
            self.showTabBarController?()
        }
        
        setupAnimation()
        addDeveloperCreditLabel()
        
    }
    
    func playSplashAudio() {
        guard let path = Bundle.main.path(forResource: "splashAudio", ofType: "mp3") else {
            print("⚠️ splashAudio.mp3 not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("⚠️ Error playing audio: \(error.localizedDescription)")
        }
    }
    
    
    func setupAnimation() {
        animationView.frame.size.width = view.frame.size.width * 0.84
        animationView.frame.size.height = view.frame.size.height * 0.26
        animationView.center = CGPoint(x: view.frame.size.width / 2,
                                       y: view.frame.size.height / 2)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .repeat(2)
        animationView.play()
        view.addSubview(animationView)
    }
    
    func setupImageView() {
        setupImageView1()
        setupImageView2()
    }
    
    func setupImageView1() {
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        splashImageView.contentMode = .scaleAspectFit
        splashImageView.clipsToBounds = true
        
        view.addSubview(splashImageView)
        
        NSLayoutConstraint.activate([
            splashImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.widthAnchor.constraint(equalToConstant: 800),
            splashImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupImageView2() {
        splashImageView2.translatesAutoresizingMaskIntoConstraints = false
        splashImageView2.contentMode = .scaleAspectFit
        splashImageView2.clipsToBounds = true
        
        view.addSubview(splashImageView2)
        
        NSLayoutConstraint.activate([
            splashImageView2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            splashImageView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView2.widthAnchor.constraint(equalToConstant: 300),
            splashImageView2.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func addDeveloperCreditLabel() {
        let creditLabel = UILabel()
        creditLabel.translatesAutoresizingMaskIntoConstraints = false
        creditLabel.text = "Designed & Developed by: Deepanshu Bajaj"
        creditLabel.textColor = .white
        creditLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        creditLabel.textAlignment = .center
        creditLabel.numberOfLines = 1

        view.addSubview(creditLabel)

        NSLayoutConstraint.activate([
            creditLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            creditLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
