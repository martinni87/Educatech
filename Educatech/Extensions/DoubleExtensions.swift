//
//  DoubleExtension.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 15/10/23.
//

import Foundation

/// A set of extensions for the `Double` class, providing additional functionality.
extension Double {
    
    /**
     Converts the double value to a string rounded to the specified number of decimal places.
     
     - Parameters:
        - numberOfDecimals: The number of decimal places to round the double value to.
     
        - Returns: A string representation of the double value rounded to the specified number of decimal places.
     
     - Example:
       ```
       let pi = 3.1415926535
       let roundedPiString = pi.toStringRoundedToDecimal(2)
       // roundedPiString is "3.14"
       ```
     */
    func toStringRoundedToDecimal(_ numberOfDecimals: Int) -> String {
        return String(format: "%.\(numberOfDecimals)f", self) // Example, Double 3.14325 returns "3.14" string
    }
}
