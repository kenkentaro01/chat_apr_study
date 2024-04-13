//
//  ChatViewModel.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/13.
//

import Foundation

class ChatViewModel{
//    後からデータの値を変更できるようにするためにvarで宣言
    var chatData: [Chat] = []
//    Chatモデルのmessagesプロパティのデータのため以下のデータ型になる。
    var messages: [Message] = []
    
    init(){
//        ChatViewModelが初期化された時に実行される
        chatData = fetchChatData()
        messages = chatData[0].messages
        print(messages)
    }
    private func fetchChatData()->[Chat]{
        let fileName = "chatData.json"
        let data: Data
//        ファイルのパスを取得する処理
//        nilを返す可能性があるため「guard」を追加
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: nil)
        else{
            fatalError("\(fileName)が見つかりませんでした。")
        }
        do{
//            このデータのままだとバイト形式なので扱えないため、行目の処理が必要
            data = try Data(contentsOf: filePath)
        }catch{
//            このイニシャライザは例外を位発生させる場合があるためtry文を書く必要がある。
//            tryはdo catch構文を書き込む必要がある。
            fatalError("\(fileName)のロードに失敗しました。")
        }
        do{
            //        1つ目の引数　Json形式で解析した後にどのような構造のデータに変換するのかをSwiftに支持するためのデータ型を渡す。
            //        第２引数では解析するデータを渡す
           return try JSONDecoder().decode([Chat].self, from: data)
        }catch{
            fatalError("\(fileName)を\(Chat.self)に変換することに失敗しました。")
        }
    }
}
