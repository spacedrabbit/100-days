//
//  TheVanView.swift
//  One00Days
//
//  Created by Louis Tur on 5/2/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit


internal class DeliveryVanView: UIView {
  
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.attachBounceAnimationOnVan()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK - Animations
  internal func attachBounceAnimationOnVan() {
    self.deliveryVanBody.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
    self.frontWheel.layer.anchorPoint =  CGPoint(x: 0.5, y: -1.75)
    self.backWheel.layer.anchorPoint =  CGPoint(x: 0.5, y: -1.75)
    
    let bounce: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.y")
    bounce.duration = 1.2
//    bounce.timeOffset = 
    bounce.repeatCount = HUGE
    bounce.values = [0.0, -3.0, 3.0, 0.0]
    bounce.autoreverses = true
    bounce.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    let wheel1bounce: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.y")
    wheel1bounce.duration = 1.2
    wheel1bounce.repeatCount = HUGE
    wheel1bounce.values = [0.0, -4.0, 5.0, 0.0]
    wheel1bounce.autoreverses = true
    wheel1bounce.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    let wheel2bounce: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.y")
    wheel2bounce.duration = 1.2
    wheel2bounce.repeatCount = HUGE
    wheel2bounce.values = [0.0, -4.0, 5.0, 0.0]
    wheel2bounce.autoreverses = true
    wheel2bounce.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    self.deliveryVanBody.layer.add(bounce, forKey: "bou")
    self.frontWheel.layer.add(wheel1bounce, forKey: "w1b")
    self.backWheel.layer.add(wheel2bounce, forKey: "w2b")
  }
  
  // MARK: - Layout
  internal func configureConstraints() {
    self.deliveryVanBody.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self)
      make.width.equalTo(132.0)
      make.height.equalTo(57.0)
    }
    
    self.frontWheel.snp.makeConstraints { (make) -> Void in
      make.height.width.equalTo(24.0)
      make.centerY.equalTo(self.deliveryVanBody.snp.bottom)
      make.centerX.equalTo(self.deliveryVanBody.snp.centerX).multipliedBy(0.40)
    }
    
    self.backWheel.snp.makeConstraints { (make) -> Void in
      make.height.width.centerY.equalTo(self.frontWheel)
      make.centerX.equalTo(self.deliveryVanBody.snp.centerX).multipliedBy(1.6)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(deliveryVanBody)
    self.addSubviews([frontWheel, backWheel])
  }
  
  
  // MARK: - Lazys
  lazy var deliveryVanBody: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "van_body"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  lazy var frontWheel: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "van_full_wheel"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  lazy var backWheel: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "van_full_wheel"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
}
