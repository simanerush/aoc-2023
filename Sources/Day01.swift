import Algorithms

struct Day01: AdventDay {

  var data: String

  var lines: [String.SubSequence] {
    data.split(separator: "\n")
  }

  var entities: [[Int]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { Int($0) }
    }
  }

  let digits = ["one": 1,
                "two": 2,
                "three": 3,
                "four": 4,
                "five": 5,
                "six": 6,
                "seven": 7,
                "eight": 8,
                "nine": 9]

  func transformSpelled(_ s: String.SubSequence, _ i: String.Index) -> Int? {
    for dig in digits.keys {
      if s[i...].hasPrefix(dig) {
        return digits[dig]!
      }
    }

    return nil
  }

  func transformIntoDigits(_ s: String.SubSequence) -> [Int] {
    var res: [Int] = []
    for i in s.indices {
      if let num = s[i].wholeNumberValue {
        res.append(num)
      }
      if let spelled = transformSpelled(s, i) {
        res.append(spelled)
      }
    }
    return res
  }

  func part1() -> Any {
    lines
      .map {
        $0.filter { $0.isNumber }
      }
      .map {
        if $0.count == 1 {
          return $0 + $0
        }
        return "\($0.first!)\($0.last!)"
      }
      .compactMap { Int($0) }
      .reduce(0, +)
  }

  func part2() -> Any {
    lines
      .map {
        transformIntoDigits($0)
      }
      .map {
        if $0.count == 1 {
          return "\($0.first!)\($0.first!)"
        }
        return "\($0.first!)\($0.last!)"
      }
      .compactMap { Int($0) }
      .reduce(0, +)
  }
}
