# 🎄 Advent of Code in Swift 🎄

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

My solutions for [Advent of Code](<https://adventofcode.com/>) 2023. 

## Challenges

The challenges assume three files.

- `Data/DayNN.txt`: the input data provided for the challenge
- `Sources/DayNN.swift`: the solution
- `Tests/DayNN.swift`: unit tests

The `AdventOfCode.swift` file controls which day's challenge is run
with `swift run`. By default that runs the most recent challenge in the package.

To supply command line arguments use `swift run AdventOfCode`. For example,
`swift run -c release AdventOfCode --benchmark 3` builds the binary with full
optimizations, and benchmarks the challenge for day 3.

## Formatting
 
```shell
$ swift package format-source-code --allow-writing-to-package-directory
```
