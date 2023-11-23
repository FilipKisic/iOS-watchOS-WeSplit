//
//  ContentView.swift
//  WeSplit
//
//  Created by Filip Kisić on 20.11.2023..
//

import SwiftUI

struct MainView: View {
  // MARK: - PROPERTY
  @FocusState private var amountIsFocused: Bool
  
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 0
  @State private var tipPercentage = 15
  
  private let tipPercentagesList = [0, 10, 15, 20, 25]
  
  // MARK: - GENERATED PROPERTY
  private var tipAmount: Double {
    let tipSelection = Double(tipPercentage)
    return checkAmount / 100 * tipSelection
  }
  
  private var grandTotal: Double {
    return checkAmount + tipAmount
  }
  
  private var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  
  // MARK: - BODY
  var body: some View {
    NavigationStack {
      ZStack {
        LinearGradient(
          colors: [.gradientBegin, .gradientEnd],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        Form {
          //HEADER VALUE
          VStack {
            HStack {
              Spacer()
              VStack {
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                  .font(.system(size: 62, weight: .bold, design: .rounded))
                Text("per person")
                  .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                  .fontDesign(.rounded)
              } //: VSTACK
              Spacer()
            } //: HSTACK
            .padding()
            
            Divider()
            
            HStack {
              Text("Tip amount: ")
              Spacer()
              Text(tipAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
            }
            .padding(.bottom, 1)
            HStack {
              Text("Check amount: ")
              Spacer()
              Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
            }
            .padding(.bottom, 1)
            
            Capsule()
              .frame(height: 1)
            
            HStack {
              Text("Grand total: ").fontWeight(.bold)
              Spacer()
              Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .fontWeight(.bold)
            }
            .padding(.vertical, 1)
          }
          
          
          //INPUT FORM
          Section("Check details") {
            HStack {
              Text("Check amount")
              Spacer()
              TextField(
                "0.00",
                value: $checkAmount,
                format: .currency(code: Locale.current.currency?.identifier ?? "EUR")
              ).multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
            }
            
            Picker("Number of people", selection: $numberOfPeople) {
              ForEach(2..<20) {
                Text("\($0) people")
              }
            } //: PICKER
            .pickerStyle(.navigationLink)
          } //: SECTION
          
          Section("Please choose the tip percentage") {
            Picker("Tip percentage", selection: $tipPercentage) {
              ForEach(tipPercentagesList, id: \.self) {
                Text($0, format: .percent)
              }
            } //: PICKER
            .pickerStyle(.segmented)
          } //: SECTION
          
        } //: FORM
        .scrollContentBackground(.hidden)
        .navigationTitle("WeSplit")
        .toolbar {
          if amountIsFocused {
            Button("Done") {
              amountIsFocused = false
            }
          }
        } //: TOOLBAR
      } //: ZSTACK
    } //: NAVIGATION STACK
  }
}

// MARK: - PREVIEW
#Preview {
  MainView()
}
