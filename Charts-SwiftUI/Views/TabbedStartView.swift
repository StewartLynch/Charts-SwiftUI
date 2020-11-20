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
                    Image(systemName: "chart.bar.fill")
                    Text("Bar Chart")
                }

            GroupedBCView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Bar Chart2")
                }
            PCView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Pie Chart")
                }
        }
    }
}

struct TabbedStartView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedStartView()
    }
}
