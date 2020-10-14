//
//  MothraConfig.swift
//  Pods
//
//  Created by kuroky on 2020/3/31.
//

import Foundation
import XCGLogger
import IQKeyboardManagerSwift

let _xcode_workaround_log: XCGLogger = {
    //创建一个logger对象
    let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)
    //控制台输出
    let systemDestination = AppleSystemLogDestination(owner: log, identifier: "advancedLogger.systemDestination")
    //设置控制台输出的各个配置项
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    systemDestination.showDate = true
    //logger对象中添加控制台输出
    log.add(destination: systemDestination)
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "✅ ", postfix: "", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ ", postfix: "", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️ ", postfix: "", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️ ", postfix: "", to: .error)
    log.formatters = [emojiLogFormatter]
    
    //开始启用
    log.logAppDetails()
    
    return log
}()
public let molog: XCGLogger = _xcode_workaround_log

public class MothraConfig {
    
    /// httpsDomain
    /// - Parameter httpsDomain: cer证书域名
    public static func launchSetup(httpsDomain: String?) {
        molog.info("setup") // console log配置
        NetworkConfig.shared.httpsDomain = httpsDomain // 域名设置
        ImageCacheManager.setupImageCache() // 图片缓存
        //IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = true
    }
    
    
}
