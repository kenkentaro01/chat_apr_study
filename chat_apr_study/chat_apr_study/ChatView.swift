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
            ScrollView{
//                縦にメッセージが入っていくためのvstack
                VStack(spacing:0){
                    ForEach(0..<15){ _ in
                        HStack{
        //                    メッセージを複製するためのループ処理
                            Circle()
                                .frame(width: 60,height: 60)
                            Capsule()
                                .frame(height: 60)
                    }
                        .padding(.bottom)
                }
                }
//                左右に隙間を開ける
                .padding(.horizontal)
                .padding(.top,72)
                
            }
            .background(.cyan)
//            被せるレイアウトを作成する時に使用する。
            .overlay(
                HStack{
                    Circle()
                        .frame(width: 40, height: 40)
                    Text("Title")
//                    横いっぱいに広げるためのspacerを利用する
                    Spacer()
                    Circle()
                        .frame(width: 40, height: 40)
                    Circle()
                        .frame(width: 40, height: 40)
                    Circle()
                        .frame(width: 40, height: 40)
                }
//                要素の色を白色にする
                    .foregroundColor(.white)
                    .padding()
                    .background(.black.opacity(0.5))
                ,alignment: .top
            )
//            inputエリア
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
    }
}

#Preview {
    ChatView()
}
