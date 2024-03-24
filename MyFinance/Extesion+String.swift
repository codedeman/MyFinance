//
//  Extesion+String.swift
//  MyFinance
//
//  Created by Kevin on 3/24/24.
//

import Foundation

extension String {
    func formatAmount() -> String {
        // Remove non-numeric characters from the input
        let numericString = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        // Format the numeric string with commas for every three digits
        if let numericValue = Int(numericString) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            if let formattedAmount = numberFormatter.string(from: NSNumber(value: numericValue)) {
                return "\(formattedAmount)"
            }
        }

        return self
    }
}
