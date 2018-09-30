//
//  MobileListInteractorTest.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Quick
import Nimble
import Moya

@testable import MobileListDisplay

class MobileListInteractorTest: QuickSpec {
  
  override func spec() {
    var interactor: MobileListInteractor!
    var presenter: MobileListPresenterSpy!
    var worker: MobileListWorker!

    beforeEach {
      interactor = MobileListInteractor()
      presenter = MobileListPresenterSpy()
      interactor.presenter = presenter
      worker = MobileListWorker()
    }
    
    describe("GetMobileDataFromService") {
      context("No record") {
        beforeEach {
          let provider: MoyaProvider<ApiServiceConfigurations> = self.noDataStubbingProvider()
          worker.provider = provider
        }
        
        it("No data found") {
          interactor.getMobileListFromService(request: MobileList.GetMobileList.Request())
          expect(presenter.error) == MobileList.GetMobileList.ViewModel.GetMobileServiceError.noRecord
        }
      }
    }
    
    describe("Sorting") {
      beforeEach {
        let mobile1 = Mobile()
        mobile1.id = 1
        mobile1.rating = 4.9
        mobile1.name = "Moto E4 Plus"
        mobile1.description = "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly."
        mobile1.thumbImageURL = "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg"
        mobile1.brand = "Samsung"
        mobile1.price = 179.99
        
        let mobile2 = Mobile()
        mobile2.id = 2
        mobile2.rating = 4.6
        mobile2.name = "Nokia 6"
        mobile2.description = "Nokia is back in the mobile phone game and after a small price drop to the Nokia 6 we've now seen it enter our best cheap phone list. It comes with a Full HD 5.5-inch display, full metal design and a fingerprint scanner for added security. The battery isn't incredible on the Nokia 6, but it's not awful either making this one of our favorite affordable phones on the market right now."
        mobile2.thumbImageURL = "https://cdn.mos.cms.futurecdn.net/8LWUERoxMAWavvVAAbxuac-650-80.jpg"
        mobile2.brand = "Nokia"
        mobile2.price = 199.99
        
        interactor.mobiles = [mobile1, mobile2]
        FavouriteListWorker.shared.addFav(mobileId: 1)
        FavouriteListWorker.shared.addFav(mobileId: 2)
      }
      
      context("Sort by price low to high") {
        it("Should first record Moto E4 Plus and last Nokia 6") {
          interactor.getSortedMobileList(request:  MobileList.GetSortedMobileList.Request(selectedTab: .all, sorting: .low))
          expect(presenter.mobiles.first?.name) == "Moto E4 Plus"
          expect(presenter.mobiles.last?.name) == "Nokia 6"
        }
      }
      
      context("Sort by price high to low") {
        it("Should first record Nokia 6 and last Moto E4 Plus") {
          interactor.getSortedMobileList(request:  MobileList.GetSortedMobileList.Request(selectedTab: .all, sorting: .high))
          expect(presenter.mobiles.first?.name) == "Nokia 6"
          expect(presenter.mobiles.last?.name) == "Moto E4 Plus"
        }
      }
      
      context("Sort by Rating") {
        it("Should first record Moto E4 Plus and last Nokia 6") {
          interactor.getSortedMobileList(request:  MobileList.GetSortedMobileList.Request(selectedTab: .all, sorting: .rating))
          expect(presenter.mobiles.first?.name) == "Moto E4 Plus"
          expect(presenter.mobiles.last?.name) == "Nokia 6"
        }
      }
      
    }
    
    
    describe("Select Mobile") {
      context("Select one mobile") {
        beforeEach {
          let mobile1 = Mobile()
          mobile1.id = 1
          mobile1.rating = 4.9
          mobile1.name = "Moto E4 Plus"
          mobile1.description = "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly."
          mobile1.thumbImageURL = "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg"
          mobile1.brand = "Samsung"
          mobile1.price = 179.99
          
          let mobile2 = Mobile()
          mobile2.id = 2
          mobile2.rating = 4.6
          mobile2.name = "Nokia 6"
          mobile2.description = "Nokia is back in the mobile phone game and after a small price drop to the Nokia 6 we've now seen it enter our best cheap phone list. It comes with a Full HD 5.5-inch display, full metal design and a fingerprint scanner for added security. The battery isn't incredible on the Nokia 6, but it's not awful either making this one of our favorite affordable phones on the market right now."
          mobile2.thumbImageURL = "https://cdn.mos.cms.futurecdn.net/8LWUERoxMAWavvVAAbxuac-650-80.jpg"
          mobile2.brand = "Nokia"
          mobile2.price = 199.99

          interactor.mobiles = [mobile1, mobile2]
        }
        
        it("call presentSelectedMobile") {
          interactor.selectedMobile(request: MobileList.SelectedMobile.Request(id: 1))
          expect(presenter.isPresentSelectedMobile) == true
        }
        
      }
    }
  }
  
}


class MobileListPresenterSpy: MobileListPresentationLogic {
  var isSuccess = false
  var mobiles: [Mobile] = []
  var error: MobileList.GetMobileList.ViewModel.GetMobileServiceError = .noRecord
  var selectedMobile = Mobile()
  var isPresentSelectedMobile = false
  
  func presentMobileListFromService(response: MobileList.GetMobileList.Response) {
    switch response.result {
    case .success(let mobiles):
      isSuccess = true
      self.mobiles = mobiles
    case .failure(.noRecord):
      error = .noRecord
    case .failure(.serviceError):
      error = .serviceError
    default: break
    }
  }
  
  func presentMobileListWithSorting(response: MobileList.GetSortedMobileList.Response) {
    mobiles = response.mobiles

  }
  
  func presentSelectedMobile(response: MobileList.SelectedMobile.Response) {
    isPresentSelectedMobile = true
    }
}

extension MobileListInteractorTest {
  func noDataEndpointsClosure(target: ApiServiceConfigurations) -> Endpoint {
    let sampleResponseClosure = { () -> EndpointSampleResponse in
      let response = ""
      return .networkResponse(200, response.data(using: .utf8)!)
    }
    
    let url = target.baseURL.absoluteString
    let method = target.method
    let endpoint = Endpoint(url: url, sampleResponseClosure: sampleResponseClosure, method: method, task: target.task, httpHeaderFields: target.headers)
    return endpoint
  }
  
  public func noDataStubbingProvider() -> MoyaProvider<ApiServiceConfigurations> {
    return MoyaProvider<ApiServiceConfigurations>(endpointClosure: noDataEndpointsClosure, stubClosure: MoyaProvider.immediatelyStub)
  }
  
  func errorEndpointsClosure(target: ApiServiceConfigurations) -> Endpoint {
    let sampleResponseClosure = { () -> EndpointSampleResponse in
      return .networkResponse(500, Data())
    }
    
    let url = target.baseURL.absoluteString
    let method = target.method
    let endpoint = Endpoint(url: url, sampleResponseClosure: sampleResponseClosure, method: method, task: target.task, httpHeaderFields: target.headers)
    return endpoint
  }
  
  public func errorStubbingProvider() -> MoyaProvider<ApiServiceConfigurations> {
    return MoyaProvider<ApiServiceConfigurations>(endpointClosure: errorEndpointsClosure, stubClosure: MoyaProvider.immediatelyStub)
  }
}




