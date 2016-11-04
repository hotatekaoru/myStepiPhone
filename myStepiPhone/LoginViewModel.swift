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
	
	// 通信状態を表す
	enum RequestState {
		case None		// 未通信
		case Requesting	// 通信中
		case Finish		// 通信完了
}
	
	let requestState = Observable<RequestState>(.None)
	let username = Observable<String?>("")
	let password = Observable<String?>("")
	let errorMsg = Observable<String?>("")
	let isEnableSignIn = Observable<Bool>(false)
	var resp:UserResp?
	
	// 通信中インディケーターのアニメーションの有無を制御するフラグ
	// Requesting状態の時だけTrueになる。
	var isLoadingViewAnimate: EventProducer<Bool> {
		return requestState.map { $0 == .Requesting }
	}
	
	var isLoadingViewHidden: EventProducer<Bool> {
		return requestState.map { $0 != .Requesting }
	}
	
	var signUpViewStateInfo: EventProducer<(buttonEnabled: Bool, buttonAlpha: CGFloat, errorMsg: String)> {
		
		return combineLatest(requestState, username, password).map { (requestState, username, password) in
			
			guard let username = username, password = password where requestState != .Requesting else {
				return (false, 0.5, "")
			}
			
			if username.isEmpty || password.isEmpty  {
				return (false, 0.5, "")
			}
			
			if username.characters.count < MIN_LENGTH_USERNAME {
				return (false, 0.5, "Nameは4文字以上入力してください。")
			}
			
			if password.characters.count < MIN_LENGTH_PASSWORD {
				return (false, 0.5, "Passwordは4文字以上入力してください。")
			}
			
			return (true, 1.0, "")
			
		}
	}
	
	var finishSignUp: EventProducer<(username: String, password: String)?> {
		
		return requestState.map { [weak self] requestState in
			
			guard let username = self?.username.value, password = self?.password.value where requestState == .Finish else {
				return nil
			}
			
			return (username, password)
			
		}
		
	}
	
	func signIn (username: String, password: String) -> (result: Bool, errMsg: String) {

		if !isExistUser(username, password: password) {
			return (false, "")
		}

		requestState.next(.Requesting)
		let delay = 1.0 * Double(NSEC_PER_SEC)
		let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		
		dispatch_after(time, dispatch_get_main_queue()) { [unowned self] in
			self.requestState.next(.Finish)
		}
				
		return (true, "")
	}
	
	func isExistUser(username: String, password: String) -> Bool {
		
		let req = UserReq(userName: username, password: password)
		var exist = false
		
		Alamofire.request(.POST, req.urlString, parameters: req.parameters).responseJSON { response in
			switch response.result {
			case .Success:
				if let value = response.result.value {
					self.resp = UserResp(json:JSON(value))
					exist = true
					print("Alamofire成功")
					print(self.resp?.userId)
				}
			case .Failure(let error):
				print(error)
			}
		}
		
		return exist
	}

}
