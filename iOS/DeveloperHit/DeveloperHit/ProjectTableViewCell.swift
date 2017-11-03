//
//  ProjectTableViewCell.swift
//  DeveloperHit
//
//  Created by Yang Li on 04/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
  
  var rankLabel: UILabel?
  var repositoryLabel: UILabel?
  var userLabel: UILabel?
  var descriptionLabel: UILabel?
  var starLabel: UILabel?
  var titleImageView: UIImageView?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let height = 94.5
    let heightSpace = 2.0
    let weight = Double(UIScreen.main.bounds.size.width)
    let orginY = 5.0
    let preWidth = 10.0
    let rankWidth = 40.0
    let sufRankWidth = 10.0
    let repositoryLabelWidth = 180.0
    let repositoryLabelHeight = 20.0
    let userLabelWidth = 110.0
    let imageViewWidth = 30.0
    let labelWidth = weight - 2 * preWidth - rankWidth - sufRankWidth
    
    contentView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    let bgView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: weight, height: height))
    bgView.backgroundColor = .white
    contentView.addSubview(bgView)
    
    rankLabel = UILabel(frame: CGRect(x: preWidth, y: orginY, width: rankWidth, height: repositoryLabelHeight))
    bgView.addSubview(rankLabel!)
    
    repositoryLabel = UILabel(frame: CGRect(x: preWidth + rankWidth + sufRankWidth, y: orginY, width: repositoryLabelWidth, height: repositoryLabelHeight))
    bgView.addSubview(repositoryLabel!)
    
    userLabel = UILabel(frame: CGRect(x: preWidth + rankWidth + sufRankWidth, y: orginY + repositoryLabelHeight + heightSpace, width: userLabelWidth, height: repositoryLabelHeight))
    bgView.addSubview(userLabel!)
    
    descriptionLabel = UILabel(frame: CGRect(x: preWidth + rankWidth + sufRankWidth, y: orginY + repositoryLabelHeight * 2 + heightSpace * 2, width: labelWidth, height: repositoryLabelHeight * 2))
    bgView.addSubview(descriptionLabel!)
    
    titleImageView = UIImageView(frame: CGRect(x: preWidth + (rankWidth - imageViewWidth) / 2, y: orginY + 30 + heightSpace, width: imageViewWidth, height: imageViewWidth))
    bgView.addSubview(titleImageView!)
    
    starLabel = UILabel(frame: CGRect(x: preWidth + rankWidth + sufRankWidth + repositoryLabelWidth, y: orginY, width: 75, height: repositoryLabelHeight))
    bgView.addSubview(starLabel!)
    
    descriptionLabel!.numberOfLines = 0
    descriptionLabel!.font = UIFont.systemFont(ofSize: 13)
    
    repositoryLabel!.textColor = UIColor(red: 0.24, green: 0.51, blue: 0.78, alpha: 1)
    
    userLabel!.font = UIFont.systemFont(ofSize: 12)
    userLabel!.textColor = UIColor(red: 0.54, green: 0.54, blue: 0.54, alpha: 1)
    
    starLabel!.font = UIFont.systemFont(ofSize: 12)
    starLabel!.textColor = UIColor(red: 0.54, green: 0.54, blue: 0.54, alpha: 1)
    
    rankLabel!.textColor = UIColor(red: 0.24, green: 0.51, blue: 0.78, alpha: 1)
    rankLabel!.textAlignment = .center
    
    titleImageView!.layer.cornerRadius = 5
    titleImageView!.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
    titleImageView!.layer.borderWidth = 0.2
    titleImageView!.layer.masksToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
