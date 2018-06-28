//
//  Apiservice.swift
//  Currencies
//
//  Created by Artem on 28/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import Moya


enum ApiService{
    case fetch(String)
}

extension ApiService : TargetType{
    
    public var baseURL: URL { return URL(string: "https://revolut.duckdns.org")! }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters:  parameters ?? [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var path: String {
        return "/latest"
    }
    
    var parameters : [String:Any]?{
        switch self {
        case .fetch(let base):
            return ["base":base]
        }
    }
}


