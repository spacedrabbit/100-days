//
//  Day2ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/22/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

extension CGRect {
  func CGRectLengthenFromRect(rect: CGRect) -> CGRect {
    let originalRect: CGRect = rect
    let orignalHeight: CGFloat = originalRect.size.height
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, orignalHeight * 2.0)
  }
}

class Day2ViewController: UIViewController, UIGestureRecognizerDelegate {
  
  let viewHeight: CGFloat = 60.0
  let maxViewHeight: CGFloat = 90.0
  
  lazy var expandingView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  
  lazy var day1Slider: UISlider = {
    var slider: UISlider = UISlider()
    slider.value = 0.0
    return slider
  }()
  
  lazy var dayLabel: UILabel = {
    var label: UILabel = UILabel()
    return label
  }()
  
  var longPressGestureRecognizer: UILongPressGestureRecognizer {
    let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    longPressGesture.minimumPressDuration = 0.30
    longPressGesture.allowableMovement = 20.0
    return longPressGesture
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.setupActions()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.expandingView)
    self.expandingView.addSubview(self.dayLabel)
    self.view.addSubview(self.day1Slider)
  }
  
  internal func configureConstraints() {
    self.expandingView.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp_left).offset(8.0)
      make.right.equalTo(self.view.snp_right).offset(-8.0)
      make.top.equalTo(self.view.snp_top).offset(10.0)
      make.height.equalTo(60.0)
    }
    
    self.day1Slider.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp_left).offset(40.0)
      make.right.equalTo(self.view.snp_right).offset(-40.0)
      make.bottom.equalTo(self.view.snp_bottom).offset(-10.0)
      make.height.equalTo(60.0)
    }
    
    self.dayLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.expandingView.snp_top).offset(10.0)
      make.centerX.equalTo(self.expandingView.snp_centerX)
      make.height.equalTo(30.0)
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func setupActions() {
    let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "expandingViewWasHeld:")
    longPressGesture.minimumPressDuration = 0.30
    longPressGesture.allowableMovement = 20.0
    longPressGesture.delegate = self
    self.expandingView.addGestureRecognizer(longPressGesture)
    
    self.dayLabel.text = "Day 2"
    self.dayLabel.alpha = 0.0
    self.dayLabel.font = UIFont.boldSystemFontOfSize(30.0)
    self.dayLabel.textColor = UIColor.whiteColor()
  }
  
  internal func expandingViewWasHeld(sender: UILongPressGestureRecognizer) {
    print("damn straight you're touching")
    let currentFrame: CGRect = self.expandingView.frame
    UIView.animateWithDuration(1.0, animations: { () -> Void in
      self.expandingView.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, self.maxViewHeight)
      self.dayLabel.alpha = 1.0
      }) { (complete: Bool) -> Void in
    }
  }
  
  internal func expandingViewWasReleased() {
    
  }
  
  func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
    if let longPressGesture: UILongPressGestureRecognizer = gestureRecognizer as? UILongPressGestureRecognizer {
      let currentState: UIGestureRecognizerState = longPressGesture.state
      switch currentState {
      case .Possible: print("possible")
      case .Began, .Changed: print("began or changed")
      case .Ended: print("ended")
      case .Failed: print("failed")
      default: print("default state")
      }
    }
    return true
  }
  
}
