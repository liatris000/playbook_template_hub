# AbortController パターン

## 概要

検索入力や画面遷移時に不要リクエストを中断し、古いレスポンスによる上書きを防ぐ。
フロントエンドの競合と無駄な通信を削減する。

## 適用条件

- 入力中に連続リクエストを発行するUI
- ページ遷移や再描画で古い通信が残る
- 最新結果のみを表示したい

## アンチパターン

- 毎回 `fetch` して前リクエストを放置する
- 返却順が逆転して古い結果を描画する
- `AbortError` を一般エラーとして扱う

## 推奨パターン

1. 新規リクエスト前に前回Controllerを中断する
2. `AbortError` は正常系キャンセルとして無視する
3. 描画更新は最新リクエストに限定する
4. unmount 時にも中断する

## 最小実装例

```ts
let controller: AbortController | null = null;

async function load(q: string) {
  controller?.abort();
  controller = new AbortController();
  try {
    const res = await fetch(`/api/search?q=${encodeURIComponent(q)}`, {
      signal: controller.signal,
    });
    return await res.json();
  } catch (e) {
    if ((e as Error).name === "AbortError") return null;
    throw e;
  }
}
```

## チェックリスト

- [ ] 前回リクエストの中断処理がある
- [ ] `AbortError` を分岐処理している
- [ ] 古いレスポンスで画面更新しない
- [ ] unmount 時に通信を中断している

## 関連テンプレート / プレイブック

- [Multi Step Form Race Condition](./multi-step-form-race-condition.md)
- [Response Change Checklist](../api/response-change-checklist.md)
