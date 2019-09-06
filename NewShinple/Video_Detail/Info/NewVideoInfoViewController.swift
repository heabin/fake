//
//  NewVideoInfoViewController.swift
//  NewShinple
//
//  Created by user on 02/09/2019.
//  Copyright © 2019 veronica. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NewVideoInfoViewController: UIViewController {
    
    @IBOutlet weak var lblVideoTitle: UILabel!
    @IBOutlet weak var tvVideoInfo: UITextView!
    @IBOutlet weak var lblUploadDate: UILabel!
    @IBOutlet weak var lblDueDate: UILabel!
    
    //var lecture:LECTURE = LECTURE()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblVideoTitle.text = "제2강. 장애인식개선교육 '버디&키디'"
        lblUploadDate.text = "2019/09/01"
        lblDueDate.text = "2019/09/30"
//        tvVideoInfo.text =
        
        tvVideoInfo.isEditable = false
        tvVideoInfo.isScrollEnabled = true
        resize(textView: tvVideoInfo)
        
    }
    
    fileprivate func resize(textView: UITextView) {
        var newFrame = textView.frame
        let width = newFrame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        newFrame.size = CGSize(width: width, height: newSize.height)
        textView.frame = newFrame
    }
}

extension NewVideoInfoViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripViewController: PagerTabStripViewController)->IndicatorInfo {
        return IndicatorInfo(title: "강의 정보")
    }
}

