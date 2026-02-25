# 技術テンプレ: ツール基盤（Supabase / Vercel / Sentry）

## 対象資産

| パス | ラベル | 用途 |
|---|---|---|
| `project-docs/07_SUPABASE_PRODUCTION_DESIGN.md` | B | Supabase 本番運用設計 |
| `supabase/migrations/` | B | スキーマ/RLS の適用履歴 |
| `project-docs/08_DEPLOY_GUIDE.md` | B | Vercel デプロイ手順 |
| `vercel.json` | B | Vercel 設定雛形 |
| `sentry.server.config.ts`, `sentry.edge.config.ts`, `sentry.*` | B | 監視設定 |
| `project-docs/11_INCIDENT_RESPONSE.md` | B | インシデント運用 |

RLS 変更の詳細は
[supabase-rls-template.md](../../core/security/supabase-rls-template.md) を参照してください。

## 置換ポイント

- Supabase: `{SUPABASE_PROJECT}`, `{RLS_BOUNDARY}`, `{DB_ENVS}`
- Vercel: `{VERCEL_PROJECT}`, `{CUSTOM_DOMAIN}`, `{ENV_SECRETS}`
- Sentry: `{SENTRY_DSN}`, `{ALERT_CHANNEL}`
- OAuth: `{AUTH_REDIRECT_URI}`

## 最小移植手順

1. Supabase プロジェクトを新規作成し、主要マイグレーションを適用する
2. RLS 境界を新案件の権限モデルに合わせて再定義する
3. Vercel の Preview/Production に環境変数を分離設定する
4. Sentry DSN と通知先を設定し、テストエラー送信を確認する

## 受け入れチェック

- [ ] `supabase db reset` または同等の適用手順が成功する
- [ ] RLS の拒否系テスト（アクセス不可ケース）を確認した
- [ ] OAuth リダイレクト URI とデプロイドメインが一致している
- [ ] Vercel Preview と Production の両方でビルド成功
- [ ] Sentry にエラーイベントが届き、通知経路が機能している
