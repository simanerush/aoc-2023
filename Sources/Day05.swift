//
//  Day05.swift
//
//
//  Created by Sima Nerush on 12/5/23.
//

import Algorithms
import Foundation

struct Day05: AdventDay {

  var data: String

  var lines: [String.SubSequence] {
    data.split(separator: "\n\n")
  }

  struct Almanac {
    let seeds: [Int]
    var seedRanges: [Range<Int>]
    let maps: [[Range<Int>: Range<Int>]]

    init(_ lines: [String.SubSequence]) {
      self.seeds = lines
        .first!
        .split(separator: ":")
        .last!
        .split(separator: " ")
        .compactMap { Int($0)! }
      
      self.seedRanges = []
      for i in stride(from: 0, to: seeds.count, by: 2) {
        let destRange = seeds[i]..<seeds[i]+seeds[i+1]
        self.seedRanges.append(destRange)
      }
      
      self.maps = lines
        .map {
          var mappings: [Range<Int>: Range<Int>] = [:]
          let mapValues = $0
            .split(separator: "\n").dropFirst()

          for value in mapValues {
            let numbers = value.split(separator: " ").map { Int($0)! }
            guard let rangeLength = numbers.last else { continue }
            
            let dest: Range<Int> = numbers[0]..<numbers[0]+rangeLength
            let source: Range<Int> = numbers[1]..<numbers[1]+rangeLength
            mappings[source] = dest
          }

          return mappings
        }
    }

    func location(for seed: Int, mapIdx: Int) -> Int {
      guard let range = maps[mapIdx]
        .filter ({ $0.key.contains(seed) })
        .first, range.key.contains(seed) else {
        return mapIdx == maps.count - 1 ?
          seed : location(for: seed, mapIdx: mapIdx + 1)
      }

      let destinationValue = range.value.lowerBound + seed - range.key.lowerBound

      return mapIdx == maps.count - 1 ? destinationValue : location(for: destinationValue, mapIdx: mapIdx + 1)
    }
  }

  func part1() -> Any {
    let almanac = Almanac(lines)
    return almanac
      .seeds
      .map {
        almanac.location(for: $0, mapIdx: 0)
      }
      .min()!
  }

  func part2() -> Any {
    return 0
  }
}

