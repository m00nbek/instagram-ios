//
//  FeedController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    private let signOutBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 50, height: 50)
        button.backgroundColor = .blue
        button.setTitle("Sign out", for: .normal)
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    // MARK: - Selectors
    @objc func signOut() {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
        guard let tab = window.rootViewController as? MainTabController else {return}
        tab.logOut()
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - Helpers
    func configure() {
        view.addSubview(signOutBtn)
        signOutBtn.center(inView: view)
        collectionView.backgroundColor = .white
    }
}
