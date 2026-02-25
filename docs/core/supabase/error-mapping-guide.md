# Supabase エラーマッピングガイド

## 概要

DB/SDK エラーをアプリ公開エラーへ正規化し、UI と監視の一貫性を保つ。
内部詳細をそのまま公開せず、利用者向けメッセージと内部ログを分離する。

## 適用条件

- API が Supabase エラーを受け取る
- フロントに表示するエラーを統一したい
- 監視でエラー分類を行いたい

## アンチパターン

- 生のエラーメッセージをそのまま返す
- ステータスコードと業務エラーの意味が不一致
- 同種エラーでメッセージが毎回変わる

## 推奨パターン

1. `source_error -> app_error_code -> http_status` の表を持つ
2. 返却は `error.code` を主、表示文言は別管理にする
3. ログには相関IDと内部詳細を記録する
4. 未分類エラーは `INTERNAL_ERROR` にフォールバックする

## 最小実装例

```ts
function mapSupabaseError(code?: string) {
  if (code === "23505") return { status: 409, appCode: "CONFLICT" };
  if (code === "42501") return { status: 403, appCode: "FORBIDDEN" };
  return { status: 500, appCode: "INTERNAL_ERROR" };
}
```

## チェックリスト

- [ ] 主要エラーコードの対応表を作成した
- [ ] UI で扱う公開コードを固定した
- [ ] 未分類エラーのフォールバックを実装した
- [ ] 監視でエラー分類できるログ項目を出力した

## 関連テンプレート / プレイブック

- [Response Format Standard](../api/response-format-standard.md)
- [RPC Decision Guide](./rpc-decision-guide.md)
