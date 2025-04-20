//
//  NavigationBarHelper.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 19/04/25.
//

import UIKit

class NavigationBarHelper {
    
    static func customizeBackButton(for viewController: UIViewController) {
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        viewController.navigationItem.backBarButtonItem = backItem
        
        viewController.navigationController?.navigationBar.tintColor = .white
    }
}

