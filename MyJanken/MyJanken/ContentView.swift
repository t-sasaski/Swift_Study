//
//  ContentView.swift
//  MyJanken
//
//  Created by 佐々木成記 on 2023/04/14.
//

import SwiftUI

struct ContentView: View {
    
    // じゃんけんの結果を格納する変数
    //（0=初期画面、1=グー、2=チョキ、3=パー）
    @State var answerNumber = 0
    // ★ @State 状態変数：状態変数の値が変更されると自動的に、bodyを再計算して画面を描写
    
    var body: some View {
        VStack {
            // スペースを追加
            Spacer()
            
            // じゃんけんの数字が0だったら
            if answerNumber == 0 {
                // 初期画面のテキストを表示
                Text("これからじゃんけんをします！")
                    // 下辺に余白を設定
                    .padding(.bottom)
            } else if answerNumber == 1 {
                // じゃんけんの数字が1だったら、グー画像を指定
                
                // グー画像を指定
                Image("gu")
                // リサイズを指定
                    .resizable()
                // 画面に収まるように、アスペクト比（縦横比）を指定
                    .scaledToFit()
                // スペースを追加
                Spacer()
                // じゃんけんの種類を指定
                Text("グー")
                    // 下辺に余白を設定
                    .padding(.bottom)
            } else if answerNumber == 2 {
                // じゃんけんの数字が2だったら、チョキ画像を指定
                
                // チョキ画像を指定
                Image("choki")
                // リサイズを指定
                    .resizable()
                // 画面に収まるように、アスペクト比（縦横比）を指定
                    .scaledToFit()
                // スペースを追加
                Spacer()
                // じゃんけんの種類を指定
                Text("チョキ")
                    // 下辺に余白を設定
                    .padding(.bottom)
            } else {
                // じゃんけんの数字が「1」、「2」以外だったら、パー画像を指定
                
                // パー画像を指定
                Image("pa")
                // リサイズを指定
                    .resizable()
                // 画面に収まるように、アスペクト比（縦横比）を指定
                    .scaledToFit()
                // スペースを追加
                Spacer()
                // じゃんけんの種類を指定
                Text("パー")
                    // 下辺に余白を設定
                    .padding(.bottom)
            }
            
            // 「じゃんけんをする！」ボタン
            Button {
                // 新しいじゃんけんの結果を一時的に格納する変数を設ける
                var newAnswerNumber = 0
                
                // ランダムに結果を出すが、前回の結果と異なる場合のみ採用
                // repeatは繰り返しを意味する
                repeat {
                    // 1,2,3の数値をランダムに算出
                    newAnswerNumber = Int.random(in: 1...3)
                    
                    // 前回と同じ結果のときは、再度ランダムに数値を出す
                    // 異なる結果のときは、repeatを抜ける
                } while answerNumber == newAnswerNumber
                
                // 新しいじゃんけんの結果を格納
                answerNumber = newAnswerNumber
            } label: {
                // Buuttonに表示する文字を指定
                Text("じゃんけんをする！")
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .font(.title)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
