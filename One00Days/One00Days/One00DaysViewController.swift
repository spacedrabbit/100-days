//
//  One00DaysViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/21/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

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
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.blueColor()
    return label;
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureConstraints()
    self.configureViews()
  }
  
  internal func configureConstraints() {
    self.view.backgroundColor = UIColor.lightGrayColor()
    self.view.addSubview(self.animationSlider)
    self.view.addSubview(self.changingTextView)
    
    self.animationSlider.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.view.snp_left).offset(10.0)
      make.right.equalTo(self.view.snp_right).offset(-10.0)
      make.bottom.equalTo(self.view.snp_bottom).offset(-10.0)
      make.height.equalTo(60.0)
    }
    
    self.changingTextView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view.snp_center)
      make.height.equalTo(50.0)
      make.left.equalTo(self.view.snp_left).offset(10.0)
      make.right.equalTo(self.view.snp_right).offset(-10.0)
    }
  }
  
  internal func configureViews() {
    self.animationSlider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }

  internal func sliderValueDidChange(sender: AnyObject?) {
    if let slider: UISlider = sender as? UISlider {
      print("Current Value: \(slider.value)")
    }
  }

}

