# Supabase トランザクション RPC パターン

## 概要

整合性が必要な複数操作を1つのRPCに集約し、ロールバック可能な単位にする。
アプリ層は RPC をユースケース単位の API として扱う。

## 適用条件

- 親子テーブルの同時作成
- 在庫や残高のような競合しやすい更新
- 複数テーブル更新の原子性が必須

## アンチパターン

- クライアントから逐次 `insert/update` を連鎖実行する
- RPC 内で権限前提を曖昧にする
- 失敗時にアプリ側が復旧責務を負う

## 推奨パターン

1. 1ユースケース1RPCにまとめる
2. 必要なら `security definer` と RLS を併用する
3. 入力検証を DB とアプリ双方で行う
4. 返却値は最小情報に絞る

## 最小実装例

```ts
const { data, error } = await supabase.rpc("create_order_with_items", {
  _order: orderPayload,
  _items: itemPayloads,
});

if (error) {
  throw new Error("ORDER_CREATE_FAILED");
}
```

## チェックリスト

- [ ] RPC 単位がユースケース単位になっている
- [ ] トランザクション境界を明示した
- [ ] RLS/権限の検証を含めた
- [ ] 競合時の再試行方針を決めた

## 関連テンプレート / プレイブック

- [Supabase RLS Template](../security/supabase-rls-template.md)
- [RPC Decision Guide](./rpc-decision-guide.md)
