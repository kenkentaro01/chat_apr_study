//
//  ChatView.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/06.
//
//イベントハンドラー　→　機能を実行するためのトリガーとなる値
import SwiftUI

struct ChatView: View {
    let chat: Chat
    
    @State private var textFieldText : String = ""
//    フォーカスが当たっているかどうかの変数
//    @FocusStateのプロパティラッパーを付与することで、Focusの監視したい要素に関連づけることができる。
    @FocusState private var textFieldFocused: Bool
//    画面を閉じるためのハンドラーを取得することができる。
    @Environment(\.dismiss) private var dismiss
    
//    ObservedObjectを付与する場合は、定数(let)ではなく変数(var)でないといけないルールがある。
//    @ObservedObject var vm: ChatViewModel = ChatViewModel()
//ChatViewModelのインスタンスを一つに統一する
//    リスト画面で初期化したインスタンスをチャット画面からもアクセスできるようにする
//    リスト画面からチャット画面のプロパティにインスタンスへの参照を渡すようにする。
    @EnvironmentObject var vm: ChatViewModel
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

//#Preview {
//    ChatView()
//}

extension ChatView{
    
    //    private : アクセス修飾子
    //    ChatViewの中からのみアクセスすることができる。
    private var messageArea: some View{
        //        スクロール内をコントロールする。
        ScrollViewReader{proxy in
            ScrollView{
                //                縦にメッセージが入っていくためのvstack
                VStack(spacing:0){
                    //               第一引数に配列を渡す場合は、idを第二引数で渡す必要がある
                    //                Identifiableを記述していると「id: \.id」が必要なくなる
                    ForEach(chat.messages){ message in
                        //                    Text(message.id)
                        MessageRow(message: message)
                    }
                }
                //                左右に隙間を開ける
                .padding(.horizontal)
                .padding(.top,72)
                
            }
            //        カラーの中身の名前はAsset.xcassetsで作成したColorsフォルダ内にある名前となる
            .background(Color("Background"))
            .onTapGesture {
                textFieldFocused = false
            }
            .onAppear{
                scrollToLast(proxy: proxy)
            }
        }
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
                .onSubmit {
                    sendMessage()
                }
            //            @FocusState private var textFieldFocused: Boolより
                .focused($textFieldFocused)
            Image(systemName: "mic")
                .font(.title2)
        }
        .padding(.horizontal)
        .padding(.trailing)
        .background(Color(uiColor: .systemBackground))
    }
    
    private var navigationArea: some View{
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.primary)
            }

            
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
        .background(Color("Background").opacity(0.9))
    }
    
    private func sendMessage(){
        //            データの処理は複数あると混乱するためChatViewModelの中でまとめる
        //textFieldTextがからであるかどうかを判定する。
        //            →このプロパティがfalseだったらTrueになるようにする。
        //            空でない時にif文内が実行されるようになる。
        if !textFieldText.isEmpty{
            vm.addMessage(chatID: chat.id, text: textFieldText)
            textFieldText = ""
        }
    }
    
    private func scrollToLast(proxy: ScrollViewProxy){
        //        オプショナル型になるためif文によってアンラップする必要がある。
        if let lastMessage = chat.messages.last{
//            このめっソドの引数はユニークのデータを渡す必要がある。
            proxy.scrollTo(lastMessage.id, anchor: .bottom)
        }
    }
}
