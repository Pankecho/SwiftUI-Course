//
//  PathChartsExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 27/01/22.
//

import SwiftUI

struct PathChartsExample: View {
    var body: some View {
        VStack(spacing: 100) {
            //BasicPath()
            //PieChart()
            
            ProgressIndicator(progress: 0.75)
            DonutChart()
        }
    }
}

struct BasicPath: View {
    var body: some View {
        VStack {
            Path() { path in
                path.move(to: .init(x: 20, y: 20))
                path.addLine(to: .init(x: 300, y: 20))
                path.addLine(to: .init(x: 300, y: 200))
                path.addLine(to: .init(x: 20, y: 200))
                // Close path
                path.closeSubpath()
            }
            .stroke(.green, lineWidth: 20)
            
            ZStack {
                Path() { path in
                    path.move(to: .init(x: 20, y: 300))
                    path.addLine(to: .init(x: 40, y: 300))
                    path.addQuadCurve(to: .init(x: 210, y: 300),
                                      control: .init(x: 125, y: 200))
                    path.addLine(to: .init(x: 230, y: 300))
                    path.addLine(to: .init(x: 230, y: 350))
                    path.addLine(to: .init(x: 20, y: 350))
                }
                .fill(.purple)
                
                Path() { path in
                    path.move(to: .init(x: 20, y: 300))
                    path.addLine(to: .init(x: 40, y: 300))
                    path.addQuadCurve(to: .init(x: 210, y: 300),
                                      control: .init(x: 125, y: 200))
                    path.addLine(to: .init(x: 230, y: 300))
                    path.addLine(to: .init(x: 230, y: 350))
                    path.addLine(to: .init(x: 20, y: 350))
                    path.closeSubpath()
                }
                .stroke(.black, lineWidth: 5)
            }
        }
    }
}

struct PathChartsExample_Previews: PreviewProvider {
    static var previews: some View {
        PathChartsExample()
    }
}


struct PieChart: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: .init(x: 200, y: 200))
                // Degrees are inverted
                path.addArc(center: .init(x: 200, y: 200),
                            radius: 150,
                            startAngle: .init(degrees: 0),
                            endAngle: .init(degrees: 315),
                            clockwise: true)
            }
            .fill(.green)
            
            Path { path in
                path.move(to: .init(x: 200, y: 200))
                // Degrees are inverted
                path.addArc(center: .init(x: 200, y: 200),
                            radius: 150,
                            startAngle: .init(degrees: 315),
                            endAngle: .init(degrees: 180),
                            clockwise: true)
            }
            .fill(.blue)
            
            Path { path in
                path.move(to: .init(x: 200, y: 200))
                // Degrees are inverted
                path.addArc(center: .init(x: 200, y: 200),
                            radius: 150,
                            startAngle: .init(degrees: 90),
                            endAngle: .init(degrees: 180),
                            clockwise: false)
            }
            .fill(.yellow)
            
            Path { path in
                path.move(to: .init(x: 200, y: 200))
                // Degrees are inverted
                path.addArc(center: .init(x: 200, y: 200),
                            radius: 150,
                            startAngle: .init(degrees: 90),
                            endAngle: .init(degrees: 360),
                            clockwise: true)
                path.closeSubpath()
            }
            .fill(.orange)
            // Highlight segment
            .offset(x: 20, y: 20)
            .overlay(
                Text("25%")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .offset(x: 90, y: -100)
            )
        }
    }
}

// Custom Shape
struct Dome: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .init(x: 0, y: 0))
        path.addQuadCurve(to: .init(x: rect.size.width, y: 0),
                          control: .init(x: rect.size.width / 2, y: -(rect.size.width * 0.1)))
        path.addRect(.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        
        return path
    }
}

struct ProgressIndicator: View {
    let progress: Double
    private let gradient = LinearGradient(gradient: .init(colors: [.green, .blue]),
                                          startPoint: .leading,
                                          endPoint: .trailing)
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray6), lineWidth: 20)
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(gradient, lineWidth: 20)
                .frame(width: 250, height: 250)
                .overlay(
                    VStack {
                        Text("75%")
                            .font(.system(size: 80,
                                          weight: .bold,
                                          design: .rounded))
                        
                        Text("Complete")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .foregroundColor(.gray)
                    }
                )
        }
    }
}

struct DonutChart: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.4)
                .stroke(.blue, lineWidth: 40)
            
            Circle()
                .trim(from: 0.4, to: 0.6)
                .stroke(.red, lineWidth: 40)
            
            Circle()
                .trim(from: 0.6, to: 0.75)
                .stroke(.green, lineWidth: 40)
            
            Circle()
                .trim(from: 0.75, to: 1)
                .stroke(.yellow, lineWidth: 40)
                .offset(x: 10, y: -10)
        }
        .frame(width: 250, height: 250)
    }
}
