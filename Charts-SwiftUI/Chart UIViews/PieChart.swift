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


    func configureChart(_ pieChart: PieChartView) {
        pieChart.rotationEnabled = false
        pieChart.animate(yAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
    }
    
    static func setCenterText(_ text: String) -> NSAttributedString{
        let font = UIFont.systemFont(ofSize: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.label,
            .paragraphStyle: paragraphStyle
        ]
        let centerText = NSAttributedString(string: text, attributes: attributes)
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


    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
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
