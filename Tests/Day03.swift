//
//  Day03.swift
//
//
//  Created by Sima Nerush on 12/3/23.
//

import XCTest

@testable import AdventOfCode

final class Day03Tests: XCTestCase {
  let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
  """

  func testPart1() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual("4361", String(describing: challenge.part1()))
  }

  func testPart2() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual("467835", String(describing: challenge.part2()))
  }
}
