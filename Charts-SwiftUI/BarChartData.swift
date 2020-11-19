//
//  BarChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-18.
//

import Charts
import Foundation

struct SampleBarChartData {
    enum ItemType {
        case itemIn, itemOut, none
    }
    var year: Int
    var month: Double
    var quantity: Double
    var itemType: ItemType = .itemIn

    static var selectedItem = SampleBarChartData(year: 2020, month: -1, quantity: -1, itemType: .none)
    static func initialItem(year: Int) -> SampleBarChartData {
        SampleBarChartData(year: year, month: -1, quantity: -1, itemType: .none)
    }
    static var monthArray = ["Jan","Feb","Mar","Apr","May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    static func dataForYear(_ year: Int, itemType:ItemType = .itemIn) -> [BarChartDataEntry] {
        let yearData = SampleBarChartData.mySamples.filter{$0.year == year && $0.itemType == itemType}
        return yearData.map{BarChartDataEntry(x: $0.month, y: $0.quantity)}
    }

    static var mySamples:[SampleBarChartData] {
        [
            SampleBarChartData(year: 2019, month: 0, quantity: 86, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 1, quantity: 15, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 2, quantity: 50, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 3, quantity: 62, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 4, quantity: 20, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 5, quantity: 19, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 6, quantity: 71, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 7, quantity: 52, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 8, quantity: 33, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 9, quantity: 75, itemType: .itemIn),
            SampleBarChartData(year: 2019, month: 10, quantity: 20, itemType:.itemIn),
            SampleBarChartData(year: 2019, month: 11, quantity: 90, itemType:.itemIn),
            SampleBarChartData(year: 2020, month: 0, quantity: 23, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 1, quantity: 45, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 2, quantity: 20, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 3, quantity: 32, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 4, quantity: 30, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 5, quantity: 29, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 6, quantity: 61, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 7, quantity: 12, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 8, quantity: 23, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 9, quantity: 65, itemType: .itemOut),
            SampleBarChartData(year: 2019, month: 10, quantity: 30, itemType:.itemOut),
            SampleBarChartData(year: 2019, month: 11, quantity: 80, itemType:.itemOut),
            SampleBarChartData(year: 2020, month: 0, quantity: 63, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 1, quantity: 0, itemType: .itemIn),
            SampleBarChartData(year: 2020, month: 2, quantity: 22, itemType:.itemIn),
            SampleBarChartData(year: 2020, month: 3, quantity: 15, itemType:.itemIn),
            SampleBarChartData(year: 2020, month: 4, quantity: 88, itemType:.itemIn),
            SampleBarChartData(year: 2020, month: 5, quantity: 7, itemType: .itemIn),
            SampleBarChartData(year: 2020, month: 6, quantity: 0, itemType: .itemIn),
            SampleBarChartData(year: 2020, month: 7, quantity: 0, itemType: .itemIn),
            SampleBarChartData(year: 2020, month: 8, quantity: 0, itemType: .itemIn),
            SampleBarChartData(year: 2020, month: 9, quantity: 0, itemType: .itemIn),
            SampleBarChartData(year: 2020, month: 10, quantity: 0, itemType:.itemIn),
            SampleBarChartData(year: 2020, month: 11, quantity: 0, itemType:.itemIn),
            SampleBarChartData(year: 2020, month: 0, quantity: 33, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 1, quantity: 30, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 2, quantity: 12, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 3, quantity: 25, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 4, quantity: 48, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 5, quantity: 17, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 6, quantity: 3, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 7, quantity: 0, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 8, quantity: 0, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 9, quantity: 0, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 10, quantity: 0, itemType: .itemOut),
            SampleBarChartData(year: 2020, month: 11, quantity: 0, itemType: .itemOut)
        ]
    }

}
