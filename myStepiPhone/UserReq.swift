//
//  UserReq.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/10/30.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import Foundation

class UserReq {
	let urlString = "http://52.68.55.108/api/v1/login"
	let parameters: [String: String]
	
	init(userName: String, password: String) {
		self.parameters = ["userName":userName, "password":password]
	}


}