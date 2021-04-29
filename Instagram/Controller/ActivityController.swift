//
//  ActivityController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class ActivityController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - Functions
    
    func configure() {
        tableView.backgroundColor = .red
    }
}
