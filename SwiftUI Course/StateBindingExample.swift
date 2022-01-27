//
//  StateBindingExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 26/01/22.
//

import SwiftUI

struct StateBindingExample: View {
    @State private var isPlaying: Bool = false
    @State private var sharedCounter = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(isPlaying ? .red : .green)
            }
            
            ButtonCounter(count: $sharedCounter, color: .blue)
            
            ButtonCounter(count: $sharedCounter, color: .red)
            
            ButtonCounter(count: $sharedCounter, color: .orange)
            
            ButtonCounter(count: $sharedCounter, color: .purple)
        }
    }
}

struct StateBindingExample_Previews: PreviewProvider {
    static var previews: some View {
        StateBindingExercise()
    }
}

struct StateBindingExercise: View {
    @State var counterOne = 0
    @State var counterTwo = 0
    @State var counterThree = 0
    
    var body: some View {
        let total = counterOne + counterTwo + counterThree
        VStack {
            Text("\(total)")
                .font(.system(size: 150))
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.bold)
            
            HStack {
                ButtonCounter(count: $counterOne, color: .blue)
                
                ButtonCounter(count: $counterTwo, color: .red)
                
                ButtonCounter(count: $counterThree, color: .orange)
            }
        }
    }
}

struct ButtonCounter: View {
    
    @Binding var count: Int
    var color: Color
    
    var body: some View {
        VStack {
            Button {
                count += 1
            } label: {
                Circle()
                    .foregroundColor(color)
                    .overlay(
                        Text("\(count)")
                            .font(.system(size: 50))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    )
                    .frame(width: 100, height: 100)
            }
        }
    }
}
