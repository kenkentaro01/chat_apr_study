//
//  Chat.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/13.
//

import Foundation

struct Chat: Decodable, Identifiable{
    let id: String
//    ModelsのMessage.swiftで定義したもの
    var messages: [Message]
    var recentMessageText: String{
        
        guard let recentMessage = self.messages.last else{return ""}
//        最新のメッセージの取得
        return recentMessage.text
    }
    
    var recentMessageDateString: String{
        guard let recentMessage = self.messages.last else{return ""}
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        date型に変換した値をdateに与える
        guard let date  = formatter.date(from: recentMessage.date) else {return ""}
//        時間だけを表示する
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
}
