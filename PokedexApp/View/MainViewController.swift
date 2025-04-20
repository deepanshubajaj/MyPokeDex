//
//  MainViewController.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 18/04/25.
//

import UIKit
import Kingfisher

class MainViewController: BaseViewController, UISearchBarDelegate {
    
    //MARK: - Variables, Componenets and Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    let customCellId = "PokeCell"
    let leftRightPadding = 15.0
    let searchController = UISearchController(searchResultsController: nil)
    var mainViewModel: MainViewModel = MainViewModel()
    var filteredList: [Pokemon]!
    var pokemonId: String = ""
    var isEmpty: Bool = false
    
    private lazy var imageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.image = UIImage(named: "emptySearch")
        myImageView.contentMode = .scaleAspectFill
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        return myImageView
    }()
    
    private lazy var backgroundOfImageView  : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: "backgroundColor")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var searchNulLabel : UILabel = {
        let label = UILabel()
        label.text = "Sorry... \n I don't know anyone by that Name."
        label.textColor = .yellow
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        navigationController?.navigationBar.barTintColor = UIColor.systemPink
        filteredList = mainViewModel.pokemonList
        title = "My PokéDex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search your Pokémon", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            searchController.searchBar.searchTextField.textColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.tintColor = UIColor(red: 248/255, green: 208/255, blue: 130/255, alpha: 1)
        
        
    }
    
    //MARK: - Configuration for CollectionView
    
    func configureCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibCell = UINib(nibName: customCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: customCellId)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 20, left: leftRightPadding, bottom: 0, right: leftRightPadding)
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
}

//MARK: - CollectionView Extensions

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredList.count
    }
    
    
    //MARK: CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as! PokeCell
        let chosedPokemon = filteredList[indexPath.item]
        cell.cellNameLabel.text = chosedPokemon.name.capitalized
        
        mainViewModel.getIdFromUrl(url: chosedPokemon.url) { resultId in
            self.pokemonId = resultId!
        }
        let imageUrl = "\(APIPaths.apiImageUrl)\(pokemonId).png"
        cell.cellImageView.kf.setImage(with: URL(string: imageUrl))
        
        return cell
    }
    
    
    //MARK:  didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        let chosedPokemon = filteredList[indexPath.item]
        mainViewModel.getIdFromUrl(url: chosedPokemon.url) { resultId in
            self.pokemonId = resultId!
        }
        detailVC?.viewModel.pokeId =  Int(pokemonId)
        
        NavigationBarHelper.customizeBackButton(for: self)
        
        guard let detailViewController = detailVC else { return }
        
        DispatchQueue.main.async {}
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    //MARK: - Search Bar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredList = mainViewModel.pokemonList
        self.collectionView.reloadData()
        backgroundOfImageView.removeFromSuperview()
        collectionView.isHidden = false
    }
    
    func createImageView() {
        view.addSubview(backgroundOfImageView)
        backgroundOfImageView.addSubview(imageView)
        backgroundOfImageView.addSubview(searchNulLabel)
        NSLayoutConstraint.activate([
            backgroundOfImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundOfImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundOfImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundOfImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchNulLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchNulLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -16),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            
        ])
    }
    
    func showImageView(isSearchNil: Bool){
        if isSearchNil == true {
            collectionView.isHidden = true
            createImageView()
        }
        else {
            imageView.removeFromSuperview()
            backgroundOfImageView.removeFromSuperview()
            collectionView.isHidden = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = []
        
        if searchText.count < 3 {
            filteredList = mainViewModel.pokemonList
            backgroundOfImageView.removeFromSuperview()
            collectionView.isHidden = false
            
        } else {
            for poke in mainViewModel.pokemonList {
                if poke.name.lowercased().contains(searchText.lowercased()) {
                    self.showImageView(isSearchNil: false)
                    filteredList.append(poke)
                }
            }
            
            if filteredList.isEmpty {
                self.showImageView(isSearchNil: true)
            } else {
                collectionView.isHidden = false
            }
        }
        
        self.collectionView.reloadData()
    }
    
    
    
}

//MARK: - Size of Cells
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        return CGSize(width: (screenWidth - (3 * leftRightPadding)) / 2, height: screenHeight / 4)
    }
}


