//
//  CustomInputField.swift
//  WeSplitWatchOS Watch App
//
//  Created by Filip Kisić on 22.11.2023..
//

import SwiftUI

struct CustomInputField: View {
  // MARK: - PROPERTY
  @State private var scale = 1.0
  @State private var isAmountInputPresented = false
  
  @State private var checkAmountWhole = 0
  @State private var checkAmountDecimal = 0
  
  private let currencySymbol = Locale.current.currencySymbol ?? "$"
  
  // MARK: - FUNCTION
  private func isCheckAmountEmpty() -> Bool {
    return checkAmountWhole == 0 && checkAmountDecimal == 0
  }
  
  private func showInputFormContent() -> String{
    return isCheckAmountEmpty() ? "Check amount" : "\(currencySymbol)\(checkAmountWhole).\(checkAmountDecimal)"
  }
  
  // MARK: - BODY
  var body: some View {
    Text("Check amount")
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: isCheckAmountEmpty() ? .leading : .trailing)
      .multilineTextAlignment(.trailing)
      .frame(maxWidth: 200, maxHeight: 37, alignment: .leading)
      .padding()
      .background(.inputFieldBackground)
      .foregroundColor(isCheckAmountEmpty() ? .inputFieldForeground : .white)
      .cornerRadius(12)
      .scaleEffect(scale)
      .onTapGesture {
        isAmountInputPresented.toggle()
        
        withAnimation(Animation.easeInOut(duration: 0.05)) {
          scale = 1.05
        } completion: {
          withAnimation(Animation.easeInOut(duration: 0.05)) {
            scale = 1
          }
        }
      }
      .sheet(isPresented: $isAmountInputPresented, content: {
        AmountInputView(wholePart: $checkAmountWhole, decimalPart: $checkAmountDecimal)
      })
    Spacer()
  }
}

// MARK: - PREVIEW
#Preview {
  CustomInputField()
}
