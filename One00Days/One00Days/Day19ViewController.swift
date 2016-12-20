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
    self.view.backgroundColor = UIColor.white
    setupViewHierarchy()
    configureConstraints()
  }
  
  internal func configureConstraints() {
    
    self.scrollView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp.edges)
    }
    
    self.stackView.snp.makeConstraints { (make) -> Void in
      make.left.equalTo(self.scrollView.snp.left)
      make.right.equalTo(self.scrollView.snp.right)
      make.top.equalTo(self.scrollView.snp.top)
      make.bottom.equalTo(self.scrollView.snp.bottom)
      make.width.equalTo(self.view.snp.width)
      make.height.greaterThanOrEqualTo(0.0)
    }
    
    for button in self.stackView.arrangedSubviews {
      if let actuallyAButton: UIButton = button as? UIButton {
        actuallyAButton.snp.makeConstraints({ (make) -> Void in
          make.size.equalTo(CGSize(width: UIScreen.main.bounds.width, height: 100.0))
        })
      }
    }
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(self.stackView)
    
    self.stackView.axis = .vertical
    self.stackView.distribution = .equalCentering
    self.stackView.alignment = .center
    self.stackView.spacing = 8.0
    self.stackView.isUserInteractionEnabled = true
    
    for i in 1...10 {
      let button: UIButton = UIButton()
      button.tag = i
      button.setTitle("Button \(i)", for: UIControlState())
      button.setTitleColor(UIColor.black, for: UIControlState())
      button.setTitleColor(UIColor.gray, for: .highlighted)
      button.addTarget(self, action: #selector(Day19ViewController.tapped(_:)), for: .touchUpInside)
      button.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
      self.stackView.addArrangedSubview(button)
    }
  }
  
  internal func tapped(_ sender: UIButton) {
    print("tapped button \(sender.tag)")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
