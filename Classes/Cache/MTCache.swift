//
//  MTCache.swift
//  Mothra
//
//  Created by kuroky on 2020/3/30.
//  Copyright © 2020 Emucoo. All rights reserved.
//

import EasyStash

/// 缓存单例
public class MTCache {
    
    public static let shared = MTCache()
    
    var storage: Storage! {
        var options = Options()
        options.folder = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
        let store = try! Storage(options: options)
        return store
    }        
    
    /// 对象异步缓存 (内存和磁盘)
    /// - Parameters:
    ///   - objc: 缓存对象 事项Codable协议
    ///   - key: 缓存key
    ///   - closure: 闭包
   public func setObject<T: Codable>(objc: T, forkey key: String, closure: @escaping (Bool)->Void) {
        DispatchQueue.global().async {
            do {
                try self.storage.save(object: objc, forKey: key)
                DispatchQueue.main.async {
                    closure(true)
                }
            } catch  {
                closure(false)
            }
        }
    }
    
    /// 读取缓存对象 (内存和磁盘)
    /// - Parameters:
    ///   - key: 缓存的key
    ///   - closure: 闭包
    public func getObject<T: Codable>(for key: String, type: T.Type) -> T?  {
        do {            
            let object = try storage.load(forKey: key, as: type)
            return object
            
        } catch {
            return nil
        }
    }        
 
    /// 移除指定key的缓存 (内存和磁盘)
    /// - Parameter key: key
    public func removeObject(forkey key: String) {
        try? storage.remove(forKey: key)
    }
    
    /// 清空缓存
    public func removeAll() {
        try? storage.removeAll()
    }
}
