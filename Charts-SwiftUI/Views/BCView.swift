//
//  ContentView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import SwiftUI
import Charts

struct BCView: View {

    @State private var selectedItem:Transaction = Transaction.initialItem(year: 2019)
    var body: some View {
        VStack {
            Text("My Wine Consumption")
                .font(.title)
            Picker(selection: $selectedItem.year, label: Text("Year"), content: {
                Text("2019").tag(2019)
                Text("2020").tag(2020)
            })
            .pickerStyle(SegmentedPickerStyle())
            BarChart(selectedItem: $selectedItem,
                     entries: Transaction.transactionsForYear(selectedItem.year,
                                                              transactions: Transaction.allTransactions))
                
                .frame(height: 300)
            if selectedItem.month != -1 {
                Text("\(Int(selectedItem.quantity)) for \(Transaction.monthArray[Int(selectedItem.month)])")
            } else {
                Text(" ")
            }
            VStack {
                Text("Swipe from right to see more months.")
                Text("Tap on a bar to see detail.")
            }
                .font(.caption)
        }
        .onChange(of: selectedItem.year, perform: { value in
            selectedItem.month = -1
        })
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BCView()
    }
}
