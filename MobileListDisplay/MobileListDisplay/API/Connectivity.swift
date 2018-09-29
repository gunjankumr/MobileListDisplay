//
//  Connectivity.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Alamofire

class Connectivity {
  class var isConnectedToInternet:Bool {
    return NetworkReachabilityManager()!.isReachable
  }
}


