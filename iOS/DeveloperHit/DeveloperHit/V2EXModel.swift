//
//  V2EXModel.swift
//  DeveloperHit
//
//  Created by Yang Li on 05/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import Foundation

public class Member {
  public var id: Int?
  public var userName: String?
  public var avatar: String?
  
  init(id: Int, userName: String, avatar: String) {
    self.id = id
    self.userName = userName
    self.avatar = avatar
  }
}

public class Node {
  public var id: Int?
  public var name: String?
  public var title: String?
  public var titleAlternative: String?
  public var url: String?
  public var topics: Int?
  public var avatar: String?
  
  init(id: Int, name: String, title: String, titleAlternative: String, url: String, topics: Int, avatar: String) {
    self.id = id
    self.name = name
    self.title = title
    self.titleAlternative = titleAlternative
    self.url = url
    self.topics = topics
    self.avatar = avatar
  }
}

public class Topic {
  public var id: Int?
  public var title: String?
  public var url: String?
  public var content: String?
  public var replies: Int?
  public var member: Member?
  public var node: Node?
  
  init(id: Int, title: String, url: String, content: String, replies: Int, member: Member, node: Node) {
    self.id = id
    self.title = title
    self.url = url
    self.content = content
    self.replies = replies
    self.member = member
    self.node = node
  }
}
