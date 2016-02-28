//
//  Day7ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/27/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day7ViewController: UIViewController {
  
  lazy var doorView: DoorView = {
    var doorView: DoorView = DoorView()
    return doorView
  }()
  
  lazy var clockView: ClockView = {
    var clockView: ClockView = ClockView()
    return clockView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func configureConstraints() {
    self.doorView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp_edges)
    }
    
    self.clockView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(120.0, 120.0))
      make.leading.equalTo(20.0)
      make.top.equalTo(20.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.doorView)
    
    self.view.addSubview(self.clockView)
  }
  
}
