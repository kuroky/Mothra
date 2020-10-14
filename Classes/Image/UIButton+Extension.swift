//
//  UIButton+Extension.swift
//  Mothra
//
//  Created by kuroky on 2019/7/4.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit
import Kingfisher

extension UIButton {
    
    /// UIButton加载网络图片
    /// - Parameter state: button state
    func setImage(for state: UIControl.State) {
        let url = URL(string: "")
        self.kf.setImage(with: url, for: state)
    }
}
