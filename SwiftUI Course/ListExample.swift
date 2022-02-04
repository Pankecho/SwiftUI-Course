//
//  ListExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 02/02/22.
//

import SwiftUI


struct ListExample: View {
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
        List {
            ForEach(restaurants, id: \.id) { restaurant in
                ImageRow(name: restaurant.name,
                         image: restaurant.image)
                /*
                 Article(title: restaurant.name,
                         image: restaurant.image,
                         author: restaurant.name,
                         rating: 5,
                         description: restaurant.name)
                 */
            }
        }
    }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        ListExample()
    }
}

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

struct ImageRow: View {
    let name: String
    let image: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            
            Text(name)
        }
    }
}

struct FullImageRow: View {
    let name: String
    let image: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.black)
                        .opacity(0.2)
                )
            
            Text(name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}

struct Article: View {
    let title: String
    let image: String
    let author: String
    let rating: Int
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
            
            Text(title)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
            
            Text("BY \(author.uppercased())")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack(spacing: 5) {
                ForEach(1...rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
