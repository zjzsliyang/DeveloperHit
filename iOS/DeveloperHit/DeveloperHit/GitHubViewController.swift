//
//  GitHubViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 27/10/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

@objcMembers class GitHubViewController: UIViewController, XMLParserDelegate {
  
  var eleName = String()
  var projects: [Project] = []
  var contributors: [Developer] = []
  
  dynamic var name: String? = nil
  dynamic var owner: String? = nil
  dynamic var repository_name: String? = nil
  dynamic var descriptions: String? = nil
  dynamic var language: String? = nil
  dynamic var stars: String? = nil
  dynamic var url: String? = nil
  dynamic var contributor_url: String? = nil
  dynamic var contributor: [Developer]? = nil
  
  dynamic var id: String? = nil
  dynamic var display_name: String? = nil
  dynamic var full_name: String? = nil
  dynamic var dev_url: String? = nil
  dynamic var avatar: String? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    requestGitHub()
  }
  
  func requestGitHub() {
    let parse = XMLParser(contentsOf: URL(string: ServiceBase.GitHubUrl)!)
    parse?.delegate = self
    parse?.parse()
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    eleName = elementName
    if elementName == "project" {
      name = String()
      owner = String()
      repository_name = String()
      descriptions = String()
      language = String()
      stars = String()
      url = String()
      contributor_url = String()
      contributor = []
    }
    if elementName == "contributor" {
      id = String()
      display_name = String()
      full_name = String()
      dev_url = String()
      avatar = String()
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    if elementName == "project" {
      let project = Project(name: name!, owner: owner!, repositoryName: repository_name!, descriptions: descriptions!, language: language!, stars: Int(stars!)!, url: url!, contributorUrl: contributor_url!, contributor: contributors)
      projects.append(project)
      contributors = []
    }
    if elementName == "contributor" {
      let contributor = Developer(id: Int(id!)!, displayName: display_name!, fullName: full_name!, devUrl: dev_url!, avatar: avatar!)
      contributors.append(contributor)
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    let str = string.trimmingCharacters(in: .whitespacesAndNewlines)
    self.setValue(String(describing: value(forKey: eleName)!) + str, forKey: eleName)
  }
  
  override func setValue(_ value: Any?, forUndefinedKey key: String) {}
  override func value(forUndefinedKey key: String) -> Any? {
    return ""
  }
}
