//
//  ContentView.swift
//  Temperature4U
//
//  Application will convert Temparature to different units C, F, K
//
//  Challenge Day #1 from 100 Days of SwiftUI
//  https://www.hackingwithswift.com/100/swiftui/19
//  Created by Petie Positivo on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties & Formulas
    @FocusState private var amountIsFocused: Bool
    @State private var inputTemp = 0.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Celsius"
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var computeTemp: Double {
        
        //Celsius
        if inputUnit == "Celsius" {
            if outputUnit == "Fahrenheit" {
                return ((inputTemp * 9) / 5) + 32
            } else if outputUnit == "Kelvin" {
                return inputTemp + 273.15
            } else if outputUnit == "Celsius" {
                return inputTemp
            }
        }
        
        //Fahrenheit
        else if inputUnit == "Fahrenheit" {
            if outputUnit == "Celsius" {
                return ((inputTemp - 32) * 5) / 9
            } else if outputUnit == "Kelvin" {
                return (((inputTemp - 32) * 5) / 9) + 273.15
            } else if outputUnit == "Fahrenheit" {
                return inputTemp
            }
        }
        
        //Kelvin
        else if inputUnit == "Kelvin" {
            if outputUnit == "Celsius" {
                return inputTemp - 273.15
            } else if outputUnit == "Fahrenheit" {
                return (((inputTemp - 273.15) * 9) / 5) + 32
            } else if outputUnit == "Kelvin" {
                return inputTemp
            }
        }
        
        return 0.0
    }
    
    var body: some View {
        
        //MARK: UI

        NavigationView {
            Form {
                    
                    //TODO: Text Field to enter a number
                    Section {
                        TextField("Input", value: $inputTemp, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    } header: {
                        Text("Input Temperature")
                    }
                    
                    //TODO: Segmented Control to choose input unit (Picker)
                    Section {
                        Picker("Input Unit", selection: $inputUnit) {
                            ForEach(temperatureUnits, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                    } header: {
                        Text("Input Unit")
                    }
                    
                    //TODO: Segmented Control to choose output unit (Picker)
                    Section {
                        Picker("Output Unit", selection: $outputUnit) {
                            ForEach(temperatureUnits, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                    } header: {
                        Text("Output Unit")
                    }
                    
                    //TODO: Text View to display result
                    Section {
                        Text(computeTemp, format: .number)
                            .keyboardType(.decimalPad)
                    } header: {
                        Text("Output Temperature")
                    }
                    
            }.navigationTitle("Temperature4U 🌡")
            .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Done") {
                                amountIsFocused = false
                            }
                        }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
