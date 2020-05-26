-- Уменьшить цену всех книг изданных более 10 лет назад, на 5 процентов --
UPDATE book SET cost = cost*0.95
WHERE (julianday('now') - julianday(date_of_receipt)) > 3650;