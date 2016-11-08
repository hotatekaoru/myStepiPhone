//
//  LoginViewController.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/10/22.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	// Storyboardの部品
	@IBOutlet weak var topMainImage: UIImageView!
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var signInBtn: UIButton!
	@IBOutlet weak var errorMsgArea: UIView!
	@IBOutlet weak var errorMsg: UILabel!
	@IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

	private var loginVM = LoginViewModel()
	private var const = Const()

	override func viewDidLoad() {
		super.viewDidLoad()

		topMainImage.image = UIImage(named: "triangle.png")
		mainView.backgroundColor = const.lightBlueColor()
		errorMsgArea.layer.cornerRadius = 8.0
		setupBind()

	}
	
	private func setupBind() {

		loginVM.username.bidirectionalBindTo(nameTextField.bnd_text)
		loginVM.password.bidirectionalBindTo(passwordTextField.bnd_text)

		// 各InputItemの状態に応じた挙動を定義
		loginVM.signUpViewStateInfo.observe { [weak self] (buttonEnabled, errorMsg) -> Void in
			self?.errorMsg.text = errorMsg
			self?.signInBtn.enabled = buttonEnabled
			self?.signInBtn.alpha = buttonEnabled ? 1.0 : 0.5

			if self?.errorMsg.text != "" {
				self?.errorMsgArea.backgroundColor = UIColor.magentaColor()
				self?.errorMsgArea.alpha = 0.3
			} else {
				self?.errorMsgArea.alpha = 0
			}
		}

		loginVM.isLoadingViewHidden.bindTo(loadingIndicator.bnd_hidden)
		loginVM.isLoadingViewAnimate.bindTo(loadingIndicator.bnd_animating)
		
		// signInボタン押下時の処理を定義
		signInBtn.bnd_controlEvent.filter { $0 == .TouchUpInside }.observe { [weak self] _ -> Void in

			self?.loginVM.signIn(self!.nameTextField.text!, password: self!.passwordTextField.text!)

		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

