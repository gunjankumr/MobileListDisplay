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
    cell.setMobile(mobile: mobile, selectedTab: .all)
    
    return cell
  }
}
