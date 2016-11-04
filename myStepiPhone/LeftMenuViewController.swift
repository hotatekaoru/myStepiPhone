//
//  LeftMenuViewController.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/11/03.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit

// 定数設定などその他
struct MenuSetting {
	
	// ScrollViewに表示するボタン名称に関する設定
	static let buttonSettingList: [String] = [
		"🍅1番目", "🍊2番目", "🍔3番目", "🍟4番目",
		"🍛5番目", "🍜6番目", "🍰7番目", "☕️8番目"
	]
	
	// ボタンの背景色に関する設定
	static let colorSettingList: [String] = [
		"f8c6c7", "f2cb24", "87c9a3", "b9e4f7",
		"face83", "d2cce6", "ccdc47", "81b7ea"
	]
}

class LeftMenuViewController: UIViewController {
	
	// ボタン群を格納するためのスクロールビュー
	@IBOutlet weak var menuTableView: UITableView!
	
	// 配置するテーブルビューに関するセッティング
	private let sectionCount = 1
	private let cellCount = MenuSetting.buttonSettingList.count
	private let cellHeight = 43.5
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		menuTableView.delegate = self
		menuTableView.dataSource = self
		
		//Xibのクラスを読み込む宣言を行う
		let nibDefault: UINib = UINib(nibName: "LeftMenuTableViewCell", bundle: nil)
		menuTableView.registerNib(nibDefault, forCellReuseIdentifier: "LeftMenuTableViewCell")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}

extension LeftMenuViewController: UITableViewDelegate {
	
	// テーブルのセル高さ
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return CGFloat(cellHeight)
	}
}

extension LeftMenuViewController: UITableViewDataSource {
	
	// テーブルの要素数
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return sectionCount
	}
	
	// テーブルの行数
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellCount
	}
	
	// 表示するセルの中身
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuTableViewCell") as? LeftMenuTableViewCell
		
		//cell!.titleLabel.text = MenuSetting.buttonSettingList[indexPath.row]
		cell!.backgroundColor = ColorConverter.colorWithHexString(MenuSetting.colorSettingList[indexPath.row])
		
		cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
		cell!.selectionStyle = UITableViewCellSelectionStyle.None
		
		return cell!
	}
	
}
