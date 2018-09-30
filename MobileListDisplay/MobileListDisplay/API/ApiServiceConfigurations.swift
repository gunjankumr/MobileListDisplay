//
//  ApiServiceConfigurations.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Moya
import Alamofire

public enum ApiServiceConfigurations {
  case getMobileList
  case getMobileDetailImages(mobileId: Int)
}

extension ApiServiceConfigurations: TargetType {
  
  public var baseURL: URL {
    return URL(string: ApiEnvironment.environment.baseURL)!
  }

  
  public var method: Moya.Method {
    return .get
  }
  
  public var path: String {
    switch self {
    case .getMobileList:
      return "mobiles/"
    case .getMobileDetailImages(let mobileId):
      return "mobiles/\(mobileId)/images/"
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var parameters: [String: Any]? {
    return [:]
  }
  
  public var task: Task {
    let encoding: ParameterEncoding = method == .get ? Alamofire.URLEncoding.default : Alamofire.JSONEncoding.default
    return Task.requestParameters(parameters: parameters!, encoding: encoding)
  }
  
  public var headers: [String : String]? {
    return nil
  }
}

