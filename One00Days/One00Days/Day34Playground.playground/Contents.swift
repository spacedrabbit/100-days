//: Playground - noun: a place where people can play


// see: https://robots.thoughtbot.com/swift-sequences
// https://www.natashatherobot.com/swift-conform-to-sequence-protocol/
// http://lillylabs.no/2014/09/30/make-iterable-swift-collection-type-sequencetype/

import UIKit

struct Cat {
  var name: String
  
  init(name: String) {
    self.name = name
  }
}

struct CatClub: SequenceType, GeneratorType {
  typealias Element = Cat
  private var allCats: [Cat] = [Cat]()
  private var nextIndex: Int
  
  init(cats: [Cat]) {
    self.allCats = cats
    self.nextIndex = 0
  }
  
  mutating func next() -> Cat? {
    if nextIndex < self.allCats.count {
    print("Index: \(nextIndex) is returning a cat: \(allCats[nextIndex])")
    return allCats[nextIndex++]
    }
    return nil
  }
}

var applicantCats: [Cat] = [ Cat(name: "Fiddles"), Cat(name: "Jerry"), Cat(name: "Meowser"), Cat(name: "Sir Bottom Waggles")]
let clubCats: CatClub = CatClub(cats: applicantCats)

for cat in clubCats {
  print("Name: \(cat.name)")
}
