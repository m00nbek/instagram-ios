//
//  LoginController.swift
//  Instagram
//
//  Created by Oybek on 4/11/21.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    // MARK: - Properties
    var validEmail: Bool?
    var validPass: Bool?
    private let bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "insta_bg")
        return iv
    }()
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "header_logo")
        return iv
    }()
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Sign up to see photos and videos \n from your friends!"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.alpha = 0.5
        button.isUserInteractionEnabled = false
        return button
    }()
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureComponents()
    }
    
    // MARK: - Selector
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                print("DEBUG: Error while signing in Err: \(err.localizedDescription)")
                return
            }
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let tab = window.rootViewController as? MainTabController else {return}
            tab.authUserAndUpdateUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(bgImageView)
        bgImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 60)
        logoImageView.setDimensions(width: 200, height: 120)
        
        view.addSubview(headerTitle)
        headerTitle.centerX(inView: view, topAnchor: logoImageView.bottomAnchor, paddingTop: 0)
        headerTitle.anchor(left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.center(inView: view)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        //        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor,
        //                     right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
    }
    func configureComponents() {
        passwordTextField.delegate = self
        emailTextField.delegate = self
    }
}
// MARK: - UITextFieldDelegate
extension LoginController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            if textField.placeholder == "Email" {
                if isValidEmail(textField.text!) && !textField.text!.contains(" ") {
                    validEmail = true
                    updateUI(isValid: true, in: emailContainerView)
                } else {
                    validEmail = false
                    updateUI(isValid: false, in: emailContainerView)
                }
            } else {
                if textField.text!.count >= 6 && !textField.text!.contains(" "){
                    validPass = true
                    updateUI(isValid: true, in: passwordContainerView)
                } else {
                    validPass = false
                    updateUI(isValid: false, in: passwordContainerView)
                }
            }
        }
    }
    func updateUI(isValid: Bool, in view: UIView) {
        if !isValid {
            view.layer.borderWidth = 2
        } else {
            view.layer.borderWidth = 0
        }
        if validEmail != nil && validPass != nil {
            if validEmail! && validPass! {
                loginButton.alpha = 1
                loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.7967690979)
                loginButton.isUserInteractionEnabled = true
            } else {
                loginButton.alpha = 0.5
                loginButton.backgroundColor = .clear
                loginButton.isUserInteractionEnabled = false
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
