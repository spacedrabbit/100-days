//
//  Day5ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/25/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//
// Today was actually only 50 min max

import Foundation
import UIKit

internal class Day5ViewController: UIViewController {
  
  lazy var contentView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.lightGrayColor()
    return view
  }()
  
  lazy var plusButton: TappableCircleButton = {
    var control: TappableCircleButton = TappableCircleButton()
    return control
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewHierarchy()
    self.configureConstraints() 
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
  
  internal func configureConstraints() {
    self.contentView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self.view.snp_leading).offset(50.0)
      make.trailing.equalTo(self.view.snp_trailing).inset(50.0)
      make.top.equalTo(self.view.snp_top).offset(50.0)
      make.bottom.equalTo(self.view.snp_bottom).inset(50.0)
    }
    
    self.plusButton.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.contentView.snp_center)
      make.height.equalTo(50.0)
      make.width.equalTo(self.plusButton.snp_height)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.contentView)
    self.contentView.addSubview(self.plusButton)
  }
  
  
}