//
//  DoorView.swift
//  One00Days
//
//  Created by Louis Tur on 2/27/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class DoorView: UIView {
  var isOpen: Bool = false
  
  // MARK: - Lazy Views
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
  
  lazy var rodrigoLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "RODRIGO"
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.whiteColor()
    return label
  }()
  
  lazy var shiftLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "SHIFT"
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.whiteColor()
    return label
  }()
  
  lazy var posseLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "POSSE"
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.whiteColor()
    return label
  }()
  
  
  // MARK: Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupViewHierarchy()
    self.configureConstraints()
    self.setupDoorAsButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    
    self.wallView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.snp_edges)
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
    
    self.rodrigoLabel.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.rodrigoSignView.snp_edges)
    }
    
    self.shiftLabel.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.shiftSignView.snp_edges)
    }
    
    self.posseLabel.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.posseSignView.snp_edges)
    }
    
  }
  
  internal func setupViewHierarchy() {
    self.addSubview(self.wallView)
    self.wallView.addSubview(self.interiorView)
    self.interiorView.addSubview(self.doorView)
    
    self.doorView.addSubview(self.rodrigoSignView)
    self.doorView.addSubview(self.shiftSignView)
    self.doorView.addSubview(self.posseSignView)
    
    self.rodrigoSignView.addSubview(self.rodrigoLabel)
    self.shiftSignView.addSubview(self.shiftLabel)
    self.posseSignView.addSubview(self.posseLabel)
  }
  
  private func setupDoorAsButton() {
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "toggleDoor")
    self.doorView.addGestureRecognizer(tapGesture)
  }
  
  
  // MARK: - Helpers
  private func degreeToRad(x: Double) -> Double {
    return (x * (M_PI / 180.0))
  }
  
  
  // MARK: - Actions
  internal func toggleDoor() {
    let angleAsRads: Double = self.degreeToRad(75.0)
    self.doorView.layer.anchorPoint = CGPointMake(1.0, 0.5)
    self.doorView.layer.position = CGPointMake(CGRectGetMaxX(self.doorView.layer.bounds) + 4.0, CGRectGetMidY(self.doorView.layer.bounds) + 4.0)
    
    if !self.isOpen {
      let doorOpenTransform: CATransform3D = CATransform3DMakeRotation( CGFloat(angleAsRads), 0.0, 1.0, 0.0)
      
      UIView.animateWithDuration(1.75, animations: { () -> Void in
        self.doorView.layer.transform = doorOpenTransform
        }) { (complete: Bool) -> Void in
          if complete {
            self.isOpen = true
          }
      }
    } else {
      UIView.animateWithDuration(1.75, animations: { () -> Void in
        self.doorView.layer.transform = CATransform3DIdentity
        }) { (complete: Bool) -> Void in
          if complete {
            self.isOpen = false
          }
      }
      
    }
    
  }

}
