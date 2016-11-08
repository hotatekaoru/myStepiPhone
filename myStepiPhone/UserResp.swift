//
//  UserResp.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/10/30.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//


import SwiftyJSON

struct UserResp {
	
	let err: String?
	let userId: Int?
	
	init?(json: JSON) {
		guard let
			err = json["err"].string,
			userId = json["id"].int
		else {
			return nil
		}

		self.err = err
		self.userId = userId
	}
	
}