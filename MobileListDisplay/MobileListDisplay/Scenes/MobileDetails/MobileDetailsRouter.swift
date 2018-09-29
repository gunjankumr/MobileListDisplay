//
//  MobileDetailsRouter.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright (c) 2018 Allianz Technology. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol MobileDetailsRoutingLogic {
  
}

protocol MobileDetailsDataPassing {
  var dataStore: MobileDetailsDataStore? { get }
}

class MobileDetailsRouter: NSObject, MobileDetailsRoutingLogic, MobileDetailsDataPassing {
  weak var viewController: MobileDetailsViewController?
  var dataStore: MobileDetailsDataStore?
  
  // MARK: - Route Functions
  
  // MARK: - Navigate Functions
  
  // MARK: - Passing Data Functions
  
}