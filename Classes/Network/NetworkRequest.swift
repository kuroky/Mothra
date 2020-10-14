//
//  NetworkFetch.swift
//  Pods
//
//  Created by kuroky on 2020/3/31.
//

import Moya
import Alamofire
import CoreTelephony

public typealias successCallback = ((NetworkResponse) -> Void)

/// 超时时间
private var requestTimeout: Double = 15
private var httpsDomain: String?

/// 配置请求体
private let endpointClosure = {(fetcher: Fetcher) -> Endpoint in
    
    httpsDomain = NetworkConfig.shared.httpsDomain
    let url = fetcher.baseURL.absoluteString + fetcher.path // url拼接
    
    var headers: [String: String]? = fetcher.headers
    requestTimeout = fetcher.timeoutInterval
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: {.networkResponse(200, fetcher.sampleData)},
        method: fetcher.method,
        task: fetcher.task,
        httpHeaderFields: fetcher.headers)
    return endpoint
}

/// 网络请求设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request: URLRequest = try endpoint.urlRequest()
        request.timeoutInterval = requestTimeout
        done(.success(request))
    }
    catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

private func defaultAlamofireManager() -> Session {
    let configuration = URLSessionConfiguration.af.default
    configuration.headers = HTTPHeaders.default
    guard let domain = httpsDomain else {
        return Alamofire.Session(configuration: configuration, startRequestsImmediately: false)
    }
    let cer = ServerTrustManager.init(evaluators: [domain: PinnedCertificatesTrustEvaluator()])
    
    return Alamofire.Session(configuration: configuration, startRequestsImmediately: false, serverTrustManager: cer)
}

 /*
private let networkPlugin = NetworkActivityPlugin { (changeType, targetType: TargetType) in
    var start: CFTimeInterval!
    var end: CFTimeInterval!
    switch(changeType) {
    case .began:
        start = CACurrentMediaTime() * 1000
    case .ended:
        end = CACurrentMediaTime() * 1000
        //print(String(format: "%.f", end - start) + "ms")
    }
}
*/

/// 网络请求log打印
class LogPlugin: PluginType {
    var start: CFTimeInterval!
    var end: CFTimeInterval!
    func willSend(_ request: RequestType, target: TargetType) {
        start = CACurrentMediaTime() * 1000
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        end = CACurrentMediaTime() * 1000
    }
}

/// 创建网络请求对象
private let Provider = MoyaProvider<Fetcher>(endpointClosure: endpointClosure,
                                                requestClosure: requestClosure,
                                                session: defaultAlamofireManager(),
                                                plugins: [LogPlugin()],
                                                trackInflights: false)

/// 常规网络请求 不支持HUD、不支持cancel
///
/// - Parameters:
///   - fetcher: 请求体
///   - completion: 请求回调
public func fetchNetwork(fetcher: Fetcher, completion: @escaping successCallback) {
    _ = startRequest(fetcher: fetcher, hud: false, completion: completion)
}

/// 网络请求 带HUD 不支持cancel
///
/// - Parameters:
///   - fetcher: 请求体
///   - completion: 请求回调
public func fetchAlowHUD(fetcher: Fetcher, completion: @escaping successCallback) {
    _ = startRequest(fetcher: fetcher, hud: true, completion: completion)
}

/// 网络请求 带HUD 支持cancel
///
/// - Parameters:
///   - fetcher: 请求体
///   - completion: 请求回调
/// - Returns: cancel
public func fetchAllowCancel(fetcher: Fetcher, completion: @escaping successCallback) -> Cancellable {
    return startRequest(fetcher: fetcher, hud: true) { resp in
        completion(resp)
    }
}

/// 发起网络请求
///
/// - Parameters:
///   - fetcher: 网络请求体
///   - completion: 回调
private func startRequest(fetcher: Fetcher, hud: Bool, completion: @escaping successCallback) -> Cancellable {
    let start = CACurrentMediaTime() * 1000 // 请求开始时间
    if hud {
        showHUD()
    }

    return Provider.request(fetcher) { result in
        hideHUD()
        let end = CACurrentMediaTime() * 1000 // 请求回调时间
        let delta = end - start // 请求耗时
        var resp: NetworkResponse!
        switch result {
        case let .success(response):
            do {
                if let dic = try response.mapJSON() as? [String : Any] {
                    resp = NetworkResponse(fetcher: fetcher, time: delta, resp: dic)
                    resp.success = true
                }
            } catch {
                resp = NetworkResponse(fetcher: fetcher, time: delta, resp: [:])
                resp.err = "response parser fail"
            }
        case let .failure(error):
            resp = NetworkResponse(fetcher: fetcher, time: delta, resp: [:])
            resp.err = "network failed" + (error.errorDescription ?? "")
        }        
        completion(resp)
    }
}

// 显示HUD
private func showHUD() {
    MTHUD.showProgress()
}

// 隐藏HUD
private func hideHUD() {
    MTHUD.hide()
}

var isNetworkConnect: Bool {
    get {
        if CTCellularData().restrictedState == .restricted {
            molog.debug("not open")
            return false
        }
        
        let network = NetworkReachabilityManager(host: "https://www.apple.com/cn/")
                
        network?.startListening(onUpdatePerforming: { status in
            print(status)
        })
        
        return network?.isReachable ?? false
    }
}
