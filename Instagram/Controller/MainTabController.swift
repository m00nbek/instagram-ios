//
//  ViewController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    private let isLogged = false
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authUserAndUpdateUI()
    }
    
    // MARK: - Helpers
    func authUserAndUpdateUI() {
        if !isLogged {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
        }
    }
    func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavController(image: UIImage(named: "home_unselected")!, rootViewController: feed)
        
        let explore = ExploreController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav2 = templateNavController(image: UIImage(named: "search_unselected")!, rootViewController: explore)
        
        let post = PostController()
        let nav3 = templateNavController(image: UIImage(systemName: "plus.viewfinder")!, rootViewController: post)
        
        let activity = ActivityController()
        let nav4 = templateNavController(image: UIImage(named: "like")!, rootViewController: activity)
        
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav5 = templateNavController(image: UIImage(systemName: "person.crop.circle")!, rootViewController: profile)
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    func templateNavController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}

