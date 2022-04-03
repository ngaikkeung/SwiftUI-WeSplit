//
//  ContentView.swift
//  WeSpliit
//
//  Created by KK NGAI on 2/4/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocus: Bool
    
    var userCurrencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD").rounded()
    }
    
    var totalAmount: Double {
        let tipeSelection = Double(tipPercentage)
        let tipValue = checkAmount * tipeSelection / 100
        
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let pepopleCount = Double(numberOfPeople + 2)
        
        return totalAmount / pepopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: userCurrencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: userCurrencyFormatter)
                } header: {
                    Text("Total amount")
                }
                
                
                Section {
                    Text(totalPerPerson, format: userCurrencyFormatter)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocus = false
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
