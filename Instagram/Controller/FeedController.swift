//
//  FeedController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Helpers
    func configure() {
        collectionView.backgroundColor = .white
    }
}
