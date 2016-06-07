//
//  TouchDragControl.swift
//  One00Days
//
//  Created by Louis Tur on 6/4/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class TouchDragControl: UIControl {
  
  private var lastMeasurement: NSDate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal func configureConstraints() {
    self.interiorControl.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.edges.equalTo(self).inset(UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0))
    }
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(interiorControl)
  }
  
  // MARK: - Helpers
  internal func updateControlLocation(offset: CGPoint, currentFrame: CGRect, xAxisVelocity: Double = 0.0, yAxisVelocity: Double = 0.0) {
    
    let newX = currentFrame.origin.x + offset.x
    let newY = currentFrame.origin.y + offset.y
    let newControlFrame = CGRectMake(newX, newY, currentFrame.size.width, currentFrame.size.height)

    let convertedInitialPoint: CGPoint = self.convertPoint(self.interiorControl.center, toView: self.superview!)
    self.interiorControl.center = convertedInitialPoint
    
    UIView.animateWithDuration(0.000001, animations: { () -> Void in
      self.frame = newControlFrame
      self.interiorControl.center = convertedInitialPoint
      }) { (complete: Bool) -> Void in
        if complete {
          UIView.animateWithDuration(0.000001, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.LayoutSubviews, .BeginFromCurrentState], animations: { () -> Void in
            self.interiorControl.center = self.convertPoint(self.interiorControl.center, toView: self.superview!)
            }) { (complete: Bool) -> Void in
              
          }
        }
    }
  }
  
  // MARK: - UIControl Override
  override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
    let now: NSDate = NSDate()
    if lastMeasurement == nil {
      print("date was nil")
      lastMeasurement = NSDate()
    }
    
    let lastTimeSinceMeasurement: NSTimeInterval = (lastMeasurement?.timeIntervalSinceDate(now))!
    
    let currentRelativeLocation: CGPoint = touch.preciseLocationInView(self.superview!)
    let previousRelativeLocation: CGPoint = touch.precisePreviousLocationInView(self.superview!)
    let currentFrame: CGRect = touch.view!.frame
    
    
    let deltaX: CGFloat = (currentRelativeLocation.x - previousRelativeLocation.x)
    let deltaY: CGFloat = (currentRelativeLocation.y - previousRelativeLocation.y)
    
    let relativeXVelocity = fabs(Double(deltaX) / Double(lastTimeSinceMeasurement))
    let relativeYVelocity = fabs(Double(deltaY) / Double(lastTimeSinceMeasurement))
    
    self.updateControlLocation(CGPointMake( deltaX, deltaY), currentFrame: currentFrame, xAxisVelocity: relativeXVelocity, yAxisVelocity: relativeYVelocity)
    
    return true
  }
  
  // MARK: - Lazys
  internal lazy var interiorControl: UIControl = {
    let control: UIControl = UIControl()
    control.backgroundColor = UIColor.redColor()
    return control
  }()
  
}
