//
//  UserResp.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/10/30.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import SwiftyJSON

struct UserResp {
	
	let userId: Int?
	
	init(json: JSON) {
		self.userId = json["id"].int
	}
	
}