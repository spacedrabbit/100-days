//
//  DragViewController.swift
//  One00Days
//
//  Created by Louis Tur on 6/4/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import SnapKit

class DragViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }

  internal func configureConstraints() {
    self.touchDragControl.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(CGSizeMake(100.0, 100.0))
    }
    
  }
  
  internal func setupViewHierarchy() {
    touchDragControl.backgroundColor = UIColor.yellowColor()
    
    self.view.addSubviews([touchDragControl])
    
  }
  
  lazy internal var touchDragControl: TouchDragControl = TouchDragControl()
  
}
