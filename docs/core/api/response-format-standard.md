# API レスポンス形式統一規約

## 概要

API レスポンスを成功・失敗で統一し、クライアント実装とテストのばらつきを減らす。
基本形式を `{ data: T }` / `{ error: { code, message } }` に固定する。

## 適用条件

- HTTP API を複数エンドポイントで提供する
- フロントエンドで共通パーサを使いたい
- 失敗時のハンドリングを一貫化したい

## アンチパターン

- エンドポイントごとにレスポンス形が異なる
- 失敗時にプレーン文字列だけ返す
- ステータスコードとボディの意味が一致しない

## 推奨パターン

1. 成功時は必ず `data` キーで包む
2. 失敗時は `error.code` と `error.message` を返す
3. HTTP ステータスと `error.code` の対応表を持つ
4. 仕様変更時は互換期間を設ける

## 最小実装例

```ts
type ApiSuccess<T> = { data: T };
type ApiError = { error: { code: string; message: string } };

return Response.json({ data: payload } satisfies ApiSuccess<User>);
// 失敗時
return Response.json(
  { error: { code: "VALIDATION_ERROR", message: "invalid input" } } satisfies ApiError,
  { status: 422 }
);
```

## チェックリスト

- [ ] 全エンドポイントが `data` / `error` 形式に従っている
- [ ] エラーコードを仕様書に列挙している
- [ ] クライアント側で共通デコード関数を利用している
- [ ] 契約テストでレスポンス構造を固定している

## 関連テンプレート / プレイブック

- [Response Change Checklist](./response-change-checklist.md)
- [API Test Template](../../templates/api-contract/api-test-template.md)
