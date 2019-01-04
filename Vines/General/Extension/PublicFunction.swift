//
//  PublicFunction.swift
//  Vines
//
//  Created by Patrick Marshall on 04/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation

public func halfCeil(_ number: Int) -> Int {
    if number % 2 == 0 {
        return number / 2
    } else {
        return (number / 2) + 1
    }
}
