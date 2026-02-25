# ADR-0001: このリポジトリを汎用資産の正本とする

- Status: Accepted
- Date: 2026-02-26

## Context

個人運用で Obsidian に下書きが蓄積されるが、そのままでは再利用資産の正本管理が難しい。

## Decision

- Obsidian は下書き専用
- このリポジトリは確定版の正本
- 同期は Obsidian -> Repo の片方向
- 汎用資産は `docs/core` と `docs/templates`、業種別は `docs/examples` に分離

## Consequences

- メモと正本の役割が明確になる
- 再利用時の探索コストが下がる
- 初期運用では削除同期を禁止し、誤削除リスクを避ける
