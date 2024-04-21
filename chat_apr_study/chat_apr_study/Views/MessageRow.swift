//
//  MessageRow.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/08.
//

import SwiftUI

struct MessageRow: View {
    let message: Message
    
    var body: some View {
        HStack(alignment: .top){
            if message.user.isCurrentUser{
//                ログインユーザであるときの処理
                Spacer()
                messageState
                messageText
                
            }else{
//                ログインユーザでなかったときの処理
                userThumb
                messageText
                messageState
                Spacer()
            }
           
    }
        .padding(.bottom)
    }
}

//#Preview {
//    MessageRow()
////    アプリの実装の際には、以下の背景色は影響しない
//        .background(.cyan)
//}

extension MessageRow{
    private var userThumb: some View{
        Image(message.user.image)
            .resizable()
            .frame(width: 48,height: 48)
            .clipShape(Circle())
    }
    private var messageText: some View{
        Text(message.text)
            .padding()
//        ? :は参考演算子と呼ばれるもの　Trueだった場合　：　の左側の処理が実行される
            .background(message.user.isCurrentUser ? Color("Bubble"): Color(uiColor: .tertiarySystemBackground))
            .cornerRadius(30)
            .foregroundColor(message.user.isCurrentUser ?.black:.primary)
    }
    private var messageState: some View{
        VStack(alignment: .trailing){
            Spacer()
//            ログインユーザーかつ既読とついている場合
            if message.user.isCurrentUser && message.readed{
                Text("既読")
            }
            
            Text(formattedDateString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    private var formattedDateString: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        date型に変換した値をdateに与える
        guard let date  = formatter.date(from: message.date) else {return ""}
//        時間だけを表示する
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
