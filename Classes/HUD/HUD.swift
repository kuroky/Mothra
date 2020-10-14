//
//  HUD.swift
//  Mothra
//
//  Created by kuroky on 2019/7/3.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import PKHUD

/// 假装HUD永不消失
private let delayForever    =   86400.0
private let hideToastDelay  =   1.5

public class MTHUD {
            
    /// 显示progress 需要手动hide
    ///
    /// - Parameter title: 标题
    public static func showProgress(title: String = "") {
        MTHUD.excuteMainQueue {
            HUD.dimsBackground = true
            HUD.allowsInteraction = false
            HUD.flash(.labeledProgress(title: title, subtitle: ""), delay: delayForever)
        }
    }
    
    /// 显示一段文字 允许交互，背景不灰暗处理
    ///
    /// - Parameter title: 文字标题
    public static func toast(title: String) {
        MTHUD.excuteMainQueue {
            HUD.dimsBackground = false
            HUD.allowsInteraction = true
            HUD.flash(.label(title), delay: hideToastDelay)
        }
    }
    
    /// 显示操作成功
    public static func showSuccess() {
        MTHUD.excuteMainQueue {
            HUD.dimsBackground = true
            HUD.allowsInteraction = false
            HUD.flash(.success, delay: hideToastDelay)
        }
    }
    
    /// 显示操作失败
    public static func showError() {
        MTHUD.excuteMainQueue {
            HUD.dimsBackground = true
            HUD.allowsInteraction = false
            HUD.flash(.error, delay: hideToastDelay)
        }
    }
    
    /// 自定义progress
    ///
    /// - Parameter imageName: 图片名称
    public static func showCustomPorgress(imageName: String = "progress") {
        MTHUD.excuteMainQueue {
            HUD.dimsBackground = true
            HUD.allowsInteraction = false
            HUD.flash(.rotatingImage(UIImage(named: imageName)), delay: delayForever)
        }
    }

    /// 隐藏HUD
    public static func hide() {
        MTHUD.excuteMainQueue {
            HUD.hide(animated: true)
        }
    }

    private static func excuteMainQueue(_ closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
