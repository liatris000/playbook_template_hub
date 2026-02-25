# core README

`core/` は案件横断で再利用するプレイブックを置く領域です。

## 方針

- 業種固有・顧客固有の語彙は避ける
- 実装言語に依存しない判断基準を先に書く
- サンプルコードは最小断片にする

## カテゴリ

- `process/`: 開発進行・運用ルール
- `api/`: API 契約と変更管理
- `supabase/`: Supabase 特有の判断・実装パターン
- `frontend/`: UI 実装時の不具合予防パターン
- `architecture/`, `migration/`, `security/`: 既存カテゴリ
