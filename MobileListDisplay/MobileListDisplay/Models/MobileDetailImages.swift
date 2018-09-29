//
//  MobileDetailImages.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Foundation

public class MobileDetailImages: Decodable {
  var id: Int
  var url: String
  var mobileId: Int
  
  init() {
    id = 0
    url = ""
    mobileId = 0
  }
  
  private enum CodingKeys: String, CodingKey {
    case id
    case url
    case mobileId = "mobile_id"
  }
}

