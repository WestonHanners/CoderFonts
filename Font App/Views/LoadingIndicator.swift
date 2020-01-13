//
//  LoadingIndicator.swift
//  Font App
//
//  Created by Weston Hanners on 12/12/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct Spinner: Shape, Animatable {
    typealias AnimatableData = AnimatablePair<Double, Double>
    
    public var animatableData: AnimatableData {
        get { return AnimatableData(startAngle.degrees, endAngle.degrees) }
        set {
            startAngle = Angle(degrees: newValue.first)
            endAngle = Angle(degrees: newValue.second)
        }
    }
    
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addArc(
            center: CGPoint(x: rect.size.width * 0.5, y: rect.size.width * 0.5),
            radius: rect.size.width/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        return path
    }
}

struct LoadingIndicator: View {
    @State var animating: Bool = false
    @State var endAngle = Angle.degrees(350)
    
    var gradient: AngularGradient {
        let gradient = Gradient(colors: [.blue, .green])
        return AngularGradient(gradient: gradient, center: .center)
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {

                Spacer()
                    .frame(width: nil, height: 80, alignment: .center)
                
                Spinner(startAngle: Angle.degrees(50),
                        endAngle: endAngle)
                    .stroke(gradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 100, height: 100, alignment: .center)
                    .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: endAngle)
                    .rotationEffect(self.animating ? Angle.radians(Double.pi * 2) : Angle.degrees(0))
                    .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: false))
                    .compositingGroup()
                
                Text("Installing...")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                
                
                Spacer()
            }
            .onAppear() {
                self.endAngle = Angle.degrees(50)
                self.animating = true
            }
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
