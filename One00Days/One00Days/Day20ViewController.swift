//
//  Day20ViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/11/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class Day20ViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorSwatch.sr_coolWhite
    
    self.setupViewHierarchy()
    self.configureConstraints()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  internal func configureConstraints() {
    
    self.topContainterView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.view.snp_top)
      make.left.equalTo(self.view.snp_left)
      make.right.equalTo(self.view.snp_right)
      make.height.equalTo(200.0)
    }
    
    self.bottomContainerView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.topContainterView.snp_bottom)
      make.left.equalTo(self.view.snp_left)
      make.right.equalTo(self.view.snp_right)
      make.bottom.equalTo(self.view.snp_bottom)
    }
    
    self.libraryScrollView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(topContainterView.snp_edges)
    }
    
    self.gridScrollView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(bottomContainerView.snp_edges)
    }
    
    self.topStackView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self.libraryScrollView.snp_top)
      make.bottom.equalTo(self.libraryScrollView.snp_bottom)
      
      make.right.equalTo(self.view.snp_right)
      make.left.equalTo(self.view.snp_left)
      make.width.equalTo(self.view.snp_width)
    }
    
    self.bottomStackView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.gridScrollView.snp_edges)
      make.width.equalTo(self.bottomContainerView.snp_width)
      make.height.equalTo(self.bottomContainerView.snp_height)
    }
    
    for stackedView in self.topStackView.arrangedSubviews {
      stackedView.snp_makeConstraints(closure: { (make) -> Void in
        make.size.equalTo(CGSizeMake(40.0, 40.0))
      })
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(topContainterView)
    self.view.addSubview(bottomContainerView)
    
    self.topContainterView.addSubview(libraryScrollView)
    self.bottomContainerView.addSubview(gridScrollView)
    
    self.libraryScrollView.addSubview(topStackView)
    self.gridScrollView.addSubview(bottomStackView)
    
    self.bottomStackView.addArrangedSubview(bottomStackViewRow1)
    self.bottomStackView.addArrangedSubview(bottomStackViewRow2)
    self.bottomStackView.addArrangedSubview(bottomStackViewRow3)

    for _ in 1...25 {
      self.topStackView.addArrangedSubview(randomColorView())
      
//      for _ in 1...self.bottomStackView.arrangedSubviews.count {
//        self.bottomStackViewRow1.addArrangedSubview(randomColorView())
//        self.bottomStackViewRow2.addArrangedSubview(randomColorView())
//        self.bottomStackViewRow3.addArrangedSubview(randomColorView())
//      }
    }
   
    self.view.layoutIfNeeded()
  }
  
  
  internal func randomColorView() -> UIView {
    
    let view: UIView = UIView()
    view.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
    
    view.frame = CGRectMake(0, 0, 40.0, 40.0)
    return view
  }
  
  // MARK: - Lazys
  
  //alignments
  lazy var topContainterView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  lazy var bottomContainerView: UIView = {
    let view: UIView = UIView()
    return view
  }()
  
  
  // scrolls
  lazy var libraryScrollView: UIScrollView = {
    let view: UIScrollView = UIScrollView()
    view.backgroundColor = UIColor.yellowColor()
    return view
  }()
  
  lazy var gridScrollView: UIScrollView = {
    let view: UIScrollView = UIScrollView()
    view.backgroundColor = UIColor.redColor()
    return view
  }()
  
  
  // top stack
  lazy var topStackView: UIStackView = {
    let view: UIStackView = UIStackView()
//    view.distribution = .EqualCentering
//    view.spacing = 5.0
//    view.alignment = .Center
    view.axis = .Horizontal
    return view
  }()
  
  // bottom stack
  lazy var bottomStackView: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .FillEqually
    view.alignment = .Fill
    view.axis = .Vertical
    
    return view
  }()
  
  // bottom rows
  lazy var bottomStackViewRow1: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .EqualSpacing
    view.alignment = .Center
    view.axis = .Horizontal
    
    return view
  }()
  
  lazy var bottomStackViewRow2: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .EqualSpacing
    view.alignment = .Center
    view.axis = .Horizontal
    
    return view
  }()
  
  lazy var bottomStackViewRow3: UIStackView = {
    let view: UIStackView = UIStackView()
    
    view.distribution = .EqualSpacing
    view.alignment = .Center
    view.axis = .Horizontal
    
    return view
  }()
  
}
