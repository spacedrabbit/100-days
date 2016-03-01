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
    view.backgroundColor = UIColor.clearColor()
    view.layer.doubleSided = true
    return view;
  }()
  
  var side1: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.blueColor()
    return view
  }()
  
  var label1: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.whiteColor()
    label.text = "1"
    return label
  }()
  
  var side2: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.purpleColor()
    return view
  }()
  
  var label2: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.whiteColor()
    label.text = "2"
    return label
  }()
  
  var side3: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  
  var label3: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.whiteColor()
    label.text = "3"
    return label
  }()
  
  var side4: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.greenColor()
    return view
    
  }()
  
  var label4: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.whiteColor()
    label.text = "4"
    return label
  }()
  
  var side5: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  var label5: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.whiteColor()
    label.text = "5"
    return label
  }()
  
  var side6: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.orangeColor()
    return view
  }()
  
  var label6: UILabel = {
    let label: UILabel = UILabel()
    label.font = UIFont.systemFontOfSize(24.0)
    label.textColor = UIColor.whiteColor()
    label.text = "6"
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    self.setupViewHierarchy()
    self.configureConstraints()

    
    UIView.animateWithDuration(5.0) { () -> Void in
      self.transformLayersOfCube()
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  internal func transformLayersOfCube() {
    let ninety: CGFloat = degreesToRadians(75.0)
    let boundingRect: CGRect = self.containerView.frame
    
    // left/right sides
    self.side1.layer.anchorPoint = CGPointMake(1.0, 0.5)
    self.side1.layer.position = CGPointMake(self.side1.frame.origin.x / 2.0, self.side1.frame.origin.y)
    self.side1.layer.transform = CATransform3DMakeRotation(ninety, 0.0, 1.0, 0.0)
//    self.side1.layer.transform = CATransform3DMakeTranslation(1.0, 0.0, 0.0)
    self.side2.layer.anchorPoint = CGPointMake(0.0, 0.5)
    self.side2.layer.position = CGPointMake(self.side2.frame.size.width, self.side2.frame.origin.y)
    self.side2.layer.transform = CATransform3DMakeRotation(ninety, 0.0, 0.0, 1.0)
//    self.side2.layer.transform = CATransform3DMakeTranslation(0.0, 1.0, 0.0)
    
    // top/bottom
//    self.side3.layer.transform = CATransform3DMakeRotation(ninety, 1.0, 0.0, 0.0)
//    self.side4.layer.transform = CATransform3DMakeRotation(ninety, 1.0, 0.0, 0.0)
    
//    let frontTransFormOne = CATransform3DMakeRotation(ninety, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##z: CGFloat##CGFloat#>)
  }
  
  internal func rotateContainer() {
    let almostAll: CGFloat = degreesToRadians(10)
    self.containerView.layer.transform = CATransform3DMakeRotation(almostAll, 0.0, 1.0, 0.0)
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
//    self.side3.snp_makeConstraints { (make) -> Void in
//      make.size.equalTo(CGSizeMake(100.0, 100.0))
//      make.center.equalTo(self.containerView.snp_center)
//    }
//    self.side4.snp_makeConstraints { (make) -> Void in
//      make.size.equalTo(CGSizeMake(100.0, 100.0))
//      make.center.equalTo(self.containerView.snp_center)
//    }
//    self.side5.snp_makeConstraints { (make) -> Void in
//      make.size.equalTo(CGSizeMake(100.0, 100.0))
//      make.center.equalTo(self.containerView.snp_center)
//    }
//    self.side6.snp_makeConstraints { (make) -> Void in
//      make.size.equalTo(CGSizeMake(100.0, 100.0))
//      make.center.equalTo(self.containerView.snp_center)
//    }

  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.containerView)
    self.containerView.addSubview(self.side1)
    self.containerView.addSubview(self.side2)
//    self.containerView.addSubview(self.side3)
//    self.containerView.addSubview(self.side4)
//    self.containerView.addSubview(self.side5)
//    self.containerView.addSubview(self.side6)
    
    self.side1.addSubview(self.label1)
    self.side2.addSubview(self.label2)
//    self.side3.addSubview(self.label3)
//    self.side4.addSubview(self.label4)
//    self.side5.addSubview(self.label5)
//    self.side6.addSubview(self.label6)
  }
  
}
