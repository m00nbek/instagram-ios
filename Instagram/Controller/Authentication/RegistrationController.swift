//
//  RegisterController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    var validEmail: Bool?
    var validPass: Bool?
    var validUsername: Bool?
    var isPhotoChosen: Bool = false {
        didSet {
            updateUI(isValid: true, in: addPhotoButton)
        }
    }
    private let bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "insta_bg")
        return iv
    }()
    private var profileImage: UIImage?
    private let imagePicker = UIImagePickerController()
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return button
    }()
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account? ", "Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    private lazy var usernameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        return tf
    }()
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.alpha = 0.5
        button.isUserInteractionEnabled = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureComponents()
    }
    
    // MARK: - Selectors
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleAddPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    // MARK: - Functions
    
    func configure() {
        view.addSubview(bgImageView)
        bgImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(addPhotoButton)
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 60)
        addPhotoButton.centerX(inView: view)
        addPhotoButton.setDimensions(width: 160, height: 160)
        
        let stack = UIStackView(arrangedSubviews: [usernameContainerView, emailContainerView,
                                                   passwordContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    func configureComponents() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isPhotoChosen = true
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        addPhotoButton.layer.cornerRadius = 160 / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        
        addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension RegistrationController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            if textField.placeholder == "Email" {
                if isValidEmail(textField.text!) {
                    validEmail = true
                    updateUI(isValid: true, in: emailContainerView)
                } else {
                    validEmail = false
                    updateUI(isValid: false, in: emailContainerView)
                }
            } else if textField.placeholder == "Password" {
                if textField.text!.count >= 6 {
                    validPass = true
                    updateUI(isValid: true, in: passwordContainerView)
                } else {
                    validPass = false
                    updateUI(isValid: false, in: passwordContainerView)
                }
            } else {
                if textField.text!.count >= 4 {
                    validUsername = true
                    updateUI(isValid: true, in: usernameContainerView)
                } else {
                    validUsername = false
                    updateUI(isValid: false, in: usernameContainerView)
                }
            }
        }
    }
    func updateUI(isValid: Bool, in view: UIView = UIView()) {
        if !isValid {
            view.layer.borderWidth = 2
        } else {
            view.layer.borderWidth = 0
        }
        if validEmail != nil && validPass != nil && validUsername != nil {
            if validEmail! && validPass! && validUsername! {
                if isPhotoChosen {
                    addPhotoButton.tintColor = .white
                    signUpButton.alpha = 1
                    signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.7967690979)
                    signUpButton.isUserInteractionEnabled = true
                } else {
                    addPhotoButton.tintColor = .red
                    signUpButton.alpha = 0.5
                    signUpButton.backgroundColor = .clear
                    signUpButton.isUserInteractionEnabled = false
                }
            }
        }
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        do {
            let regex = try NSRegularExpression(pattern: emailPattern)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count != 0 {
                return true
            } else {
                return false
            }
        } catch {
            fatalError("DEBUG: \(error)")
        }
    }
}
