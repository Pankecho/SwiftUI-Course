//
//  CarouselView.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 25/01/22.
//

import SwiftUI

struct CarouselExample: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("MONDAY, AUG 20")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Your Reading")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Group {
                        CardView(image: "swiftui-button",
                                 category: "SwiftUI",
                                 heading: "Drawing a Border with Rounded Corners",
                                 author: "Simon NG")
                        
                        CardView(image: "macos-programming",
                                 category: "macOS",
                                 heading: "Building a Simple Editing App",
                                 author: "Gabriel T")
                        
                        CardView(image: "flutter-app",
                                 category: "Flutter",
                                 heading: "Building a Complex Layout with Flutter",
                                 author: "Lawrence Tan")
                        
                        CardView(image: "natural-language-api",
                                 category: "iOS",
                                 heading: "What's New in Natural Language API",
                                 author: "Sai Kambampati")
                    }
                    .frame(width: 300)
                }
            }
            
            Spacer()
        }
    }
}

struct CarouselExample_Previews: PreviewProvider {
    static var previews: some View {
        CarouselExample()
    }
}


struct CardView: View {
    var image: String
    var category: String
    var heading: String
    var author: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    
                    Text("Written by \(author)".uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}
