//
//  TheSunView.swift
//  One00Days
//
//  Created by Louis Tur on 5/1/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class TheSunView: UIView {
  
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
//    let tapG: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "attachRotationAnimationToRays")
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
//    self.attachRotationAnimationToRays()
//    self.attachTranslationScaleTransformToRays()
    self.attachFullAnimationToRays()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal func attachRotationAnimationToRays() {
    let rotationTransform = CGAffineTransformMakeRotation((CGFloat(180.0 * M_PI) / 180.0))
    
    UIView.animateWithDuration(2.0, delay: 0.0, options: [.CurveLinear, .Repeat], animations: { () -> Void in
      self.sunRayImageView.layer.transform = CATransform3DMakeAffineTransform(rotationTransform)
      }) { (complete: Bool) -> Void in
    }
    
  }
  
  internal func attachTranslationScaleTransformToRays() {
    let scaleTransform = CGAffineTransformMakeScale(1.25, 1.1)
    
    UIView.animateWithDuration(1.0, delay: 0.0, options: [.CurveLinear, .Repeat, .Autoreverse], animations: { () -> Void in
      self.sunRayImageView.layer.transform = CATransform3DMakeAffineTransform(scaleTransform)
      }) { (complete: Bool) -> Void in
        
    }
  }
  
  internal func attachFullAnimationToRays() {
    
    let animationGroup: CAAnimationGroup = CAAnimationGroup()
    
    let rotationAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
    rotationAnimation.duration = 2.0
    rotationAnimation.additive = true
    rotationAnimation.repeatDuration = Double.infinity
    rotationAnimation.values = [0.0, 1.0]
    rotationAnimation.values = [0, M_PI]
//    rotationAnimation.fillMode = kCAFillModeForwards
//    rotationAnimation.removedOnCompletion = false
    
    let scaleXTransFormAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale.x")
    
    self.sunRayImageView.layer.addAnimation(rotationAnimation, forKey: "rot")
  }
  
  // MARK: - Layout
  internal func configureConstraints() {
    self.sunRayImageView.snp_makeConstraints { (make) -> Void in
      make.center.width.equalTo(self)
      make.height.equalTo(30.0)
    }
    
    self.sunBodyImageView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.sunRayImageView)
      make.width.height.equalTo(self).multipliedBy(0.6)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.addSubviews([sunRayImageView, sunBodyImageView])
  }
  
  
  // MARK: - Lazys
  lazy var sunBodyImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "sun_body"))
    imageView.contentMode = .ScaleAspectFill
    imageView.backgroundColor = UIColor.clearColor()
    imageView.clipsToBounds = false
    return imageView
  }()
  
  lazy var sunRayImageView: UIImageView = {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "sun_triangle_group"))
    imageView.contentMode = .ScaleAspectFit
    imageView.backgroundColor = UIColor.clearColor()
    imageView.clipsToBounds = false
    return imageView
  }()
  
}
