//
//  BarChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import Charts
import Foundation

struct Transaction {
    enum ItemType {
        case itemIn, itemOut, none
    }
    var year: Int
    var month: Double
    var quantity: Double
    var itemType: ItemType

    static var selectedItem = Transaction(year: 2020, month: -1, quantity: -1, itemType: .none)
    static func initialItem(year: Int) -> Transaction {
        Transaction(year: year, month: -1, quantity: -1, itemType: .none)
    }
    static var monthArray = ["Jan","Feb","Mar","Apr","May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    static func transactionsForYear(_ year: Int, transactions: [Transaction], itemType:ItemType = .itemIn) -> [BarChartDataEntry] {
        let yearData = transactions.filter{$0.year == year && $0.itemType == itemType}
        return yearData.map{BarChartDataEntry(x: $0.month, y: $0.quantity * (itemType == ItemType.itemOut ? -1 : 1))}
    }

    static func lineChartDataForYear(_ year: Int, transactions: [Transaction], itemType:ItemType = .itemIn) -> [ChartDataEntry] {
        let yearData = transactions.filter{$0.year == year && $0.itemType == itemType}
        return yearData.map{BarChartDataEntry(x: $0.month, y: $0.quantity)}
    }

    static var allTransactions:[Transaction] {
        [
            Transaction(year: 2019, month: 0, quantity: 86, itemType: .itemIn),
            Transaction(year: 2019, month: 1, quantity: 15, itemType: .itemIn),
            Transaction(year: 2019, month: 2, quantity: 50, itemType: .itemIn),
            Transaction(year: 2019, month: 3, quantity: 62, itemType: .itemIn),
            Transaction(year: 2019, month: 4, quantity: 20, itemType: .itemIn),
            Transaction(year: 2019, month: 5, quantity: 19, itemType: .itemIn),
            Transaction(year: 2019, month: 6, quantity: 71, itemType: .itemIn),
            Transaction(year: 2019, month: 7, quantity: 52, itemType: .itemIn),
            Transaction(year: 2019, month: 8, quantity: 33, itemType: .itemIn),
            Transaction(year: 2019, month: 9, quantity: 75, itemType: .itemIn),
            Transaction(year: 2019, month: 10, quantity: 20, itemType:.itemIn),
            Transaction(year: 2019, month: 11, quantity: 90, itemType:.itemIn),
            Transaction(year: 2019, month: 0, quantity: 23, itemType: .itemOut),
            Transaction(year: 2019, month: 1, quantity: 45, itemType: .itemOut),
            Transaction(year: 2019, month: 2, quantity: 20, itemType: .itemOut),
            Transaction(year: 2019, month: 3, quantity: 32, itemType: .itemOut),
            Transaction(year: 2019, month: 4, quantity: 30, itemType: .itemOut),
            Transaction(year: 2019, month: 5, quantity: 29, itemType: .itemOut),
            Transaction(year: 2019, month: 6, quantity: 61, itemType: .itemOut),
            Transaction(year: 2019, month: 7, quantity: 12, itemType: .itemOut),
            Transaction(year: 2019, month: 8, quantity: 23, itemType: .itemOut),
            Transaction(year: 2019, month: 9, quantity: 65, itemType: .itemOut),
            Transaction(year: 2019, month: 10, quantity: 30, itemType:.itemOut),
            Transaction(year: 2019, month: 11, quantity: 80, itemType:.itemOut),

            Transaction(year: 2020, month: 0, quantity: 24, itemType: .itemIn),
            Transaction(year: 2020, month: 1, quantity: 65, itemType: .itemIn),
            Transaction(year: 2020, month: 2, quantity: 0, itemType: .itemIn),
            Transaction(year: 2020, month: 3, quantity: 33, itemType: .itemIn),
            Transaction(year: 2020, month: 4, quantity: 42, itemType: .itemIn),
            Transaction(year: 2020, month: 5, quantity: 5, itemType: .itemIn),
            Transaction(year: 2020, month: 6, quantity: 80, itemType: .itemIn),
            Transaction(year: 2020, month: 7, quantity: 26, itemType: .itemIn),
            Transaction(year: 2020, month: 8, quantity: 0, itemType: .itemIn),
            Transaction(year: 2020, month: 9, quantity: 0, itemType: .itemIn),
            Transaction(year: 2020, month: 10, quantity: 0, itemType:.itemIn),
            Transaction(year: 2020, month: 11, quantity: 0, itemType:.itemIn),
            Transaction(year: 2020, month: 0, quantity: 15, itemType: .itemOut),
            Transaction(year: 2020, month: 1, quantity: 28, itemType: .itemOut),
            Transaction(year: 2020, month: 2, quantity: 18, itemType: .itemOut),
            Transaction(year: 2020, month: 3, quantity: 12, itemType: .itemOut),
            Transaction(year: 2020, month: 4, quantity: 0, itemType: .itemOut),
            Transaction(year: 2020, month: 5, quantity: 29, itemType: .itemOut),
            Transaction(year: 2020, month: 6, quantity: 61, itemType: .itemOut),
            Transaction(year: 2020, month: 7, quantity: 12, itemType: .itemOut),
            Transaction(year: 2020, month: 8, quantity: 0, itemType: .itemOut),
            Transaction(year: 2020, month: 9, quantity: 0, itemType: .itemOut),
            Transaction(year: 2020, month: 10, quantity: 0, itemType:.itemOut),
            Transaction(year: 2020, month: 11, quantity: 0, itemType:.itemOut),
        ]
    }

}
