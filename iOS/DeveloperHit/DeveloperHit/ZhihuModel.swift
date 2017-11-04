//
//  ZhihuModel.swift
//  DeveloperHit
//
//  Created by Yang Li on 04/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import Foundation

public class User {
  public var name: String? = nil
  public var url: String? = nil
  
  init(name: String, url: String) {
    self.name = name
    self.url = url
  }
}

public class Question {
  public var title_: String? = nil
  public var url: String? = nil
  public var upvotes: String? = nil
  public var commentCount: String? = nil
  public var answerUrl: String? = nil
  public var user: [User]? = nil
  
  init(title_: String, url: String, upvotes: String, commentCount: String, answerUrl: String, user: [User]) {
    self.title_ = title_
    self.url = url
    self.upvotes = upvotes
    self.commentCount = commentCount
    self.answerUrl = answerUrl
    self.user = user
  }
}
