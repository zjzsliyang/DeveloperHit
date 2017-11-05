//
//  V2EXViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 04/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class V2EXViewController: UIViewController {
  
  var topics: [Topic] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestV2EX()
  }
  
  func requestV2EX() {
    Alamofire.request(ServiceBase.V2EXUrl).responseJSON { (response) in
      let json = JSON(data: response.data!)
      for (_, subJson): (String, JSON) in json {
        let member = Member(id: subJson["member"]["id"].string!, userName: subJson["member"]["username"].string!, avatar: subJson["member"]["avatar_mini"].string!)
        let node = Node(id: subJson["node"]["id"].string!, name: subJson["node"]["name"].string!, title: subJson["node"]["title"].string!, titleAlternative: subJson["node"]["title_alternative"].string!, url: subJson["node"]["url"].string!, topics: subJson["node"]["topics"].string!, avatar: subJson["node"]["avatar_mini"].string!)
        let topic = Topic(id: subJson["id"].string!, title: subJson["title"].string!
          , url: subJson["url"].string!, content: subJson["content"].string!, replies: subJson["replies"].string!, member: member, node: node)
        self.topics.append(topic)
      }
    }
  }
  
}
