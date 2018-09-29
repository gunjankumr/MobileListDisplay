//
//  PublicEnums.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

public enum Sorting {
  case low
  case high
  case rating
}

public enum TapOptions {
  case all
  case favourite
}

public enum APIError: Swift.Error {
  case noRecord
  case noInternet
  case serviceError
}

