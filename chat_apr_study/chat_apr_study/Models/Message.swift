//
//  Message.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/13.
//

import Foundation

struct Message: Decodable{
//    スイフトで自動的に生成される文字列の値が代入されるようにしている。
    let id: String
    let text: String
//    userの定義はUser.swiftで定義しているもの
    let user: User
//    Date → Stringに変更
//    外部のリソースからデータを取得する場合、そのデータの構造に応じてデータモデルを変更する必要がある。
    let date: String
    let readed: Bool
}