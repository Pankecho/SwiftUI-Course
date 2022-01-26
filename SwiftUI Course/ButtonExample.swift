//
//  ButtonExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 25/01/22.
//

import SwiftUI

struct ButtonExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Button with text
                Button {
                    //
                } label: {
                    Text("Press me")
                }

                // Button with custom font
                Button {
                    //
                } label: {
                    Text("Press me")
                        .padding()
                        .background(.orange)
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                // Button with border
                Button {
                    //
                } label: {
                    Text("Press me")
                        .font(.title)
                        .padding()
                        .background(.black)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(.black, lineWidth: 4)
                        )
                }
                
                // Button with icon
                Button {
                    //
                } label: {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                
                // Button with icon and text
                Button {
                    //
                } label: {
                    HStack {
                        Image(systemName: "trash")
                            .font(.title)
                        
                        Text("Delete")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(40)
                }
                
                // Button with label
                Button {
                    //
                } label: {
                    Label {
                        Text("Add to favorites")
                            .fontWeight(.semibold)
                            .font(.title)
                    } icon: {
                        Image(systemName: "star.fill")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(40)
                }
                
                // Button with gradient color
                Button {
                    //
                } label: {
                    Label {
                        Text("Add to cart")
                            .fontWeight(.semibold)
                            .font(.title)
                    } icon: {
                        Image(systemName: "cart")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .cornerRadius(40)
                }
                
                // Button with shadow
                Button {
                    //
                } label: {
                    Label {
                        Text("Download")
                            .fontWeight(.semibold)
                            .font(.title)
                    } icon: {
                        Image(systemName: "arrow.down.circle")
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]),
                                               startPoint: .trailing,
                                               endPoint: .leading))
                    .shadow(radius: 5)
                    .cornerRadius(40)
                }
                
                // Full width button
                Button {
                    //
                } label: {
                    Label {
                        Text("Share")
                            .fontWeight(.semibold)
                            .font(.title)
                    } icon: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                    }
                }
                .buttonStyle(GradientBackgroundStyle())
                
                // Button with animation
                Button {
                    //
                } label: {
                    Image(systemName: "plus")
                }
                .buttonStyle(RotateAnimationStyle())
            }
        }
    }
}

struct ButtonExample_Previews: PreviewProvider {
    static var previews: some View {
        ButtonExample()
    }
}

// Custom style for Button
struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.green, .yellow]),
                                       startPoint: .bottom,
                                       endPoint: .top))
            .shadow(radius: 5)
            .cornerRadius(40)
            .padding(.horizontal)
    }
}

// Custom style for Button
struct RotateAnimationStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 40, height: 40)
            .padding()
            .foregroundColor(.white)
            .background(.purple)
            .shadow(radius: 5)
            .cornerRadius(20)
            .padding(.horizontal)
            .rotationEffect(configuration.isPressed ? Angle(degrees: 90) : .zero)
    }
}
