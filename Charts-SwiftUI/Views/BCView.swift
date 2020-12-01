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
            Text("\(selectedItem.year)".replacingOccurrences(of: ",", with: ""))
                .font(.title2)
            Button("Change Year") {
                selectedItem.year = (selectedItem.year) == 2020 ? 2019 : 2020
                selectedItem.month = -1
            }
            BarChart(selectedItem: $selectedItem,
                     entries: Transaction.transactionsForYear(selectedItem.year,
                                                              transactions: Transaction.allTransactions))
                
                .frame(height: 300)
            if selectedItem.month != -1 {
                Text("\(Int(selectedItem.quantity)) for \(Transaction.monthArray[Int(selectedItem.month)])")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BCView()
    }
}
