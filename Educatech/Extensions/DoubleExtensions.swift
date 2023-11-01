//
//  DoubleExtension.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 15/10/23.
//

import Foundation

extension Double {
    func toStringRoundedToDecimal(_ numberOfDecimals: Int) -> String {
        return String(format: "%.\(numberOfDecimals)f", self) // Example, Double 3.14325 returns "3.14" string
    }
}
