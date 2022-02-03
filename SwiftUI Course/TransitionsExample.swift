//
//  TransitionsExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 02/02/22.
//

import SwiftUI

struct TransitionsExample: View {
    @State private var show = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
                .overlay(
                    Text("Show Details")
                        .font(.system(.largeTitle))
                        .bold()
                        .foregroundColor(.white)
                )
                .onTapGesture {
                    withAnimation(Animation.spring()) {
                        show.toggle()
                    }
                }
            
            if show {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.purple)
                    .overlay(
                        Text("Well, here is the details")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                    )
                    .transition(.offset(x: -600, y: 0)
                                    .combined(with: .scale)
                                    .combined(with: .opacity))
            }
        }
    }
}

struct TransitionsExample_Previews: PreviewProvider {
    static var previews: some View {
        TransitionsExample()
    }
}
