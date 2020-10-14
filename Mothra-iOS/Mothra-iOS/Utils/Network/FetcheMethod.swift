//
//  FetcheMethod.swift
//  Mothra-iOS
//
//  Created by kuroky on 2020/4/1.
//  Copyright © 2020 Emucoo. All rights reserved.
//

import Foundation
import Moya

enum APIMethod {
    case login(para: [String: Any]) // 登录
    case logout(para: [String: Any]) // 登出
    
    func baseUrl() -> String {
        return "http://192.168.16.188:9093/"
    }
    
    /// 配置请求方法
    /// - Returns: method
    func method() -> String {
        switch self {
        case .login:
            return "api/user/login"
        case .logout:
            return "api/user/logout"
        }
    }
    
    /// 请求header
    /// - Returns: headers
    func headers() -> [String: String] {
        var heads = [
            "Content-Type": "application/json",
            "ApiType": "IOS",
            "Version": "1.0.0",
            "serviceType": "1"]
        
        switch self {
        case .login: break
        default:
            heads["token"] = "token"
        }
        return heads
    }
    
    /// 请求参数
    /// - Returns: 字典类型参数
    func task() -> Task {
        var dic: [String: Any] = [:]
        switch self {
        case let .login(para: dict):
            dic = dict
        case let .logout(para: dict):
            dic = dict        
        }
        return .requestParameters(parameters: dic, encoding: JSONEncoding.default)
    }
    
    func timeoutInterval() -> Double {
        switch self {
        case .login:
            return 15
        case .logout:
            return 5
        }
    }        
}
