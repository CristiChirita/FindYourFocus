//
//  HorizontalBarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Keshav Aggarwal on 14/03/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit
import Charts

class HorizontalBarChartViewController: UIViewController {
    
    
    @IBOutlet weak var barChartView: HorizontalBarChartView!
    
    var months: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
    }
    
    @IBAction func saveChart(sender: UIBarButtonItem) {
        barChartView.saveToCameraRoll()
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 243/255, alpha: 1)
        
        barChartView.noDataText = "You need to provide data for the chart."
        
        barChartView.xAxis.labelPosition = .Bottom
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
        
        barChartView.descriptionText = ""
        
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
//        let ll = ChartLimitLine(limit: 10.0, label: "Target")
//        barChartView.rightAxis.addLimitLine(ll)
    }

}
