//
//  StackTestViewController.swift
//  One00Days
//
//  Created by Louis Tur on 3/8/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

class StackTestViewController: UIViewController {
  
  lazy var stackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .Vertical
    stackView.alignment = .Center
    stackView.distribution = .EqualSpacing
    stackView.spacing = 10.0
    return stackView
  }()
  
  lazy var scrollingView: UIScrollView = {
    let scrollView: UIScrollView = UIScrollView()
    scrollView.alwaysBounceHorizontal = false
    scrollView.backgroundColor = UIColor.redColor()
    return scrollView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    setupViewHierarchy()
    configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  internal func configureConstraints() {
    
    scrollingView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view.snp_edges)
    }
    
    stackView.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.scrollingView.snp_edges)
    }
    
    for view in stackView.arrangedSubviews {
      view.snp_makeConstraints(closure: { (make) -> Void in
        make.size.equalTo(CGSizeMake(self.view.bounds.width, 200.0))
      })
    }
    
    self.view.layoutIfNeeded()
  }
  
  internal func setupViewHierarchy() {
    self.view.addSubview(scrollingView)
    self.scrollingView.addSubview(stackView)
    
    let viewsArray: [UIView] = [createView(), createView(), createView(), createView(), createView(), createView(), createView()]
    for (idx, view) in viewsArray.enumerate() {
      view.tag = idx
      self.stackView.addArrangedSubview(view)
    }
    
  }
  
  internal func createView() -> UIView {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.init(red: CGFloat(Double(arc4random_uniform(255))/255.0), green: CGFloat(Double(arc4random_uniform(255))/255.0), blue: CGFloat(Double(arc4random_uniform(255))/255.0), alpha: 1.0)
    return view
  }

}
