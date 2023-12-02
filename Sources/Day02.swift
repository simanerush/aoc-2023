//
//  Day02.swift
//
//
//  Created by Sima Nerush on 12/1/23.
//

import Algorithms

struct Day02: AdventDay {

  var data: String

  var lines: [String.SubSequence] {
    data.split(separator: "\n")
  }

  struct Cubes {
    var red: Int
    var green: Int
    var blue: Int
  }

  struct Game {
    let id: Int
    var cubes: [Cubes]

    func isPossible() -> Bool {
      let r = 12
      let g = 13
      let b = 14

      return !cubes.contains { $0.red > r || $0.green > g || $0.blue > b }
    }

    func power() -> Int {
      var maxR = 0
      var maxG = 0
      var maxB = 0

      for currCubes in cubes {
        maxR = max(currCubes.red, maxR)
        maxG = max(currCubes.green, maxG)
        maxB = max(currCubes.blue, maxB)
      }

      return maxR * maxG * maxB
    }
  }

  let colors = ["red", "green", "blue"]

  func parse() -> [Game] {
    // Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    var games: [Game] = []
    for line in lines {
      let fullString = line.split(separator: ": ")
      let id = Int(fullString.first!.split(separator: " ").last!)!
      let components = fullString.last!.split(separator: "; ")
      var totalCubes: [Cubes] = []
      for component in components {
        let quants = component.split(separator: ", ")
        var cubes: Cubes = Cubes(red: 0, green: 0, blue: 0)
        for quant in quants {
          let colors = quant.split(separator: " ")
          let num = Int(colors.first!)!
          switch colors.last! {
          case "red": cubes.red = num
          case "green": cubes.green = num
          case "blue": cubes.blue = num
          default: fatalError("Parsing failed")
          }
        }
        totalCubes.append(cubes)
      }
      games.append(Game(id: id, cubes: totalCubes))
    }
    return games
  }

  func part1() -> Any {
    parse()
      .filter { $0.isPossible() }
      .map { $0.id }
      .reduce(0, +)
  }

  func part2() -> Any {
    parse()
      .map { $0.power() }
      .reduce(0, +)
  }
}
