//
//  Day4ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/24/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day4ViewController: UIViewController {
  
  lazy var contentView: UIView = {
    var view: UIView = UIView()
    return view
  }()
  
  lazy var plusButton: UIControl = {
    var control: UIControl = UIControl()
    return control
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.configureButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func configureConstraints() {
    
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.contentView)
    self.view.addSubview(self.plusButton)
  }
  
  internal func configureButton() {
    
  }
  
}
