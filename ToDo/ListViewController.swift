//
//  ListViewController.swift
//  ToDo
//
//  Created by 이예진 on 2020/02/17.
//  Copyright © 2020 yejin. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    let format = DateFormatter()
    
    //2.사용자의 데이터 추가,수정,삭제 등을 렘테이블에 반영하기위해 realm테이블 위치한 폴더에 접근
    let realm = try! Realm()
    
    //3.렘테이블에 저장된 데이터를 필터/정렬해 원하는 항목을 담아놓을 공간
    var list : Results<ToDo>!
    // 이 공간에 대한 : '타입'을 쓴다 할때만 떙떙 씀

    @IBOutlet weak var ToDoTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        ToDoTableView.reloadData()
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        //4.렘테이블에서 필터/정렬해 원하는 데이터를 가져온 후, list라는 변수에 값 담기
        list = realm.objects(ToDo.self).sorted(byKeyPath: "id", ascending: false)
        
        ToDoTableView.delegate = self
        ToDoTableView.dataSource = self
        
        
        
        
        
    }
    //1.셀의 갯수
           
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //2.셀의 디자인
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testTableViewCell", for: indexPath) as! testTableViewCell
        cell.delegate = self
        
        
        
        
        
        //dateformatter 2. 포맷형태
               format.dateFormat = "yyyy년 MM월 dd일"
               
        if list[indexPath.item].important == 0 {
            cell.ImportantLabel.text = "매우 중요"
        }else if list[indexPath.item].important == 1 {
            cell.ImportantLabel.text = "중요"
        }else {
            cell.ImportantLabel.text = "덜 중요"
        }
        
        
        
        cell.ThingsToDoLabel.text = list[indexPath.item].contents
        cell.DoUntilWhenLabel.text = format.string(from: list[indexPath.item].userDate)
        //cell.ImportantLabel.text = list[indexPath.item].important
        
        print("\(list[indexPath.item].userDate)")
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "삭제") { action, indexPath in
                // handle action by updating model with deletion
            }

            // customize the action appearance
            deleteAction.image = UIImage(named: "삭제")

            return [deleteAction]
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBAction func PlusButtonClicked(_ sender: Any) {
    
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.modalPresentationStyle = .fullScreen
    
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
}
