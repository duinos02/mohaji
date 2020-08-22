//
//  RealmModel.swift
//  ToDo
//
//  Created by 이예진 on 2020/02/23.
//  Copyright © 2020 yejin. All rights reserved.
//


//렘 DB테이블 구조
//1.테이블의 이름 정하기
//2.테이블 내에 저장할 항목 설정 : 제목, 메모, 사진 ..
//3.사용자가 입력하는 내용이 옵션 혹은 필수인지 설정


import Foundation
import RealmSwift

class ToDo: Object {
    @objc dynamic var contents = "" //할일 내용(필수)
    @objc dynamic var userDate = Date() // 사용자가 정한 날짜(필수)
    @objc dynamic var important = 0 //중요도 - 1:매우중요, 2:중요, 3:덜 중요(필수)
    @objc dynamic var regDate = Date() //글 등록일(필수)
    @objc dynamic var id = 0 //primary key
    
    override static func primaryKey() -> String? {
        return "id"
    } //프라이머리 키로 설정한게 얘다 라고 알려주기
    
}

