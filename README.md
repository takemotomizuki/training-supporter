# training-supporter（仮）
## 運用
パッケージの変更があった場合は
```
flutter pub get
```
をお願いします。

当分developmentブランチは必要ないからmainから直接ブランチ生やす \
基本的に`feature/小タスクID`で運用しようかなと思ってる

マージするときはPR必須にしてます。

基本的に`lib`以下にコードを記述していきます。 \
フォルダ構成は以下の通り
- `view`アプリの画面単位でファイルを格納
- `component`ヘッダー、フッターボタンなど使い回す予定のものを格納
- `pose_detection`姿勢検知のクラスを格納
- `main.dart`エントリーポイントすべてはここから呼び出す。

## Flutterインストール方法
参考[Android Studioを使ったFlutterの開発環境を構築する！](https://qiita.com/Keisuke-Magara/items/e07055cd253881b3b4b4)　\
記事がWindowsでわかりにくい

### Android Studioインストール

- [Android Studio](https://developer.android.com/studio?hl=ja)
- インストールしたらAndroid Studioを開いてFinishを押すとこまで適当に連打！
- プロジェクトを開く時とかにSDKのインストールを促されると思うからインストール（[これ](https://qiita.com/Keisuke-Magara/items/e07055cd253881b3b4b4#android-cmdline-tools-%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)でもできる）
- Android StudioのPluginからFlutter拡張機能をインストール

- `flutter doctor`で`cmdline-tools component is missing`と出る場合
    - Android StudioのCustomize→All settrings→Language & Frameworks→Android SDK→SDK tools→Android SDK Command-line Tools(latest)にチェックを入れる

- ライセンス認証
 ```
 flutter doctor --android-licenses
 ```
 これをうってyを連打！


### 拡張機能インストール

- VS Codeで[Flutter拡張機能](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)インストール

### Flutterインストール
- [Flutterダウンロードサイト](https://docs.flutter.dev/get-started/install/macos/mobile-ios?tab=download)からインストール
- 下のコマンドで`~/development`に展開

```
unzip ~/Downloads/flutter_macos_3.22.1-stable.zip \
     -d ~/development/
```
- ~/.zshenvに下の文を追記
```
export PATH=$HOME/development/flutter/bin:$PATH
```

### Xcodeインストール
-  App StoreからXcodeをインスール
- 実行下記コマンドを実行
```
sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
```

- cocoapodsのインストール
```
sudo gem install -n /usr/local/bin cocoapods
```
おれがやったときこんなエラーがでたのでそういう人は
```
ERROR:  Error installing cocoapods:
        The last version of drb (>= 0) to support your Ruby & RubyGems was 2.0.6. Try installing it with `gem install drb -v 2.0.6` and then running the current 
```
指示通り
```
sudo gem install drb -v 2.0.6
```
こんなエラーもでたので
```
ERROR:  Error installing cocoapods:
        The last version of activesupport (>= 5.0, < 8) to support your Ruby & RubyGems was 6.1.7.7. Try installing it with `gem install activesupport -v 6.1.7.7` and then running the current command again
```
こう
```
sudo gem install activesupport -v 6.1.7.7
```

- Platformのインストール
```
xcodebuild -downloadPlatform iOS 
```

### 確認
```
flutter doctor
```
でオールグリーンならOK

## 試してみる
Android Studioを開いてプロジェクトからこのリポジトリを選択 \
エミュレーターをしていして再生ボタンをクリックして実機テストができるか確認