//
//  PostController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class PostController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isUserPosting == false {
            configure()
        }
    }
    // MARK: - Properties
    private var isUserPosting: Bool = false {
        didSet {
            if isUserPosting == false {
                imageView.removeFromSuperview()
                caption.removeFromSuperview()
            }
        }
    }
    private let imagePicker = UIImagePickerController()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    private let caption: UITextView = CaptionTextView()
    private let cancelButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.action = #selector(cancel)
        btn.title = "Cancel"
        btn.style = .plain
        btn.tintColor = .black
        return btn
    }()
    private let postButton: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.style = .plain
        btn.title = "Post"
        btn.tintColor = .black
        btn.action = #selector(post)
        return btn
    }()
    // MARK: - Selectors
    @objc func cancel() {
        tabBarController?.selectedIndex = 0
        isUserPosting = false
    }
    @objc func post() {
        tabBarController?.selectedIndex = 0
        isUserPosting = false
    }
    // MARK: - Functions
    private func configureUI() {
        // setup components
        isUserPosting = true
        cancelButton.target = self
        postButton.target = self
        caption.backgroundColor = .secondarySystemBackground
        caption.isScrollEnabled = true
        caption.translatesAutoresizingMaskIntoConstraints = false
        let stack = UIStackView(arrangedSubviews: [imageView, caption])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        // UIStackView constraints
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    private func configure() {
        navigationItem.title = "New Post"
        navigationItem.setRightBarButton(postButton, animated: true)
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        view.backgroundColor = .white
    }
}
extension PostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        imageView.image = image
        print("Image has picked")
        configureUI()
        picker.dismiss(animated: true, completion: nil)
    }
}
