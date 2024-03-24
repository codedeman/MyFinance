import SwiftUI
import Combine

struct FinanceView: View {
    var viewModel: FinanceViewModel
    @State var capitalResStr: String = ""
    @State var interateRate: String = ""
    @State var lastStr: String = ""

    @State private var sliderValue: Double = 50

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Amount of money", text: $capitalResStr)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 10)
                        .keyboardType(.numberPad)
                        .onReceive(Just(capitalResStr), perform: { newValue in
                            capitalResStr = newValue.formatAmount()
                        })


                    TextField("Last", text: $lastStr)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 10)
                        .keyboardType(.numberPad)

                    TextField("Interest Rate", text: $interateRate)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(3.0)
                        .shadow(radius: 10)
                        .keyboardType(.numberPad)
                        .onChange(of: interateRate) { newValue in
                            // Perform any necessary logic here when interateRate changes
                        }

                    Text(viewModel.result)
                }
                .padding()
                .onChange(of: interateRate) { newValue in
                    viewModel.performCaculateInterestRate(
                        amount: capitalResStr,
                        interest: interateRate,
                        last: lastStr
                    )
                }
            }
            .navigationBarTitle("My Finance", displayMode: .large)
        }
    }
}

struct FinanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceView(viewModel: FinanceViewModel(result: ""))
    }
}
