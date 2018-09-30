//
//  MobileDetailsInteractorTest.swift
//  MobileListDisplayTests
//
//  Created by Sujeet Sinha on 30/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//

import Quick
import Nimble
import Moya


@testable import MobileListDisplay

class MobileDetailsInteractorTest: QuickSpec {
  
  override func spec() {
    var interactor: MobileDetailsInteractor!
    var presenter: MobileDetailsPresenterSpy!
    var worker: MobileDetailsWorker!
    
    beforeEach {
      interactor = MobileDetailsInteractor()
      presenter = MobileDetailsPresenterSpy()
      interactor.presenter = presenter
      worker = MobileDetailsWorker()
    }
    
    describe("GetDetailData") {
      context("Get selected mobile data") {
        beforeEach {
          let mobile = Mobile()
          mobile.id = 1
          mobile.rating = 4.9
          mobile.name = "Moto E4 Plus"
          mobile.description = "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly."
          mobile.thumbImageURL = "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg"
          mobile.brand = "Samsung"
          mobile.price = 179.99
          interactor.selectedMobile = mobile
        }
        
        it("noData record") {
          let provider: MoyaProvider<ApiServiceConfigurations> = self.noDataStubbingProvider()
          worker.provider = provider
          interactor.getMobileDetailInfo(request: MobileDetails.GetMobileDetail.Request())
          expect(presenter.mobile?.name).to(beNil())
          expect(presenter.imageGallery).to(beNil())
        }
      }
    }
    
  }
  
}

class MobileDetailsPresenterSpy: MobileDetailsPresentationLogic {
  var mobile: Mobile?
  var imageGallery: [MobileDetailImages]?
  
  func presentMobileDetails(response: MobileDetails.GetMobileDetail.Response) {
    self.mobile = response.mobile
    self.imageGallery = response.imageGallery
  }
  
  func presentMobileDetailError() {
  }
}

extension MobileDetailsInteractorTest {
  func noDataEndpointsClosure(target: ApiServiceConfigurations) -> Endpoint {
    let sampleResponseClosure = { () -> EndpointSampleResponse in
      let response = ""
      return .networkResponse(200, response.data(using: .utf8)!) // Success response
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
      return .networkResponse(500, Data()) // Internal server error
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
