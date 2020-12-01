//
//  CombinedChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-29.
//

import Charts
import SwiftUI

struct CombinedChart: UIViewRepresentable {
    var barEntries : [BarChartDataEntry]
    var lineEntries : [ChartDataEntry]
    @Binding var year: Int
    let combinedChart = CombinedChartView()
    func makeUIView(context: Context) -> CombinedChartView {
        return combinedChart
    }
    
    func updateUIView(_ uiView: CombinedChartView, context: Context) {
        setChartData(uiView)
        formatXAxis(uiView.xAxis)
        formatLeftAxis(uiView.leftAxis)
        formatRightAxis(uiView.rightAxis)
        configureChart(uiView)
        uiView.notifyDataSetChanged()
    }
    func configureChart(_ combinedChart: CombinedChartView) {
        combinedChart.drawValueAboveBarEnabled = false
        combinedChart.setScaleEnabled(false)
        combinedChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .linear)
    }
    
    func setChartData(_ combinedChart: CombinedChartView) {
        let barDataSet = BarChartDataSet(entries: barEntries)
        let barChartData = BarChartData(dataSet: barDataSet)
        let lineDataSet = LineChartDataSet(entries: lineEntries)
        let lineChartData = LineChartData(dataSet: lineDataSet)
        let data = CombinedChartData()
        data.lineData = lineChartData
        data.barData = barChartData
        combinedChart.data = data
        formatLineChartDataSet(lineDataSet)
        formatBarChartDataSet(barDataSet)
    }
    func formatXAxis(_ xAxis: XAxis) {
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5
        xAxis.axisMaximum = 11.5
        xAxis.granularity = 1
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Sale.months)
        xAxis.labelTextColor =  UIColor.label
    }

    func formatLeftAxis(_ leftAxis: YAxis) {
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = (barEntries.map{$0.y}.max() ?? 0) + 20
        leftAxis.labelTextColor =  .red
    }

    func formatRightAxis(_ rightAxis: YAxis) {
        let rightAxisFormatter = NumberFormatter()
        rightAxisFormatter.numberStyle = .none
        rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: rightAxisFormatter)
        rightAxis.axisMinimum = 0
        rightAxis.axisMaximum = (lineEntries.map{$0.y}.max() ?? 0) + 150
        rightAxis.labelTextColor =  .red
    }

    func formatLineChartDataSet(_ lineDataSet: LineChartDataSet) {
        lineDataSet.label = "Revenue"
        lineDataSet.setColor(.systemIndigo)
        lineDataSet.lineWidth = 2.5
        lineDataSet.setCircleColor(.systemIndigo)
        lineDataSet.circleRadius = 5
        lineDataSet.circleHoleRadius = 0
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .systemIndigo
        lineDataSet.axisDependency = .right
    }

    func formatBarChartDataSet( _ barDataSet: BarChartDataSet) {
        barDataSet.label = "Units Sold"
        barDataSet.colors = [UIColor.systemPurple]
        barDataSet.valueTextColor = UIColor.white
        barDataSet.valueFont = .boldSystemFont(ofSize: 10)
        barDataSet.axisDependency = .left
    }
}



struct CombinedChart_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChart(barEntries: Sale.UnitsFor(Sale.allSales, year: 2019), lineEntries: Sale.TransactionsFor(Sale.allSales, year: 2019), year: .constant(2019))
    }
}
