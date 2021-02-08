//
//  ContentView.swift
//  Shared
//
//  Created by Apple on 07/02/21.
//

import SwiftUI

struct Arrow : Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: (rect.maxX - rect.minX) * 0.33, y: rect.midY))
        path.addLine(to: CGPoint(x: (rect.maxX - rect.minX) * 0.33, y: rect.maxY))
        path.addLine(to: CGPoint(x: (rect.maxX - rect.minX) * 0.66, y: rect.maxY))
        path.addLine(to: CGPoint(x: (rect.maxX - rect.minX) * 0.66, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
                
//        path.move(to: CGPoint(x: 100 ,y: 200))
//        path.addLine(to: CGPoint(x: 100, y: 100))
//        path.addLine(to: CGPoint(x: 200, y: 100))
//        path.addLine(to: CGPoint(x: 200, y: 200))
//        path.addLine(to: CGPoint(x: 100, y: 200))
//        path.addLine(to: CGPoint(x: 200, y: 200))
//        path.addLine(to: CGPoint(x: 100, y: 200))
        return path
    }
   
    
    
}
struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startPosition: UnitPoint = .top
    var endPosition: UnitPoint = .bottom
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: startPosition, endPoint: endPosition), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineWidth: CGFloat = 10
    @State private var colorCycle = 0.0
    @State private var startPosition: UnitPoint = .top
    @State private var endPosition: UnitPoint = .bottom
    
    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        self.lineWidth = CGFloat.random(in: 1...75)
                    }
                }
            
            Slider(value: $lineWidth, in: 1...75, step: 1)
                .padding()
            
            ColorCyclingRectangle(amount: self.colorCycle, startPosition: startPosition, endPosition: endPosition)
                .frame(width: 100, height: 100)
                .onTapGesture {
                    withAnimation {
                        
                        self.startPosition = self.startPosition == .top ? .leading : .top
                        self.endPosition = self.endPosition == .bottom ? .trailing : .bottom
                    }
                }
            
            Slider(value: $colorCycle)
                .padding()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

















//Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
//            .strokeBorder(Color.blue, lineWidth: 40)
//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//
//        return path
//    }
//}
//
//struct Arc: InsettableShape {
//    var startAngle: Angle
//    var endAngle: Angle
//    var clockwise: Bool
//    var insetAmount : CGFloat = 0
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: (Angle.degrees(90) - startAngle), endAngle: (Angle.degrees(90) - endAngle), clockwise: clockwise)
//
//        return path
//    }
//
//    func inset(by amount: CGFloat) -> some InsettableShape {
//        var arc = self
//        arc.insetAmount += amount
//        return arc
//    }
//}


//                    .frame(width: 300, height: 300)
//        Circle()
//            .strokeBorder(Color.red,lineWidth: 40)
//        Triangle()
//            .fill(Color.red)
//            .frame(width: 300, height: 300)
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .stroke(Color.blue, lineWidth: 10)
//            .frame(width: 300, height: 300)
//        Triangle()
//            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
//        Path{ path in
//            path.move(to: CGPoint(x: UIScreen.main.bounds.width / 2 , y: 100))
//            path.addLine(to: CGPoint(x: (UIScreen.main.bounds.width / 2) - 100, y: 300))
//            path.addLine(to: CGPoint(x: (UIScreen.main.bounds.width / 2) + 100 , y: 300))
//            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width / 2, y: 100))
//            path.addLine(to: CGPoint(x: (UIScreen.main.bounds.width / 2) - 100, y: 300))
//
//        }
////        .fill(Color.red)
//        .stroke(Color.blue, lineWidth: 10)

