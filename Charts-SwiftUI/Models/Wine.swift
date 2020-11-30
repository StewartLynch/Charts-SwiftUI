//
//  SamplePieChartData.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//

import Charts
import Foundation

struct Wine {
    enum Category: String {
        case variety, winery
    }
    var category: Category
    var value:Double
    var label:String

    static func winesForCategory(_ category: Category, wines: [Wine]) -> [PieChartDataEntry] {
        let requestedEntries =  wines.filter{$0.category == category}
        return requestedEntries.map{PieChartDataEntry(value: $0.value, label: $0.label)}
    }

    static var allWines:[Wine] {
        [
            Wine(category: .variety, value: 6, label: "Chardonnay"),
            Wine(category: .variety, value: 2, label: "Merlot"),
            Wine(category: .variety, value: 5, label: "Pinot Gris"),
            Wine(category: .variety, value: 7, label: "Gewürtztraminer"),
            Wine(category: .variety, value: 12, label: "Red Blend"),
            Wine(category: .variety, value: 10, label: "White Blend"),
            Wine(category: .variety, value: 3, label: "Sauvingnon Blanc"),
            Wine(category: .variety, value: 6, label: "Cabernet Franc"),
            Wine(category: .winery, value: 5, label: "Sumac Ridge"),
            Wine(category: .winery, value: 8, label: "Mission Hill"),
            Wine(category: .winery, value: 5, label: "50th Parallel"),
            Wine(category: .winery, value: 6, label: "Quails Gate"),
            Wine(category: .winery, value: 3, label: "Tumbler Ridge"),
            Wine(category: .winery, value: 12, label: "Moraine"),
            Wine(category: .winery, value: 18, label: "Tantalus")
        ]
    }
}

