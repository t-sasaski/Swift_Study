//
//  BackgroundView.swift
//  MyMusic
//
//  Created by 佐々木成記 on 2023/04/25.
//

import SwiftUI

struct BackgroundView: View {
    
    // 画像ファイル名
    let imageName: String
    
    var body: some View {
        // 背景画像を指定する
        Image(imageName)
        // リサイズする
        .resizable()
        // 画面いっぱいになるようにセーフエリア外まで表示されるように指定
        .ignoresSafeArea()
        // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
        .scaledToFill()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(imageName: "background")
    }
}
