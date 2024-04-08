//
//  MessageRow.swift
//  chat_apr_study
//
//  Created by 健太郎 on 2024/04/08.
//

import SwiftUI

struct MessageRow: View {
    var body: some View {
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

#Preview {
    MessageRow()
}
