//
//  RelatedVideoTableViewController.swift
//  NewShinple
//
//  Created by 혜빈 on 31/08/2019.
//  Copyright © 2019 veronica. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RelatedVideoTableViewController: UITableViewController, UISearchBarDelegate, UITextViewDelegate {
    
    
    //---------- 공통 color ----------//
    
    let colorStartBlue = UIColor(red: 15/255, green: 83/255, blue: 163/255, alpha: 1)
    let colorMiddleBlue = UIColor(red: 20/255, green: 123/255, blue: 195/255, alpha: 1)
    let colorEndBlue = UIColor(red: 27/255, green: 164/255, blue: 227/255, alpha: 1)
    let colorLightGray = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    
    
    //---------- 샘플 Data ----------//
    
    var titles:[String] = ["제1강. 장애인식개선교육 '버디&키디'",
                           "제2강. 장애인식개선교육 '버디&키디'",
                           "제3강. 장애인식개선교육 '버디&키디'",
                           "제4강. 장애인식개선교육 '버디&키디'",
                           "제5강. 장애인식개선교육 '버디&키디'"]
    var imgurls:[URL] = [URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Info/image/Chap1.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Info/image/Chap2.png")!,
                         URL(string: "hhttps://shinpleios.s3.us-east-2.amazonaws.com/Duty/Info/image/Chap3.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Info/image/Chap1.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Info/image/Chap2.png")!]
    
    var videoRates:[Float] = [1, 0.3, 0, 0, 0]
    var contents:[String] = ["우리나라 등록장애인 현황과 세계 장애",
                             "장애인 인권과 관련된 법과 제도의 이해",
                             "장애인과의 소통을 위한 에티켓",
                             "리어프리(BF)와 유니버설디자인(UD)의 이해",
                             "교육진행방법과 실적보고과정의 이해"]
    var videoTimes:[Int] = [3300, 2000, 5200, 2500, 6030]
    var favorites:[Bool] = [false, false, false, false, false]
    
    let heartEmpty = UIImage(named: "heart_empty.png")
    let heartFill = UIImage(named: "heart_fill.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imgurls.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! RelatedVideoTableViewCell
        
        cell.lblTitle.text = titles[row]
        cell.lblContent.text = contents[row]
        
        cell.imgVideo.downloadImage(from: imgurls[row])
        cell.imgVideo.translatesAutoresizingMaskIntoConstraints = true
        
        if favorites[row] == true {
            cell.btnFavorite.setImage(heartFill, for: .normal)
        }
        cell.btnFavorite.addTarget(self, action: #selector(setFavorite(_:)), for: .touchUpInside)
        cell.sliderTime.setValue(videoRates[row], animated: false)
        
        cell.lblVideoTime.text = timeIntToString(from: videoTimes[row])
        
        return cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gotovideodetail: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoDetailSID")
        
        self.present(gotovideodetail, animated: true, completion: nil)
    }
    
    
    //---------- 좋아요 클릭/해제 ----------//
    @objc func setFavorite(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "heart_fill.png") {
            sender.setImage(heartEmpty, for: .normal)
        } else if sender.currentImage == UIImage(named: "heart_empty.png") {
            sender.setImage(heartFill, for: .normal)
        }
    }
    
    func timeIntToString(from time: Int) -> String {
        
        let totalSeconds = time
        let hours = Int(totalSeconds / 3600 )
        let minutes = Int(totalSeconds % 3600) / 60
        let seconds = Int(totalSeconds % 3600) % 60
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours, minutes, seconds])
        }else{
            return String(format: "%02i:%02i", arguments: [minutes, seconds])
        }
    }
    
}

extension RelatedVideoTableViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripViewController: PagerTabStripViewController)->IndicatorInfo {
        return IndicatorInfo(title: "강의 목록")
    }
}
