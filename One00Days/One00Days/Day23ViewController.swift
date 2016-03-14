//
//  Day23ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/14/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day23ViewController: UIViewController {
  
  let progress: CircularProgressView = {
    let view: CircularProgressView = CircularProgressView(frame: CGRectMake(0,0,200,200))
//    view.progress = 75.0
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    self.progress.startAnimating(restart: false)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  internal func configureConstraints() {
    progress.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(CGSizeMake(200.0, 200.0))
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(progress)
  }
  
}
