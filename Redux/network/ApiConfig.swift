//
//  ApiConfig.swift
//  Redux
//
//  Created by Sandi on 7/12/20.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SystemConfiguration
import SwiftyJSON
import Reachability

let apiKey = "2d69f33faee189cc2f0a21c6db9b2e36"
let baseUrl = "https://api.themoviedb.org/3/movie/"
let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZDY5ZjMzZmFlZTE4OWNjMmYwYTIxYzZkYjliMmUzNiIsInN1YiI6IjVmMDQzOTM1OGEwZTliMDAzMzlhYjY2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XA8bLCoXoNqdksu9hUZ6Qml2P08hK-lQiz66ZxMbK9g"

let API_KEY = "api_key"
let BASE_IMG_URL = "https://image.tmdb.org/t/p/w500"

class ApiClient {
    //MARK:- NETWORK CALLS
    static let shared = ApiClient()
    
    private let APIManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let delegate = Session.default.delegate
        let manager = Session.init(configuration: configuration,
                                   delegate: delegate)
        return manager
    }()
    
    
    public func request(url : String,
                        method : HTTPMethod = .get,
                        parameters : Parameters = [:],
                        headers : HTTPHeaders = [:]) -> Observable<Any>{
        
        if !ApiClient.checkReachable() {
            
            return Observable.create { observer in
                let message = "လူကြိးမင်း၏ အင်တာနက်အား ပြန်လည်စစ်ဆေးပါ။"
                let error = NSError(domain:"", code: 99999, userInfo:[ NSLocalizedDescriptionKey: message]) as Error
                observer.onError(error)
                return Disposables.create()
            }
        }
        
        var headers = headers
//        headers["Authorization"] = "APP_KEY \(ApiConfig.APP_KEY)"
        headers["Content-Type"] = "application/json"
        
        let encoding : ParameterEncoding = (method == .get ? URLEncoding.default : JSONEncoding.default)
        
        return Observable.create { observer in
            
            self.APIManager.request(url, method: method, parameters: parameters,encoding: encoding, headers: headers).responseData { (response) in
                switch response.result {
                    
                case .success(let data) :
                    
//                    if let baseResponse = data.decode(modelType: BaseResponse.self),
//                        let status = 1,
////                        let message = baseResponse.message,
//                        status != 1{
//                        let error = NSError(domain:"", code: 1, userInfo:[ NSLocalizedDescriptionKey: "message"]) as Error
//                        observer.onError(error)
//                    }
                    
                    observer.onNext(data)
                    observer.onCompleted()
                    
                case .failure(let error) :
                    observer.onError(error)
                    print(error.localizedDescription)
                    break
                }
                
            }
            
            return Disposables.create()
        }
        
        
    }
    
}

//MARK:- CHECK NETWORK
extension ApiClient {
    
    static func isOnline(callback: @escaping (Bool) -> Void){
        //declare this property where it won't go out of scope relative to your listener
        
        let reachability = try! Reachability()
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                callback(true)
            } else {
                print("Reachable via Cellular")
                callback(true)
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            callback(false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
            callback(false)
        }
    }
    
    static func checkReachable() -> Bool{
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        if (isNetworkReachable(with: flags))
        {
            print (flags)
            if flags.contains(.isWWAN) {
                return true
            }
            
            //                        self.alert(message:"via wifi",title:"Reachable")
            
            return true
        }
        else if (!isNetworkReachable(with: flags)) {
            //            self.alert(message:"Sorry no connection",title: "unreachable")
            print (flags)
            return false
        }
        
        return false
    }
    
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}

