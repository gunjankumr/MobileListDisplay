//
//  MobileListViewControllerTest.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Nimble
import Quick
import SWSegmentedControl

@testable import MobileListDisplay

class MobileListViewControllerTest: QuickSpec {
  override func spec() {
    describe("MobileListViewController") {
      var controller: MobileListViewController!
      var interactor: MobileListInteractorSpy!
      var tableView: UITableView!
      var segmentedControl: SWSegmentedControl!
      var sorting: Sorting!
      var selectedTab: TapOptions!
      var mobiles: [MobileList.MobileInfo]!

      beforeEach {
        controller = MobileListViewController()
        interactor = MobileListInteractorSpy()
        controller.interactor = interactor
        tableView = UITableView()
        segmentedControl = SWSegmentedControl()
        controller.tableView = tableView
      }
      
      describe("getMobileDataFromService") {
        beforeEach {
          controller.getMobileDataFromService()
        }
        it("should test getMobileDataFromService") {
          expect(interactor.isGetMobileListFromService).to(beTrue())
        }
      }
      
      describe("getSortedMobileList") {
        beforeEach {
          controller.getMobileList()
        }
        
        it("should test getSortedMobileList") {
          expect(interactor.isGetSortedMobileList).to(beTrue())
        }
      }
      
      describe("selectedMobile") {
        let testMobile: MobileList.MobileInfo = MobileList.MobileInfo(id: 1, rating: 4.9, name: "Moto E4 Plus", description: "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.", thumbImageURL: "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg", price: 179.99)
        beforeEach {
          controller.selectedMobile(mobile: testMobile)
        }
        
        it("should test selectedMobile") {
          expect(interactor.isSelectedMobile).to(beTrue())
        }
      }
      
      describe("displayMobileList") {
        context("one record") {
          beforeEach {
            let testMobile: MobileList.MobileInfo = MobileList.MobileInfo(id: 1, rating: 4.9, name: "Moto E4 Plus", description: "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.", thumbImageURL: "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg", price: 179.99)
            
            var mobileListArray:[MobileList.MobileInfo] = []
            mobileListArray.append(testMobile)
            controller.mobiles = mobileListArray
            let viewModel = MobileList.GetMobileList.ViewModel(result: .success(mobileListArray))
            controller.displayMobileList(viewModel: viewModel)
          }
          it("get the mobile info count") {
            expect(controller.mobiles).to(haveCount(1))
          }
        }
        
        context("multiple mobiles") {
          beforeEach {
            var mobileListArray:[MobileList.MobileInfo] = []
            let testMobile: MobileList.MobileInfo = MobileList.MobileInfo(id: 1, rating: 4.9, name: "Moto E4 Plus", description: "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.", thumbImageURL: "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg", price: 179.99)
            let testMobile1: MobileList.MobileInfo = MobileList.MobileInfo(id: 1, rating: 4.9, name: "Moto E4 Plus", description: "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.", thumbImageURL: "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg", price: 179.99)
            
            
            mobileListArray.append(testMobile)
            mobileListArray.append(testMobile1)
            controller.mobiles = mobileListArray

            let viewModel = MobileList.GetMobileList.ViewModel(result: .success(mobileListArray))
            controller.displayMobileList(viewModel: viewModel)
          }
          it("get the mobile info count") {
            expect(controller.mobiles).to(haveCount(2))
          }
        }
        
        context("No mobile with fail response") {
          beforeEach {

            let viewModel = MobileList.GetMobileList.ViewModel(result: .failure(.noRecord))
            controller.displayMobileList(viewModel: viewModel)
          }
          it("No rescord found") {
            expect(controller.mobiles).to(haveCount(0))
          }
        }
        
        context("No mobile with no internet") {
          beforeEach {
            
            let viewModel = MobileList.GetMobileList.ViewModel(result: .failure(.noInternet))
            controller.displayMobileList(viewModel: viewModel)
          }
          it("No internet connection") {
            expect(controller.mobiles).to(haveCount(0))
          }
        }
        
        context("No mobile with service error") {
          beforeEach {
            
            let viewModel = MobileList.GetMobileList.ViewModel(result: .failure(.serviceError))
            controller.displayMobileList(viewModel: viewModel)
          }
          it("No response from service") {
            expect(controller.mobiles).to(haveCount(0))
          }
        }
      }
      
      describe("displayMobileListWithSorting") {
        context("sorting feature for low and all") {
          beforeEach {
              var mobileListArray:[MobileList.MobileInfo] = []
              let testMobile: MobileList.MobileInfo = MobileList.MobileInfo(id: 1, rating: 4.9, name: "Moto E4 Plus", description: "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.", thumbImageURL: "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg", price: 179.99)
            
              let testMobile1: MobileList.MobileInfo = MobileList.MobileInfo(id: 2, rating: 4.6, name: "Nokia 6", description: "Nokia is back in the mobile phone game and after a small price drop to the Nokia 6 we've now seen it enter our best cheap phone list. It comes with a Full HD 5.5-inch display, full metal design and a fingerprint scanner for added security. The battery isn't incredible on the Nokia 6, but it's not awful either making this one of our favorite affordable phones on the market right now.", thumbImageURL: "https://cdn.mos.cms.futurecdn.net/8LWUERoxMAWavvVAAbxuac-650-80.jpg", price: 199.99)
            
            
              mobileListArray.append(testMobile)
              mobileListArray.append(testMobile1)
              controller.mobiles = mobileListArray
              sorting = .low
              selectedTab = .all
              controller.getMobileList()
              let viewModel = MobileList.GetSortedMobileList.ViewModel(mobiles: mobileListArray)
              controller.displayMobileListWithSorting(viewModel: viewModel)

          }
          it("Sort mobile list with sorting low and tab all") {
            expect(controller.mobiles[0].id).to(equal(1))
            expect(controller.mobiles[0].rating).to(equal(4.9))
            expect(controller.mobiles[0].name).to(equal("Moto E4 Plus"))
            expect(controller.mobiles[0].description).to(equal("First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly."))
            expect(controller.mobiles[0].thumbImageURL).to(equal("https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg"))
            expect(controller.mobiles[0].price).to(equal(179.99))

          }
        }
    }
      
//      describe("displaySelectedMobile") {
//        context("all request types") {
//          beforeEach {
//            let requestTypeNames = ["Request 1", "Request 2", "Request 3"]
//            let requestTypeIdentifiers = ["id 1", "id 2", "id 3"]
//            let viewModel = CreateCase.GetRequestTypes.ViewModel(requestTypeNames: requestTypeNames,
//                                                                 requestTypeIdentifiers: requestTypeIdentifiers)
//            controller.displayRequestTypes(viewModel)
//          }
//          it("Set requestTypeNames and requestTypeIdentifiers variables") {
//            expect(controller.requestTypeNames).to(haveCount(3))
//            expect(controller.requestTypeIdentifiers).to(haveCount(3))
//            expect(controller.requestTypeNames[0]).to(equal("Request 1"))
//            expect(controller.requestTypeIdentifiers[0]).to(equal("id 1"))
//          }
//        }
//      }
    }
  }
}

private class MobileListInteractorSpy: MobileListBusinessLogic {
  var isGetMobileListFromService = false
  var isGetSortedMobileList = false
  var isSelectedMobile = false

  func getMobileListFromService(request: MobileList.GetMobileList.Request) {
    isGetMobileListFromService = true
  }
  
  func getSortedMobileList(request: MobileList.GetSortedMobileList.Request) {
    isGetSortedMobileList = true
  }
  
  func selectedMobile(request: MobileList.SelectedMobile.Request) {
    isSelectedMobile = true
  }
  
}

