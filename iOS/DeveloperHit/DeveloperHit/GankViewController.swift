//
//  GankViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 04/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GankViewController: UIViewController {
  
  var ganks: [Gank] = []
  let categorys = ["iOS", "Android", "瞎推荐", "拓展资源", "福利", "休息视频"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestGank()
  }
  
  func requestGank() {
    Alamofire.request(ServiceBase.GankUrl).response { (response) in
      let json = JSON(data: response.data!)
      for category in self.categorys {
        for (_, subJson): (String, JSON) in json["results"][category] {
          let gank = Gank(id: subJson["_id"].string!, createAt: subJson["createdAt"].string!, desc: subJson["desc"].string!, publishedAt: subJson["publishedAt"].string!, type: subJson["type"].string!, url: subJson["url"].string!, used: subJson["used"].bool!, who: subJson["who"].string!)
          self.ganks.append(gank)
        }
      }
    }
  }
  
  
}
