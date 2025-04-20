//
//  MusicToggleButton.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 20/04/25.
//

import Foundation
import UIKit

class MusicToggleButton: UIButton {
    static let shared = MusicToggleButton()
    
    private var muteImage: UIImage?
    private var unmuteImage: UIImage?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupImages()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImages()
        setupButton()
    }
    
    private func setupImages() {
        if #available(iOS 13.0, *) {
            muteImage = UIImage(systemName: "speaker.slash.fill")
            unmuteImage = UIImage(systemName: "speaker.wave.2.fill")
        } else {
            // Fallback images
            let originalMuteImage = UIImage(named: "unmuteIcon")
            let originalUnmuteImage = UIImage(named: "muteIcon")
            
            let imageSize = CGSize(width: 20, height: 20)
            
            muteImage = originalMuteImage?.resized(to: imageSize)
            unmuteImage = originalUnmuteImage?.resized(to: imageSize)
        }
    }
    
    private func setupButton() {
        updateIcon()
        tintColor = .white
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 20
        clipsToBounds = true
        addTarget(self, action: #selector(toggleMusic), for: .touchUpInside)
    }
    
    @objc private func toggleMusic() {
        MusicManager.shared.toggleMute()
        updateIcon()
    }
    
    private func updateIcon() {
        let image = MusicManager.shared.isMuted ? muteImage : unmuteImage
        setImage(image, for: .normal)
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage?.withRenderingMode(.alwaysTemplate)
    }
}
