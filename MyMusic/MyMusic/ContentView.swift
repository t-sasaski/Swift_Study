//
//  ContentView.swift
//  MyMusic
//
//  Created by 佐々木成記 on 2023/04/25.
//

import SwiftUI

struct ContentView: View {
    // 音を鳴らすためのSoundPlayerクラスのインスタンス生成
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        // 奥行き方向をレイアウト
        ZStack {
            
            // 背景画像を表示する
            BackgroundView(imageName: "background")
            
            // 水平にレイアウト（横方向にレイアウト）
            HStack {
                // シンバルボタン
                Button {
                    // ボタンをタップしたときのアクション
                    // シンバルの音を鳴らす
                    soundPlayer.cymbalPlay()
                } label: {
                    // 画像を表示する
                    Image("cymbal")
                }
                
                Button {
                    // ボタンをタップしたときのアクション
                    // ギターの音を鳴らす
                    soundPlayer.guitarPlay()                    
                } label: {
                    // 画像を表示する
                    Image("guitar")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
