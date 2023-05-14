//
//  EffectView.swift
//  MyCamera
//
//  Created by 佐々木成記 on 2023/05/01.
//

import SwiftUI

struct EffectView: View {
    // エフェクト編集画面(sheet)の開閉状態を管理
    @Binding var isShowSheet: Bool
    // 撮影した写真
    let captureImage: UIImage
    // 表示する写真
    @State var showImage: UIImage?
    // フィルタ名を列挙した配列（Array）
    // 0.モノクロ
    // 1.Chrome
    // 2.Fade
    // 3.Instant
    // 4.Noir
    // 5.Process
    // 6.Tonal
    // 7.Transfer
    // 8.SepiaTone
    let filterArray = ["CIPhotoEffectMono",
                       "CIPhotoEffectChrome",
                       "CIPhotoEffectFade",
                       "CIPhotoEffectInstant",
                       "CIPhotoEffectNoir",
                       "CIPhotoEffectProcess",
                       "CIPhotoEffectTonal",
                       "CIPhotoEffectTransfer",
                       "CISepiaTone"
    ]
    
    // 選択中のエフェクト（filterArrayの添字）
    @State var filterSelectNumber = 0
    
    var body: some View {
        // 縦方向にレイアウト
        VStack {
            // スペース追加
            Spacer()
            
            if let showImage {
                // 表示する写真がある場合は画面に表示
                Image(uiImage: showImage)
                // リサイズする
                    .resizable()
                // アスペクト比（縦横比）を維持して画面内に収まるようにする
                    .scaledToFit()
            }
            
            // スペース追加
            Spacer()
            // 「エフェクト」ボタン
            Button {
                // ボタンをタップしたときのアクション
                // フィルタ名を指定
                let filterName = filterArray[filterSelectNumber]
                
                // 次回に適用するフィルタを決めておく
                filterSelectNumber += 1
                // 最後のフィルタまで適用した場合
                if filterSelectNumber == filterArray.count {
                    // 最後の場合は、最初のフィルタに戻す
                    filterSelectNumber = 0
                }
                
                // 元々の画像の回転角度を取得
                let rotate = captureImage.imageOrientation
                // UIImage形式の画像をCIImage形式に変換
                let inputImage = CIImage(image: captureImage)
                
                // フィルタの種別を引数で指定された種類を
                // 指定してCIFilterのインスタンスを取得
                guard let effctFilter = CIFilter(name: filterName) else {
                    return
                }
                //フィルタ加工のパラメータを初期化
                effctFilter.setDefaults()
                // インスタンスにフィルタ加工する元画像を設定
                effctFilter.setValue(
                    inputImage, forKey: kCIInputImageKey)
                // フィルタ加工を行う情報を生成
                guard let outputImage = effctFilter.outputImage else {
                    return
                }
                
                // CIContextのインスタンスを取得
                let ciContext = CIContext(options: nil)
                // フィルタ加工後の画像をCIContext上に描写し、
                // 結果をcgImageとしてCGImage形式の画像を取得
                guard let cgImage = ciContext.createCGImage(
                    outputImage, from: outputImage.extent) else {
                    return
                }
                // フィルタ加工後の画像をCGImage形式から
                // UIImage形式に変更。その際に回転角度を指定。
                showImage = UIImage(
                    cgImage: cgImage,
                    scale: 1.0,
                    orientation: rotate
                )
            } label: {
                // テキストを表示する
                Text("エフェクト")
                // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                // 高さ50ポイント指定
                    .frame(height: 50)
                // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                // 背景を青色に指定
                    .background(Color.blue)
                // 文字色を白色に指定
                    .foregroundColor(Color.white)
            }
            // 上下左右に余白を追加
            .padding()
            
            // showImageをアンラップする
            if let showImage = showImage?.resized() {
               // captureImageから共有する画像を生成する
               let shareImage = Image(uiImage: showImage)
                // 共有シート
                ShareLink(item: shareImage, subject: nil, message: nil,
                          preview: SharePreview("Photo", image: shareImage)) {
                    // テキスト表示
                    Text("シェア")
                    // 横幅いっぱい
                        .frame(maxWidth: .infinity)
                    // 高さ50ポイント指定
                        .frame(height: 50)
                    // 背景を青色に指定
                        .background(Color.blue)
                    // 文字色を白色に指定
                        .foregroundColor(Color.white)
                }
                // 上下左右に余白を追加
                .padding()
            }
            
            // 「閉じる」ボタン
            Button {
                // ボタンをタップしたときのアクション
                //  エフェクト編集画面を閉じる
                isShowSheet.toggle()
            } label: {
                // テキスト表示
                Text("閉じる")
                // 横幅いっぱい
                    .frame(maxWidth: .infinity)
                // 高さ50ポイント指定
                    .frame(height: 50)
                // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                // 背景を青色に指定
                    .background(Color.blue)
                // 文字色を白色に指定
                    .foregroundColor(Color.white)
            }
            // 上下左右に余白を追加
            .padding()
        }
        // 写真が表示されるときに実行される
        .onAppear {
            // 撮影した写真を表示する写真に設定
            showImage = captureImage
        }
    }
}

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(
            isShowSheet: .constant(true),
            captureImage: UIImage(named: "preview_use")!
        
        )
    }
}
