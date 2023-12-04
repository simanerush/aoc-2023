//
//  Utils.swift
//
//
//  Created by Sima Nerush on 12/4/23.
//

import Foundation

extension String.SubSequence {
  var numbers: [Int] {
    split(whereSeparator: { !"-0123456789".contains($0) })
      .map { Int($0)! }
  }
}
