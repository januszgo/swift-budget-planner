//
//  EditIncomeView.swift
//  swiftapp
//
//  Created by user230926 on 1/1/23.
//

import SwiftUI

struct EditIncomeView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var income: FetchedResults<Income>.Element
    
    @State private var name = ""
    @State private var value: Double = 0
    @State private var text = ""
    
    var body: some View {
        Form {
            Section() {
                TextField("\(income.name!)", text: $name)
                    .onAppear {
                        name = income.name!
                        value = income.value
                        text = "\(String(format: "%.2f", value))"
                    }
                VStack {
                    Text("Edycja pozycji")
                    TextField("",text:$text).keyboardType(.decimalPad)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Zapisz") {
                        value = Double(text)!
                        DataController().editIncome(income: income, name: name, value: value, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
