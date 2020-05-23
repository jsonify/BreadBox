//
//  BottomBar.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/22/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct BottomBar: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var showingCreateView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Image("icon-plus")
                .foregroundColor(Color("buttonGray"))
                .onTapGesture {
                    self.showingCreateView.toggle()
//                    Haptic().simpleSuccess()
                    
            }
            .sheet(isPresented: $showingCreateView) {
                CreateView().environment(\.managedObjectContext, self.moc)
            }
//            Image("icon-plus")
                .offset(y: -50)
            Spacer()
        }
    }
}
//
//struct BottomBar_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomBar()
//    }
//}

struct CurvedShape: View {
    var body: some View {
        
        Path { bezierPath in
            bezierPath.move(to: CGPoint(x: 143.02, y: 56))
            bezierPath.addLine(to: CGPoint(x: 0, y: 56))
            bezierPath.addLine(to: CGPoint(x: 0, y: 0))
            bezierPath.addLine(to: CGPoint(x: 375, y: 0))
            bezierPath.addLine(to: CGPoint(x: 375, y: 56))
            bezierPath.addLine(to: CGPoint(x: 232.98, y: 56))
            bezierPath.addCurve(to: CGPoint(x: 188, y: 36), control1: CGPoint(x: 213, y: 56), control2: CGPoint(x: 213.68, y: 36))
            bezierPath.addCurve(to: CGPoint(x: 143.02, y: 56), control1: CGPoint(x: 162.32, y: 36), control2: CGPoint(x: 163, y: 56))
        }
        .fill(Color("textViewBackground"))
        .rotationEffect(.init(degrees: 180))
    }
}
