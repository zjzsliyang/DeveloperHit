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

class V2EXViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let topicTableView = UITableView()
  
  var topics: [Topic] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestV2EX()

    navigationController?.navigationBar.topItem?.title = "V2EX Hot"
  }
  
  func initTopicTableView() {
    topicTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    topicTableView.delegate = self
    topicTableView.dataSource = self
    topicTableView.rowHeight = 95
    topicTableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: String(describing: ProjectTableViewCell.self))
    self.view.addSubview(topicTableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topics.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectTableViewCell.self), for: indexPath) as! ProjectTableViewCell
    cell.selectionStyle = .none
    let topic = topics[indexPath.row]
    cell.rankLabel?.text = String(describing: indexPath.row + 1)
    cell.repositoryLabel?.text = topic.title
    cell.repositoryLabel?.frame = CGRect(x: 65, y: 5, width: 280, height: 20)
    cell.repositoryLabel?.font = UIFont.systemFont(ofSize: 14)
    cell.userLabel?.text = topic.member?.userName
    do {
      let imageData = try Data(contentsOf: URL(string: "https:" + (topic.member?.avatar)!)!)
      cell.titleImageView?.image = UIImage(data: imageData)
    } catch {
      cell.titleImageView?.image = UIImage(named: "unknown")
    }
    cell.descriptionLabel?.text = topic.content
    cell.languageLabel?.text = "👉 " + String(describing: topic.replies!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let webView = WebKitViewController()
    webView.webView.loadRequest(URLRequest(url: URL(string: topics[indexPath.row].url ?? "https://v2ex.com/")!))
    self.navigationController?.pushViewController(webView, animated: true)
  }
  
  func requestV2EX() {
    Alamofire.request(ServiceBase.V2EXUrl).responseJSON { (response) in
      let json = JSON(data: response.data!)
      for (_, subJson): (String, JSON) in json {
        let member = Member(id: subJson["member"]["id"].int!, userName: subJson["member"]["username"].string!, avatar: subJson["member"]["avatar_mini"].string!)
        let node = Node(id: subJson["node"]["id"].int!, name: subJson["node"]["name"].string!, title: subJson["node"]["title"].string!, titleAlternative: subJson["node"]["title_alternative"].string!, url: subJson["node"]["url"].string!, topics: subJson["node"]["topics"].int!, avatar: subJson["node"]["avatar_mini"].string!)
        let topic = Topic(id: subJson["id"].int!, title: subJson["title"].string!
          , url: subJson["url"].string!, content: subJson["content"].string!, replies: subJson["replies"].int!, member: member, node: node)
        self.topics.append(topic)
      }
      self.initTopicTableView()
    }
  }
  
}
