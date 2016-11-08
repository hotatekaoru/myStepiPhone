//
//  DashBoardViewController.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/11/06.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController, UINavigationControllerDelegate {
	
	//ナビゲーションのアイテム
	var leftMenuButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//UINavigationControllerのデリゲート
		self.navigationController?.delegate = self
		
		//タイトル用の色および書式の設定
		let attrsMainTitle = [
			NSForegroundColorAttributeName : UIColor.whiteColor(),
			NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 15)!
		]
		self.navigationItem.title = "Welcome to This Sample!"
		self.navigationController?.navigationBar.titleTextAttributes = attrsMainTitle
		
		//ナビゲーション用の色および書式の設定
		let attrsBarButton = [
			NSFontAttributeName : UIFont(name: "Georgia-Bold", size: 16)!
		]
		
		//左メニューボタンの配置
		leftMenuButton = UIBarButtonItem(title: "🔖", style: .Plain, target: self, action: #selector(DashBoardViewController.leftMenuButtonTapped(_:)))
		leftMenuButton.setTitleTextAttributes(attrsBarButton, forState: .Normal)
		self.navigationItem.leftBarButtonItem = leftMenuButton
		
	}
	
	//左メニューボタンを押した際のアクション
	func leftMenuButtonTapped(sender: UIBarButtonItem) {
		
		let viewController = self.parentViewController?.parentViewController as! ViewController
		viewController.handleMainContentsContainerState(MainContentsStatus.LeftMenuOpened)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}
