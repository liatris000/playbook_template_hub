# 技術テンプレ: API / バリデーション / テスト

## 対象資産

<!-- markdownlint-disable MD013 -->
| パス | ラベル | 用途 |
|---|---|---|
| `src/infra/api/with-auth.ts`（`toResponse`） | B | ServiceResult -> HTTP レスポンス変換 |
| `project-docs/06_API_SPEC.md`（テンプレ部） | B | エンドポイント設計のひな形 |
| `project-docs/10_ERROR_HANDLING.md` | B | エラー分類と共通レスポンス方針 |
| `project-docs/07_TEST_PLAN.md` | B | unit/integration/e2e 戦略 |
| `tests/unit/**`, `tests/integration/**`, `tests/e2e/**` | B | レイヤ別テスト配置の雛形 |
<!-- markdownlint-enable MD013 -->

## 置換ポイント

- API 契約: `{API_RESOURCE}`, `{PAGINATION_RULE}`
- バリデーション: `{VALIDATION_SCHEMA}`（Zod 前提を維持するか）
- エラー方針: `{ERROR_CONTRACT}`（`error`, `details` 形式）
- テスト運用: `{CI_TEST_COMMANDS}`（実行順・閾値）

## 最小移植手順

1. 代表 API 1 本に対して request/response 契約テストを先に作成する
2. バリデーション不正（400）とサーバー例外（500）の失敗系テストを先に作成する
3. 実装後に unit/integration/e2e を最低1本ずつ追加する

## 受け入れチェック

- [ ] API レスポンス形式が全エンドポイントで一貫している
- [ ] バリデーションが単一ソース（Zod など）に集約されている
- [ ] 失敗系テスト（400/401/403/500）がある
- [ ] CI でテストが安定実行できる
