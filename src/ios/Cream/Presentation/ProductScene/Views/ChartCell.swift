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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.text = "시세"
        return label
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["1개월","3개월","6개월","1년","전체"])
        segmentControl.backgroundColor = .systemBackground
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    private lazy var chartView: LineChartView = {
        let charView = LineChartView()
        
        charView.backgroundColor = .white
        charView.tintColor = .red
        charView.leftAxis.enabled = false
        charView.xAxis.enabled = false
        charView.doubleTapToZoomEnabled = false
        charView.xAxis.drawGridLinesEnabled = false
        charView.legend.enabled = false
        
        let yAxis = charView.rightAxis
        yAxis.labelFont = .systemFont(ofSize: 12)
        yAxis.labelTextColor = .systemGray2
        yAxis.axisLineColor = .clear
        yAxis.labelPosition = .outsideChart
        yAxis.setLabelCount(6, force: false)
        yAxis.axisMinimum = 0
        
        return charView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartCell: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(titleLabel,
                    segmentControl,
                    chartView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(15)
            $0.bottom.equalTo(segmentControl.snp.top).offset(-10)
        }
        segmentControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(chartView.snp.top).offset(-15)
        }
        chartView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(15)
        }
    }
    override func prepareForReuse() {
        segmentControl.isSelected = false
    }
}

extension ChartCell {
    func configure(with entries: [[ChartDataEntry]], period: Int = 4) {
        let entry = entries[period]
        let dataset = LineChartDataSet(entries: entry, label: nil)
        segmentControl.selectedSegmentIndex = period
        dataset.mode = .cubicBezier
        dataset.setColor(.red)
        dataset.setCircleColor(.red)
        dataset.circleHoleColor = .red
        dataset.setDrawHighlightIndicators(false)
        dataset.mode = .cubicBezier
        dataset.drawCirclesEnabled = false
        
        let data = LineChartData(dataSet: dataset)
        data.setValueTextColor(.red)
        data.setDrawValues(false)

        chartView.data = data
    }
}
