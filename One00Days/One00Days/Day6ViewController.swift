//
//  Day6ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/26/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day6ViewController: UIViewController {
  
  lazy var doorView: UIView = {
    var view:UIView = UIView()
    view.backgroundColor = UIColor.darkGrayColor()
    return view
  }()
  
  lazy var interiorView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  lazy var wallView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.lightGrayColor()
    return view
  }()
  
  lazy var rodrigoSignView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.blackColor()
    return view
  }()
  
  lazy var shiftSignView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  lazy var posseSignView: UIView = {
    var view: UIView = UIView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.setupDoorAsButton()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  internal func configureConstraints() {
    
    self.wallView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp_edges)
    }
    
    self.interiorView.snp_makeConstraints { (make) -> Void in
      make.center.equalTo(self.wallView.snp_center)
      make.height.equalTo(225.0)
      make.width.equalTo(160.0)
    }
    
    self.doorView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.interiorView.snp_edges).offset(UIEdgeInsetsMake(4.0, 4.0, -4.0, 4.0))
    }
    
    self.rodrigoSignView.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(50.0)
      make.height.equalTo(20.0)
      make.trailing.equalTo(self.doorView.snp_trailing).inset(15.0)
      make.top.equalTo(self.doorView.snp_top).offset(40.0)
    }
    
    self.shiftSignView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(self.rodrigoSignView.snp_size)
      make.centerX.equalTo(self.rodrigoSignView.snp_centerX)
      make.top.equalTo(self.rodrigoSignView.snp_bottom).offset(8.0)
    }
    
    self.posseSignView.snp_makeConstraints { (make) -> Void in
      make.size.equalTo(self.rodrigoSignView.snp_size)
      make.centerX.equalTo(self.rodrigoSignView.snp_centerX)
      make.top.equalTo(self.shiftSignView.snp_bottom).offset(8.0)
    }

  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.wallView)
    self.wallView.addSubview(self.interiorView)
    self.interiorView.addSubview(self.doorView)
    
    self.doorView.addSubview(self.rodrigoSignView)
    self.doorView.addSubview(self.shiftSignView)
    self.doorView.addSubview(self.posseSignView)
  }
  
  internal func setupDoorAsButton() {
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "openDoor")
    self.doorView.addGestureRecognizer(tapGesture)
  }
  
  internal func degreeToRad(x: Double) -> Double {
    return (x * (180.0 / M_PI))
  }
  
  internal func openDoor() {
    
    let angleAsRads: Double = self.degreeToRad(40.0)
    self.doorView.layer.anchorPoint = CGPointMake(1.0, 0.5)
    self.doorView.layer.position = CGPointMake(CGRectGetMaxX(self.doorView.layer.bounds) + 4.0, CGRectGetMidY(self.doorView.layer.bounds) + 4.0)
    let doorOpenTransform: CATransform3D = CATransform3DMakeRotation( CGFloat(angleAsRads), 0.0, 1.0, 0.0)
    
    UIView.animateWithDuration(2.0) { () -> Void in
      self.doorView.layer.transform = doorOpenTransform
    }
    
  }
  
}
