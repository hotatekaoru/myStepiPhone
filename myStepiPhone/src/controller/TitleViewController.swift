//
//  TitleViewController
//  myStepiPhone
//
//  Created by 保立馨 on 2016/09/27.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

	//パーツ生成
	let loginVC: UIViewController = LoginViewController()
	
	//このVCで管理するviewを設定する
	override func loadView() {
		view = UIView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.blueColor()
		//self.navigationController?.pushViewController(loginVC, animated: true)
	}
	
	override func viewDidAppear(animated: Bool) {
		self.presentViewController(loginVC, animated: true, completion: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

