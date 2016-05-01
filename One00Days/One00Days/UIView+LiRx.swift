//
//  UIView+LiRx.swift
//  One00Days
//
//  Created by Louis Tur on 4/30/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

internal extension UIView {
  
  internal func addSubviews(views: [UIView]) {
    for view in views {
      self.addSubview(view)
    }
  }
  
}