# 技術テンプレ: 認証/認可（Auth/AuthZ）

## 対象資産

| パス | ラベル | 用途 |
|---|---|---|
| `src/infra/api/with-auth.ts` | B | API の認証/認可ラッパー（`withAuth`, `withRole`） |
| `src/domains/auth/types.ts` | B | ロール型・セッション型 |
| `src/domains/auth/permissions.ts` | B | 権限マトリクス |
| `src/app/api/auth/*` | B | ログイン/ログアウト/コールバック/me API |
| `tests/unit/lib/api/with-auth.test.ts` | B | 401/500 失敗系テスト |
| `tests/integration/api/auth/*.test.ts` | B | 認証 API 結合テスト |

## 置換ポイント

- 認証方式: `{AUTH_PROVIDER}`（Supabase/Auth0/Cognito 等）
- ロール定義: `{ROLE_MATRIX}`（admin/manager 等）
- ホワイトリスト戦略: `allowed_users` を使うかどうか
- エラーメッセージ: 日本語/英語、監査ログ要件

## 最小移植手順

1. `withAuth` と `withRole` を先に移植する
2. `Role` 型と `permissions` を新案件に合わせて置換する
3. `/api/auth/me` を先に通し、セッション取得を確認する
4. 401/403/200 の3系統テストを先に失敗させてから実装する

## 受け入れチェック

- [ ] 未認証アクセスで 401 が返る
- [ ] 権限不足で 403 が返る
- [ ] 許可ロールで 200 が返る
- [ ] 監査ログ/セキュリティイベントの最小記録ができる
