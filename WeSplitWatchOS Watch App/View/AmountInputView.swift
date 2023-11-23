//
//  AmountInputView.swift
//  WeSplitWatchOS Watch App
//
//  Created by Filip Kisić on 22.11.2023..
//

import SwiftUI

struct AmountInputView: View {
  // MARK: - PARAMETER
  @Binding var wholePart : Int
  @Binding var decimalPart: Int
  
  
  private let currencySymbol = Locale.current.currencySymbol ?? "$"
  
  // MARK: - BODY
  var body: some View {
    VStack {
      HStack {
        Text("Bill:")
        Picker("Choose amount", selection: $wholePart) {
          ForEach (0..<1000, id: \.self) { amount in
            Text(String(amount))
          }
          .pickerStyle(.wheel)
        }
        .labelsHidden()
        Text(".")
        Picker("Choose amount", selection: $decimalPart) {
          ForEach (0..<100, id: \.self) { amount in
            Text(String(amount))
          }
          .pickerStyle(.wheel)
        }
        .onReceive([self.decimalPart].publisher.first()) { value in
          print(value ?? "Heyo")
        }
        .labelsHidden()
      } //: HSTACK
      HStack {
        Text("Bill:")
        Picker("Choose amount", selection: $wholePart) {
          ForEach (0..<1000, id: \.self) { amount in
            Text(String(amount))
          }
          .pickerStyle(.wheel)
        }
        .labelsHidden()
        Text(".")
        Picker("Choose amount", selection: $decimalPart) {
          ForEach (0..<100, id: \.self) { amount in
            Text(String(amount))
          }
          .pickerStyle(.wheel)
        }
        .onReceive([self.decimalPart].publisher.first()) { value in
          print(value ?? "Heyo")
        }
        .labelsHidden()
      } //: HSTACK
      Button("Done") {
        
      }
    } //:VSTACK
  }
}

// MARK: - PREVIEW
#Preview {
  AmountInputView(wholePart: .constant(12), decimalPart: .constant(63))
}
