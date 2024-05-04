//
//  ChatViewModel.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/13.
//

import Foundation

//ChatViewModelはchatView.swiftで初期化されてvmの変数へ渡している。
//classの場合、初期化されてインスタンスが渡される場合コピーではなく参照が渡される。
//ChatViewが初期化されるタイミングは、chat_apr_studyApp.swiftのところ→アプリを立ち上げた直後
//ユーザが投稿するタイミングはアプリを立ち上げた後のタイミング

class ChatViewModel: ObservableObject{
//    後からデータの値を変更できるようにするためにvarで宣言
    @Published var chatData: [Chat] = []
//    Chatモデルのmessagesプロパティのデータのため以下のデータ型になる。→どこからもアクセスされなくなったため削除
    
    init(){
//        ChatViewModelが初期化された時に実行される
        chatData = fetchChatData()
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
    func addMessage(chatID: String, text: String){
        
       guard let index = chatData.firstIndex(where:{chat in
            chat.id == chatID
       }) else {return }
//        /Message型インスタンスを作成するためにメッセージを初期化します。
//        UUIDはユニークな値を作成してくれる。
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDateString = formatter.string(from: Date())
        
        let newMessage = Message(id: UUID().uuidString,
                                 text:text,
                                 user: User.currentUser,
                                 date: formattedDateString,
//                                 投稿するテキストは既読ではないのでfalse
                                 readed: false
        )
//        classの中の値が変更されたタイミンングで画面を再描画する仕組みを実装する。
//        3つのポイント
//        ・定数vmに対してオブザーどを付与すること。
//        ・Generic struct 'ObservedObject' requires that 'ChatViewModel' conform to 'ObservableObject'
//        →オブザーどオブジェクトを付与する対象のクラスは必ずオブザーバルオブジェクトプロトコルに準拠していなければならに
//        2つ目のポイントだけでは画面に反映されない。
//        →オブザーバルオブジェクトプロトコルは監視対象のクラスから何らかの通知があった際に自身のViweを再描写するだけのため
//        ・通知する仕組みは監視対象のクラスで実装すること
//        →@published を追記する必要がある
        chatData[index].messages.append(newMessage)
    }
    
    func getTitle(messages: [Message]) -> String{
        var title = ""
        let names = getMembers(messages: messages, type: .name)
        
        for name in names{
//            三項演算子を利用することで、最後にカンマをつかないようにする。
                    title += title.isEmpty ?"\(name)" : ",\(name)"
        }
        return title
    }
//    ナビゲーションのアイコンを配列に格納してビューに渡すための関数
//    returnは省略
    func getImages(messages:[Message]) -> [String]{getMembers(messages: messages, type: .image)}
//    getMembersはgetImagesとgetTitleからしかアクセスされないためprivateによりアクセス制限する。
//    privateはこのクラス内でしかアクセスされない　→不用意なアクセスを防ぐことでバグを避けることができる
    private func getMembers(messages:[Message],type: valueType)->[String]{
        var members: [String] = []
        var userIds: [String] = []
        
        for message in messages{
            let id = message.user.id
//            重複を避ける処理
//            continueはfor構文で使用できる
//             投稿したidとcurrentUserのidが一致していた場合、continue以降の処理は実行されない。
//            カレントユーザーの判定を先に行う理由
//              →効率が上がるため
            if id == User.currentUser.id{continue}
            if userIds.contains(id){continue}
            userIds.append(id)
      
//            if文と違うところは、列挙型で記載されていないものに関してコンパイラーエラーで通知してくれるところ
//            数に縛られないメリットがある
//              →Bool型の場合２種類飲みになってしまう
            switch type{
            case .name:
                members.append(message.user.name)
            case .image:
                members.append(message.user.image)
            }

        }
        return members
    }
}

enum valueType{
    case name
    case image
}
