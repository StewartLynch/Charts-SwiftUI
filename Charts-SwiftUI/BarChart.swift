//
//  BarChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-15.
//

import Charts
import SwiftUI

struct BarChart : UIViewRepresentable {
    var entries : [BarChartDataEntry]
    let chart = BarChartView()
    @Binding var selectedItem: SampleData
    func makeUIView(context: Context) -> BarChartView {
//        let chart = BarChartView()
        chart.delegate = context.coordinator
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        formatLegend(legend: uiView.legend)
        uiView.rightAxis.enabled = false
        uiView.setScaleEnabled(false)
        if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }
        uiView.noDataText = "No Data"
        let dataSet = BarChartDataSet(entries: entries, label: "My Bars")
        uiView.data = updateData(dataSet: dataSet)
//        uiView.fitBars = true
        formatXAxis(xAxis: uiView.xAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatDataSet(dataSet: dataSet)
        uiView.notifyDataSetChanged()
        if selectedItem.month == -1 {
            uiView.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .linear)
            uiView.highlightValue(nil, callDelegate: false)
        }
        
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: BarChart
        init(parent: BarChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            parent.selectedItem.month = entry.x
            parent.selectedItem.quantity = entry.y
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateData(dataSet: BarChartDataSet) -> BarChartData {
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.85
        return data
        
    }
    
    func formatDataSet(dataSet: BarChartDataSet) {
        let format = NumberFormatter()
        format.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: format)
        dataSet.highlightAlpha = 0.2
        dataSet.colors = [.red]
    }

    func formatLeftAxis(leftAxis:YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.granularity = 1
        leftAxis.labelTextColor =  .red
        leftAxis.drawGridLinesEnabled = true
        
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.drawGridLinesEnabled = true
        xAxis.labelPosition = .bottom
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .spellOut
        //        xaxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        xAxis.valueFormatter = IndexAxisValueFormatter(values:SampleData.monthArray)
        xAxis.labelTextColor =  .black
        xAxis.granularity = 0
    }
    
    func formatLegend(legend: Legend) {
        legend.textColor = UIColor.red
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 30.0
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(entries: SampleData.dataForYear(2020), selectedItem: .constant(SampleData.selectedItem))
    }
}


struct SampleData {
    var year: Int
    var month: Double
    var quantity: Double
    var barChartEntry: BarChartDataEntry {
        BarChartDataEntry(x: month, y: quantity)
    }
    static var selectedItem = SampleData(year: 2020, month: -1, quantity: -1)
    static func initialItem(year: Int) -> SampleData {
        SampleData(year: year, month: -1, quantity: -1)
    }
    static var monthArray = ["Jan","Feb","Mar","Apr","May","Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    static var mySamples:[SampleData] {
        [
            SampleData(year: 2019, month: 0, quantity: 86),
            SampleData(year: 2019, month: 1, quantity: 15),
            SampleData(year: 2019, month: 2, quantity: 50),
            SampleData(year: 2019, month: 3, quantity: 62),
            SampleData(year: 2019, month: 4, quantity: 20),
            SampleData(year: 2019, month: 5, quantity: 19),
            SampleData(year: 2019, month: 6, quantity: 71),
            SampleData(year: 2019, month: 7, quantity: 52),
            SampleData(year: 2019, month: 8, quantity: 33),
            SampleData(year: 2019, month: 9, quantity: 75),
            SampleData(year: 2019, month: 10, quantity: 20),
            SampleData(year: 2019, month: 11, quantity: 90),
            SampleData(year: 2020, month: 0, quantity: 43),
            SampleData(year: 2020, month: 1, quantity: 0),
            SampleData(year: 2020, month: 2, quantity: 22),
            SampleData(year: 2020, month: 3, quantity: 15),
            SampleData(year: 2020, month: 4, quantity: 88),
            SampleData(year: 2020, month: 5, quantity: 7),
            SampleData(year: 2020, month: 6, quantity: 0),
            SampleData(year: 2020, month: 7, quantity: 0),
            SampleData(year: 2020, month: 8, quantity: 0),
            SampleData(year: 2020, month: 9, quantity: 0),
            SampleData(year: 2020, month: 10, quantity: 0),
            SampleData(year: 2020, month: 11, quantity: 0)
        ]
    }
    
    static func dataForYear(_ year: Int) -> [BarChartDataEntry] {
        let yearData = SampleData.mySamples.filter{$0.year == year}
        return yearData.map{BarChartDataEntry(x: $0.month, y: $0.quantity)}
    }
}
