//
//  RecipeView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct RecipeView: View {
    @State private var show = false
//        var recipe: Recipe
        
        var body: some View {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("Formula".uppercased())
                        .font(.title).bold()
                    .kerning(3)
                    .bold()
                    .scaledFont(name: "Avenir", size: 28)
                    
                    Text("Flour: 500g".uppercased())
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                    Text("Water: 500g".uppercased())
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                    Text("Starter: 500g".uppercased())
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                    Text("Salt: 500g".uppercased())
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                }
                .padding(30)
//                .frame(maxWidth: show ? .infinity : screen.width - 30, maxHeight: show ? .infinity : 70, alignment: .top)
                .offset(y: show ? 300 : 70)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .opacity(show ? 1 : 0)
                
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("sourdough".uppercased())
                                    .bold()
                                    .kerning(3)
                                    .scaledFont(name: "Avenir", size: 18)
                                
                                Spacer()
                                
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 23))
                                    .foregroundColor(.white)
                                    .offset(y: -20)
                            }
                                
                            Text("May 19, 2020".uppercased())
                                .kerning(2)
                                .foregroundColor(.white)
                                .scaledFont(name: "Avenir", size: 12)
                            Spacer()
                        }
                        .padding(.top, show ? 50 : 16)
                        
                        Spacer()
                    }
                    
                }
                .padding(20)
//                .frame(maxWidth: show ? .infinity : screen.width - 30)
//                .frame(maxHeight: show ? 300 : 70)
                .background(Color.gray)
                .cornerRadius(14)
                
                .onTapGesture {
                    self.show.toggle()
                }
            }
    //        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .animation(.easeInOut)
            .edgesIgnoringSafeArea(.all)
        }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
