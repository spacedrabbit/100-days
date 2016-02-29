//
//  Dat8ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 2/28/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Dat8ViewController: UIViewController {
  
  let frontCardView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.lightGrayColor()
    return view
  }()
  
  let backCardView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.blueColor()
    return view
  }()
  
  let frontCardText: UILabel = {
    let label: UILabel = UILabel()
    label.text = "Hello world, how are you"
    label.font = UIFont(name: "Menlo", size: 40.0)
    label.numberOfLines = 3
    return label
  }()
  
  let insideCardText: UILabel = {
    let label: UILabel = UILabel()
    label.text = "World keeps turning and I've been better"
    label.font = UIFont(name: "Menlo", size: 40.0)
    label.numberOfLines = 3
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.brownColor()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
  
  internal func configureConstraints() {
    self.frontCardView.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(100.0)
      make.height.equalTo(100.0)
      make.center.equalTo(self.view.snp_center)
    }
    
    self.backCardView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.frontCardView.snp_edges)
    }
    
    self.frontCardText.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.frontCardView.snp_edges)
    }
    
    self.insideCardText.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.backCardView.snp_edges)
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.frontCardView)
    
    self.frontCardView.addSubview(self.backCardView)
    self.frontCardView.addSubview(self.frontCardText)
    self.frontCardView.sendSubviewToBack(self.backCardView)
    
    self.backCardView.addSubview(self.insideCardText)
  }
  
  
}
