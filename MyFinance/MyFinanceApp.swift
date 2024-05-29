//
//  MyFinanceApp.swift
//  MyFinance
//
//  Created by Kevin on 3/24/24.
//

import SwiftUI

@main
struct MyFinanceApp: App {
    private var viewModel = FinanceViewModel()
    @StateObject var themeMode = Theme(primaryColor: .red)
    var body: some Scene {
        WindowGroup {
            FinanceView()
                .environmentObject(viewModel)
                .environmentObject(themeMode)
        }
    }
}
