//
//  DetailPokemonScreen.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 18/04/25.
//

import UIKit
import Kingfisher

class DetailPokemonScreen: UIViewController {
    
    var pokemonID: Int?
    var pokemonName: String?
    var pokemonType: String?
    
    var pokemonNameLabel: UILabel!
    var pokemonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewToScreen()
        
        if let id = pokemonID {
            loadPokemonDetails(withID: id)
        }
    }
    
    func addViewToScreen() {
        placeholderImage1()
        setupUI()
        placeholderImage2()
        placeholderImage3()
    }
    
    func placeholderImage1(){

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "pokemonBg") {
            imageView.image = image
        } else {
            print("Image 'pokemonBg' not found in assets")
        }
        
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func placeholderImage2() {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "ashLove") {
            imageView.image = image
        } else {
            print("Image 'ashLove' not found in assets")
        }
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowRadius = 20
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = .zero
        imageView.layer.masksToBounds = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    func placeholderImage3() {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "pokemonText") {
            imageView.image = image
        } else {
            print("Image 'pokemonText' not found in assets")
        }
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowRadius = 20
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = .zero
        imageView.layer.masksToBounds = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: pokemonImageView.topAnchor, constant: -60),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 900),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: pokemonType ?? "") ?? .white
        
        pokemonImageView = UIImageView()
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.contentMode = .scaleAspectFit
        
        // Shadow effect
        pokemonImageView.layer.shadowColor = UIColor.black.cgColor
        pokemonImageView.layer.shadowOpacity = 0.8
        pokemonImageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        pokemonImageView.layer.shadowRadius = 10
        pokemonImageView.layer.masksToBounds = false
        pokemonImageView.layer.shadowPath = UIBezierPath(rect: pokemonImageView.bounds).cgPath
        
        view.addSubview(pokemonImageView)
        
        pokemonNameLabel = UILabel()
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.text = pokemonName?.capitalized
        pokemonNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        pokemonNameLabel.textColor = .white
        
        // Outline effect using shadow
        pokemonNameLabel.layer.shadowColor = UIColor.black.cgColor
        pokemonNameLabel.layer.shadowRadius = 4.0
        pokemonNameLabel.layer.shadowOpacity = 1.0
        pokemonNameLabel.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        pokemonNameLabel.layer.masksToBounds = false
        
        view.addSubview(pokemonNameLabel)
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 240),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 240),
            
            pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 20),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Black border to the view
        view.layer.borderColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        view.layer.borderWidth = 30
    }
    
    
    func loadPokemonDetails(withID id: Int) {
        let imageUrlString = "\(APIPaths.apiImageUrl)\(id).png"
        if let imageUrl = URL(string: imageUrlString) {
            pokemonImageView.kf.setImage(with: imageUrl)
        }
    }
}
