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
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var latestCloseLabel: UILabel!
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockAcronymLabel: UILabel!
    @IBOutlet weak var stockCountryLabel: UILabel!
    @IBOutlet weak var chartContainer: UIView!
    
    @IBOutlet weak var openValueLabel: UILabel!
    @IBOutlet weak var closeValueLabel: UILabel!
    @IBOutlet weak var highValueLabel: UILabel!
    @IBOutlet weak var lowValueLabel: UILabel!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pullDownButton: UIButton!
    @IBOutlet weak var pickerView: UIMenu!
    
    private let chart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        LoadingView.show()
        viewModel.didGetTickerDetail()
        bind(to: viewModel)
        createMenuForPullDownButton()
    }
    
    private func createMenuForPullDownButton() {
        let menu = UIMenu(title: "Tap to change metrics", children: [
            UIAction(title: "Open", handler: { [weak self] _ in
                self?.viewModel.didSelectMetrics(dataSetSelected: DataSet.open)
            }),
            UIAction(title: "Close", handler: { [weak self] _ in
                self?.viewModel.didSelectMetrics(dataSetSelected: DataSet.close)
            }),
            UIAction(title: "High", handler: { [weak self] _ in
                self?.viewModel.didSelectMetrics(dataSetSelected: DataSet.high)
            }),
            UIAction(title: "Low", handler: { [weak self] _ in
                self?.viewModel.didSelectMetrics(dataSetSelected: DataSet.low)
            }),
            UIAction(title: "Volume", handler: { [weak self] _ in
                self?.viewModel.didSelectMetrics(dataSetSelected: DataSet.volume)
            })
        ])
        pullDownButton.showsMenuAsPrimaryAction = true
        pullDownButton.menu = menu
    }
    
    private func bind(to viewModel: TickerDetailsViewModel) {
        //To bind updates, changes, errors
        viewModel.itemDetail.observe(on: self) { [weak self] _ in self?.getEodITems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.graphicDataSet.observe(on: self) { [weak self] _ in self?.generateGraph() }
    }
    
    private func setupViews() {
        title = viewModel.tickerSymbol
        nameLabel.text = viewModel.tickerName
        symbolLabel.text = viewModel.tickerSymbol
        latestCloseLabel.text = ""
        stockNameLabel.text = viewModel.tickerStockName
        stockAcronymLabel.text = viewModel.tickerStockAcronym
        stockCountryLabel.text = viewModel.tickerStockCountry
        
        openValueLabel.text = "Open: N/A"
        closeValueLabel.text = "Close: N/A"
        highValueLabel.text = "High: N/A"
        lowValueLabel.text = "Low: N/A"
        volumeValueLabel.text = "Volume: N/A"
        dateLabel.text = "N/A"
        
        chart.frame = chartContainer.frame
        chartContainer.addSubview(chart)
    }
    
    private func getEodITems() {
        LoadingView.hide()
        guard let firstItemValue = viewModel.itemDetail.value.first else { return }
        
        if let openValue = firstItemValue.open, let closeValue = firstItemValue.close, let highValue = firstItemValue.high, let lowValue = firstItemValue.low, let volume = firstItemValue.volume {
            self.latestCloseLabel.textColor = closeValue > 0 ? .green : .red
            self.latestCloseLabel.text = "Closed \(closeValue)"
            
            self.openValueLabel.textColor = openValue > 0 ? .green : .red
            self.closeValueLabel.textColor = closeValue > 0 ? .green : .red
            self.highValueLabel.textColor = highValue > 0 ? .green : .red
            self.lowValueLabel.textColor = lowValue > 0 ? .green : .red
            
            self.openValueLabel.text = "Open: \(openValue)"
            self.closeValueLabel.text = "Close: \(closeValue)"
            self.highValueLabel.text = "High: \(highValue)"
            self.lowValueLabel.text = "Low: \(lowValue)"
            self.volumeValueLabel.text = "Volume: \(volume)"
            self.dateLabel.text = firstItemValue.date
        }
        //to setup an initial value
        generateGraph()
    }
    
    private func generateGraph() {
        let dataSetSelected = viewModel.graphicDataSet.value.isEmpty 
                              ? "Open" :
                              viewModel.graphicDataSet.value.keys.first ?? ""
        
        let setDataSet = viewModel.graphicDataSet.value.isEmpty
                             ? viewModel.itemDetail.value.map { $0.open ?? 0.0 }
                             : viewModel.graphicDataSet.value[dataSetSelected] ?? []
        
        
        
        var lineChartEntries: [ChartDataEntry] = []
        
        for (index, value) in setDataSet.enumerated() {
            lineChartEntries.append(ChartDataEntry(x: Double(index), y: value))
        }
        
        let dataSet = LineChartDataSet(entries: lineChartEntries, label: dataSetSelected)
        dataSet.mode = .cubicBezier
        dataSet.setColor(NSUIColor.green)
        dataSet.drawCirclesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.data = data
    }
    
    private func showError(_ error: String) {
        LoadingView.hide()
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
}
