//
//  NetworkConfig.swift
//  Pods
//
//  Created by kuroky on 2020/4/1.
//

import Foundation

/// 网络层配置
@objc public class NetworkConfig: NSObject {
    
    @objc public static let shared = NetworkConfig()
            
    /// 证书https域名
    @objc public var httpsDomain: String?
    
    /// 是否打印log
    public var showConsole: Bool = true
}
