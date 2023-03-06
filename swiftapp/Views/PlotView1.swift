//
//  PlotView.swift
//  swiftapp
//
//  Created by user230926 on 1/2/23.
//

import SwiftUI
import SwiftUICharts

struct PlotView1: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.value, order: .reverse)]) var income: FetchedResults<Income>
    @Environment(\.dismiss) var dismiss
        
    private var name = ""
    private var value: Double = 0
    
    private struct NamedFont: Identifiable {
        let name: String
        let value: Double
        var id: String {name}
    }
    private var namedFonts: [NamedFont] = [
    ]
    @State private var arrayUpdated = false
    
    var body: some View {
        
        Text("Wykres wydatkow")
        PieChart().data(incomeSum()).chartStyle(ChartStyle(backgroundColor: .white,foregroundColor: ColorGradient(.blue, .purple)))
        List{
            ForEach(incomeSum1()){namedFont in
                Text("\(String(namedFont.name))  \(Double(namedFont.value), specifier: "%.2f") zl")
            }}
        
        HStack {
            Spacer()
            Button("Cofnij") {
                dismiss()
            }
            Spacer()
        }

    }
    
    private func incomeSum() -> [Double] {
        var incomeSum : [Double] = []
        for item in income {
            if(item.value<0)
            {incomeSum.append(item.value*(-1))}
        }
        //print("Przychody: \(incomeSum)")
        return incomeSum
    }
    private func incomeSum1() -> [NamedFont] {
        var incomeSum : [NamedFont] = []
        for item in income {
            if(item.value<0)
            {incomeSum.append(NamedFont(name:item.name!,value:item.value*(-1)))}
        }
        //print("Przychody: \(incomeSum)")
        return incomeSum
    }
    
}

struct PlotView1_Previews: PreviewProvider {
    static var previews: some View {
        PlotView1()
    }
}
