//
//  GitHubViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 27/10/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

enum ContributerError: Error {
  case NOCONTRIBUTER
  case NOAVATAR
  case INVALIDURL
}

@objcMembers class GitHubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {

  let trendTableView = UITableView()
  
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
    initTrendTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func initTrendTableView() {
    trendTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    trendTableView.delegate = self
    trendTableView.dataSource = self
    trendTableView.rowHeight = 95
    trendTableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: String(describing: ProjectTableViewCell.self))
    self.view.addSubview(trendTableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return projects.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProjectTableViewCell.self), for: indexPath) as! ProjectTableViewCell
    cell.selectionStyle = .none
    let project = projects[indexPath.row]
    cell.rankLabel?.text = String(describing: indexPath.row + 1)
    cell.repositoryLabel?.text = project.repositoryName
    cell.userLabel?.text = "Owner: " + project.owner!
    do {
      guard let contributerData = project.contributor else {
        throw ContributerError.NOCONTRIBUTER
      }
      if contributerData.isEmpty {
        cell.titleImageView?.image = UIImage(named: "unknown")
      } else {
        guard let avatarData = contributerData[0].avatar else {
          throw ContributerError.NOAVATAR
        }
        guard let urlData = URL(string: avatarData) else {
          throw ContributerError.INVALIDURL
        }
        let imageData = try Data(contentsOf: urlData)
        cell.titleImageView?.image = UIImage(data: imageData)
      }
    } catch {
      cell.titleImageView?.image = UIImage(named: "unknown")
    }
    
    cell.descriptionLabel?.text = project.descriptions
    cell.starLabel?.text = "Star: " + String(describing: project.stars ?? -1)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
//    TODO
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
