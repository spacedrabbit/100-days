//
//  Day25ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/16/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day25ViewController: UIViewController {
  lazy var circularGradientView: UIView = {
  let view: UIView = UIView()
  return view
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  internal func configureConstraints() {
    circularGradientView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.view)
      make.size.equalTo(175.0+&175.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(circularGradientView)

  }
}
