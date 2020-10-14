//
//  File.swift
//  Pods
//
//  Created by kuroky on 2020/4/1.
//

import Foundation
import Moya

/// 请求体
open class Fetcher: TargetType {
    
    /// 域名地址
    open var baseURL: URL {
        return URL(string: "")!
    }
    
    /// 各个请求具体路径
    open var path: String {
        return ""
    }
    
    /// 请求参数
    open var task: Task {
        return .requestParameters(parameters: ["": ""], encoding: JSONEncoding.default)
    }
        
    /// 请求头
    open var headers: [String: String]? {
        return [:]
    }
    
    /// 网络超时
    open var timeoutInterval: Double {
        return 15
    }
    
    /// 请求类型
    public var method: Moya.Method {
        return .post
    }
    
    /// 单元测试
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    public init() {}
}

public struct NetworkResponse: CustomStringConvertible {
    
    /// url
    var requestUrl = ""
    
    /// 耗时
    public var time = 0.0
    
    /// 请求头
    var headers: [String: String] = [:]
    
    /// 请求参数
    var para: [String: Any] = [:]
    
    /// 返回值
    public var resp: [String: Any] = [:]
    
    /// 是否成功 仅代表网络和数据解析
    public var success: Bool = false
    
    /// 异常msg
    var err: String?
            
    init(fetcher: Fetcher, time: Double, resp: [String: Any]?) {
        self.time = time
        self.requestUrl = fetcher.baseURL.absoluteString + fetcher.path
        self.headers = fetcher.headers!
        switch fetcher.task {
        case .requestParameters(parameters: let para, encoding: _):
            self.para = para
        default:
            self.para = [:]
        }
        self.resp = resp ?? [:]
    }
    
    public var description: String {
        var desc: String = "\(type(of: self)){" + "\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                var val = ""
                if propertyName == "time" {
                    let time = "耗时: " + String(format: "%.f", child.value as! Double) + "ms"
                    val = "\(time)" + "\n"
                }
                else {
                    val = "\(propertyName): \(child.value)" + "\n"
                }
                desc += val
            }
        }
        desc = String(desc.dropLast(2))
        desc += "\n }"
        return desc
    }
        
 
}


