//
//  TouchDragControl.swift
//  One00Days
//
//  Created by Louis Tur on 6/4/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class TouchDragControl: UIControl {
  
  fileprivate var lastMeasurement: Date?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal func configureConstraints() {
    self.interiorControl.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self)
      make.edges.equalTo(self).inset(UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0))
    }
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(interiorControl)
  }
  
  // MARK: - Helpers
  internal func updateControlLocation(_ offset: CGPoint, currentFrame: CGRect, xAxisVelocity: Double = 0.0, yAxisVelocity: Double = 0.0) {
    
    let newX = currentFrame.origin.x + offset.x
    let newY = currentFrame.origin.y + offset.y
    let newControlFrame = CGRect(x: newX, y: newY, width: currentFrame.size.width, height: currentFrame.size.height)

    let convertedInitialPoint: CGPoint = self.convert(self.interiorControl.center, to: self.superview!)
    self.interiorControl.center = convertedInitialPoint
    
    UIView.animate(withDuration: 0.000001, animations: { () -> Void in
      self.frame = newControlFrame
      self.interiorControl.center = convertedInitialPoint
      }, completion: { (complete: Bool) -> Void in
        if complete {
          UIView.animate(withDuration: 0.000001, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.layoutSubviews, .beginFromCurrentState], animations: { () -> Void in
            self.interiorControl.center = self.convert(self.interiorControl.center, to: self.superview!)
            }) { (complete: Bool) -> Void in
              
          }
        }
    }) 
  }
  
  // MARK: - UIControl Override
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let now: Date = Date()
    if lastMeasurement == nil {
      print("date was nil")
      lastMeasurement = Date()
    }
    
    let lastTimeSinceMeasurement: TimeInterval = (lastMeasurement?.timeIntervalSince(now))!
    
    let currentRelativeLocation: CGPoint = touch.preciseLocation(in: self.superview!)
    let previousRelativeLocation: CGPoint = touch.precisePreviousLocation(in: self.superview!)
    let currentFrame: CGRect = touch.view!.frame
    
    
    let deltaX: CGFloat = (currentRelativeLocation.x - previousRelativeLocation.x)
    let deltaY: CGFloat = (currentRelativeLocation.y - previousRelativeLocation.y)
    
    let relativeXVelocity = fabs(Double(deltaX) / Double(lastTimeSinceMeasurement))
    let relativeYVelocity = fabs(Double(deltaY) / Double(lastTimeSinceMeasurement))
    
    self.updateControlLocation(CGPoint( x: deltaX, y: deltaY), currentFrame: currentFrame, xAxisVelocity: relativeXVelocity, yAxisVelocity: relativeYVelocity)
    
    return true
  }
  
  // MARK: - Lazys
  internal lazy var interiorControl: UIControl = {
    let control: UIControl = UIControl()
    control.backgroundColor = UIColor.red
    return control
  }()
  
}
