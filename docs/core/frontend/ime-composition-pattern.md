# IME Composition パターン

## 概要

日本語入力中の Enter を送信確定と誤判定しないため、composition 状態を制御する。
多言語入力フォームの誤送信を防ぐ。

## 適用条件

- Enter で submit するフォーム
- 日本語・中国語など IME 入力を想定する
- チャットUIや検索UIで即時送信がある

## アンチパターン

- `onKeyDown` の Enter 判定のみで送信する
- `isComposing` を考慮しない
- IME 確定直後のイベント順序を無視する

## 推奨パターン

1. `compositionstart/end` で入力状態を保持する
2. Enter 送信は `!isComposing` を条件にする
3. `nativeEvent.isComposing` も併用して判定する
4. 送信後に入力状態を明示的にリセットする

## 最小実装例

```tsx
const [isComposing, setIsComposing] = useState(false);

<input
  onCompositionStart={() => setIsComposing(true)}
  onCompositionEnd={() => setIsComposing(false)}
  onKeyDown={(e) => {
    if (e.key === "Enter" && !isComposing && !e.nativeEvent.isComposing) {
      onSubmit();
    }
  }}
/>
```

## チェックリスト

- [ ] composition 状態を管理している
- [ ] Enter 送信条件に IME 判定を含めた
- [ ] 日本語入力で誤送信しないことを手動確認した
- [ ] E2EでIME入力ケースを追加した

## 関連テンプレート / プレイブック

- [Abort Controller Pattern](./abort-controller-pattern.md)
- [CI Green Policy](../process/ci-green-policy.md)
