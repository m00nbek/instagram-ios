//
//  FeedController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit
import Firebase

class FeedController: UICollectionViewController {
    var posts = [Post]()
    var user: User? {
        didSet {
            posts = [
                Post(user: user!, likes: 0, caption: "Caption"),
                Post(user: user!, likes: 2, caption: "NewCaption"),
                Post(user: user!, likes: 0, caption: "Caption"),
                Post(user: user!, likes: 2, caption: "NewCaption")
            ]
        }
    }
    // MARK: - Properties
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
    @objc func showStoryUploader() {
        
    }
    @objc func showMessages() {
        
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configure()
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: postCellIdentifier)
        
    }
    // MARK: - Helpers
    private func configure() {
        collectionView.backgroundColor = .white
    }
    private func configureNavbar() {
        navigationItem.leftBarButtonItem = uploadStoryButton
        navigationItem.rightBarButtonItem = messagesButton
        let imgView = UIImageView(image: UIImage(named: "header_logo"))
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        navigationItem.titleView = imgView
    }
}

// MARK: - UICollectionViewDataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCellIdentifier, for: indexPath) as! PostCell
        cell.post = posts[indexPath.row]
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: view.frame.width + 72)
    }
}
