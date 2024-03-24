//
//  FinanceViewModel.swift
//  MyFinance
//
//  Created by Kevin on 3/24/24.
//

import Foundation
import Combine
@MainActor

final class FinanceViewModel: ObservableObject {
    //MARK: Variable
    @Published var result: String = ""
    @Published var percentageStr: String = ""

    init(result: String) {
        self.result = result
    }

    public func performCaculateInterestRate(
        amount: String,
        interest: String,
        last: String
    ) {
        let amountDouble = Double(amount)
        guard let amountValue = Double(amount.replacingOccurrences(of: ",", with: "")), // Convert amount to Double
              let interestRate = Double(interest), // Convert interest rate to Double
              let lastValue = Double(last) // Convert last value to Double
        else {
            print("Invalid input. Please enter numeric values.")
            return
        }

        // Calculate interest
        let interestAmount = amountValue * interestRate * lastValue
        result = "Result" + "\(interestAmount)".formatAmount()
    }

    public func getPercentage(percentStr: String) {
        let percent = Double(percentStr) ?? 0.0
        let percentage = percent*100
        let rounderNum = Int(percentage)
        percentageStr = "Percentage \(rounderNum)%"
    }

    

}
