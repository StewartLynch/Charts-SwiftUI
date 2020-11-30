//
//  CombinedChartView.swift
//  Charts-SwiftUI
//
//  Created by Stewart Lynch on 2020-11-29.
//

import SwiftUI

struct CombinedChrtView: View {
    var body: some View {
        CombinedChart(barEntries: Sale.UnitsFor(Sale.allSales), lineEntries: Sale.TransactionsFor(Sale.allSales))
            .frame(height: 500)
    }
}

struct CombinedChrtView_Previews: PreviewProvider {
    static var previews: some View {
        CombinedChrtView()
    }
}
