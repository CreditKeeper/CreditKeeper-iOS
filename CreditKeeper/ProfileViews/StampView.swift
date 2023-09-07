//
//  StampView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/5/23.
//

import SwiftUI

struct PostageStampPattern: Shape {
    func path(in rect: CGRect) -> Path {
        let humpHeight: CGFloat = 20 // Double the depth of the hump
        let valleyHeight: CGFloat = 10 // Double the depth of the valley
        let patternWidth: CGFloat = 30
        
        var path = Path()
        var currentX: CGFloat = 0
        
        while currentX < rect.width {
            path.move(to: CGPoint(x: currentX, y: 0))
            path.addLine(to: CGPoint(x: currentX, y: humpHeight))
            currentX += patternWidth / 2
            
            path.addLine(to: CGPoint(x: currentX, y: valleyHeight))
            currentX += patternWidth / 2
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

struct PostageStampView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(.thinMaterial, style: StrokeStyle(lineWidth: 20, dash: [20, 10])) // Adjust the dash pattern
                .frame(width: 200, height: 100)
                .aspectRatio(1.0, contentMode: .fit)
                .background(.orange)
            
            Text("Millenium \nForce")
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.headline)
                .lineLimit(4)
        }
    }
}

struct PostageStampView_Previews: PreviewProvider {
    static var previews: some View {
        PostageStampView()
    }
}
