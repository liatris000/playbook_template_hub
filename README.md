# playbook_template_hub

汎用プレイブック・テンプレート・業種別サンプルを管理する個人用リポジトリです。

## 目的

- Obsidian の下書きから、確定版ドキュメントを昇格して管理する
- 案件横断で再利用できる運用資産を一元管理する
- 業種別ドキュメントは `examples/` に分離し、汎用資産と混在させない

## 運用モデル

- 下書き: Obsidian Vault 内の `playbook_template_hub`
- 正本: このリポジトリ
- 同期方向: Obsidian -> Repo（片方向）
- 同期方式: `scripts/sync_from_obsidian.sh`
- 同期設定:
  - 共有テンプレ: `sync/manifest.yaml`
  - ローカル上書き: `sync/manifest.local.yaml`（git管理外）

## ディレクトリ構成

- `docs/core/`: 汎用プレイブック
- `docs/templates/`: 再利用テンプレート
- `docs/examples/`: 業種別サンプル
- `docs/adr/`: 意思決定ログ（ADR）
- `sync/`: 同期マニフェスト
- `scripts/`: 同期・補助スクリプト

## クイックスタート

```bash
# 1) 初回のみ: ローカル用 manifest を作成
cp sync/manifest.yaml sync/manifest.local.yaml

# 2) source_root をローカル環境に合わせる
# 例: /path/to/your/ObsidianVault/playbook_template_hub
$EDITOR sync/manifest.local.yaml

# 3) Obsidian -> Repo 同期を実行
bash scripts/sync_from_obsidian.sh

# 4) 変更を確認
git status
```

## ルール

- `docs/core` と `docs/templates` は業種依存の表現を避ける
- 業種依存は `docs/examples/<domain>` に置く
- 破壊的な同期（削除反映）は初期運用では禁止
- Obsidian に置いただけでは反映されない。
  `sync_from_obsidian.sh` 実行後に `git commit` / `git push` する
- ローカル固有パスは `sync/manifest.local.yaml` にのみ記載する
- 個社情報・非公開情報は `_private/` 配下に置く（同期除外）
- public 公開前に、固有名詞・内部ID・機密文字列をスキャンして除去する

## Public公開前チェック

```bash
# 1) 同期
bash scripts/sync_from_obsidian.sh

# 2) 差分確認
git status
git diff

# 3) 公開NGワードの簡易スキャン
rg -n \
  "YMN|ymn|#[0-9]+|token|secret|password|api[_-]?key|/Users/" \
  docs -g "*.md" || true
```
