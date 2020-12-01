//
//  GroupedBCView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import SwiftUI
import Charts

struct GroupedBCView: View {
    @State private var selectedItem:Transaction = Transaction.initialItem(year: 2019)
    var body: some View {
        VStack {
            Text("Wine In and Out")
                .font(.title)
            Picker(selection: $selectedItem.year, label: Text("Year"), content: {
                Text("2019").tag(2019)
                Text("2020").tag(2020)
            })
            .pickerStyle(SegmentedPickerStyle())
            GroupedBarChart(selectedItem: $selectedItem,
                            entriesIn: Transaction.transactionsForYear(selectedItem.year, transactions: Transaction.allTransactions, itemType: .itemIn),
                            entriesOut: Transaction.transactionsForYear(selectedItem.year, transactions: Transaction.allTransactions, itemType: .itemOut))
                .frame(height: 400)
            if selectedItem.month != -1 {
                Text("\(selectedItem.itemType == .itemIn ? "Purchased " : "Consumed ") \(abs(Int(selectedItem.quantity))) wines in \(Transaction.monthArray[Int(selectedItem.month)])")
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

struct GroupedBCView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedBCView()
    }
}
