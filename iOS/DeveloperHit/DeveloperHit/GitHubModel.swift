//
//  GitHubModel.swift
//  DeveloperHit
//
//  Created by Yang Li on 27/10/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import Foundation

public class Developer {
  public var id: Int
  public var displayName: String
  public var fullName: String
  public var url: String
  public var avatar: String
  
  init(id: Int, displayName: String, fullName: String, url: String,
       avatar: String) {
    self.id = id
    self.displayName = displayName
    self.fullName = fullName
    self.url = url
    self.avatar = avatar
  }
}

public class Project {
  public var name: String
  public var owner: String
  public var repositoryName: String
  public var description: String
  public var language: String
  public var stars: Int
  public var url: String
  public var contributorUrl: String
  public var contributor: [Developer]
  
  init(name: String, owner: String, repositoryName: String, description: String,
       language: String, stars: Int, url: String, contributorUrl: String,
       contributor: [Developer]) {
    self.name = name
    self.owner = owner
    self.repositoryName = repositoryName
    self.description = description
    self.language = language
    self.stars = stars
    self.url = url
    self.contributorUrl = contributorUrl
    self.contributor = contributor
  }
}
