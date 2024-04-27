//
//  ListView.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/27.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var vm: ChatViewModel = ChatViewModel()
    var body: some View {
        NavigationView{
            VStack{
                //           Header
                header
                //            List
                list
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ListView()
}

extension ListView{
    private var header: some View{
        HStack{
            Text("トーク")
                .font(.title2.bold())
            Spacer()
            HStack(spacing: 16){
                Image(systemName: "text.badge.checkmark")
                Image(systemName: "square")
                Image(systemName: "ellipsis.bubble")
                
            }
            .font(.title2)
            
        }
    }
    
    private var list: some View{
        ScrollView{
            VStack{
                ForEach(vm.chatData){chat in
                    NavigationLink {
                        ChatView(chat: chat)
//                        下記のvmは上記に定義しているvm
                            .environmentObject(vm)
                            .toolbar(.hidden)
                    } label: {
                        listRow(chat: chat)
                    }

                    
                }
            }
        }
    }
    private func listRow(chat: Chat)-> some View {
//    private var listRow: some View{
        HStack{
            Image("user01")
                .resizable()
                .frame(width: 40,height: 40)
                .clipShape(Circle())
            VStack{
                Text("タイトル")
                    .foregroundColor(.primary)
                Text(chat.recentMessageText)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            Spacer()
            Text(chat.recentMessageDateString)
                .font(.caption)
                .foregroundColor(Color(uiColor: .secondaryLabel))
        }
    }
    
}
