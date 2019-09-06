//
//  SearchTableViewController.swift
//  NewShinple
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 veronica. All rights reserved.
//

import UIKit

/*
 bin
 */
class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    let sampleData = ["어서와 C언어는 처음이지!", "AWS 시스템 설계와 마이그레이션", "나도 이제 데이터 분석 준전문가", "초보자를 위한 파이썬", "Python과 Pygame으로 게임 만들기", "당신이 지금 알아야 할 AWS", "The 친절한 Swift 프로그래밍", "10대와 통하는 스포츠 이야기", "토익의 입문", "부동산을 팔고 금을 사라", "펀드, 모른다면 이것만 해라!", "백종원의 요리비책", "회사에서하는 유산소운동 다이어트", "중국어 3달만에 귀가 트이는 법", "스페인여행 기초회화", "너도 영어할래?", "어린이 안전교육", "임산 초기 주의사항", "문과도 쉽게 학습하는 ADsP", "AWS클라우드 이해하기", "모두의 데이터 분석", "Do it! 쉽게 배우는 R 데이터 분석", "데이터 분석의 힘(Python)", "라이브러리를 활용한 Python 데이터 분석"]
    
    var baseArray = ["Python", "데이터 분석", "R", "프로그래밍", "개발"]

    
    
    //---------- 공통 color ----------//
    
    let colorStartBlue = UIColor(red: 15/255, green: 83/255, blue: 163/255, alpha: 1)
    let colorMiddleBlue = UIColor(red: 20/255, green: 123/255, blue: 195/255, alpha: 1)
    let colorEndBlue = UIColor(red: 27/255, green: 164/255, blue: 227/255, alpha: 1)
    let colorLightGray = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //---------- 샘플 Data ----------//
    
    var titles:[String] = ["제1강. Python과 Pygame으로 게임 만들기",
                            "제2강. Python과 Pygame으로 게임 만들기",
                            "제3강. Python과 Pygame으로 게임 만들기"]
    var imgurls:[URL] = [URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Develop/Python/image/Chapp2.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Develop/Python/image/Chapp2.png")!,
                         URL(string: "https://shinpleios.s3.us-east-2.amazonaws.com/Develop/Python/image/Chapp3.png")!]
    
    var videoRates:[Float] = [1, 0.7, 0.3]
    var contents:[String] = ["Pygame 라이브러리에 대한 소개와 함께 2D 그래픽 게임",
                             "기본적인 머신 러닝 알고리즘(선형회귀, KNN, K-MEANS)",
                             "한국데이터베이스진흥원에서 실시하고 있는 데이터 분석 전문가 자격증"]
    var videoTimes:[Int] = [2000, 5200, 2500]
    var favorites:[Bool] = [false, true, true]
    
    let heartEmpty = UIImage(named: "heart_empty.png")
    let heartFill = UIImage(named: "heart_fill.png")
    
    
    
    //---------- important variable ----------//
    
    var searchedData = [String]()
    var searching = false
    var selectedButton = false
    var selectedTitle = ""


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let row = indexPath.row
        
        if (selectedButton == false) {
            if row == 0{
                return 40
            }else {
                return 50
            }
        } else {
            return 120
        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selectedButton == false) {
            if searching{
                return searchedData.count+1
            }else {
                return baseArray.count+1
            }
        } else {
            return imgurls.count
        }
        
    }
    
    //목록 삭제 함수
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            baseArray.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // 선택 셀 삭제 불가 함수
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var edit: Bool = true;
        
        if(indexPath.row == 0) {
            edit = false;
        }
        return edit;
    }
    
    
    //삭제시 Delete 대신 "삭제"
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let listLine = row-1
        
//        SearchTableViewCell
        if(selectedButton == false) {
            if(row == 0){
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell1", for: indexPath) as! SearchTableViewCell1
                
                if searching {
                    cell.isHidden = true
                }else {
                    cell.label.text = "최근 검색기록 입니다.   "
                    cell.backgroundColor = colorLightGray
                    cell.label.backgroundColor = colorLightGray
                    
                    cell.allDeleteBtn.addTarget(self, action: #selector(delectCell), for: .touchUpInside)
                    //            cell.allDeleteBtn?.textInputContextIdentifier = "X"
                }
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell2", for: indexPath) as! SearchTableViewCell2
                if searching {
                    cell.btnSearchContent.setTitle(searchedData[listLine], for: .normal)
                    cell.btnSearchContent.addTarget(self, action: #selector(goToDetailList(_:)), for: .touchUpInside)
                } else {
                    print("sample data print")
                    cell.btnSearchContent.setTitle(baseArray[listLine], for: .normal)
                    cell.btnSearchContent.addTarget(self, action: #selector(goToDetailList(_:)), for: .touchUpInside)
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDetailTableViewCell1") as! SearchDetailTableViewCell1
            
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
       
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailPage()
    }
    
    
    @objc func goToDetailList(_ sender: UIButton) {
        
        selectedButton = true
        selectedTitle = sender.currentTitle!
        searchBar.text = selectedTitle

        self.searchBar.endEditing(true)
        
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    //---------- 좋아요 클릭/해제 ----------//
    @objc func setFavorite(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "heart_fill.png") {
            sender.setImage(heartEmpty, for: .normal)
        } else if sender.currentImage == UIImage(named: "heart_empty.png") {
            sender.setImage(heartFill, for: .normal)
        }
    }
    
    func goToDetailPage() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoDetailSID")
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    //전체 삭제 함수
    @objc func delectCell() {
        baseArray = []
        tableView.reloadData()
    }
    
    //-------------viewDidLoad-------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchedData = sampleData.filter{$0.lowercased().contains(searchText.lowercased())}
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if selectedButton == false {
            searching = false
            searchBar.text = ""
        } else if selectedButton == true {
            searching = false
            selectedButton = false
            
            self.tableView.reloadData()
            refreshControl?.endRefreshing()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("edit start")
        
        searching = true
        selectedButton = false
        
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("edit end")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.tableView.endEditing(true)
        self.view.endEditing(true)
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
