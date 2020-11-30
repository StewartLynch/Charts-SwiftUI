//
//  TabbedStartView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-20.
//

import SwiftUI

struct TabbedStartView: View {
    var body: some View {
        TabView {
            BCView()
                .tabItem {
                    Image("BarChart")
                    Text("Bar Chart")
                }

            GroupedBCView()
                .tabItem {
                    Image("Grouped")
                    Text("Grouped Bar Chart")
                }
            PCView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Pie Chart")
                }
            LineChrtView()
                .tabItem {
                    Image("StackedLine")
                    Text("Stacked Line Chart")
                }
            CombinedChrtView()
                .tabItem {
                    Image("StackedBarLine")
                    Text("Bar + Line Chart")
                }
        }
    }
}

struct TabbedStartView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedStartView()
    }
}
