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
    private let uploadStoryButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "camera.fill"), style: .plain, target: self, action: #selector(showStoryUploader))
        button.tintColor = .darkGray
        return button
    }()
    private let messagesButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "paperplane.fill"), style: .plain, target: self, action: #selector(showMessages))
        button.tintColor = .darkGray
        return button
    }()
    // MARK: - Selectors
    @objc func signOut() {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
        guard let tab = window.rootViewController as? MainTabController else {return}
        tab.logOut()
    }
    @objc func showStoryUploader() {
        
    }
    @objc func showMessages() {
        
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
    }
    // MARK: - Helpers
    func configure() {
        view.addSubview(signOutBtn)
        signOutBtn.center(inView: view)
        collectionView.backgroundColor = .white
    }
    func configureNavbar() {
        navigationItem.leftBarButtonItem = uploadStoryButton
        navigationItem.rightBarButtonItem = messagesButton
        let imgView = UIImageView(image: UIImage(named: "header_logo"))
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        navigationItem.titleView = imgView
    }
}
