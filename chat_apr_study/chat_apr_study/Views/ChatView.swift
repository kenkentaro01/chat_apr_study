//
//  ChatView.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/06.
//

import SwiftUI

struct ChatView: View {
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
                ForEach(0..<15){ _ in
                    MessageRow()
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
            Circle()
                .frame(width: 40,height: 40)
            Circle()
                .frame(width: 40,height: 40)
            Circle()
                .frame(width: 40,height: 40)
            Capsule()
                .frame(height: 40)
            Circle()
                .frame(width: 40,height: 40)
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