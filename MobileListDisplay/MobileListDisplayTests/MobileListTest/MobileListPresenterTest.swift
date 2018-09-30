//
//  MobileListPresenterTest.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Quick
import Nimble
import Result

@testable import MobileListDisplay

class MobileListPresenterTests: QuickSpec {
  
  override func spec() {
    
    var presenter: MobileListPresenter!
    var viewController: MobileListViewControllerSpy!
    
    beforeEach {
      presenter = MobileListPresenter()
      viewController = MobileListViewControllerSpy()
      presenter.viewController = viewController
    }
    
    describe("Display mobile data from service") {
      context("Send response to controller") {
        
        it("Should call displayMobileList") {
          presenter.presentMobileListFromService(response: MobileList.GetMobileList.Response(result: .success([Mobile()])))
          expect(viewController.mobiles.count) == 1
        }
      }
    }
    
    describe("Sorting") {
      context("Send response to controller") {
        it("Should call displayMobileListWithSorting") {
          presenter.presentMobileListWithSorting(response: MobileList.GetSortedMobileList.Response(mobiles: [Mobile(), Mobile()]))
          expect(viewController.mobiles.count) == 2
        }
      }
    }
    
    describe("Select Mobile") {
      context("Send response to controller") {
        it("Should call displaySelectedMobile") {
          presenter.presentSelectedMobile(response: MobileList.SelectedMobile.Response())
          expect(viewController.isDisplaySelectedMobile) == true
        }
      }
    }
    
  }
  
}


class MobileListViewControllerSpy: MobileListDisplayLogic {
  var isDisplaySelectedMobile = false
  var mobiles: [MobileList.MobileInfo] = []

  func displayMobileList(viewModel: MobileList.GetMobileList.ViewModel) {
    switch viewModel.result {
    case .success(let mobiles):
      self.mobiles = mobiles
    default: break
    }
  }
  
  func displayMobileListWithSorting(viewModel: MobileList.GetSortedMobileList.ViewModel) {
    mobiles = viewModel.mobiles
  }
  
  func displaySelectedMobile(viewModel: MobileList.SelectedMobile.ViewModel) {
    isDisplaySelectedMobile = true
  }
}

