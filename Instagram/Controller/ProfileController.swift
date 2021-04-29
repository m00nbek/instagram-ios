//
//  ProfileController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - Functions
    
    func configure() {
        collectionView.backgroundColor = .black
    }
}
