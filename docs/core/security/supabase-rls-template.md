# 技術テンプレ: Supabase RLS

RLS は「動けばOK」ではなく、「想定外アクセスを確実に拒否できるか」を検証する領域です。  
このテンプレは、RLS 変更時の最低限の安全手順を定義します。

## 対象資産

| パス | ラベル | 用途 |
|---|---|---|
| `project-docs/07_SUPABASE_PRODUCTION_DESIGN.md` | B | RLS 方針の正本 |
| `supabase/migrations/` | B | POLICY/GRANT の変更履歴 |
| `.agents/skills/auth-rls/` | C | プロジェクト固有の認可前提（転用時は再定義） |

## RLS 変更時の必須ステップ

1. テーブル設計変更と RLS 変更を同時に設計する
2. `ENABLE ROW LEVEL SECURITY` の有無を確認する
3. `SELECT/INSERT/UPDATE/DELETE` の各ポリシーを明示する
4. サービスロールと通常ロールのアクセス境界を明示する
5. 主要 API テストで「許可されるケース/拒否されるケース」を両方検証する

## 失敗しやすいポイント

- `SELECT` だけ定義して `UPDATE` を忘れる
- 新テーブル作成後に RLS 有効化を忘れる
- `USING` と `WITH CHECK` の条件が不一致
- 管理者向け例外を広く書きすぎて全件閲覧可能になる
- RLS 変更後に API テストを更新せず、実運用で 403/500 が増える

## PR 前チェックリスト（RLS）

- [ ] 新規テーブルは RLS 有効化済み
- [ ] 4操作（SELECT/INSERT/UPDATE/DELETE）のポリシー有無を確認した
- [ ] `USING` / `WITH CHECK` が期待通りか確認した
- [ ] 拒否系テスト（アクセス不可）が追加されている
- [ ] 管理者例外の条件が最小権限になっている
- [ ] 適用後の監視項目（403増加、API失敗率）を定義した

## 今は未実施でも導入推奨

- policy 単体テストの自動化（許可/拒否マトリクス）
- `DROP POLICY` / `ALTER POLICY` のレビュー強化（2名承認）
- 本番前に「匿名ユーザー・一般ユーザー・管理者」の3ロール回帰テストを自動実行
