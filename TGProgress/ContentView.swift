//
//  ContentView.swift
//  TGProgress
//
//  Created by satish.v on 06/01/21.
//

import SwiftUI

struct ContentView: View {
    let segmentCount = 200
    let colors :[Color]
    
    @State private var xOffset:CGFloat = 0
    
    @State private var resetValue:CGFloat = 320*2
    @State private var timer:Timer? = nil
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
                        .frame(width: geo.frame(in: CoordinateSpace.local).width - 32,  height: 10)
                        .cornerRadius(5.0)
                    HStack() {
                        ForEach(0..<segmentCount) {_ in
                            Spacer()
                            Rectangle().foregroundColor(.white)
                                .rotationEffect(.init(degrees: 44))
                                .frame(width: 11, height: 47)
                            Spacer()
                        }
                        .frame(height: 10)
                        .offset(x: xOffset)
                    }
                    .frame(width: geo.frame(in: CoordinateSpace.local).width * 2)
                }
                .frame(width: geo.frame(in: CoordinateSpace.local).width - 32)
                .clipped()
            
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .onAppear(perform: {
                self.resetValue = (geo.frame(in: CoordinateSpace.local).width * 2)
                xOffset = -resetValue
                timer = statAnimation()
            })
        }
    }
    
    @discardableResult
    func statAnimation() -> Timer {
        func update(_ : Timer) {
            if self.xOffset > 0 {
                self.xOffset = -resetValue
            } else {
                self.xOffset += 1
            }
        }
        
       return Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: update(_:))
    }
    
    func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colors: [Color.blue, Color.green])
    }
}

