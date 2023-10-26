//
//  ChartSwiftUIView.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 20/10/23.
//

import SwiftUI
import Charts

/*struct LineChartWithLabels: View {
    @ObservedObject var viewModelWrapper: MoviesQueryListViewModelWrapper

    var body: some View {
        VStack {
            ForEach(metric.data) { data in
                                if metric.source == "youtube" {
                                    BarMark(x: .value("Date", data.date, unit: .day),
                                            y: .value("Views", data.views))
                                } else {
                                    LineMark(x: .value("Date", data.date, unit: .day),
                                             y: .value("Views", data.views))
                                }
                            }
                            .foregroundStyle(by: .value("Axis", metric.source))
        }
    }
}

struct LineChartWithLabels_Previews: PreviewProvider {
    static var previews: some View {
        LineChartWithLabels()
    }
}

@available(iOS 13.0, *)
final class ChartDataSetWrapper: ObservableObject {
    @Published var dataSetSelected: [Double] = []
}*/
