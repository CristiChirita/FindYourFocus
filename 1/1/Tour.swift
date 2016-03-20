//
//  Tour.swift
//  1
//
//  Created by Keshav Aggarwal on 03/03/16.
//  Copyright © 2016 University College London. All rights reserved.
//

import UIKit

class Tour: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let V1: View1 = View1(nibName: "View1", bundle: nil)
        let V2: View2 = View2(nibName: "View2", bundle: nil)
        let V3: View3 = View3(nibName: "View3", bundle: nil)
        let V4: View4 = View4(nibName: "View4", bundle: nil)
        
        
        self.addChildViewController(V1)
        self.scrollView.addSubview(V1.view)
        V1.didMoveToParentViewController(self)
        
        self.addChildViewController(V2)
        self.scrollView.addSubview(V2.view)
        V2.didMoveToParentViewController(self)
        
        self.addChildViewController(V3)
        self.scrollView.addSubview(V3.view)
        V3.didMoveToParentViewController(self)
        
        self.addChildViewController(V4)
        self.scrollView.addSubview(V4.view)
        V4.didMoveToParentViewController(self)
        
        
        var V2Frame: CGRect = V1.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        var V3Frame: CGRect = V3.view.frame
        V3Frame.origin.x = 2 * self.view.frame.width
        V3.view.frame = V3Frame
        
        var V4Frame: CGRect = V4.view.frame
        V4Frame.origin.x = 3 * self.view.frame.width
        V4.view.frame = V4Frame
        
        let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 4, self.view.frame.size.height - navigationBarHeight)
    }
    
}
