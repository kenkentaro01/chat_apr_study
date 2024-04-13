//
//  User.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/13.
//

import Foundation
//構造体で作成していくのが一般的

struct User: Decodable{
    let id: String
    let name: String
    let image: String
}
