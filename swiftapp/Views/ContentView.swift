//
//  ContentView.swift
//  swiftapp
//
//  Created by user230926 on 12/31/22.
//

import SwiftUI
import CoreData
import Alamofire
import UserNotifications

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.value, order: .reverse)]) var income: FetchedResults<Income>
    
    @State private var showingAddView = false
    @State private var showingSubView = false
    @State private var showingPlotView = false
    @State private var showingPlotView1 = false
    @State var plneur: Double = 0.00
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                Text("Bilans konta \(Double(incomeSum()), specifier: "%.2f") zl \(Double(incomeSum()/plneur), specifier: "%.2f") €")
                    .padding([.horizontal])
                Text("Kurs euro \(Double(plneur), specifier: "%.2f") zl")
                    .padding([.horizontal])
                List {
                    ForEach(income) { income in
                        NavigationLink(destination: EditIncomeView(income: income)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(income.name!)
                                        .bold()
        
                                    Text("\(Double(income.value), specifier: "%.2f") zl \(Double(income.value/plneur), specifier: "%.2f") €")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteIncome)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Historia operacji")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Dodaj wydatek", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddIncomeView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSubView.toggle()
                    } label: {
                        Label("Dodaj wydatek", systemImage: "minus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    //EditButton()
                }
            }
            .sheet(isPresented: $showingSubView) {
                AddOutcomeView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingPlotView1.toggle()
                    } label: {
                        Label("Wykres1", systemImage: "note")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    //EditButton()
                }
            }
            .sheet(isPresented: $showingPlotView1) {
                PlotView1()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingPlotView.toggle()
                    } label: {
                        Label("Wykres", systemImage: "note")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    //EditButton()
                }
            }
            .sheet(isPresented: $showingPlotView) {
                PlotView()
            }
            
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteIncome(offsets: IndexSet) {
        withAnimation {
            offsets.map { income[$0] }
            .forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    private func incomeSum() -> Double {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        {scucess, error in}
        let content = UNMutableNotificationContent()
        content.title="Aktualny kurs walut"
        content.subtitle = "Euro " + String(plneur) + " zl"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (10), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: (120), repeats: true)
        let request1 = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger1)
        UNUserNotificationCenter.current().add(request)
        UNUserNotificationCenter.current().add(request1)
        plnToEur()
        var incomeSum : Double = 0
        for item in income {
            incomeSum += item.value
            
        }
        return incomeSum
    }
    
    private func plnToEur() {
        AF.request("https://api.exchangerate.host/latest", method: .get).responseJSON {response in
            let json = response.value as! NSDictionary
            let rates = json["rates"] as! NSDictionary
            plneur = rates["PLN"] as! Double
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
