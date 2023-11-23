//
//  ContentView.swift
//  WeSplitWatchOS Watch App
//
//  Created by Filip Kisić on 21.11.2023..
//

import SwiftUI

struct MainView: View {
  // MARK: - PROPERTY
  @State private var checkAmountWhole = 0
  @State private var checkAmountDecimal = 0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 15
  
  @State private var isResultViewShown = false
  
  private let currencySymbol = Locale.current.currencySymbol ?? "$"
  private let tipPercentagesList = [0, 10, 15, 20, 25]
  
  // MARK: - GENERATED PROPERTY
  private var tipAmount: Double {
    let checkAmount = Double(checkAmountWhole) + (Double(checkAmountDecimal) / 100.0)
    print("Check amount: \(checkAmount) \(numberOfPeople)")
    let tipSelection = Double(tipPercentage)
    return checkAmount / 100 * tipSelection
  }
  
  private var grandTotal: Double {
    let checkAmount = Double(checkAmountWhole) + (Double(checkAmountDecimal) / 100.0)
    return checkAmount + tipAmount
  }
  
  private var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople)
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  
  // MARK: - BODY
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack {
          //CHECK AMOUNT INPUT
          HStack {
            Text("Bill: \(currencySymbol)")
            
            Picker("", selection: $checkAmountWhole) {
              ForEach (0..<1000, id: \.self) { amount in
                Text(String(amount))
              }
            }
            .labelsHidden()
            
            Text(".")
            
            Picker("Choose amount", selection: $checkAmountDecimal) {
              ForEach (0..<100, id: \.self) { amount in
                Text(String(amount))
              }
            }
            .labelsHidden()
          } //: HSTACK
          .frame(minHeight: 40)
          
          //NUMBER OF PEOPLE INPUT
          HStack {
            Text("Number of people:")
              .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Choose amount", selection: $numberOfPeople) {
              ForEach (2..<21, id: \.self) { amount in
                Text(String(amount))
              }
            }
            .labelsHidden()
          } //: HSTACK
          .frame(minHeight: 40)
          
          //TIP PERCENTAGE INPUT
          HStack {
            Text("Tip amount:")
              .frame(maxWidth: .infinity)
            
            Picker("Choose amount", selection: $tipPercentage) {
              ForEach (tipPercentagesList, id: \.self) { percentage in
                Text("\(percentage)%")
              }
            }
            .labelsHidden()
          } //: HSTACK
          .frame(minHeight: 40)
          
          Button("Calculate") {
            isResultViewShown.toggle()
          }
          .fullScreenCover(isPresented: $isResultViewShown) {
            VStack {
              Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .font(.system(size: 42, weight: .bold, design: .rounded))
              Text("per person")
            } //: VSTACK
          } //: FULL SCREEN COVER
        } //: VSTACK
        .navigationTitle("WeSplit")
      } //: SCROLL VIEW
    } //: NAVIGATION STACK
  }
}

// MARK: - PREVIEW
#Preview {
  MainView()
}
