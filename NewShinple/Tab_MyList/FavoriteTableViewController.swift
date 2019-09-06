//
//  FavoriteTableViewController.swift
//  NewShinple
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 veronica. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavoriteTableViewController: UITableViewController {
    
    
    //---------- 공통 color ----------//
    
    let colorStartBlue = UIColor(red: 15/255, green: 83/255, blue: 163/255, alpha: 1)
    let colorMiddleBlue = UIColor(red: 20/255, green: 123/255, blue: 195/255, alpha: 1)
    let colorEndBlue = UIColor(red: 27/255, green: 164/255, blue: 227/255, alpha: 1)
    let colorLightGray = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    
    let heartEmpty = UIImage(named: "heart_empty.png")
    let heartFill = UIImage(named: "heart_fill.png")
    
    
    
    var titles:[String] = ["제2강. 어서와 C언어는 처음이지!",
                           "제1강. AWS 시스템 설계와 마이그레이션 ",
                           "제2강. AWS 시스템 설계와 마이그레이션 ",
                           "제3강. 펀드, 모른다면 이것만 해라!",
                           "제2강. 부동산을 팔고 금을 사라",
                           "제1강. 어린이 안전교육"]
    var imgurls:[URL] = [URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Develop/C/image/Chap3.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Certi/AWS/image/Chap1.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Certi/AWS/image/Chap2.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Finance/Fund/image/Chap3.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Finance/Estate/image/Chap2.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Infant/Edu/image/Chap1.png")!]
    
    var videoRates:[Float] = [0.2, 0.1, 0.5, 0.1, 0.3, 0.3]
    var contents:[String] = ["C 언어를 처음 시작하는 출발선은 같지만 C 언어 문법 하나하나가",
                             "AWS 서비스를 잘 활용해 실전에서 바로 서비스를 운영",
                             "AWS와 서비스 운영에 첫걸음을 내디딜 수 있게 도와준다!",
                             "『데이터 분석 전문가 가이드(ADP)(ADSP)』는 데이터 분석 전문가 양성을 위한",
                             "한국데이터베이스진흥원에서 실시하고 있는 데이터 분석 전문가 자격증",
                             "기본적인 머신 러닝 알고리즘(선형회귀, KNN, K-MEANS)",
                             "육아 교육을 위한 육아 교육 팁"]
    var videoTimes:[Int] = [5513, 3520, 1511, 90132, 1300, 1280]
    var favorites:[Bool] = [true, true, true, true, true, true]
    
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCellIdentifier", for: indexPath) as! FavoriteTableViewCell
        
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
        
        cell.btnFavorite.setImage(heartFill, for: .normal)
        
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

extension FavoriteTableViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripViewController: PagerTabStripViewController)->IndicatorInfo {
        return IndicatorInfo(title: "찜 목록")
    }
}

