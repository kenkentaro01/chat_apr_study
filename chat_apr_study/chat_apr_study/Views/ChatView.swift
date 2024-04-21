//
//  ChatView.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/06.
//

import SwiftUI

struct ChatView: View {
    @State private var textFieldText : String = ""
    
    let vm: ChatViewModel = ChatViewModel()
    var body: some View {
//        不要なスペースを無効化
        VStack(spacing:0){
//            メッセージエリア（スクロールする部分）
//            プロパティの呼び出しのためカッコは不要
            messageArea
//            被せるレイアウトを作成する時に使用する。
            .overlay(
               navigationArea
                ,alignment: .top
            )
//            inputエリア
            inputArea
        }
    }
}

#Preview {
    ChatView()
}

extension ChatView{
//    private : アクセス修飾子
//    ChatViewの中からのみアクセスすることができる。
    private var messageArea: some View{
        ScrollView{
//                縦にメッセージが入っていくためのvstack
            VStack(spacing:0){
//               第一引数に配列を渡す場合は、idを第二引数で渡す必要がある
//                Identifiableを記述していると「id: \.id」が必要なくなる
                ForEach(vm.messages){ message in
//                    Text(message.id)
                    MessageRow(message: message)
            }
            }
//                左右に隙間を開ける
            .padding(.horizontal)
            .padding(.top,72)
            
        }
        .background(.cyan)
    }
    private var inputArea: some View{
        HStack{
            HStack{
                Image(systemName: "plus")
                Image(systemName: "camera")
                Image(systemName: "photo")
            }
            .font(.title2)
            TextField("Area",text: $textFieldText)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(Capsule())
                .overlay(Image(systemName: "face.smiling")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
//                         右端による
                         ,alignment: .trailing)
            
            Image(systemName: "mic")
                .font(.title2)
        }
        .padding()
        .background(.white)
    }
    
    private var navigationArea: some View{
        HStack{
            Image(systemName: "chevron.backward")
                .font(.title2)
            Text("Title")
                .font(.title2.bold())
//                    横いっぱいに広げるためのspacerを利用する
            Spacer()
            HStack(spacing: 16){
                Image(systemName: "text.magnifyingglass")
                Image(systemName: "phone")
                Image(systemName: "line.3.horizontal")
            }
            .font(.title2)
        }
            .padding()
            .background(.cyan.opacity(0.9))
    }
}
