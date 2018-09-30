//
//  ApiEnvironment.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

public class ApiEnvironment {
  public static var environment = Environment.test
  
  public enum Environment {
    case test
    public var baseURL: String {
      switch self {
      case .test:
        return "https://scb-test-mobile.herokuapp.com/api/"
      }
    }
  }
  
}
