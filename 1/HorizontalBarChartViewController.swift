//
//  HorizontalBarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Keshav Aggarwal on 14/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit
import Charts

class HorizontalBarChartViewController: UIViewController {
    
    
    @IBOutlet weak var barChartView: HorizontalBarChartView!
    
    var activities: [String]!
    var below18Activities: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()

        activities = ["Resting", "Walking", "Watching TV", "News", "Music", "Radio", "Gaming", "Board games", "Childcare", "Sports", "Working", "Studying", "Relations", "Exercising", "Eating", "Reading", "Cooking", "Praying", "Chatting", "Email", "Surfing net", "With family", "With friends", "Shopping", "Household", "Travelling", "Other"]
        
        let focusLevels = [20.0, 40.0, 60.0, 30.0, 75.0, 80.0, 30.0, 78.0, 25.0, 40.0, 50.0, 44.0, 70.0, 80.0, 20.0, 30.0, 55.0, 35.0, 71.0, 90.0, 20.0, 25.0, 30.0, 50.0, 82.0, 80.0, 50.0]
        
        below18Activities = ["Resting", "Walking", "Watching TV", "News", "Music", "Radiot", "Gaming", "Board games", "Childcare", "Sports", "Working", "Studying", "Exercising", "Eating", "Reading", "Cooking", "Praying", "Chatting", "Email", "Surfing net", "With family", "With friends", "Shopping", "Household", "Travelling", "Other"]
        
        setChart(activities, values: focusLevels)
    }
    
    @IBAction func saveChart(sender: UIBarButtonItem) {
        barChartView.saveToCameraRoll()
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.backgroundColor = UIColor(red: 240/255, green: 242/255, blue: 243/255, alpha: 1)
        
        barChartView.noDataText = "You don't have enough data for the graph."
        
        barChartView.xAxis.labelPosition = .Bottom
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Your Focus")
        let chartData = BarChartData(xVals: activities, dataSet: chartDataSet)
        barChartView.data = chartData
        
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
    }

}
