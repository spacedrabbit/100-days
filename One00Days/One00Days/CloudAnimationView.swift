//
//  CloudAnimationView.swift
//  One00Days
//
//  Created by Louis Tur on 4/30/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

class CloudAnimationView: UIView {
  

  // MARK: - Init
  // ------------------------------------------------------------
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - Emitter Setup
  // ------------------------------------------------------------
  internal func startCloudEmitter() {
    self.layoutIfNeeded() // needed right before positioning to get correct sizes
    
    cloudEmitterNode.emitterMode = kCAEmitterLayerPoints
    cloudEmitterNode.position = self.cloudGeneratorView.center
    cloudEmitterNode.emitterShape = kCAEmitterLayerCircle
    cloudEmitterNode.emitterSize = self.cloudGeneratorView.frame.size
    
    let foregroundCells = self.makeCloudCellForPosition(.foreGround)
    let midgroundCells = self.makeCloudCellForPosition(.midGround)
    let backgroundCells = self.makeCloudCellForPosition(.backGround)

    cloudEmitterNode.emitterCells = [foregroundCells, midgroundCells, backgroundCells]
    self.cloudGeneratorView.layer.addSublayer(self.cloudEmitterNode)
  }
  
  fileprivate func makeCloudCellForPosition(_ position: ScenePosition) -> CAEmitterCell {
    let cell = CAEmitterCell()
    cell.emissionRange = CGFloat(0.0)
    cell.emissionLatitude = CGFloat(M_PI)
    cell.emissionLongitude = CGFloat(0.0)
    cell.contents = Cloud(withRelativePosition: position).image?.cgImage
    
    switch position {
    case .foreGround:
      cell.scale = 2.0
      cell.birthRate = 1.0
      cell.velocity = 750.0
      cell.alphaRange = 0.0
      cell.lifetime = 10.0
      
    case .midGround:
      cell.scale = 0.50
      cell.birthRate = 0.25
      cell.velocity = 50.0
      cell.alphaRange = 0.5
      cell.alphaSpeed = 10.0
      cell.lifetime = 20.0
      
    case .backGround:
      cell.scale = 0.15
      cell.birthRate = 0.1
      cell.velocity = 20.0
      cell.lifetime = 100.0
      
    }
    return cell
  }
  
  
  // MARK: - Layout
  // ------------------------------------------------------------
  internal func configureConstraints() {
    self.trackView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self)
    }
    
    self.cloudGeneratorView.snp.makeConstraints { (make) -> Void in
      make.left.equalTo(self.trackView.snp.right)
      make.top.bottom.equalTo(self.trackView)
      make.width.greaterThanOrEqualTo(100.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.addSubviews([trackView, cloudGeneratorView])
  }
  
  
  // MARK: - Lazy
  // ------------------------------------------------------------
  lazy var trackView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  lazy var cloudGeneratorView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  lazy var cloudEmitterNode: CAEmitterLayer = {
    let emitter: CAEmitterLayer = CAEmitterLayer()
    return emitter
  }()
  
}
