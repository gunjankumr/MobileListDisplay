//
//  Mobile.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

public class Mobile: Decodable {
  var id: Int
  var rating: Float
  var name: String
  var description: String
  var thumbImageURL: String
  var brand: String
  var price: Float
  
  init() {
    id = 0
    rating = 0.0
    name = ""
    description = ""
    thumbImageURL = ""
    brand = ""
    price = 0.0
  }
}

