//
//  ModalExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 03/02/22.
//

import SwiftUI

struct ModalExample: View {
    @State var showDetailView = false
    @State var selected: Restaurant?
    
    let restaurants = [
        Restaurant(name: "Cafe Deadend",
                   image: "cafedeadend"),
        Restaurant(name: "Homei",
                   image: "homei"),
        Restaurant(name: "Teakha",
                   image: "teakha"),
        Restaurant(name: "Cafe Loisl",
                   image: "cafeloisl"),
        Restaurant(name: "Petite Oyster",
                   image: "petiteoyster"),
    ]
    
    var body: some View {
        NavigationView {
            List(restaurants) { restaurant in
                ImageRow(name: restaurant.name,
                         image: restaurant.image)
                    .onTapGesture {
                        showDetailView = true
                        selected = restaurant
                    }
            }
            .sheet(isPresented: $showDetailView) {
                if let selected = selected {
                    DetailCustomView(restaurant: selected)
                }
            }
            .navigationBarTitle("Restaurants")
            .navigationViewStyle(.stack)
        }
    }
}

struct ModalExample_Previews: PreviewProvider {
    static var previews: some View {
        ModalExample()
    }
}

struct DetailCustomView: View {
    @Environment(\.presentationMode) var mode
    @State private var showAlert = false
    
    let restaurant: Restaurant
    
    var body: some View {
        ScrollView {
            VStack {
                FullImageRow(name: restaurant.name,
                             image: restaurant.image)
                
                Spacer()
            }
        }
        .overlay(
            HStack {
                Spacer()
                
                VStack {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 40)
                    
                    Spacer()
                }
            }
        ).alert(isPresented: $showAlert) {
            Alert(title: Text("Reminder"),
                  message: Text("Are you sure you are finished checking out \(restaurant.name)"),
                  primaryButton: .default(Text("Yes"),
                                          action: {
                mode.wrappedValue.dismiss()
            }), secondaryButton: .cancel(Text("No")))
        }
    }
}
