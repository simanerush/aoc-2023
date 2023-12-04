//
//  Day03.swift
//
//
//  Created by Sima Nerush on 12/3/23.
//

import Algorithms

struct Day03: AdventDay {

  var data: String

  var grid: [[Character]] {
    data.split(separator: "\n").map(Array.init)
  }

  struct Coordinate: Hashable {
    let x: Int
    let y: Int
  }

  struct PartNumber {
    let number: Int
    let coords: [Coordinate]
    let adjacentSymbols: Set<Coordinate>

    init(number: Int, coords: [Coordinate]) {
      self.number = number
      self.coords = coords

      var adjacentSymbols: Set<Coordinate> = []
      for coord in coords {
        // Find adjacent point coords from above and below
        adjacentSymbols.insert(.init(x: coord.x, y: coord.y - 1))
        adjacentSymbols.insert(.init(x: coord.x, y: coord.y + 1))
      }

      for i in -1...1 {
        // Diagonals
        adjacentSymbols.insert(.init(x: coords.first!.x - 1, y: coords.first!.y + i))
        adjacentSymbols.insert(.init(x: coords.last!.x + 1, y: coords.last!.y + i))
      }

      self.adjacentSymbols = adjacentSymbols
    }

    func isAdjacent(to symbols: Set<Coordinate>) -> Bool {
      symbols.contains { adjacentSymbols.contains($0) }
    }
  }

  func findPartNumbers(with gearSymbol: Character? = nil) -> ([PartNumber], Set<Coordinate>) {
    var partNumbers: [PartNumber] = []
    var symbols: Set<Coordinate> = []

    for (row, line) in grid.enumerated() {
      var col = 0
      while col < line.count {
        let char = line[col]
        if char.isWholeNumber {
          let firstCol = col
          var currNum = "\(char)"
          // Continue scanning until we get the whole number
          col += 1
          while col < line.count && line[col].isWholeNumber {
            currNum += "\(line[col])"
            col += 1
          }
          col -= 1
          // Now, record the coordinates
          var coords: [Coordinate] = []
          for i in firstCol...col {
            coords.append(.init(x: i, y: row))
          }

          // Populate with the collected part numbers
          partNumbers.append(.init(
            number: Int(currNum)!,
            coords: coords))
        } else if char == gearSymbol || (gearSymbol == nil && char != ".") {
          symbols.insert(.init(x: col, y: row))
        }
        col += 1
      }
    }
    return (partNumbers, symbols)
  }

  func part1() -> Any {
    let (partNumbers, symbols) = findPartNumbers()

    return partNumbers
      .filter { $0.isAdjacent(to: symbols) }
      .map { $0.number }
      .reduce(0, +)
  }

  func part2() -> Any {
    let (partNumbers, symbols) = findPartNumbers()

    return symbols
      .map { symbol in
        partNumbers
          .filter { $0.isAdjacent(to: [symbol]) }
          .map { $0.number }
      }
      .filter { $0.count == 2 }
      .map { $0[0] * $0[1] }
      .reduce(0, +)
  }
}
