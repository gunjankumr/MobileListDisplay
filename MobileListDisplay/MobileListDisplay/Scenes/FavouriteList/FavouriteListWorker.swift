//
//  FavouriteListWorker.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright (c) 2018 Allianz Technology. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//  please "import Result" to easy returning structure
//

import UIKit
import RealmSwift


class FavouriteListWorker {
  static var shared = try! FavouriteListWorker()

  let realm: Realm
  
  init() throws {
    realm = try Realm()
  }
  func addFav(mobileId: Int) {
    let newFav  = Favourite()
    newFav.mobileId = mobileId
    do {
      try realm.write {
         realm.add(newFav)
      }
    } catch {
      print("error addFav: " + error.localizedDescription)
    }
  }
  
  func deleteFav(mobileId: Int) {
    do {
      try realm.write {
        realm.delete(realm.objects(Favourite.self).filter("mobileId=%@",mobileId))

      }
    } catch {
      print("error deleteFav: " + error.localizedDescription)
    }
  }
  
  func fetchAllFav() -> [Int] {
    let favList = Array(realm.objects(Favourite.self))
    let favMobileList = favList.map { $0.mobileId }
    guard favMobileList.count > 0 else {
      return []
    }
    return favMobileList
  }
  
  func getIsFavouriteById(mobileId: Int) -> Bool {
    if fetchAllFav().contains(mobileId) {
      return true
    } else {
      return false
    }
  }
}
