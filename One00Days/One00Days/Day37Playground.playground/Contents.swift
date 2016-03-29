//: Playground - noun: a place where people can play

import UIKit
import Foundation

// loss conditions:
// 1. can never win if you go first and and items can be evenly divided by 4

func canWinNim(n: Int) -> Bool {
  if n % 4 == 0 { return false }
  return true
}

assert(canWinNim(4) == false)
assert(canWinNim(5) == true)
assert(canWinNim(11) == true)