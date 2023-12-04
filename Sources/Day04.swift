//
//  Day04.swift
//  
//
//  Created by Sima Nerush on 12/3/23.
//

import Algorithms
import Foundation

struct Day04: AdventDay {

  var data: String

  var lines: [String.SubSequence] {
    data.split(separator: "\n")
  }

  struct Card {
    let id: Int
    let winningNumbers: Set<Int>
    let cardNumbers: Set<Int>
    var winCount = 1

    init(_ str: String.SubSequence) {
      let components = str.split(separator: ": ")
      let nums = components.last!.split(separator: " | ")
      self.id = components.first!.numbers.first!
      self.winningNumbers = Set(nums.first!.numbers)
      self.cardNumbers = Set(nums.last!.numbers)
    }
    
    var matches: Int {
      winningNumbers.intersection(cardNumbers).count
    }
    var score: Int {
      Int(matches == 1 ? 1 : pow(2.0, Double(matches - 1)))
    }
  }

  func computeWins(_ cards: inout [Card]) {
    for i in cards.indices {
      if cards[i].matches > 0 {
        for _ in 1...cards[i].winCount {
          for id in cards[i].id..<cards[i].id + cards[i].matches {
            cards[id].winCount += 1
          }
        }
      }
    }
  }

  func part1() -> Any {
    lines
      .map { Card($0) }
      .map { $0.score }
      .reduce(0, +)
  }

  func part2() -> Any {
    var cards = lines.map { Card($0) }
    computeWins(&cards)
    return cards
      .map { $0.winCount }
      .reduce(0, +)
  }
}
