//
//  TitleViewController
//  myStepiPhone
//
//  Created by 保立馨 on 2016/09/27.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit
import PureLayout

class LoginViewController: UIViewController {
	
	//このVCで管理するviewを設定する
	override func loadView() {
		view = LoginView(frame: UIScreen.mainScreen().bounds)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
