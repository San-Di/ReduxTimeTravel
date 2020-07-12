//
//  Extension.swift
//  Redux
//
//  Created by Sandi on 7/12/20.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Data {
    func decode<T>(modelType: T.Type,
                   success : @escaping (T) -> Void,
                   failure : @escaping (String) -> Void) where T : Decodable{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(modelType, from: self)
            success(result)
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError)")
            failure(jsonError.localizedDescription)
        }
    }
    
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription)")
            return nil
        }
    }
    
    func toJsonString() -> String? {
        let json = JSON(self)
        let jsonString = json.rawString()
        return jsonString
    }
    
    func filterByKey(key : String) -> Data {
        let json = JSON(self)
        let value = json[key]
        let jsonString = value.rawString()
        return Data(jsonString!.utf8)
    }
}
