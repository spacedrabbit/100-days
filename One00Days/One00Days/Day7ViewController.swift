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
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.doorView)
  }
  
}
