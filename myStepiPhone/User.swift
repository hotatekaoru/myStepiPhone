//
//  User.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/10/23.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import UIKit

final class User: NSObject,NSCoding {
	var username = ""
	var password = ""
	
	override init() {
		super.init()
	}
	
	internal func update(){
		let archive = NSKeyedArchiver.archivedDataWithRootObject(self)
		let userdefaults = NSUserDefaults.standardUserDefaults()
		userdefaults.setObject(archive, forKey: "MyStepUser")
	}
	
	class func loadPerson() -> User?{
		let userdefaults = NSUserDefaults.standardUserDefaults()
		guard let unarchived = userdefaults.objectForKey("MyStepUser") as? NSData else{
			return User()
		}
		
		return (NSKeyedUnarchiver.unarchiveObjectWithData(unarchived) as? User) ?? User()
	}
	
	// ユーザーデフォルトに保存するため
	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(self.username, forKey: "name")
		aCoder.encodeObject(self.password, forKey: "password")
	}
	
	// ユーザーデフォルトに保存するため
	init?(coder aDecoder: NSCoder) {
		super.init()
		self.username = (aDecoder.decodeObjectForKey("name") as? String) ?? ""
		self.password = (aDecoder.decodeObjectForKey("password") as? String) ?? ""
	}
}