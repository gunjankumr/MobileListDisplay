//
//  MobileList+TableView.swift
//  MobileListDisplay
//
//  Created by Sujeet Sinha on 29/9/18.
//  Copyright © 2018 Sujeet Sinha. All rights reserved.
//
import UIKit
import Foundation

extension MobileListViewController: UITableViewDataSource {
  func setUpTableView() {
    tableView?.estimatedRowHeight = 120.0
    tableView?.rowHeight = 120.0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120.0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mobiles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MobileListTableViewCell", for: indexPath) as? MobileListTableViewCell else {
        return UITableViewCell()
    }
    
    let mobileInfo: MobileList.MobileInfo?  = self.mobiles[indexPath.row]
    
    guard let mobile = mobileInfo else { return cell }
    cell.favButton.tag = mobileInfo?.id ?? 0
    cell.isAccessibilityElement = true
    cell.accessibilityLabel = "\(String(describing: mobileInfo?.id))"
    cell.favButton.addTarget(self, action: #selector(favButtonClicked), for: .touchUpInside)
    cell.setMobile(mobile: mobile, selectedTab: selectedTab)

    return cell
  }
  
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if selectedTab == .favourite {
      return true
    } else {
      return false
    }
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    if selectedTab == .favourite {
      let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
        let displayMobile: MobileList.MobileInfo?  = self.mobiles[indexPath.row]
        if let mobile = displayMobile {
          FavouriteListWorker.shared.deleteFav(mobileId: mobile.id)
          self.getMobileList()
        }
      }
      return [delete]
    } else {
      return nil
    }
  }

  @objc func favButtonClicked(sender: UIButton){
    let mobileId = sender.tag
    FavouriteListWorker.shared.addFav(mobileId: mobileId)
    self.getMobileList()
  }
}

extension MobileListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let displayMobile: MobileList.MobileInfo?  = self.mobiles[indexPath.row]
    guard let mobile = displayMobile else { return }
    selectedMobile(mobile: mobile)
  }
}
