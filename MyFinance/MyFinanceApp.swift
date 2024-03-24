//
//  MyFinanceApp.swift
//  MyFinance
//
//  Created by Kevin on 3/24/24.
//

import SwiftUI

@main
struct MyFinanceApp: App {
    var body: some Scene {
        WindowGroup {
            FinanceView(viewModel: .init(result: ""))
        }
    }
}
