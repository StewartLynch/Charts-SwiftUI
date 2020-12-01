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
        case jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    }
    
    let month: Month
    let units: Double
    let transaction: Double
    let year: Int
    
    static func UnitsFor(_ sales: [Sale], year: Int) -> [BarChartDataEntry] {
        let yearlySales = sales.filter{$0.year == year}
        return yearlySales.map { BarChartDataEntry(x: $0.month.rawValue, y: $0.units)}
    }
    
    static func TransactionsFor(_ sales: [Sale], year: Int) -> [ChartDataEntry] {
        let yearlySales = sales.filter{$0.year == year}
        return yearlySales.map { ChartDataEntry(x: Double($0.month.rawValue), y: $0.transaction)}
    }
    
    static var months =  ["Jan","Feb","Mar","Apr","May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
 
    static var allSales: [Sale] {
        [
            Sale(month: .jan, units: 50, transaction: 2500, year: 2019),
            Sale(month: .feb, units: 100, transaction: 5000, year: 2019),
            Sale(month: .mar, units: 30, transaction: 1500, year: 2019),
            Sale(month: .apr, units: 110, transaction: 5100, year: 2019),
            Sale(month: .may, units: 90, transaction: 4200, year: 2019),
            Sale(month: .jun, units: 150, transaction: 7500, year: 2019),
            Sale(month: .jul, units: 25, transaction: 1250, year: 2019),
            Sale(month: .aug, units: 200, transaction: 9000, year: 2019),
            Sale(month: .sep, units: 15, transaction: 750, year: 2019),
            Sale(month: .oct, units: 200, transaction: 6000, year: 2019),
            Sale(month: .nov, units: 45, transaction: 2100, year: 2019),
            Sale(month: .dec, units: 100, transaction: 6000, year: 2019),
            Sale(month: .jan, units: 100, transaction: 2500, year: 2020),
            Sale(month: .feb, units: 100, transaction: 5000, year: 2020),
            Sale(month: .mar, units: 100, transaction: 1500, year: 2020),
            Sale(month: .apr, units: 100, transaction: 5100, year: 2020),
            Sale(month: .may, units: 100, transaction: 4200, year: 2020),
            Sale(month: .jun, units: 100, transaction: 7500, year: 2020),
            Sale(month: .jul, units: 100, transaction: 2500, year: 2020),
            Sale(month: .aug, units: 100, transaction: 5000, year: 2020),
            Sale(month: .sep, units: 100, transaction: 1500, year: 2020),
            Sale(month: .oct, units: 100, transaction: 5100, year: 2020),
            Sale(month: .nov, units: 100, transaction: 4200, year: 2020),
            Sale(month: .dec, units: 100, transaction: 7500, year: 2020)
        ]
    }
    
}
