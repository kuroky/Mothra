//
//  BaseFetcher.swift
//  Mothra-iOS
//
//  Created by kuroky on 2020/4/1.
//  Copyright © 2020 Emucoo. All rights reserved.
//

import Foundation
import Mothra
import Moya

/// 请求体
class NetworkAPI: Fetcher {
    
    /// 是否打印log
    var showConsole: Bool = false
    
    /// http请求耗时阀值 默认接口响应时间400毫秒正常
    var httpRequestTime =   400.0
    
    /// 请求枚举方法
    var fetchMethod: APIMethod!
    init(method: APIMethod) {
        self.fetchMethod = method
    }
    
    /// 请求url
    public override var baseURL: URL {
        return URL(string: self.fetchMethod.baseUrl())!
    }
    
    /// 各个请求具体路径
    public override var path: String {
        return self.fetchMethod.method()
    }
    
    /// 请求参数
    public override var task: Task {
        return self.fetchMethod.task()
    }
    
    /// 请求头
    public override var headers: [String: String]? {
        return self.fetchMethod.headers()
    }
    
    /// 网络超时
    open override var timeoutInterval: Double {
        return self.fetchMethod.timeoutInterval()
    }
}

extension NetworkAPI {
    
    typealias completion = (BaseResp) -> Void
    
    /// 发起请求
    /// - Parameter closure: 回调
    func startRequest(closure: @escaping completion) {
        fetchNetwork(fetcher: self) { resp in
            self.consolePrint(resp: resp)
            let base = self.parserResponse(resp: resp)
            closure(base)
        }
    }
    
    /// 发起请求2 hud
    /// - Parameter closure: 回调
    func startRequestWithHUD(closure: @escaping completion) {
        fetchAlowHUD(fetcher: self) { resp in
            self.consolePrint(resp: resp)
            let base = self.parserResponse(resp: resp)
            closure(base)
        }
    }
    
    func parserResponse(resp: NetworkResponse) -> BaseResp {
        var base = BaseResp()
        if resp.success == false {
            return base
        }
        
        if let code = resp.resp ["code"] as? String {
            base.errCode = Int(code)!
            base.success = base.errCode == 0 ? true : false
            base.respData = resp.resp["data"] as? [String: Any] ?? [:]
            return base
        }
        
        if let msg = resp.resp["msg"] as? String {
            base.msg = msg
        }
        
        return base        
    }
    
    /// 打印到控制台
    func consolePrint(resp: NetworkResponse) {
        #if DEBUG
        if resp.success == false {
            molog.error(resp)
            return
        }
        
        if showConsole == false {
            return
        }
        
        if resp.time > httpRequestTime  {
            molog.warning(resp)
        }
        else {
            molog.debug(resp)
        }
        
        #endif
    }
}

struct BaseResp {
    var success: Bool = false
    
    var respData: [String: Any] = [:]
    
    var errCode: Int = 408
    
    var msg: String = ""
    
}
