//
//  Day2ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/22/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

extension CGRect {
  func CGRectLengthenFromRect(_ rect: CGRect) -> CGRect {
    let originalRect: CGRect = rect
    let orignalHeight: CGFloat = originalRect.size.height
    return CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: orignalHeight * 2.0)
  }
}

class Day2ViewController: UIViewController, UIGestureRecognizerDelegate {
  
  let viewHeight: CGFloat = 60.0
  let maxViewHeight: CGFloat = 90.0
  
  lazy var expandingView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.red
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
    self.expandingView.snp.makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp.left).offset(8.0)
      make.right.equalTo(self.view.snp.right).offset(-8.0)
      make.top.equalTo(self.view.snp.top).offset(10.0)
      make.height.equalTo(60.0)
    }
    
    self.day1Slider.snp.makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp.left).offset(40.0)
      make.right.equalTo(self.view.snp.right).offset(-40.0)
      make.bottom.equalTo(self.view.snp.bottom).offset(-10.0)
      make.height.equalTo(60.0)
    }
    
    self.dayLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.expandingView.snp.top).offset(10.0)
      make.centerX.equalTo(self.expandingView.snp.centerX)
      make.height.equalTo(30.0)
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func setupActions() {
    let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(Day2ViewController.expandingViewWasHeld(_:)))
    longPressGesture.minimumPressDuration = 0.30
    longPressGesture.allowableMovement = 20.0
    longPressGesture.delegate = self
    self.expandingView.addGestureRecognizer(longPressGesture)
    
    self.dayLabel.text = "Day 2"
    self.dayLabel.alpha = 0.0
    self.dayLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
    self.dayLabel.textColor = UIColor.white
  }
  
  internal func expandingViewWasHeld(_ sender: UILongPressGestureRecognizer) {
    print("damn straight you're touching")
    let currentFrame: CGRect = self.expandingView.frame
    UIView.animate(withDuration: 1.0, animations: { () -> Void in
      self.expandingView.frame = CGRect(x: currentFrame.origin.x, y: currentFrame.origin.y, width: currentFrame.size.width, height: self.maxViewHeight)
      self.dayLabel.alpha = 1.0
      }, completion: { (complete: Bool) -> Void in
    }) 
  }
  
  internal func expandingViewWasReleased() {
    
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    if let longPressGesture: UILongPressGestureRecognizer = gestureRecognizer as? UILongPressGestureRecognizer {
      let currentState: UIGestureRecognizerState = longPressGesture.state
      switch currentState {
      case .possible: print("possible")
      case .began, .changed: print("began or changed")
      case .ended: print("ended")
      case .failed: print("failed")
      default: print("default state")
      }
    }
    return true
  }
  
}
