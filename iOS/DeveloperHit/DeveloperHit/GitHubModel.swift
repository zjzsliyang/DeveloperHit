//
//  GitHubModel.swift
//  DeveloperHit
//
//  Created by Yang Li on 27/10/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import Foundation

public class Developer {
  public var id: Int? = nil
  public var displayName: String? = nil
  public var fullName: String? = nil
  public var devUrl: String? = nil
  public var avatar: String? = nil
  
  init(id: Int, displayName: String, fullName: String, devUrl: String,
       avatar: String) {
    self.id = id
    self.displayName = displayName
    self.fullName = fullName
    self.devUrl = devUrl
    self.avatar = avatar
  }
}

public class Project {
  public var name: String? = nil
  public var owner: String? = nil
  public var repositoryName: String? = nil
  public var descriptions: String? = nil
  public var language: String? = nil
  public var stars: Int? = nil
  public var url: String? = nil
  public var contributorUrl: String? = nil
  public var contributor: [Developer]? = nil
  
  init(name: String, owner: String, repositoryName: String, descriptions: String,
       language: String, stars: Int, url: String, contributorUrl: String,
       contributor: [Developer]) {
    self.name = name
    self.owner = owner
    self.repositoryName = repositoryName
    self.descriptions = descriptions
    self.language = language
    self.stars = stars
    self.url = url
    self.contributorUrl = contributorUrl
    self.contributor = contributor
  }
}
