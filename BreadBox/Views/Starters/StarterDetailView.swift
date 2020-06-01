//
//  StarterDetailView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/30/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct StarterDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var starter: Starter

    @State private var showingSheet = false
    
    @State private var updatedFlourAmount: String = ""
    @State private var updatedWaterAmount: String = ""
    @State private var updatedSeedAmount: String = ""
    @State private var updatedInstructions: String = ""
    
    @State var value1 = 33.3
    @State var value2 = 33.3
    @State var value3 = 33.3
    
    var body: some View {
        let allBindings = [$value1, $value2, $value3]
        
        return ScrollView {
            VStack(spacing: 30.0) {
                HStack {
                    Text("Formula".uppercased())
                        .font(AvFont.header)
                        .tracking(3)
                        .bold()
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            Haptic().simpleSuccess()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Close".uppercased())
                                .font(AvFont.subtitle)
                                .tracking(1)
                                .frame(width: 60, height: 25)
                                .background(Color("Crumb"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        
                        Button(action: {
                            Haptic().simpleSuccess()
                            self.updateCoreData()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("update".uppercased())
                                .tracking(1)
                                .font(AvFont.subtitle)
                                .frame(width: 60, height: 25)
                                .background(Color("Crust"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                            
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                VStack {
//                    Scratchpad()
                    
                    HStack {
                        Text("Starter Name:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                        
                        Button(action: {
                            self.shareButton()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color("Crust"))
                        }
                        .padding(.trailing, 30)
                    }
                    
                    HStack {
                        Text("\(self.starter.name)")
                
                        Spacer()
                        
                    }
                    
                }
                .padding(.leading, 30)
                VStack {
                    HStack {
                        Text("Flour:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(updatedFlourAmount)")
                            .frame(width: 120, height: 34)
                            .font(.caption)
                            .onAppear {
                                self.updatedFlourAmount = String("\(self.value1)")
                        }
                        
                        synchronizedSlider(from: allBindings, index: 0)
                    }
                    .padding(.trailing, 30)
                    
                    HStack {
                        Text("Water:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(updatedWaterAmount)")
                            .frame(width: 120, height: 34)
                            .font(.caption)
                            .onAppear {
                                self.updatedWaterAmount = String("\(self.value2)")
                        }
                        
                        synchronizedSlider(from: allBindings, index: 1)
                    }
                    .padding(.trailing, 30)
                    
                    HStack {
                        Text("Seed:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(updatedSeedAmount)")
                            .frame(width: 120, height: 34)
                            .font(.caption)
                            .onAppear {
                                self.updatedSeedAmount = String("\(self.value3)")
                        }
                        
                        synchronizedSlider(from: allBindings, index: 2)
                    }
                    .padding(.trailing, 30)
                }
                .padding(.leading, 30)
                
                VStack {
                    HStack {
                        Text("Instructions:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    TextView(text: $updatedInstructions)
                        
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .cornerRadius(10)
                        .foregroundColor(Color("textField"))
                        .onAppear {
                            self.updatedInstructions = self.starter.instructions
                    }
                }
                .padding(.horizontal, 30)
                
                
            }
        }
        .padding(.top, 30)
        .statusBar(hidden: true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func shareButton() {
        showingSheet.toggle()
        
        let updatedstarter = "Here's that starter:\n\(self.starter.name)\n\nFlour: \(self.updatedFlourAmount)g\nWater: \(self.updatedWaterAmount)g\nStarter: \(self.updatedSeedAmount)g\n\nInstructions:\n\(self.updatedInstructions)"
        let av = UIActivityViewController(activityItems: [updatedstarter], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?
        .present(av, animated: true, completion: nil)
    }
    
    func updateCoreData() {
        self.starter.flourAmount = self.updatedFlourAmount
        self.starter.waterAmount = self.updatedWaterAmount
        self.starter.seedAmount = self.updatedSeedAmount
        self.starter.instructions = self.updatedInstructions
        
        do {
            try self.moc.save()
        } catch {
            print(error)
        }
    }
    
    func synchronizedSlider(from bindings: [Binding<Double>], index: Int) -> some View {
        return Slider(value: synchronizedBinding(from: bindings, index: index),
                      in: 0...100)
    }


    func synchronizedBinding(from bindings: [Binding<Double>], index: Int) -> Binding<Double> {

        return Binding(get: {
            return bindings[index].wrappedValue
        }, set: { newValue in

            let sum = bindings.indices.lazy.filter{ $0 != index }.map{ bindings[$0].wrappedValue }.reduce(0.0, +)
            // Use the 'sum' below if you initially provide values which sum to 100
            // and if you do not set the state in code (e.g. click the button)
            //let sum = 100.0 - bindings[index].wrappedValue

            let remaining = 100.0 - newValue

            if sum != 0.0 {
                for i in bindings.indices {
                    if i != index {
                        bindings[i].wrappedValue = bindings[i].wrappedValue * remaining / sum
                    }
                }
            } else {
                // handle 0 sum
                let newOtherValue = remaining / Double(bindings.count - 1)
                for i in bindings.indices {
                    if i != index {
                        bindings[i].wrappedValue = newOtherValue
                    }
                }
            }
            bindings[index].wrappedValue = newValue
        })

    }
}

struct StarterDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let starter = Starter(context: moc)
        starter.name = "Lucy"
        
        return NavigationView {
            StarterDetailView(starter: starter)
        }
    }
}
