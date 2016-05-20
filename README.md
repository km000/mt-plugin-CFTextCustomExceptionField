# mt-plugin-CFTextCustomExceptionField
for PowerCMS-ContactForm-Plugin.

※本プラグインは動作未検証です。

PowerCMSのContactForm向けに、バリデーション機能を拡張した一行テキストのフォーム項目を提供するMovable Type プラグインです。

##動作環境
- PowerCMS 4.21（全てのエディション）
##バリデーションの設定
フォーム項目の編集画面の項目「オプション」に、次の値をカンマ（,）区切りで追加する事で、バリデーションを拡張できる仕様です。
- numeric
-- 数値以外の値を例外として返す。
- hiragana
-- 全角ひらがな以外の値を例外として返す。
- em_katakana
-- 全角カタカナ以外の値を例外として返す。
- em
-- 全角文字以外の値を例外として返す。
- ascii
-- ASCII文字以外の値（全角文字）を例外として返す。
##その他
- フォーム項目への入力値の文字コードがUTF-8の場合のみ対応しています。

