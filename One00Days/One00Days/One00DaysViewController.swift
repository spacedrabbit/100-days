//
//  One00DaysViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/21/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//
// Cat Icon: Cat by Francielly Costantin Senra from the Noun Project

import UIKit
import SnapKit

class One00DaysViewController: UIViewController {
  
  let animationSlider: UISlider = {
    let slider: UISlider = UISlider()
    slider.value = 0.0
    return slider
  }()
  
  let changingTextView: UILabel = {
    let label: UILabel = UILabel();
    label.textAlignment = .Center
    label.numberOfLines = 1
    label.font = UIFont.systemFontOfSize(100.0)
    label.textColor = UIColor.blueColor()
    return label;
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureConstraints()
    self.configureViews()
  }
  
  internal func configureConstraints() {
    let background: UIImage? = UIImage(named: "epic")
    let backgroundImageView: UIImageView = UIImageView(image: background)
    backgroundImageView.alpha = 0.25
    self.view.addSubview(backgroundImageView)
    
    self.view.backgroundColor = UIColor.lightGrayColor()
    self.view.addSubview(self.animationSlider)
    self.view.addSubview(self.changingTextView)
    
    self.animationSlider.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp_left).offset(40.0)
      make.right.equalTo(self.view.snp_right).offset(-40.0)
      make.bottom.equalTo(self.view.snp_bottom).offset(-10.0)
      make.height.equalTo(60.0)
    }
    
    self.changingTextView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view.snp_center)
      make.height.equalTo(100.0)
      make.left.equalTo(self.view.snp_left).offset(10.0)
      make.right.equalTo(self.view.snp_right).offset(-10.0)
    }
    
    backgroundImageView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp_edges)
    }
  }
  
  internal func configureViews() {
    self.animationSlider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
    self.changingTextView.text = "100"
    
    let catIcon: UIImage? = UIImage(named: "cat_icon")
    self.animationSlider.setThumbImage(catIcon, forState: .Normal)
    self.animationSlider.minimumTrackTintColor = UIColor.redColor()
    self.animationSlider.maximumTrackTintColor = UIColor.purpleColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }

  internal func sliderValueDidChange(sender: AnyObject?) {
    if let slider: UISlider = sender as? UISlider {
      self.rotateTextView(slider.value)
      self.adjustLabelText(slider.value)
    }
  }
  
  internal func rotateTextView(rotationValue: Float) {
    let convertedDegreeValue: Double = Double((rotationValue) * 360.0)
    let radianValue: CGFloat = CGFloat((convertedDegreeValue * M_PI) / 180.0)
    self.changingTextView.transform = CGAffineTransformMakeRotation(radianValue)
  }

  internal func adjustLabelText(value: Float) {
    var displayText: String = ""
    switch value {
    case 0...0.5: displayText = "100"
    default: displayText = "Days"
    }
    
    let currentText: String = self.changingTextView.text!
    if displayText != currentText {
      
      self.changingTextView.alpha = 0.0
      UIView.animateWithDuration(0.250) { () -> Void in
        self.changingTextView.alpha = 1.0
        self.changingTextView.text = displayText
      }
    }
  }
  
}

