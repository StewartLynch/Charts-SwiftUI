//
//  Sale.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-29.
//

import Charts
import Foundation


struct Sale {
    enum Month:Double {
        case jan, feb, mar, apr, may, jun
    }
    
    let month: Month
    let units: Double
    let transaction: Double
    
    static func UnitsFor(_ sales: [Sale]) -> [BarChartDataEntry] {
        return sales.map { BarChartDataEntry(x: $0.month.rawValue, y: $0.units)}
    }
    
    static func TransactionsFor(_ sales: [Sale]) -> [ChartDataEntry] {
        return sales.map { BarChartDataEntry(x: Double($0.month.rawValue), y: $0.transaction)}
    }
    
    static var months =  ["Jan","Feb","Mar","Apr","May","Jun"]
 
    static var allSales: [Sale] {
        [
            Sale(month: .jan, units: 50, transaction: 2500),
            Sale(month: .feb, units: 100, transaction: 5000),
            Sale(month: .mar, units: 30, transaction: 1500),
            Sale(month: .apr, units: 110, transaction: 5100),
            Sale(month: .may, units: 90, transaction: 4200),
            Sale(month: .jun, units: 150, transaction: 7500)
        ]
    }
    
}
