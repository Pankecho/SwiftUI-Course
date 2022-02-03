//
//  AnimationsExample.swift
//  SwiftUI Course
//
//  Created by Juan Pablo Martinez Ruiz on 31/01/22.
//

import SwiftUI

struct AnimationsExample: View {
    var body: some View {
        VStack(spacing: 50) {
            //HeartButtonImplicit()
            //HeartButtonExplicit()
            CircleLoader()
            LinearLoader()
            ProgressLoader()
            DotLoader()
            ButtonRecorder()
        }
    }
}

struct AnimationsExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsExample()
    }
}

struct HeartButtonImplicit: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(circleColorChanged ? .gray : .red)
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .animation(.spring(response: 0.3,
                           dampingFraction: 0.3,
                           blendDuration: 0.3))
        .onTapGesture {
            circleColorChanged.toggle()
            heartColorChanged.toggle()
            heartSizeChanged.toggle()
        }
    }
}

struct HeartButtonExplicit: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(circleColorChanged ? .gray : .red)
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .onTapGesture {
            withAnimation(.default) {
                circleColorChanged.toggle()
                heartColorChanged.toggle()
                heartSizeChanged.toggle()
            }
        }
    }
}

struct CircleLoader: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.2), lineWidth: 14)
                .frame(width: 100, height: 100)
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(.green, lineWidth: 5)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(.default.repeatForever(autoreverses: false))
                .onAppear {
                    isLoading = true
                }
        }
    }
}

struct LinearLoader: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(.gray, lineWidth: 3)
                .frame(width: 250, height: 3)
            
            RoundedRectangle(cornerRadius: 3)
                .stroke(.green, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110: -110, y: 0)
                .animation(.linear(duration: 1).repeatForever(autoreverses: false))
        }
        .onAppear {
            isLoading = true
        }
    }
}

struct ProgressLoader: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Text("\(Int(progress * 100))%")
                .font(.system(.title, design: .rounded))
                .bold()
            
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 10)
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.green, lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90))
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                progress += 0.05
                
                if progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}

struct DotLoader: View {
    @State private var isLoading = false
    
    var body: some View {
        HStack {
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(Animation.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)))
            }
        }
        .onAppear {
            isLoading.toggle()
        }
    }
}

struct ButtonRecorder: View {
    @State private var recordBegin = false
    @State private var isRecording = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .blue)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(isRecording ? 0.7 : 1)
                )
            
            RoundedRectangle(cornerRadius: recordBegin ? 35 : 10)
                .trim(from: 0, to: recordBegin ? 0.0001 : 1)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(.blue)
        }.onTapGesture {
            withAnimation(Animation.spring()) {
                recordBegin.toggle()
            }
            
            withAnimation(Animation.spring().repeatForever().delay(0.5)) {
                isRecording.toggle()
            }
        }
    }
}
