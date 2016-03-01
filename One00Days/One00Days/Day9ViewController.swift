//
//  Day9ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/29/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day9ViewController: UIViewController {
  
  var containerView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.blackColor()
    return view;
  }()
  var side1: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.blueColor()
    return view
  }()
  var side2: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.purpleColor()
    return view
  }()
  var side3: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  var side4: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.greenColor()
    return view
  }()
  var side5: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  var side6: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.orangeColor()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    self.setupViewHierarchy()
    self.configureConstraints()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    self.containerView.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self.view.snp_leading)
      make.trailing.equalTo(self.view.snp_trailing)
      make.top.equalTo(self.view.snp_bottom).multipliedBy(0.25)
      make.bottom.equalTo(self.view.snp_bottom).multipliedBy(0.75)
    }
    self.side1.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(100.0, 100.0))
      make.center.equalTo(self.containerView.snp_center)
    }
    self.side2.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(100.0, 100.0))
      make.center.equalTo(self.containerView.snp_center)
    }
    self.side3.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(100.0, 100.0))
      make.center.equalTo(self.containerView.snp_center)
    }
    self.side4.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(100.0, 100.0))
      make.center.equalTo(self.containerView.snp_center)
    }
    self.side5.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(100.0, 100.0))
      make.center.equalTo(self.containerView.snp_center)
    }
    self.side6.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(CGSizeMake(100.0, 100.0))
      make.center.equalTo(self.containerView.snp_center)
    }

  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.containerView)
    self.containerView.addSubview(self.side1)
    self.containerView.addSubview(self.side2)
    self.containerView.addSubview(self.side3)
    self.containerView.addSubview(self.side4)
    self.containerView.addSubview(self.side5)
    self.containerView.addSubview(self.side6)
  }
  
}
