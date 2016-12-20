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
    label.textAlignment = .center
    label.numberOfLines = 1
    label.font = UIFont.systemFont(ofSize: 100.0)
    label.textColor = UIColor.blue
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
    
    self.view.backgroundColor = UIColor.lightGray
    self.view.addSubview(self.animationSlider)
    self.view.addSubview(self.changingTextView)
    
    self.animationSlider.snp.makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp.left).offset(40.0)
      make.right.equalTo(self.view.snp.right).offset(-40.0)
      make.bottom.equalTo(self.view.snp.bottom).offset(-10.0)
      make.height.equalTo(60.0)
    }
    
    self.changingTextView.snp.makeConstraints { (make) -> Void in
      make.center.equalTo(self.view.snp.center)
      make.height.equalTo(100.0)
      make.left.equalTo(self.view.snp.left).offset(10.0)
      make.right.equalTo(self.view.snp.right).offset(-10.0)
    }
    
    backgroundImageView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp.edges)
    }
  }
  
  internal func configureViews() {
    self.animationSlider.addTarget(self, action: #selector(One00DaysViewController.sliderValueDidChange(_:)), for: .valueChanged)
    self.changingTextView.text = "100"
    
    let catIcon: UIImage? = UIImage(named: "cat_icon")
    self.animationSlider.setThumbImage(catIcon, for: UIControlState())
    self.animationSlider.minimumTrackTintColor = UIColor.red
    self.animationSlider.maximumTrackTintColor = UIColor.purple
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }

  internal func sliderValueDidChange(_ sender: AnyObject?) {
    if let slider: UISlider = sender as? UISlider {
      self.rotateTextView(slider.value)
      self.adjustLabelText(slider.value)
    }
  }
  
  internal func rotateTextView(_ rotationValue: Float) {
    let convertedDegreeValue: Double = Double((rotationValue) * 360.0)
    let radianValue: CGFloat = CGFloat((convertedDegreeValue * M_PI) / 180.0)
    self.changingTextView.transform = CGAffineTransform(rotationAngle: radianValue)
  }

  internal func adjustLabelText(_ value: Float) {
    var displayText: String = ""
    switch value {
    case 0...0.5: displayText = "100"
    default: displayText = "Days"
    }
    
    let currentText: String = self.changingTextView.text!
    if displayText != currentText {
      
      self.changingTextView.alpha = 0.0
      UIView.animate(withDuration: 0.250, animations: { () -> Void in
        self.changingTextView.alpha = 1.0
        self.changingTextView.text = displayText
      }) 
    }
  }
  
}

