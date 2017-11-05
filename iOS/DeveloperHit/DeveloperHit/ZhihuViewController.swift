//
//  ZhihuViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 04/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

@objcMembers class ZhihuViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
  
  let topicTableView = UITableView()
  
  var eleName = String()
  var questions: [Question] = []
  var topic = String()
  var nameCnt = 0
  var urlCnt = 0
  
  dynamic var title_: String? = nil
  dynamic var url: String? = nil
  dynamic var upvotes: String? = nil
  dynamic var commentCount: String? = nil
  dynamic var answerUrl: String? = nil
  dynamic var users: [User]? = nil
  
  dynamic var name: String? = nil
  dynamic var userUrl: String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestZHihu()
    initTopicTableView()
    
    navigationController?.navigationBar.topItem?.title = topic
  }
  
  func initTopicTableView() {
    topicTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    topicTableView.delegate = self
    topicTableView.dataSource = self
    self.view.addSubview(topicTableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TopicTableViewCell")
    let question = questions[indexPath.row]
    cell.textLabel?.text = question.user![0].name
    cell.detailTextLabel?.text = question.title_
    let upvoteLabel = UILabel(frame: CGRect(x: cell.frame.maxX - 100, y: 10, width: 100, height: 20))
    upvoteLabel.textColor = UIColor(red: 0.24, green: 0.51, blue: 0.78, alpha: 1)
    upvoteLabel.font = UIFont.systemFont(ofSize: 12)
    upvoteLabel.text = "upvote: " + question.upvotes!
    cell.addSubview(upvoteLabel)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
//    TODO
  }
  
  func requestZHihu() {
    let parse = XMLParser(contentsOf: URL(string: ServiceBase.ZhihuUrl)!)
    parse?.delegate = self
    parse?.parse()
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    eleName = elementName
    if elementName == "question" {
      title_ = String()
      url = String()
      upvotes = String()
      commentCount = String()
      answerUrl = String()
      users = []
    }
    if elementName == "user" {
      name = String()
      userUrl = String()
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "question" {
      let question = Question(title_: title_!, url: url!, upvotes: upvotes!, commentCount: commentCount!, answerUrl: answerUrl!, user: users!)
      questions.append(question)
      users = []
    }
    if elementName == "user" {
      let user = User(name: name!, url: url!)
      users!.append(user)
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    let str = string.trimmingCharacters(in: .whitespacesAndNewlines)
    switch eleName {
    case "title":
      eleName += "_"
    case "comment_count":
      eleName = "commentCount"
    case "answer_url":
      eleName = "answerUrl"
    case "user_url":
      eleName = "userUrl"
    case "name":
      if nameCnt == 0 {
        topic = str
        nameCnt += 1
      }
    default: break
    }
    self.setValue(String(describing: value(forKey: eleName) ?? "") + str, forKey: eleName)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {}
  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
}
