# Supabase RPC 判断ガイド

## 概要

複数DB操作を一貫性ある単位として扱うべきかを判断し、必要時のみ RPC 化する。
不要な RPC 乱用と整合性欠如の両方を避ける。

## 適用条件

- 2件以上のDB更新を1操作として扱いたい
- 途中失敗時に不整合が発生しうる
- 権限制御や監査をDB側へ寄せたい

## アンチパターン

- 単純 CRUD まで無条件で RPC 化する
- 不整合リスクがある複数操作をクライアント直列実行する
- RPC の入出力契約を定義しない

## 推奨パターン

1. 「部分成功が許容されるか」を最初に判定する
2. 不許容なら RPC でトランザクション化する
3. RPC の戻り値はアプリ契約に沿って固定する
4. エラーコードをアプリ層へマッピングする

## 最小実装例

```sql
create or replace function public.create_order_with_items(_order jsonb, _items jsonb)
returns jsonb
language plpgsql
as $$
begin
  -- insert order
  -- insert items
  return jsonb_build_object('ok', true);
exception when others then
  raise;
end;
$$;
```

## チェックリスト

- [ ] 部分成功の許容可否を明示した
- [ ] RPC 入出力スキーマを定義した
- [ ] 正常系と失敗系の契約テストを追加した
- [ ] エラーマッピング規約に接続した

## 関連テンプレート / プレイブック

- [Transaction RPC Pattern](./transaction-rpc-pattern.md)
- [Error Mapping Guide](./error-mapping-guide.md)
