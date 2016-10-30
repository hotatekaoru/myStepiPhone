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
		
		loginVM.signUpViewStateInfo.observe { [weak self] (buttonEnabled, buttonAlpha, errorMsg) -> Void in
			self?.errorMsg.text = errorMsg
			self?.signInBtn.enabled = buttonEnabled
			self?.signInBtn.alpha = buttonAlpha
			
			if self?.errorMsg.text != "" {
				self?.errorMsgArea.backgroundColor = UIColor.magentaColor()
				self?.errorMsgArea.alpha = 0.3
			} else {
				self?.errorMsgArea.alpha = 0
			}
		}
		
		loginVM.isLoadingViewHidden.bindTo(loadingIndicator.bnd_hidden)
		loginVM.isLoadingViewAnimate.bindTo(loadingIndicator.bnd_animating)
		
		signInBtn.bnd_controlEvent.filter { $0 == .TouchUpInside }.observe { [weak self] _ -> Void in
			self?.loginVM.signUp()
		}
		
		loginVM.finishSignUp.ignoreNil().observe { [weak self] (username, password) -> Void in
			let alertController = UIAlertController(title: "メッセージ", message: "username:\(username)\npassword:\(password)", preferredStyle: .Alert)
			let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
			alertController.addAction(action)
			self?.navigationController?.presentViewController(alertController, animated: true, completion: nil)
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

