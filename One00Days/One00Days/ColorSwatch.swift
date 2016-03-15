//
//  ColorSwatch.swift
//  One00Days
//
//  Created by Louis Tur on 3/6/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import Foundation
import UIKit

postfix operator ^{
}

public postfix func ^(a: CGFloat) -> CGFloat {
  return (a/255.0)
}

struct ColorSwatch {
  static let sr_coolWhite: UIColor = UIColor(red: (252/255.0), green: 1.0, blue: (245.0/255.0), alpha: 1.0)
  static let sr_darkChalkGreen: UIColor = UIColor(red: (145.0/255.0), green: (170.0/255.0), blue: (157.0/255.0), alpha: 1.0)
  static let sr_mintGreen: UIColor = UIColor(red: (209/255.0), green: (219.0/255/0), blue: (189.0/255.0), alpha: 1.0)
  static let sr_mediumTeal: UIColor = UIColor(red: (62.0/255.0), green: (96.0/255.0), blue: (111.0/255.0), alpha: 1.0)
  static let sr_darkTeal: UIColor = UIColor(red: (25.0/255.0), green: (52.0/255.0), blue: (65.0/255.0), alpha: 1.0)
  
  static let sr_hipsterBlueBlack: UIColor = UIColor(red: 16^, green: 34^, blue: 43^, alpha: 1.0)
  static let sr_hipsterOlive: UIColor = UIColor(red: 149^, green: 171^, blue: 99^, alpha: 1.0)
  static let sr_hipsterAvocado: UIColor = UIColor(red: 189^, green: 214^, blue: 132^, alpha: 1.0)
}