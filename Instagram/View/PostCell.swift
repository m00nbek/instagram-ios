//
//  PostCell.swift
//  Instagram
//
//  Created by Oybek on 6/20/21.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Properties
    var post: Post? {
        didSet {
            configure()
        }
    }
    
    // MARK: - Selectors
    // MARK: - API
    // MARK: - Functions
    private func configure() {
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
}
