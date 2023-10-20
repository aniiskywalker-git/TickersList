//
//  TickerDetail.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 17/10/23.
//

import UIKit
import Charts
import DGCharts


final class TickerDetailsViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    private var viewModel: TickerDetailsViewModel!
    
    static func create(with viewModel: TickerDetailsViewModel) -> TickerDetailsViewController {
        let view = TickerDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    @IBOutlet weak var ChartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lineChartEntries = [
                ChartDataEntry(x: 1, y: 2),
                ChartDataEntry(x: 2, y: 4),
                ChartDataEntry(x: 3, y: 3),
            ]
            let dataSet = LineChartDataSet(entries: lineChartEntries)
            let data = LineChartData(dataSet: dataSet)
            let chart = LineChartView()
            chart.data = data
            
            ChartView.addSubview(chart)
        
    }
}
