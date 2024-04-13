//
//  Chat.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/13.
//

import Foundation

struct Chat: Decodable{
    let id: String
//    ModelsのMessage.swiftで定義したもの
    let messages: [Message]
}
