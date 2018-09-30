//
//  MobileListSpec.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

@testable import MobileListDisplay


class MobileListSpec: FBSnapshotTestCase {
  var mobileList: MobileListViewController!

  override func setUp() {
    super.setUp()
    
    XCUIApplication().launch()
    recordMode = true
    mobileList = MobileListViewController()
  }
}
