-- income, expense on homepage

SELECT 
  t.name AS transaction_type,
  SUM(pt.amount) AS total_amount
FROM users u
JOIN wallet w ON w.user_id = u.id
JOIN pocket p ON p.wallet_id = w.id
JOIN pocket_trx pt ON pt.pocket_id = p.id
JOIN trx_type t ON t.id = pt.type_id
GROUP BY t.name;
