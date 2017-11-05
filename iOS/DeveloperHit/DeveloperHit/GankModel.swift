//
//  GankModel.swift
//  DeveloperHit
//
//  Created by Yang Li on 05/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import Foundation

public class Gank{
  public var id: String? = nil
  public var createAt: String? = nil
  public var desc: String? = nil
  public var publishedAt: String? = nil
  public var type: String? = nil
  public var url: String? = nil
  public var used: Bool? = nil
  public var who: String? = nil
  
  init(id: String, createAt: String, desc: String, publishedAt: String, type: String, url: String, used: Bool, who:String) {
    self.id = id
    self.createAt = createAt
    self.desc = desc
    self.publishedAt = publishedAt
    self.type = type
    self.url = url
    self.used = used
    self.who = who
  }
}
