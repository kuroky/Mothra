//
//  UIImageView+Extension.swift
//  Mothra
//
//  Created by kuroky on 2019/7/4.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import UIKit
import Kingfisher

/// 图片加载动画时间
private let transitionDuration: TimeInterval   =   1

// MARK: - 图片扩展 (加载)
extension UIImageView {
    
    /// 图片加载
    ///
    /// - Parameters:
    ///   - url: 图片地址
    ///   - size: 裁剪尺寸
    ///   - cornerRadius: 圆角大小
    ///   - completion: 回调(UIImage)
    public func setImage(url: String, size: CGSize? = CGSize.zero, cornerRadius: CGFloat? = 0, completion: ((UIImage?) -> Void)? = nil) {
        let url = URL(string: url)
        
        var processor: ImageProcessor?
        
        // 默认缓存原图, 加载带动画效果
        var options: [KingfisherOptionsInfoItem] = [.cacheOriginalImage,
                                                    .transition(.fade(transitionDuration))]
        
        // 裁剪处理
        if let size = size, size != CGSize.zero {
            processor = DownsamplingImageProcessor(size: size)
        }
        
        // 圆角处理
        var cornerProcessor: RoundCornerImageProcessor?
        if let radius = cornerRadius, radius > 0 {
            cornerProcessor = RoundCornerImageProcessor(cornerRadius: radius)
        }
        
        // 合并processor
        if let cornerProcessor = cornerProcessor {
            if let proc = processor {
                processor = proc |> cornerProcessor
            }
            else {
                processor = cornerProcessor
            }
        }
        
        // 需要提前处理图片，且不需要使用者去手动处理
        if let processor = processor, completion == nil {
            options.append(.processor(processor))
            options.append(.scaleFactor(UIScreen.main.scale))
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options:options
            )
        {
            result in
            switch result {
            case .success(let value):
                completion?(value.image)
            case .failure(_):
                completion?(nil)
            }
        }
    }
}
