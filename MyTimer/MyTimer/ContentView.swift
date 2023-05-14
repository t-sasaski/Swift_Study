//
//  ContentView.swift
//  MyTimer
//
//  Created by 佐々木成記 on 2023/04/30.
//

import SwiftUI

struct ContentView: View {
    // タイマーの変数を作成
    @State var timerHandler : Timer?
    // カウント（経過時間）の変数を作成
    @State var count = 0
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10
    // アラート表示有無
    @State var showAlert = false
    
    var body: some View {
        NavigationStack {
            // 奥から手前方向にレイアウト
            ZStack {
                // 背景画像
                Image("backgroundTimer")
                    // リサイズする
                    .resizable()
                    // セーフエリアを超えて画面全体に配置します
                    .ignoresSafeArea()
                    // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
                    .scaledToFill()
                // 垂直方向にレイアウト（縦方向にレイアウト）
                // View（部品）間の間隔を30にする
                VStack(spacing: 30.0) {
                    // テキストを表示する
                    Text("残り\(timerValue - count)秒")
                        // 文字のサイズを指定
                        .font(.largeTitle)
                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // スタートボタン
                        Button {
                            // ボタンをタップしたときのアクション
                            // タイマーをカウントダウン開始する関数を呼び出す
                            startTimer()
                        } label: {
                            Text("スタート")
                                // 文字サイズを指定
                                .font(.title)
                                // 文字色を白に指定
                                .foregroundColor(Color.white)
                                // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                                // 背景を設定
                                .background(Color("startColor"))
                                // 円形に切り抜く
                                .clipShape(Circle())
                        }
                        
                        // ストップボタン
                        Button {
                            // ボタンをタップしたときのアクション
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // もしタイマーが、実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("ストップ")
                                // 文字サイズを指定
                                .font(.title)
                                // 文字色を白に指定
                                .foregroundColor(Color.white)
                                // 幅高さを140に指定
                                // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                                // 背景を設定
                                .background(Color("stopColor"))
                                // 円形に切り抜く
                                .clipShape(Circle())
                        }
                    }
                }
            }
            .onAppear {
                // カウント（経過時間）の変数を初期化
                count = 0
            }
            // ナビゲーションにボタンを追加
            .toolbar {
                // ナビゲーションバーの右にボタンを追加
                ToolbarItem(placement: .navigationBarTrailing) {
                    // ナビゲーション遷移
                    NavigationLink {
                        SettingView()
                    } label: {
                        // テキストを表示
                        Text("秒数設定")
                    }
                }
            }
            
            // 状態変数showAlertがtrueになった時に実行される
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                    // OKをタップした時にここが実行される
                    print("OKがタップされました")
                }
            } message: {
                Text("タイマー終了時間です")
            }
        }
    }
    
    // 1秒毎に実行されてカウントダウンする
    func countDownTimer() {
        // count（経過時間）に+1していく
        count += 1
        
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()
            
            // アラート表示する
            showAlert = true
        }
    }
    
    // タイマーをカウントダウン開始する関数
    func startTimer() {
        // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // もしタイマーが、実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                // 何も処理しない
                return
            }
        }
        
        // 残り時間が0以下のとき、count（経過時間）を0に初期化する
        if timerValue - count <= 0 {
            // count（経過時間）を0に初期化する
            count = 0
        }
        
        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // タイマー実行時に呼び出される
            // 1秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
