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
}

public class Node {
  public var id: Int?
  public var name: String?
  public var title: String?
  public var titleAlternative: String?
  public var url: String?
  public var topics: String?
  public var avatar: String?
}

public class Topic {
  public var id: Int?
  public var title: String?
  public var url: String?
  public var content: String?
  public var replies: Int?
  public var member: Member?
  public var node: Node?
}
