//
//  ImageCacheManager.swift
//  Mothra
//
//  Created by kuroky on 2019/7/4.
//  Copyright © 2019 Emucoo. All rights reserved.
//

import Foundation
import Kingfisher

/// 缓存类型
///
/// - disk: 磁盘
/// - memeory: 内存
/// - all: 磁盘和内存
public enum ImageCacheType {
    case disk
    case memeory
    case all
}

/// 基于Kingfisher的图片管理
public class ImageCacheManager {
    /// 缓存设置 (磁盘300Mb 过期时间默认7天， 内存100Mb 过期时间30分钟)
    static func setupImageCache() {
        ImageCache.default.diskStorage.config.sizeLimit = 1024 * 1024 * 300
        ImageCache.default.memoryStorage.config.expiration = .seconds(1800)
        ImageCache.default.memoryStorage.config.totalCostLimit = 1024 * 1024 * 100
    }
    
    /// 获取磁盘缓存大小
    ///
    /// - Parameter completion: 回调
    public static func getDiskCost(completion: @escaping (Double) -> Void) {
        ImageCache.default.calculateDiskStorageSize { (result) in
            switch result {
            case .success(let value):
                completion(Double(value) * 0.001 * 0.001)
            case .failure:
                completion(0)
            }
        }
    }
    
    /// 缓存图片
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - key: 缓存key
    ///   - type: 缓存类型
    public static func store(image: UIImage, key: String, type: ImageCacheType) {
        switch type {
        case .all, .disk: // 不支持纯磁盘缓存
            ImageCache.default.store(image, forKey: key)
        case .memeory:
            ImageCache.default.store(image, forKey: key, toDisk: false)
        }
    }
    
    /// 从缓存检索图片
    ///
    /// - Parameters:
    ///   - key: 缓存key
    ///   - completion: 图片回调
    public static func getImage(forKey key: String, completion: @escaping (UIImage?) -> Void) {
        ImageCache.default.retrieveImage(forKey: key, callbackQueue: .mainAsync) { result in
            switch result {
            case .success(let cacheResult):
                switch cacheResult {
                case .memory(let image), .disk(let image):
                    completion(image as UIImage)
                //case .disk(let image):
                 //   completion(image as UIImage)
                case .none:
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    /// 根据key移除缓存
    ///
    /// - Parameters:
    ///   - key: 缓存key
    ///   - type: 移除的类型
    public static func removeImage(forKey key: String, type: ImageCacheType) {
        switch type {
        case .all:
            ImageCache.default.removeImage(forKey: key)
        case .disk:
            ImageCache.default.removeImage(forKey: key, fromMemory: false, fromDisk: true)
        case .memeory:
            ImageCache.default.removeImage(forKey: key, fromMemory: false, fromDisk: true)
        }
    }
    
    /// 移除磁盘缓存
    public static func clearDiskCache() {
        ImageCache.default.clearDiskCache()
    }
}
