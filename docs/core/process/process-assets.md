# 開発プロセス再利用資産

このドキュメントは「実装内容ではなく、開発の進め方」を別受託案件へ移植するための一覧です。

## 対象

- Issue 取り込み
- docs -> issue -> code の進行順
- TDD の実行手順
- レビュー/CI/運用チェック

## 資産マトリクス（プロセス）

<!-- markdownlint-disable MD013 -->
| パス | ラベル | 理由 | 別案件での扱い |
|---|---|---|---|
| `.claude/CLAUDE.md`（プロセス系ルール） | B | 固有ルールも含む | 固有語を置換して流用 |
| `.claude/rules/workflow/` | A | ワークフロー中心 | そのままコピー |
| `.claude/skills/implement-issue-tdd/` | A | 汎用 TDD 手順 | そのままコピー |
| `.claude/skills/create-issue/` | A | 汎用 Issue 作成手順 | そのままコピー |
| `.claude/skills/review-pr/` | A | 汎用レビュー手順 | そのままコピー |
| `.claude/skills/sync-docs/` | A | ドキュメント同期手順 | そのままコピー |
| `docs/CODEX_GUIDE.md` | A | Codex 運用ガイド | そのままコピー |
| `project-docs/07_TEST_PLAN.md`（運用方針部） | B | 実行系は汎用、対象機能は固有 | テスト対象を置換して流用 |
| `docs/examples/b_support/bootstrap.md` | B | 新規CRM立ち上げの実務チェック | 業務用語を置換して流用 |
| `docs/examples/b_support/requirements-template.md` | B | 問い合わせ -> 成約の要件雛形 | ステータスとACを業務に合わせて置換 |
<!-- markdownlint-enable MD013 -->

## 抽出手順（プロセス編）

1. A ラベルをコピーし、`rules` と `skills` を先に有効化する
2. B ラベルは `{COMPANY_NAME}` `{PROJECT_NAME}` `{ROLE_MATRIX}` を置換する
3. CI で `npm run lint` `npm test` `npm run build` が通る最小フローを確認する

## 最低限の受け入れ条件

- [ ] Issue 取り込みテンプレートが存在する
- [ ] TDD 手順（Fail -> Implement -> Refactor）が明文化されている
- [ ] PR 前チェック（lint/test/build）が定義されている
- [ ] ドキュメント同期ルール（正本/補助資料）が定義されている

## 補助資料

- マージ時の再発防止: [failure-patterns.md](./failure-patterns.md)
