//
//  BaseViewController.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 20/04/25.
//

import Foundation
import UIKit

//MARK: - Music Button Set on MainViewController
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addMusicToggleButton()
    }

    func addMusicToggleButton() {
        let musicButton = MusicToggleButton.shared
        musicButton.translatesAutoresizingMaskIntoConstraints = false

        if musicButton.superview == nil {
            view.addSubview(musicButton)

            NSLayoutConstraint.activate([
                musicButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                musicButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
                musicButton.widthAnchor.constraint(equalToConstant: 40),
                musicButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
}

