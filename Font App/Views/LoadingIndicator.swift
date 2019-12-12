//
//  LoadingIndicator.swift
//  Font App
//
//  Created by Weston Hanners on 12/12/19.
//  Copyright © 2019 Weston Hanners. All rights reserved.
//

import SwiftUI

struct Spinner: Shape {
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
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                Spinner(startAngle: Angle.zero, endAngle: Angle.degrees(270))
                    .stroke(lineWidth: 20.0)
                    .foregroundColor(.blue)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: false))
                    .frame(width: 100, height: 100, alignment: .center)
                    .rotationEffect(Angle.radians(Double.pi * 2))
                    .animation(Animation.easeInOut(duration: 2.0))
                
                Text("Installing...")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                
                Spacer()
            }
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
