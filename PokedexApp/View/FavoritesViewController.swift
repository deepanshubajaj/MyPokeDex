//
//  DetailPokemonScreen.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 18/04/25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var listOfBookmarks: [DetailPokemon] = []
    let localDB = LocalDatabaseManager()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites 🐾"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 30),
            .foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        
        placeholderImage()
        
        navigationController?.navigationBar.barTintColor = UIColor.systemPink
        setFavList()
        setupCollectionView()
    }
    
    
    func placeholderImage(){
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "FavScreen") {
            imageView.image = image
        } else {
            print("Image 'FavScreen' not found in assets")
        }
        
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setFavList()
        collectionView.reloadData()
    }
    
    func setFavList() {
        listOfBookmarks = LocalDatabaseManager.getAllObjects
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 60, left: 20, bottom: 60, right: 20)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SwipeCell", bundle: nil), forCellWithReuseIdentifier: "SwipeCell")
        view.addSubview(collectionView)
    }
    
    func setImage(pokeId: Int) -> String {
        return "\(APIPaths.apiImageUrl)\(pokeId).png"
    }
    
    func addSwipeGesture(to cell: UICollectionViewCell, at indexPath: IndexPath) {
        cell.gestureRecognizers?.forEach { cell.removeGestureRecognizer($0) }
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        cell.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        cell.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let cell = gesture.view as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }
        
        // Remove item from data source
        listOfBookmarks.remove(at: indexPath.item)
        LocalDatabaseManager.saveAllObjects(allObjects: listOfBookmarks)
        
        // Animate deletion
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [indexPath])
        }, completion: nil)
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfBookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwipeCell", for: indexPath) as? SwipeCell else {
            return UICollectionViewCell()
        }
        
        let pokemon = listOfBookmarks[indexPath.item]
        cell.swCardImage.kf.setImage(with: URL(string: setImage(pokeId: pokemon.id)))
        cell.swIdLabel.text = "#\(pokemon.id)"
        cell.swTitleLabel.text = pokemon.name.capitalized
        
        if let firstType = pokemon.types.first {
            cell.swBackgroundView.backgroundColor = UIColor(named: firstType.type.name)
        } else {
            cell.swBackgroundView.backgroundColor = .gray
        }
        
        addSwipeGesture(to: cell, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.8, height: collectionView.bounds.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPokemon = listOfBookmarks[indexPath.item]
        
        let detailVC = DetailPokemonScreen()
        detailVC.pokemonID = selectedPokemon.id
        detailVC.pokemonName = selectedPokemon.name
        detailVC.pokemonType = selectedPokemon.types.first?.type.name
        
        NavigationBarHelper.customizeBackButton(for: self)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
