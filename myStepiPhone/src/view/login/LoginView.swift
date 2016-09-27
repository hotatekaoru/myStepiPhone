//
//  LoginView.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/09/27.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit
import TextFieldEffects
import PureLayout

class LoginView: UIView {
	
	private var didSetupConstraints = false

	//パーツ生成
	var userNameLabel: UILabel = {
		var label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.whiteColor()
		label.text = "label"
		return label
	}()
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		setUp()
	}
	
	override init(frame: CGRect) {
		super.init(frame: CGRectZero)
		setUp()
		
	}
	
	convenience init() {
		self.init(frame: CGRectZero)
	}
	
	func setUp() {
		self.addSubview(userNameLabel)
		self.setNeedsUpdateConstraints()
	}
	
	// 制約を設定(どこに配置するか）
	override func updateConstraints() {
		
		func setupConstraints() {
			userNameLabel.autoSetDimension(ALDimension.Height, toSize: 20)
			userNameLabel.autoSetDimension(ALDimension.Width, toSize: 120)
			userNameLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
			userNameLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 10)
		}
		
		if !didSetupConstraints {
			setupConstraints()
			didSetupConstraints = true
		}
		
		super.updateConstraints()
		
	}
	
}
