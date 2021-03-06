//
//  FormExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 18/02/22.
//

import Combine
import SwiftUI

struct DinnerListView: View {
    @State var dinners = [
        Dinner(name: "Cafe Deadend", type: "Coffee & Tea Shop", phone: "232-923423", image: "cafedeadend", priceLevel: 3),
        Dinner(name: "Homei", type: "Cafe", phone: "348-233423", image: "homei", priceLevel: 3),
        Dinner(name: "Teakha", type: "Tea House", phone: "354-243523", image: "teakha", priceLevel: 3, isFavorite: true, isCheckIn: true),
        Dinner(name: "Cafe loisl", type: "Austrian / Casual Drink", phone: "453-333423", image: "cafeloisl", priceLevel: 2, isFavorite: true, isCheckIn: true),
        Dinner(name: "Petite Oyster", type: "French", phone: "983-284334", image: "petiteoyster", priceLevel: 5, isCheckIn: true),
        Dinner(name: "For Kee Dinner", type: "Hong Kong", phone: "232-434222", image: "forkeeDinner", priceLevel: 2, isFavorite: true, isCheckIn: true),
        Dinner(name: "Po's Atelier", type: "Bakery", phone: "234-834322", image: "posatelier", priceLevel: 4),
        Dinner(name: "Bourke Street Backery", type: "Chocolate", phone: "982-434343", image: "bourkestreetbakery", priceLevel: 4, isCheckIn: true),
        Dinner(name: "Haigh's Chocolate", type: "Cafe", phone: "734-232323", image: "haighschocolate", priceLevel: 3, isFavorite: true),
        Dinner(name: "Palomino Espresso", type: "American / Seafood", phone: "872-734343", image: "palominoespresso", priceLevel: 2),
        Dinner(name: "Upstate", type: "Seafood", phone: "343-233221", image: "upstate", priceLevel: 4),
        Dinner(name: "Traif", type: "American", phone: "985-723623", image: "traif", priceLevel: 5),
        Dinner(name: "Graham Avenue Meats", type: "Breakfast & Brunch", phone: "455-232345", image: "grahamavenuemeats", priceLevel: 3),
        Dinner(name: "Waffle & Wolf", type: "Coffee & Tea", phone: "434-232322", image: "wafflewolf", priceLevel: 3),
        Dinner(name: "Five Leaves", type: "Bistro", phone: "343-234553", image: "fiveleaves", priceLevel: 4, isFavorite: true, isCheckIn: true),
        Dinner(name: "Cafe Lore", type: "Latin American", phone: "342-455433", image: "cafelore", priceLevel: 2, isFavorite: true, isCheckIn: true),
        Dinner(name: "Confessional", type: "Spanish", phone: "643-332323", image: "confessional", priceLevel: 4),
        Dinner(name: "Barrafina", type: "Spanish", phone: "542-343434", image: "barrafina", priceLevel: 2, isCheckIn: true),
        Dinner(name: "Donostia", type: "Spanish", phone: "722-232323", image: "donostia", priceLevel: 1),
        Dinner(name: "Royal Oak", type: "British", phone: "343-988834", image: "royaloak", priceLevel: 2, isFavorite: true),
        Dinner(name: "CASK Pub and Kitchen", type: "Thai", phone: "432-344050", image: "caskpubkitchen", priceLevel: 1)
    ]

    @State private var selectedDinner: Dinner?
    @State private var showSettings: Bool = false

    @EnvironmentObject var settingStore: SettingsStore

