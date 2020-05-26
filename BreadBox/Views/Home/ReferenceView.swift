//
//  ReferenceView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/23/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct ReferenceView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var glossaryData = GlossaryData()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HStack {
                    Text("Reference".uppercased())
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
                        
                    }
                }
                .padding(.horizontal, 30)
                
                VStack(spacing: 30.0) {
                    VStack {
                        HStack {
                            Text("Temperatures".uppercased())
                                .font(AvFont.title)
                                .tracking(3)
                                .bold()
                            
                            Spacer()
                        }
                        .padding()
                        
                        VStack {
                            HStack {
                                Text("°F")
                                    .bold()
                                    .frame(maxWidth: 70, alignment: .leading)
                                    .padding(.trailing, 40)
                                Text("°C")
                                .bold()
                                
                                Spacer()
                            }
                            .font(AvFont.title)
                            .padding(.bottom, 10)
                            
                            Group {
                                TemperatureLine(fahrenheit: "250", celsius: "120", heatDescription: "Very Low")
                                TemperatureLine(fahrenheit: "275", celsius: "140", heatDescription: "")
                                TemperatureLine(fahrenheit: "300", celsius: "150", heatDescription: "Low")
                            }
                            .background(Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)))
                            Group {
                                TemperatureLine(fahrenheit: "325", celsius: "170", heatDescription: "")
                                TemperatureLine(fahrenheit: "350", celsius: "180", heatDescription: "Medium")
                                TemperatureLine(fahrenheit: "375", celsius: "190", heatDescription: "")
                                TemperatureLine(fahrenheit: "400", celsius: "200", heatDescription: "Moderate")
                            }
                            .background(Color(#colorLiteral(red: 0.9957650304, green: 0.7316431403, blue: 0.4604277015, alpha: 1)))
                            
                            Group {
                                TemperatureLine(fahrenheit: "425", celsius: "220", heatDescription: "")
                                TemperatureLine(fahrenheit: "450", celsius: "230", heatDescription: "Hot")
                                TemperatureLine(fahrenheit: "475", celsius: "240", heatDescription: "Very Hot")
                            }
                            .background(Color(#colorLiteral(red: 1, green: 0.6182092428, blue: 0.4910398126, alpha: 1)))
                        }
                            .font(AvFont.textField)
                        .padding(.horizontal, 30)
                    }
                    
                    VStack {
                        HStack {
                            
                            Text("Weight".uppercased())
                                .font(AvFont.title)
                                .tracking(3)
                                .bold()
                            
                            Spacer()
                            
                            Text("Volume".uppercased())
                                .font(AvFont.title)
                                .tracking(3)
                                .bold()
                                .padding(.trailing, 10)
                            
                        }
                        .padding()
                        
                        VStack {
                            HStack {
                                Text("Imperial".uppercased())
                                    .bold()
                                    .frame(maxWidth: 60, alignment: .leading)
                                    .padding(.trailing, 40)
                                Text("Metric".uppercased())
                                    .bold()
                                .frame(maxWidth: 100, alignment: .leading)
                                
                                Spacer()
                            }
                                .font(AvFont.title)
                            .padding(.bottom, 10)
                            
                            Group {
                                WeightVolumnLine(oz: "- ", ml: "5", volume: "1 teaspoon")
                                WeightVolumnLine(oz: "- ", ml: "7.5", volume: "1/2 tablespoon")
                                WeightVolumnLine(oz: "1/2", ml: "15", volume: "1 tablespoon")
                                WeightVolumnLine(oz: "1", ml: "30", volume: "1/8 cup")
                                WeightVolumnLine(oz: "2", ml: "60", volume: "1/4 cup")
                                WeightVolumnLine(oz: "2 2/3", ml: "80", volume: "1/3 cup")
                                WeightVolumnLine(oz: "4", ml: "120", volume: "1/2 cup")
                                WeightVolumnLine(oz: "8", ml: "240", volume: "1 cup")
                                WeightVolumnLine(oz: "16", ml: "475", volume: "1 pint")
                                WeightVolumnLine(oz: "32", ml: "975", volume: "1 quart")
                            }
                        }
                        .padding(.horizontal, 30)
                        
                    }
                    
                    VStack {
                        HStack {
                            Text("Baking Glossary".uppercased())
                                .font(AvFont.title)
                                .tracking(3)
                                .bold()
                            
                            Spacer()
                        }
                        .padding()
                        
                        VStack {
                            ForEach(glossaryData.terms) { entry in
                                GlossaryTermLine(term: entry.term, definition: entry.definition)
                                
                            }
                            
                        }
                        .padding(.horizontal, 30)
                    }
                }
                
            }
            .padding(.top, 30)
        }
    }
}

struct ReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView()
    }
}

struct TemperatureLine: View {
    var fahrenheit: String
    var celsius: String
    var heatDescription: String
    
    var body: some View {
        HStack {
            HStack {
                Text(fahrenheit)
            }
            .frame(maxWidth: 110, alignment: .leading)

            HStack {
                Text(celsius)
            }
            
            Spacer()
            
            Text(heatDescription)
        }
    }
}

struct WeightVolumnLine: View {
    var oz: String
    var ml: String
    var volume: String
    
    var body: some View {
        
        HStack {
            HStack {
                Text("\(oz) oz")
                Spacer()
            }
            .frame(maxWidth: 110, alignment: .leading)
            
            HStack {
                Text("\(ml) ml")
            }
            Spacer()
            HStack {
                Text("\(volume)")
            }
        }
        .font(AvFont.textField)
        
    }
}

struct GlossaryTermLine: View {
    let term: String
    let definition: String
    
    var body: some View {
        Group {
            HStack(alignment: .firstTextBaseline) {
                Text("\(term): ".uppercased())
                .bold()
                    .frame(maxWidth: 90, alignment: .leading)
                    .font(AvFont.title)
                
                Text("\(definition)")
                    .font(AvFont.textField)
                Spacer()
            }
            .padding(.bottom)
            
        }
    }
}
