//
//  FinanceViewModel.swift
//  MyFinance
//
//  Created by Kevin on 3/24/24.
//

import Foundation
import Combine

final class FinanceViewModel: ObservableObject {

    //MARK: Variable
    @Published var result: String = ""
    @Published var percentageStr: String = ""


    func calculateInterestAmount(
        amount: String,
        interestRate: String,
        duration: String
    ) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "de_DE") // Adjust locale if necessary
        guard let amountValue = formatter.number(from: amount.replacingOccurrences(of: ",", with: ""))?.doubleValue,
              let interestRateValue = Double(interestRate),
              let durationValue = Double(duration),
              amountValue >= 0, interestRateValue >= 0, durationValue > 0 else {
            // Handle invalid input (e.g., throw an error or return an error code)
            return
        }

        // Calculate interest
        let interestAmount = amountValue * (interestRateValue / 100) * durationValue

        // Format the result
        let formattedResult: String
        if interestAmount.truncatingRemainder(dividingBy: 1) == 0 {
            formattedResult = String(format: "%.0f", interestAmount)
        } else {

            formattedResult = String(format: "%.2f", interestAmount)
        }

        result = formattedResult.formatAmount()
    }





}
