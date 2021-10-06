//
//  LoginController.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/05.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "UBER"
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor(white: 1, alpha: 0.8)
        return label
    }()

    private lazy var emailContainerView: UIView = {
      let view =  UIView().inputContainerView(image: UIImage(named: "ic_mail_outline_white_2x"),
                                           textField: passwordTextField)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()

    private let emailTextField: UITextField = {
        return UITextField().textField(withPlaceHolder: "Email", isSecureTextEntry: false)
    }()

    private lazy var passwordContainerView: UIView = {
        return UIView().inputContainerView(image: UIImage(named: "ic_lock_outline_white_2x"),
                                           textField: passwordTextField)
    }()

    private let passwordTextField: UITextField = {
        return UITextField().textField(withPlaceHolder: "Password", isSecureTextEntry: true)
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)


        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}
