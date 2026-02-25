# CI グリーン維持ポリシー

## 概要

CI を常時グリーンに保つことで、テスト不整合の蓄積と緊急修復コストを抑える。
壊れた状態を許容しない運用を明文化する。

## 適用条件

- 複数人または複数ブランチで開発している
- `lint` / `test` / `build` を CI で実行している
- マージ後に main を安定稼働させたい

## アンチパターン

- CI 失敗を「既存失敗」として放置してマージする
- 失敗原因の切り分け前に別変更を積み増す
- main の赤状態を長時間放置する

## 推奨パターン

1. main へのマージ条件を CI success に固定する
2. 失敗時は最優先で main を復旧する
3. 変更粒度を小さく保ち、失敗範囲を局所化する
4. ローカルで `lint` / `test` / `build` を先に通す

## 最小実装例

```yaml
# .github/workflows/ci.yml
name: ci
on: [pull_request]
jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run build
```

## チェックリスト

- [ ] main へのマージ条件に CI success を設定した
- [ ] 失敗時の担当アサイン手順を決めた
- [ ] PR 作成前のローカル検証コマンドを統一した
- [ ] 赤状態の許容時間（SLO）を決めた

## 関連テンプレート / プレイブック

- [Failure Patterns](./failure-patterns.md)
- [Migration Safety Playbook](../migration/migration-safety-playbook.md)
