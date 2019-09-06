//
//  EndTableViewController.swift
//  NewShinple
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 veronica. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class EndTableViewController: UITableViewController {
    
    
    //---------- 공통 color ----------//
    
    let colorStartBlue = UIColor(red: 15/255, green: 83/255, blue: 163/255, alpha: 1)
    let colorMiddleBlue = UIColor(red: 20/255, green: 123/255, blue: 195/255, alpha: 1)
    let colorEndBlue = UIColor(red: 27/255, green: 164/255, blue: 227/255, alpha: 1)
    let colorLightGray = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    
    let heartEmpty = UIImage(named: "heart_empty.png")
    let heartFill = UIImage(named: "heart_fill.png")
    
    var titles:[String] = ["제1강. 어서와 C언어는 처음이지!",
                           "제2강. 어서와 C언어는 처음이지!",
                           "제3강. 백종원의 요리비책",
                           "제2강. 모두가 함께하는 나침반 안전교육 시리즈",
                           "제1강. 장애인식개선교육 '버디&키디'",
                           "제3강. 장애인식개선교육 '버디&키디'"
                           
    ]
    var imgurls:[URL] = [URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Develop/C/image/Chap1.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Develop/C/image/Chap3.png")!,
    URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Culture/Cook/image/Chap1.png")!,
    URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Fire/image/Chap2.png")!,
    URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Disabled/image/Chap1.png")!,
    URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Duty/Disabled/image/Chap3.png")!]
    
    var videoRates:[Float] = [1,1,1,1,1,1]
    var contents:[String] = ["C 언어를 처음 시작하는 출발선은 같지만 C 언어 문법 하나하나가",
                             "초보자들을 위한 쉽게 설명하는 C프로그래밍 가이드",
                                "#백종원 #전찌개 #명절 명절 지나면 전 많이 남으시죠?",
                                "불이 났을 때 어떻게 해야 할까요? 우리 아이들이 불이",
                                "장애인 직업능력에 대한 편견을 없애기 위해 한국장애",
                                "장애인 직업능력에 대한 편견을 없애기 위해 한국장애"]
    var videoTimes:[Int] = [2113, 1530, 1113, 3520, 1511, 1300]
    var favorites:[Bool] = [false, true, false, false, false, false]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EndCellIdentifier", for: indexPath) as! EndTableViewCell
        
        let layer = CALayer()
        
        layer.frame = cell.imgVideo.layer.bounds
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = 0.7
        layer.name = "checkLayer"
        
        if videoRates[row] == 1 {
            cell.imgVideo.layer.addSublayer(layer)
            cell.imgCheck.isHidden = false
        }
        
        cell.lblTitle.text = titles[row]
        cell.lblContent.text = contents[row]
        
        cell.lblTitle.text = titles[row]
        cell.imgVideo.downloadImage(from: imgurls[row])
        cell.imgVideo.translatesAutoresizingMaskIntoConstraints = true
        
        if favorites[row] == true {
            cell.btnFavorite.setImage(heartFill, for: .normal)
        }
        cell.btnFavorite.addTarget(self, action: #selector(setFavorite(_:)), for: .touchUpInside)
        cell.lblVideoTime.text = timeIntToString(from: videoTimes[row])
        cell.sliderTime.setValue(videoRates[row], animated: false)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailPage()
    }
    
    
    
    //---------- SID를 통한 Video 상세페이지 이동 ----------//
    func goToDetailPage() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoDetailSID")
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
    //---------- 좋아요 클릭/해제 ----------//
    @objc func setFavorite(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "heart_fill.png") {
            sender.setImage(heartEmpty, for: .normal)
        } else if sender.currentImage == UIImage(named: "heart_empty.png") {
            sender.setImage(heartFill, for: .normal)
        }
    }
    
    //---------- 동영상 총 시간 ----------//
    
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

extension EndTableViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripViewController: PagerTabStripViewController)->IndicatorInfo {
        return IndicatorInfo(title: "수강 완료")
    }
}
