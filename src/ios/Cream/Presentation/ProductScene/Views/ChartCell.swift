//
//  ChartCell.swift
//  Cream
//
//  Created by wankikim-MN on 2022/02/17.
//

import UIKit
import SnapKit
import Charts

class ChartCell: UICollectionViewCell {
    static let reuseIdentifier = "\(ChartCell.self)"
        
    private lazy var chartView: LineChartView = {
        let view = LineChartView()
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureChartView() {
        var entries = [ChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(ChartDataEntry(x:Double(x),
                                          y:Double(x)))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        
        chartView.data = data
    }
}

extension ChartCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(chartView)
    }
    
    func setupConstraints() {
        chartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func viewConfigure() {
        configureChartView()
    }
}

extension ChartCell: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}

