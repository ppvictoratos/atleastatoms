import SwiftUI
import PlaygroundSupport

//have state be more of global thing
//use computed, generic properties to create custom sized shapes such as circles

struct Smile: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
}

struct FaceView: View {
    var isHappy: Bool
    
    var body: some View {
            VStack {
                HStack(spacing: 3){
                    Circle().scaleEffect(0.25)
                    Circle().scaleEffect(0.25)
                }
                Smile(startAngle: .degrees(150),
                      endAngle: .degrees(30),
                      clockwise: true)
                    .stroke(Color.black, lineWidth: 10)
                    .frame(width: 300, height: 300)
//                    .rotationEffect(isHappy ? .zero : .degrees(180))
                    .rotation3DEffect(isHappy ? .degrees(180) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                    .transformEffect(isHappy ? CGAffineTransform(translationX: 0, y: 0) : CGAffineTransform(translationX: 0, y: -180))
            }
    }
}

PlaygroundPage.current.setLiveView(FaceView(isHappy: true))


struct CircleView: View {
    @State private var tapped : Bool = false

    var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(tapped ? .yellow : .green)
                    .onTapGesture {self.tapped.toggle()}
                
                Circle().foregroundColor(tapped ? .purple : .red)
                    .onTapGesture {self.tapped.toggle()}
                //TODO: either embed or format faceview to be in this circle
                FaceView(isHappy: tapped)
            }
    }
}

PlaygroundPage.current.setLiveView(CircleView())
