//
//  PieChart.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-19.
//
import Charts
import SwiftUI

struct PieChart: UIViewRepresentable {
    var entries: [PieChartDataEntry]
    let pieChart = PieChartView()
    @Binding var category: Wine.Category
    var descriptionText:String
    var defaultCenterText: String {
        category.rawValue.capitalized
    }

    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = ChartColorTemplates.colorful()
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        configureChart(uiView)
        formatCenter(uiView)
        formatDescription(description: uiView.chartDescription)
        formatLegend(legend: uiView.legend)
        formatDataSet(dataSet: dataSet)
        uiView.notifyDataSetChanged()
    }

    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChart
        init(parent: PieChart) {
            self.parent = parent
        }

        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let lableText = (entry.value(forKey: "label")! as! String)
            let numText =  Int(entry.value(forKey: "value")! as! Double)
            parent.pieChart.centerAttributedText = setCenterText("""
\(lableText)
\(numText) bottles.
""")
        }
    }

    func configureChart(_ pieChart: PieChartView) {
        pieChart.rotationEnabled = false
        pieChart.animate(yAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    static func setCenterText(_ text: String) -> NSAttributedString{
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        let centerText = NSMutableAttributedString(string: text)
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 17)!,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
        return centerText
    }

    func formatCenter(_ pieChart: PieChartView) {
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerTextRadiusPercent = 0.95
        pieChart.centerAttributedText = PieChart.setCenterText(defaultCenterText)
    }

    func formatDescription(description: Description) {
        description.text = descriptionText
        description.font = UIFont.boldSystemFont(ofSize: 17)
    }

    func formatDataSet(dataSet: ChartDataSet) {
        dataSet.drawValuesEnabled = false
    }
    func formatLegend(legend: Legend) {
        legend.enabled = false
    }
    
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(entries: Wine.winesForCategory(.variety,
                                                wines: Wine.allWines),
                 category: .constant(.variety),
                 descriptionText: "Variety")
            .frame(height: 400)
            .padding(.horizontal)

    }
}
