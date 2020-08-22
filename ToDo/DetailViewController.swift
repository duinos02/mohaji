//
//  DetailViewController.swift
//  ToDo
//
//  Created by 이예진 on 2020/02/23.
//  Copyright © 2020 yejin. All rights reserved.
//

import UIKit
import RealmSwift //1.렘 임포트
import SwiftyPickerPopover
import TweeTextField
import TTSegmentedControl




class DetailViewController: UIViewController {

    @IBOutlet weak var DoWhatLabel: UILabel!
    @IBOutlet weak var DoWhatTextField: TweeActiveTextField!
    
    @IBOutlet weak var DoWhenLabel: UILabel!
    @IBOutlet weak var DowhenButton: UIButton!
    
    @IBOutlet weak var DoImportantLabel: UILabel!
    @IBOutlet weak var DoImportantSengmentControl: TTSegmentedControl!
    
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    //2.사용자의 데이터 추가,수정,삭제 등을 렘테이블에 반영하기위해 realm테이블 위치한 폴더에 접근
    let realm = try! Realm()
    
    var segmentSave = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  DoImportantSengmentControl.didSelectItemWith = { (index, title) -> () in
        //    self.segmentSave = index
        //}
      
       let format = DateFormatter()
                 format.dateFormat = "yyyy년 MM월 dd일"
              
                 self.DowhenButton.setTitle(format.string(from: Date()), for: .normal) //현재날짜 불러오기
    
    }
    
   
    
    
    
    @IBAction func DowhenButtonClicked(_ sender: Any) {
        
       DatePickerPopover(title: "날짜 선택")
       .setDateMode(.date)
       .setSelectedDate(Date())
       .setDoneButton(action: { popover, selectedDate in
          
           let format = DateFormatter()
           format.dateFormat = "yyyy년 MM월 dd일"
        
           self.DowhenButton.setTitle(format.string(from: selectedDate), for: .normal)
           
           print("selectedDate \(selectedDate)")
           
       })
       .setCancelButton(action: { _, _ in print("cancel")})
       .appear(originView: sender as! UIView, baseViewController: self)
       
           
        
    }
    
    
    @IBAction func DoneButtonClicked(_ sender: Any) {
        
        //3.각 항목들에 맞는 내용들을 넣기
       
        print(DoImportantSengmentControl.currentIndex)
    
        if DoWhatTextField.text?.count ?? 0 > 0 {
            let data = ToDo()
                   data.contents = DoWhatTextField.text!
            let format = DateFormatter()
                           format.dateFormat = "yyyy년 MM월 dd일"
                data.userDate = format.date(from: DowhenButton.currentTitle!)!
            data.important = segmentSave
                   data.regDate = Date()
                   data.id = createNewID()
                   
                   // let newId = createNewID() -> 사진도 올릴수 있게 하는 기능을 넣었을때 오류가 생길수 있으니 이 코드를 넣어줘야함
                   
                   //4. 원본 렘 테이블에 3번에서 작성한 내용을 최종적으로 추가
                   try! realm.write {
                       realm.add(data)
                   }
            
            dismiss(animated: true, completion: nil)
            
        }else {
            //1. 얼럿컨트롤러 생성 ( 흰 배경 )
                       let alert = UIAlertController(title: "채워지지 않은 내용이 있습니다", message: "할 일을 작성해야합니다", preferredStyle: .alert)
                       //2.얼럿버튼 생성 ( 버튼 )
                       let b1 = UIAlertAction(title: "확인", style: .default, handler: nil)

                       //3. 1번배경에 2번 얹기 : 버튼을 추가하는 순서대로 화면에 보임
                     //  alert.addAction(b3)
                     //  alert.addAction(b2)
                       alert.addAction(b1)

                       self.present(alert, animated: true, completion: nil)
                       
            
        }
        
        
    }
    
    @IBAction func CancelButtonClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func createNewID() -> Int {
        
        let realm = try! Realm()
        if let retNext = realm.objects(ToDo.self).sorted(byKeyPath: "id", ascending : false).first?.id {
            return retNext + 1
        } else { return 0 }
        
    }
    


}
