# マルチステップフォームのレースコンディション対策

## 概要

非同期バリデーション中の連打でステップが飛ぶ問題を防ぎ、画面遷移の整合性を保つ。
処理中フラグと多重実行ガードを標準化する。

## 適用条件

- ウィザード形式のフォーム
- `next` 処理で非同期API/検証を行う
- モバイル操作で連打が発生しうる

## アンチパターン

- ボタン連打を許容したまま `setStep` する
- 非同期処理の完了順序に依存する
- 検証失敗時の状態復元を持たない

## 推奨パターン

1. 送信中フラグで二重押下を抑止する
2. 最新リクエストのみ有効にする
3. ステップ更新は検証成功後に1回だけ行う
4. エラー時は同ステップで再試行可能にする

## 最小実装例

```ts
const [isSubmitting, setIsSubmitting] = useState(false);

async function onNext() {
  if (isSubmitting) return;
  setIsSubmitting(true);
  try {
    const ok = await validateStep(step);
    if (ok) setStep((s) => s + 1);
  } finally {
    setIsSubmitting(false);
  }
}
```

## チェックリスト

- [ ] 二重押下ガードを実装した
- [ ] 検証成功時のみステップ遷移する
- [ ] エラー表示と再試行導線を用意した
- [ ] E2Eで連打ケースを検証した

## 関連テンプレート / プレイブック

- [Abort Controller Pattern](./abort-controller-pattern.md)
- [API Test Template](../../templates/api-contract/api-test-template.md)
