/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 A view showing the list of landmarks.
 */

import SwiftUI

struct ContentView: View {
    
    @Environment(ModelData.self) var modelData
    
    @State private var rotation: Double = 0
    
    var body: some View {
        
         LandmarkList()
        
        // ______________ Spinner animación para mi aplicación (Simpsons) ______________
/*
         ZStack {
         HexagonShape()
         .stroke(LinearGradient(
         gradient: Gradient(colors: [.blue, .cyan]),
         startPoint: .topLeading,
         endPoint: .bottomTrailing
         ), lineWidth: 5)
         .frame(width: 100, height: 100)
         .rotationEffect(.degrees(rotation))
         .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
         .onAppear {
         rotation = 360
         }
         }
*/
        
/*
        ZStack {
            DonutShape()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [.pink, .purple]),
                        center: .center,
                        startRadius: 5,
                        endRadius: 100
                    )
                )
                .overlay(
                    DonutShape()
                        .stroke(Color.brown, lineWidth: 8)
                )
                .frame(width: 120, height: 120)
                .rotationEffect(.degrees(rotation))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
                .onAppear {
                    rotation = 360
                }
            Text("🍩")
                .font(.system(size: 40))
                .offset(y: -50)
                .rotationEffect(.degrees(-rotation))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
        }
*/
    }
    
}

/*
struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let centerX = width / 2
        let centerY = height / 2
        let size: CGFloat = min(width, height) / 2
        let angle = CGFloat.pi / 3
        
        path.move(to: CGPoint(x: centerX + size * cos(0), y: centerY + size * sin(0)))
        
        for i in 1...6 {
            let x = centerX + size * cos(angle * CGFloat(i))
            let y = centerY + size * sin(angle * CGFloat(i))
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.closeSubpath()
        return path
    }
}
*/

/*
struct DonutShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.6
        
        var path = Path()
        
        path.addEllipse(in: CGRect(
            x: center.x - outerRadius,
            y: center.y - outerRadius,
            width: outerRadius * 2,
            height: outerRadius * 2
        ))
        
        path.addEllipse(in: CGRect(
            x: center.x - innerRadius,
            y: center.y - innerRadius,
            width: innerRadius * 2,
            height: innerRadius * 2
        ))
        
        return path
    }
}
*/

#Preview {
    ContentView()
        .environment(ModelData())
}
