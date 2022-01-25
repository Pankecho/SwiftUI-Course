//
//  StackExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 25/01/22.
//

import SwiftUI

struct StackExample: View {
    var body: some View {
        VStack {
            HeaderView()
            
            HStack() {
                PlanView(title: "Basic",
                         price: "$9",
                         textColor: .white,
                         bgColor: .purple)
                
                ZStack(alignment: .bottom) {
                    PlanView(title: "Pro",
                             price: "$19",
                             textColor: .black,
                             bgColor: .gray.opacity(0.40))
                    
                    Text("Best for designer")
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(.orange)
                        .offset(x: 0, y: 10)
                }
            }
            .padding(.horizontal)
            
            ZStack(alignment: .bottom) {
                PlanView(title: "Team",
                         price: "$299",
                         textColor: .white,
                         bgColor: .black.opacity(0.70),
                         icon: "wand.and.rays")
                
                Text("Best for teams with 20 members")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(.orange)
                    .offset(x: 0, y: 10)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct StackExample_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Choose")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                
                Text("Your Plan")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
            }
            Spacer()
        }
        .padding()
    }
}

struct PlanView: View {
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var icon: String?
    
    var body: some View {
        VStack {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
            }
            
            Text(title)
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            
            Text(price)
                .font(.system(size: 40,
                              weight: .heavy,
                              design: .rounded))
                .foregroundColor(textColor)
            
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(30)
        .background(bgColor)
        .cornerRadius(10)
    }
}

struct ExerciseView: View {
    var body: some View {
        VStack {
            ZStack {
                PlanView(title: "Basic",
                         price: "$299",
                         textColor: .white,
                         bgColor: .purple,
                         icon: "wand.and.rays")
                    .offset(x: 0, y: 200)
                
                HStack {
                    Spacer()
                    PlanView(title: "Pro",
                             price: "$19",
                             textColor: .white,
                             bgColor: .orange,
                             icon: "wand.and.rays")
                        .offset(x: 0, y: 20)
                    Spacer()
                }
                
                
                HStack {
                    Spacer()
                    Spacer()
                    PlanView(title: "Team",
                             price: "$299",
                             textColor: .white,
                             bgColor: .black,
                             icon: "wand.and.rays")
                        .offset(x: 0, y: -180)
                    Spacer()
                    Spacer()
                }
            }
            .padding()
        }
    }
}
