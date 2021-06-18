//
//  ViewController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit
import Firebase
import AlamofireImage
import Alamofire

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    var profileImage = UIImage(named: "ic_person_outline_white_2x")! {
        didSet {
            configureViewControllers()
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        authUserAndUpdateUI()
    }
    
    // MARK: - Helpers
    func authUserAndUpdateUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            //            DispatchQueue.global(qos: .background).async {
            //                UserService.shared.fetchUser(uid: Auth.auth().currentUser!.uid) { user in
            //                    if let urlString = user.profileImageUrl?.absoluteString {
            //                        AF.request(urlString).responseImage { response in
            //                            if case .failure(let error) = response.result {
            //                                print(error.localizedDescription)
            //                            }
            //                            if case .success(let image) = response.result {
            //                                print("success")
            //                                self.profileImage = self.resizeImage(image: image, targetSize: CGSize(width: 32, height: 32))
            //                            }
            //                        }
            //                    }
            //                }
            //            }
        }
    }
    //    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    //       let size = image.size
    //
    //       let widthRatio  = targetSize.width  / size.width
    //       let heightRatio = targetSize.height / size.height
    //
    //       // Figure out what our orientation is, and use that to form the rectangle
    //       var newSize: CGSize
    //       if(widthRatio > heightRatio) {
    //           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    //       } else {
    //           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    //       }
    //
    //       // This is the rect that we've calculated out and this is what is actually used below
    //       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    //
    //       // Actually do the resizing to the rect using the ImageContext stuff
    //       UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
    //       image.draw(in: rect)
    //       let newImage = UIGraphicsGetImageFromCurrentImageContext()
    //       UIGraphicsEndImageContext()
    //
    //       return newImage!
    //   }
    func logOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            fatalError("DEBUG: Error while signing out Err: \(error)")
        }
    }
    func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavController(image: UIImage(named: "home_unselected")!, rootViewController: feed)
        
        let explore = ExploreController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav2 = templateNavController(image: UIImage(named: "search_unselected")!, rootViewController: explore)
        
        let post = PostController()
        let nav3 = templateNavController(image: UIImage(systemName: "plus.viewfinder")!, rootViewController: post)
        //nav3.title = "New Post"
        
        let activity = ActivityController()
        let nav4 = templateNavController(image: UIImage(named: "like")!, rootViewController: activity)
        
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav5 = templateNavController(image: profileImage, rootViewController: profile)
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    func templateNavController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}
extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.title == "New Post" {
            let nav3 = templateNavController(image: UIImage(systemName: "plus.viewfinder")!, rootViewController: PostController())
            nav3.modalPresentationStyle = .fullScreen
            self.present(nav3, animated: true, completion: nil)
            return false
        }
        return true
    }
}

