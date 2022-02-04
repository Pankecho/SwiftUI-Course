//
//  NavigationExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 03/02/22.
//

import SwiftUI

struct NavigationExample: View {
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
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: DetailView(restaurant: restaurant)) {
                        ImageRow(name: restaurant.name,
                                 image: restaurant.image)
                    }
                }
            }
            .navigationBarTitle("Restaurants")
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.systemRed,
            .font: UIFont(name: "ArialRoundedMTBold", size: 35)!
        ]
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemRed,
            .font: UIFont(name: "ArialRoundedMTBold", size: 20)!
        ]
        
        // Back button icon
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        // Tint color for back button
        UINavigationBar.appearance().tintColor = .black
    }
}

struct NavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationExample()
    }
}

struct DetailView: View {
    @Environment(\.presentationMode) var mode
    
    let restaurant: Restaurant
    
    var body: some View {
        VStack {
            FullImageRow(name: restaurant.name,
                         image: restaurant.image)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            mode.wrappedValue.dismiss()
        } label: {
            Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
        })
    }
}
