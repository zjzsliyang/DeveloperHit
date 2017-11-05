//
//  V2EXModel.swift
//  DeveloperHit
//
//  Created by Yang Li on 05/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import Foundation

public class Member {
  public var id: String?
  public var userName: String?
  public var avatar: String?
  
  init(id: String, userName: String, avatar: String) {
    self.id = id
    self.userName = userName
    self.avatar = avatar
  }
}

public class Node {
  public var id: String?
  public var name: String?
  public var title: String?
  public var titleAlternative: String?
  public var url: String?
  public var topics: String?
  public var avatar: String?
  
  init(id: String, name: String, title: String, titleAlternative: String, url: String, topics: String, avatar: String) {
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
  public var id: String?
  public var title: String?
  public var url: String?
  public var content: String?
  public var replies: String?
  public var member: Member?
  public var node: Node?
  
  init(id: String, title: String, url: String, content: String, replies: String, member: Member, node: Node) {
    self.id = id
    self.title = title
    self.url = url
    self.content = content
    self.replies = replies
    self.member = member
    self.node = node
  }
}
