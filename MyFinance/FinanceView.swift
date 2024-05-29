import SwiftUI
import Combine

final class Theme: ObservableObject {
    @Published var primaryColor: Color = .orange
    init(primaryColor: Color) {
        self.primaryColor = primaryColor
    }
}

struct FinanceView: View {

    @EnvironmentObject var viewModel: FinanceViewModel
    @EnvironmentObject var theme: Theme
    @State var capitalResStr: String = ""
    @State var interateRate: String = ""
    @State var lastStr: String = ""

    @State private var sliderValue: Double = 50
    @ObservedObject var router = Router()

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
                    HStack {
                        Text("Revenue: \(viewModel.result)")
                        Spacer()
                    }
                    
                    NavigationLink(destination: SecondView()) {
                        Text("Confirm")
                    }
                }
                .padding()
                .onChange(of: interateRate) { newValue in
                    viewModel.calculateInterestAmount(
                        amount: capitalResStr,
                        interestRate: interateRate,
                        duration: lastStr
                    )
                }
            }.background(theme.primaryColor)
            .navigationBarTitle("My Finance", displayMode: .large)
        }
    }

}

// Our observable object class
class GameSettings: ObservableObject {
    @Published var score = 0
}

// A view that expects to find a GameSettings object
// in the environment, and shows its score.
struct ScoreView: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Text("Score: \(settings.score)")
    }
}

// A view that creates the GameSettings object,
// and places it into the environment for the
// navigation stack.

struct ContentView: View {
    @StateObject var settings = GameSettings()
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        NavigationStack {
            VStack {
                // A button that writes to the environment settings
                Button("Increase Score") {
                    settings.score += 1
                }

//                NavigationLink {
                    ScoreView()
//                } label: {
//                    Text("Show Detail View")
//                }
            }
            .frame(height: 200)
        }
        .environmentObject(settings)
    }
}
//struct ContentView: View {
//    @ObservedObject var router = Router()
//
//    var body: some View {
//        NavigationStack(path: $router.navPath) {
//            VStack {
//                Text("Main View")
//                NavigationLink(destination: FirstView()) {
//                    Text("Go to First View")
//                }
//            }
//        }
//    }
//}

//struct FinanceView_Previews: PreviewProvider {
//    static var previews: some View {
////        FinanceView(viewModel: FinanceViewModel(result: ""))
//    }
//}


struct FirstView: View {
    @ObservedObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.navPath) {
            VStack {
                Text("First View")
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second View")
                }
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("Second View")
        }
    }
}


public class AnyIdentifiable: Identifiable {
    public let destination: any Identifiable

    public init(destination: any Identifiable) {
        self.destination = destination
    }
}

public final class Router: ObservableObject {
    @Published public var navPath = NavigationPath()
    @Published public var presentedSheet: AnyIdentifiable?

    public init() {}

    public func presentSheet(destination: any Identifiable) {
        presentedSheet = AnyIdentifiable(destination: destination)
    }

    public func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    public func navigateBack() {
        navPath.removeLast()
    }

    public func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
