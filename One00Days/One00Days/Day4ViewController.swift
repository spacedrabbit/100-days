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
    view.backgroundColor = UIColor.purple
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
    self.configureButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func configureConstraints() {
    self.contentView.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(100.0)
      make.leading.equalTo(self.view.snp.leading)
      make.trailing.equalTo(self.view.snp.trailing)
      make.centerY.equalTo(self.view.snp.centerY)
    }
    
    self.plusButton.snp.makeConstraints { (make) -> Void in
      make.size.equalTo(CGSize(width: 50.0, height: 50.0))
      make.leading.equalTo(self.contentView.snp.leading).offset(15.0)
      make.top.equalTo(self.contentView.snp.top).offset(15.0)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.contentView)
    self.contentView.addSubview(self.plusButton)
  }
  
  internal func configureButton() {
    
  }
  
}
