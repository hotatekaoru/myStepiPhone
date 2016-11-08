//
//  GetLoginInfo.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/11/06.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON

class GetLoginInfo {
	
	let loginVM = LoginViewModel()
	
	enum APIError: ErrorType {
		case CannotParse
	}
	
	func getUserInfo(username: String, password: String) -> Observable<UserResp> {
		
		loginVM.requestState.next(.Requesting)
		
		let req = UserReq(userName: username, password: password)
		
		return request(.POST, req.urlString, parameters: req.parameters, encoding: .URLEncodedInURL)
			.rx_JSON()
			.map(JSON.init)
			.flatMap { json -> Observable<UserResp> in
				guard let user = UserResp(json: json) else {
					return Observable.error(APIError.CannotParse)
				}
				
				return Observable.just(user)
		}
		
		/*
		Alamofire.request(.POST, req.urlString, parameters: req.parameters).responseJSON { response in
		switch response.result {
		case .Success:
		
		if let value = response.result.value {
		self.resp = UserResp(json:JSON(value))
		self.requestState.next(.Finish)
		self.err = self.resp!.err!
		}
		
		case .Failure(let error):
		print(error)
		self.requestState.next(.Error)
		self.err = "Connection Error"
		
		}
		}
		*/
	}
}
