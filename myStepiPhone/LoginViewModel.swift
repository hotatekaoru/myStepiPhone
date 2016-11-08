//
//  LoginViewModel.swift
//  myStepiPhone
//
//  Created by 保立馨 on 2016/10/23.
//  Copyright © 2016年 Kaoru Hotate. All rights reserved.
//

import Foundation
import Bond
import NGRValidator
import Alamofire
import SwiftyJSON

let MIN_LENGTH_USERNAME = 4;
let MIN_LENGTH_PASSWORD = 4;

class LoginViewModel {
	
	enum APIError: ErrorType {
		case CannotParse
	}

	// 通信状態を表す
	enum RequestState {
		case None		// 未通信
		case Requesting	// 通信中
		case Finish		// 通信完了
		case Error		// 通信エラー
	}
	
	let requestState = Observable<RequestState>(.None)
	let username = Observable<String?>("")
	let password = Observable<String?>("")
	let errorMsg = Observable<String?>("")
	let isEnableSignIn = Observable<Bool>(false)
	var resp:UserResp?
	var err = ""
	
	// 通信中インディケーターのアニメーションの有無を制御するフラグ
	// Requesting状態の時だけTrueになる。
	var isLoadingViewAnimate: EventProducer<Bool> {
		return requestState.map { $0 == .Requesting }
	}
	
	var isLoadingViewHidden: EventProducer<Bool> {
		return requestState.map { $0 != .Requesting }
	}
	
	var signUpViewStateInfo: EventProducer<(buttonEnabled: Bool, errorMsg: String)> {
		
		return combineLatest(requestState, username, password).map { (requestState, username, password) in
			
			guard let username = username, password = password where requestState != .Requesting else {
				return (false, "")
			}
			
			if !self.err.isEmpty {
				return (true, self.err)
			}
			
			if username.isEmpty || password.isEmpty  {
				return (false, "")
			}
			
			if username.characters.count < MIN_LENGTH_USERNAME {
				return (false, "Nameは4文字以上入力してください。")
			}
			
			if password.characters.count < MIN_LENGTH_PASSWORD {
				return (false, "Passwordは4文字以上入力してください。")
			}
			
			return (true, "")
			
		}
	}
	
	var getErrMsg: EventProducer<String> {
		return errorMsg.map { $0! }
	}

	func signIn(username: String, password: String) {
		
		self.getUserInfo(username, password: password)
	}
	
	func getUserInfo(username: String, password: String) {
		
		let req = UserReq(userName: username, password: password)

		Alamofire.request(.POST, req.urlString, parameters: req.parameters).responseJSON { response in
			switch response.result {
			case .Success:
				
				if let value = response.result.value {
					self.resp = UserResp(json:JSON(value))
					self.err = self.resp!.err!
				}
				self.requestState.next(.Finish)
				
			case .Failure(let error):
				print(error)
				self.requestState.next(.Error)
				self.err = "Connection Error"

			}
		}
		
	}
	
}