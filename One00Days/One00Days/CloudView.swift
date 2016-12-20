//
//  CloudView.swift
//  One00Days
//
//  Created by Louis Tur on 4/30/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


internal enum ScenePosition {
  case foreGround
  case midGround
  case backGround
}


internal struct CloundHelper {
  static let Cloud1: String = "cloud_1"
  static let Cloud2: String = "cloud_2"
  static let Cloud3: String = "cloud_3"
  
  static func allCloudNames() -> [String] {
    return [Cloud1, Cloud2, Cloud3]
  }
  
  static func allCloudImages() -> [UIImage?] {
    return [
      UIImage(named: Cloud1),
      UIImage(named: Cloud2),
      UIImage(named: Cloud3)
    ]
  }
}


internal class Cloud: UIView {
  
  internal static let positions: [ScenePosition] = [.foreGround, .midGround, .backGround]
  internal static let clouds: [UIImage?] = CloundHelper.allCloudImages()
  
  internal var relativePosition: ScenePosition = .foreGround
  internal var image: UIImage?
  
  
  // MARK: - Initialization
  // ------------------------------------------------------------
  convenience internal init(withRelativePosition position: ScenePosition) {
    self.init(frame: CGRect.zero)
    self.relativePosition = position
    self.image = self.cloudImageView.image
    
    switch position {
    case .foreGround: self.postionIndicator.text = "Fg"
    case .midGround: self.postionIndicator.text = "Mg"
    case .backGround: self.postionIndicator.text = "Bg"
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - Layout
  // ------------------------------------------------------------
  internal func configureConstraints() {
    self.cloudImageView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self)
    }
    
    self.postionIndicator.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.cloudImageView)
    }
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(cloudImageView)
    self.cloudImageView.addSubview(self.postionIndicator)
  }
  
  
  // MARK: - Lazy Init
  // ------------------------------------------------------------
  lazy var cloudImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: self.cloudImage())
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  lazy var postionIndicator: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFont(ofSize: 20.0)
    label.textColor = UIColor.red
    return label
  }()
  
  // MARK: - Helpers
  // ------------------------------------------------------------
  fileprivate func cloudImage() -> UIImage? {
    return Cloud.clouds[ Int(arc4random_uniform( UInt32(Cloud.clouds.count)))]
  }
  
  internal static func generateClouds(_ number: Int) -> [Cloud] {
    
    var cloudArray: [Cloud] = []
    for _ in 0...number {
      let randInt: Int = Int(arc4random_uniform(3))
      cloudArray.append(Cloud(withRelativePosition: self.positions[randInt]))
    }
    return cloudArray
  }
}