    var body: some View {
        NavigationView {
            List {
                ForEach(dinners.sorted(by: DisplayOrderType(type: settingStore.displayOrder).predicate())) { dinner in
                    if shouldShowItem(dinner: dinner) {
                        BasicImageRow(dinner: dinner)
                            .contextMenu {

                                Button(action: {
                                    // mark the selected restaurant as check-in
                                    self.checkIn(with: dinner.id)
                                }) {
                                    HStack {
                                        Text("Check-in")
                                        Image(systemName: "checkmark.seal.fill")
                                    }
                                }

                                Button(action: {
                                    // delete the selected restaurant
                                    self.delete(with: dinner.id)
                                }) {
                                    HStack {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }

                                Button(action: {
                                    // mark the selected restaurant as favorite
                                    self.setFavorite(with: dinner.id)

                                }) {
                                    HStack {
                                        Text("Favorite")
                                        Image(systemName: "star")
                                    }
                                }
                            }
                            .onTapGesture {
                                self.selectedDinner = dinner
                            }
                    }
                }
                .onDelete { (indexSet) in
                    self.dinners.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Restaurant")
            .toolbar {
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gear")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $showSettings) {
                FormExample().environmentObject(settingStore)
            }
            .navigationViewStyle(.stack)
        }


    }

    private func delete(with id: UUID) {
        if let index = self.dinners.firstIndex(where: { $0.id == id }) {
            self.dinners.remove(at: index)
        }
    }

    private func setFavorite(with id: UUID) {
        if let index = self.dinners.firstIndex(where: { $0.id == id }) {
            self.dinners[index].isFavorite.toggle()
        }
    }

    private func checkIn(with id: UUID) {
        if let index = self.dinners.firstIndex(where: { $0.id == id }) {
            self.dinners[index].isCheckIn.toggle()
        }
    }

    private func shouldShowItem(dinner: Dinner) -> Bool {
        return (!settingStore.showCheckInOnly || dinner.isCheckIn) && (dinner.priceLevel <= settingStore.maxPriceLevel)
    }
}


struct FormExample: View {
    @Environment(\.presentationMode) var mode

    @State private var selectedOrder: DisplayOrderType = .alphabetical
    @State private var showCheckInOnly = false
    @State private var maxPriceLevel = 5

    @EnvironmentObject var settingStore: SettingsStore

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("SORT PREFERENCE")) {
                    Picker(selection: $selectedOrder,
                           label: Text("Display Order")) {
                        ForEach(DisplayOrderType.allCases, id: \.self) { order in
                            Text(order.text)
                        }
                    }

                }

                Section(header: Text("FILTER PREFERENCE")) {
                    Toggle(isOn: $showCheckInOnly) {
                        Text("Show Check-in Only")
                    }

                    Stepper {
                        maxPriceLevel += 1

                        if maxPriceLevel > 5 {
                            maxPriceLevel = 5
                        }
                    } onDecrement: {
                        maxPriceLevel -= 1

                        if maxPriceLevel < 1 {
                            maxPriceLevel = 1
                        }
                    } label: {
                        Text("Show \(String(repeating: "$", count: maxPriceLevel)) or below")
                    }
                }
            }
            .navigationTitle("Settings")
            // Exercise
            .navigationBarItems(leading:
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                            , trailing:
                    Button {
                        settingStore.showCheckInOnly = showCheckInOnly
                        settingStore.displayOrder = selectedOrder.rawValue
                        settingStore.maxPriceLevel = maxPriceLevel
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Apply")
                    }
            )
            .onAppear {
                selectedOrder = DisplayOrderType(type: settingStore.displayOrder)
                showCheckInOnly = settingStore.showCheckInOnly
                maxPriceLevel = settingStore.maxPriceLevel
            }
        }
    }
}

struct FormExample_Previews: PreviewProvider {
    static var previews: some View {
        DinnerListView().environmentObject(SettingsStore())
    }
}

struct Dinner: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let phone: String
    let image: String
    let priceLevel: Int
    var isFavorite: Bool = false
    var isCheckIn: Bool = false
}

struct BasicImageRow: View {
    let dinner: Dinner

    var body: some View {

        HStack {
            Image(dinner.image)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 10)

            VStack(alignment: .leading) {
                HStack {
                    Text(dinner.name)
                        .font(.system(.body, design: .rounded))
                        .bold()

                    Text(String(repeating: "$", count: dinner.priceLevel))
                        .font(.subheadline)
                        .foregroundColor(.gray)

                }

                Text(dinner.type)
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.secondary)
                    .lineLimit(3)

                Text(dinner.phone)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
            }

            Spacer()
                .layoutPriority(-100)

            if dinner.isCheckIn {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.red)
            }

            if dinner.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }


    }
}

enum DisplayOrderType: Int, CaseIterable {
    case alphabetical = 0
    case favoriteFirst = 1
    case checkInFirst = 2

    var text: String {
        switch self {
        case .alphabetical: return "Alphabetical"
        case .favoriteFirst: return "Show Favorite First"
        case .checkInFirst: return "Show Check-in First"
        }
    }

    init(type: Int) {
        switch type {
        case 0: self = .alphabetical
        case 1: self = .favoriteFirst
        case 2: self = .checkInFirst
        default: self = .alphabetical
        }
    }

    func predicate() -> ((Dinner, Dinner) -> Bool) {
        switch self {
        case .alphabetical: return { $0.name < $1.name }
        case .favoriteFirst: return { $0.isCheckIn && !$1.isFavorite }
        case .checkInFirst: return { $0.isCheckIn && !$1.isCheckIn }
        }
    }
}

final class SettingsStore: ObservableObject {
    @Published var showCheckInOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferences.showCheckInOnly") {
        didSet {
            UserDefaults.standard.set(showCheckInOnly, forKey: "view.preferences.showCheckInOnly")
        }
    }

    @Published var displayOrder: Int = UserDefaults.standard.integer(forKey: "view.preferences.displayOrder") {
        didSet {
            UserDefaults.standard.set(displayOrder, forKey: "view.preferences.displayOrder")
        }
    }

    @Published var maxPriceLevel: Int = UserDefaults.standard.integer(forKey: "view.preferences.maxPriceLevel") {
        didSet {
            UserDefaults.standard.set(maxPriceLevel, forKey: "view.preferences.maxPriceLevel")
        }
    }

    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.showCheckInOnly": false,
            "view.preferences.displayOrder": 0,
            "view.preferences.maxPriceLevel": 5
        ])
    }
}
