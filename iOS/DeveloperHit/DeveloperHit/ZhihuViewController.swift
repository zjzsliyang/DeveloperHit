//
//  ZhihuViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 04/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

@objcMembers class ZhihuViewController: UIViewController, XMLParserDelegate {
  
  var eleName = String()
  var questions: [Question] = []
  
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
    default: break
    }
    self.setValue(String(describing: value(forKey: eleName) ?? "") + str, forKey: eleName)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {}
  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
}
