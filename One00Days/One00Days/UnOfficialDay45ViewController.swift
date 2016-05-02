//
//  UnOfficialDay45ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 5/2/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class UnOfficialDay45ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  
  internal func configureConstraints() {
    self.van.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(132.0)
      make.height.equalTo(57.0)
      make.center.equalTo(self.view.snp_center)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubviews([self.van])
  }
  
  internal lazy var van: DeliveryVanView = DeliveryVanView()
  
}
