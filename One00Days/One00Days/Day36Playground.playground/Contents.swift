//: Playground - noun: a place where people can play
// Given num = 38, the process is like: 3 + 8 = 11, 1 + 1 = 2. Since 2 has only one digit, return it.

import UIKit

func numbersInArray(var num: Int) -> [Int] {
  
  var numArray: [Int] = []
  while num % 10 > 0 {
    numArray.append(num % 10)
    num = num / 10
  }
  return numArray
}

func sumNumbers(numbers: [Int]) -> Int {
  
  var total: Int = 0
  for num in numbers {
    total += num
  }
  
  return total
}

func doTheThingFor(num: Int) {
  var new = numbersInArray(num)
  var newTotal: Int
  var newTotalCount: Int = 0
  
  if new.count < 2 {
    print("final: \(num)")
    return
  }
  
  repeat {
    newTotal = sumNumbers(new)
    newTotalCount = numbersInArray(newTotal).count
    new = numbersInArray(newTotal)
  } while newTotalCount > 1
  
  print("final: \(new)")
}

//doTheThingFor(99999999)
doTheThingFor(0)
//doTheThingFor(10)
doTheThingFor(2)
doTheThingFor(1)
doTheThingFor(1111111111)
