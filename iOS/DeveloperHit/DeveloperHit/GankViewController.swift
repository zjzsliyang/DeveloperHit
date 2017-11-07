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

class GankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let gankTableView = UITableView()
  
  var ganks: [[Gank]] = []
  let categorys = ["iOS", "Android", "瞎推荐", "拓展资源", "福利", "休息视频"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestGank()
    
    navigationController?.navigationBar.topItem?.title = "Gank.io"
  }
  
  func initGankTableView() {
    gankTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    gankTableView.delegate = self
    gankTableView.dataSource = self
    self.view.addSubview(gankTableView)
  }
  
  func requestGank() {
    Alamofire.request(ServiceBase.GankUrl).response { (response) in
      let json = JSON(data: response.data!)
      for category in self.categorys {
        var tempGank: [Gank] = []
        for (_, subJson): (String, JSON) in json["results"][category] {
          let gank = Gank(id: subJson["_id"].string!, createAt: subJson["createdAt"].string!, desc: subJson["desc"].string!, publishedAt: subJson["publishedAt"].string!, type: subJson["type"].string!, url: subJson["url"].string!, used: subJson["used"].bool!, who: subJson["who"].string!)
          tempGank.append(gank)
        }
        self.ganks.append(tempGank)
      }
      self.initGankTableView()
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return categorys[section]
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return categorys.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ganks[section].count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let webView = WebKitViewController()
    webView.webView.loadRequest(URLRequest(url: URL(string: ganks[indexPath.section][indexPath.row].url ?? "https://gank.io/")!))
    self.navigationController?.pushViewController(webView, animated: true)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "GankTableViewCell")
    cell.textLabel?.text = ganks[indexPath.section][indexPath.row].who
    cell.detailTextLabel?.text = ganks[indexPath.section][indexPath.row].desc
    return cell
  }
}
