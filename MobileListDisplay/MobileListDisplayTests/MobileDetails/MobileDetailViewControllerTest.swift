//
//  MobileDetailViewControllerTest.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Nimble
import Quick
import SWSegmentedControl

@testable import MobileListDisplay

class MobileDetailViewControllerTest: QuickSpec {
  override func spec() {
    describe("MobileDetailViewControllerTest") {
      var controller: MobileDetailsViewController!
      var interactor: MobileDetailsInteractorSpy!
      var tableView: UITableView!
      var segmentedControl: SWSegmentedControl!
      var sorting: Sorting!
      var selectedTab: TapOptions!
      var mobiles: [MobileList.MobileInfo]!
      
      beforeEach {
        controller = MobileDetailsViewController()
        interactor = MobileDetailsInteractorSpy()
        controller.interactor = interactor
      }
      
      describe("getMobileDetail") {
        beforeEach {
          controller.getMobileDetail()
        }
        it("should test getMobileDetail") {
          expect(interactor.isGetMobileDetailInfo).to(beTrue())
        }
      }
    }
  }
}

private class MobileDetailsInteractorSpy: MobileDetailsBusinessLogic {
  var isGetMobileDetailInfo = false
  func getMobileDetailInfo(request: MobileDetails.GetMobileDetail.Request) {
    isGetMobileDetailInfo = true
  }
}


