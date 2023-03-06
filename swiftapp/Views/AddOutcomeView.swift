//
//  AddOutcomeView.swift
//  swiftapp
//
//  Created by user230926 on 1/1/23.
//
import SwiftUI

struct AddOutcomeView: View {
    @Environment (\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var text = "0.00"
    @State private var value: Double = 0
    var body: some View{
        Form {
            Section {
                Text("Dodawanie nowego wydatku")
                TextField("Nazwa wydatku", text: $name)
                TextField("Wartosc",text:$text).keyboardType(.decimalPad)
                HStack {
                    Spacer()
                    Button("Dodaj"){
                        value = -1 * Double(text)!
                        if(name==""){
                            name="Wydatek"
                        }
                        DataController().addIncome(name:name,value:value,context:managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
                
            }
        }
    }
}

struct AddOutcomeView_Previews: PreviewProvider {
    static var previews: some View {
        AddOutcomeView()
    }
}
