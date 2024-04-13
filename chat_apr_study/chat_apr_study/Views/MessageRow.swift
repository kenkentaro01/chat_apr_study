//
//  MessageRow.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/08.
//

import SwiftUI

struct MessageRow: View {
    var body: some View {
        HStack(alignment: .top){
            userThumb
            messageText
            messageState
            Spacer()
    }
        .padding(.bottom)
    }
}

#Preview {
    MessageRow()
//    アプリの実装の際には、以下の背景色は影響しない
        .background(.cyan)
}

extension MessageRow{
    private var userThumb: some View{
        Image("user01")
            .resizable()
            .frame(width: 48,height: 48)
            .clipShape(Circle())
    }
    private var messageText: some View{
        Text("こんにちは")
            .padding()
            .background(.white)
            .cornerRadius(30)
    }
    private var messageState: some View{
        VStack(alignment: .trailing){
            Spacer()
            Text("既読")
            Text(formattedDateString)
        }
        .foregroundColor(.secondary)
        .font(.footnote)
    }
    private var formattedDateString: String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}
