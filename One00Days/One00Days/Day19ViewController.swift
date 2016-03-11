//
//  Day19ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/10/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit
import SnapKit

class Day19ViewController: UIViewController {
  var stackView: UIStackView = UIStackView()
  var scrollView: UIScrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    setupViewHierarchy()
    configureConstraints()
  }
  
  internal func configureConstraints() {
    
    self.scrollView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp_edges)
    }
    
    self.stackView.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.scrollView.snp_left)
      make.right.equalTo(self.scrollView.snp_right)
      make.top.equalTo(self.scrollView.snp_top)
      make.bottom.equalTo(self.scrollView.snp_bottom)
      make.width.equalTo(self.view.snp_width)
      make.height.greaterThanOrEqualTo(0.0)
    }
    
    for button in self.stackView.arrangedSubviews {
      if let actuallyAButton: UIButton = button as? UIButton {
        actuallyAButton.snp_makeConstraints(closure: { (make) -> Void in
          make.size.equalTo(CGSizeMake(UIScreen.mainScreen().bounds.width, 100.0))
        })
      }
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.stackView)
    
    self.stackView.axis = .Vertical
    self.stackView.distribution = .EqualCentering
    self.stackView.alignment = .Center
    self.stackView.spacing = 8.0
    self.stackView.userInteractionEnabled = true
    
    for i in 1...10 {
      let button: UIButton = UIButton()
      button.tag = i
      button.setTitle("Button \(i)", forState: .Normal)
      button.setTitleColor(UIColor.blackColor(), forState: .Normal)
      button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
      button.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
      button.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
      self.stackView.addArrangedSubview(button)
    }
  }
  
  internal func tapped(sender: UIButton) {
    print("tapped button \(sender.tag)")
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
