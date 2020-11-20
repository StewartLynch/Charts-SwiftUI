//
//  SamplePieChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import Foundation

import Foundation
import Charts

struct SamplePieChartData {
    enum Category: String {
        case variety, winery
    }
    var category: Category
    var value:Double
    var label:String

    static func entriesForCategory(_ category: Category) -> [PieChartDataEntry] {
        let requestedEntries =  allData.filter{$0.category == category}
        return requestedEntries.map{PieChartDataEntry(value: $0.value, label: $0.label)}
    }

    static var allData:[SamplePieChartData] {
        [
            SamplePieChartData(category: .variety, value: 6, label: "Chardonnay"),
            SamplePieChartData(category: .variety, value: 2, label: "Merlot"),
            SamplePieChartData(category: .variety, value: 5, label: "Pinot Gris"),
            SamplePieChartData(category: .variety, value: 7, label: "Gewürtztraminer"),
            SamplePieChartData(category: .variety, value: 12, label: "Red Blend"),
            SamplePieChartData(category: .variety, value: 10, label: "White Blend"),
            SamplePieChartData(category: .variety, value: 3, label: "Sauvingnon Blanc"),
            SamplePieChartData(category: .variety, value: 6, label: "Cabernet Franc"),
            SamplePieChartData(category: .winery, value: 5, label: "Sumac Ridge"),
            SamplePieChartData(category: .winery, value: 8, label: "Mission Hill"),
            SamplePieChartData(category: .winery, value: 5, label: "50th Parallel"),
            SamplePieChartData(category: .winery, value: 6, label: "Quails Gate"),
            SamplePieChartData(category: .winery, value: 3, label: "Tumbler Ridge"),
            SamplePieChartData(category: .winery, value: 12, label: "Moraine"),
            SamplePieChartData(category: .winery, value: 18, label: "Tantalus")
        ]
    }
}

