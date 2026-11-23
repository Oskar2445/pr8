-- Практична робота 8. Варіант 1 — Бібліотека
-- База продовжує lab_work_7.db; структура таблиць не змінюється.
PRAGMA foreign_keys = ON;

-- Завдання 1. COUNT(*) проти COUNT(return_date).
SELECT COUNT(*) AS усі_видачі,
       COUNT(return_date) AS видачі_з_датою_повернення
FROM loans;
-- Результат: усі_видачі = 7; видачі_з_датою_повернення = 4;
-- NULL у return_date = 3.

-- Завдання 2. SUM і AVG кількості примірників книг.
SELECT SUM(copies_count) AS усі_примірники,
       AVG(copies_count) AS середня_кількість_примірників,
       COUNT(copies_count) AS книг_з_відомою_кількістю
FROM books;
-- Результат: SUM = 22; AVG = 3.142857142857143; COUNT = 7.

-- Завдання 3. MIN/MAX на текстовій колонці та даті.
SELECT MIN(title) AS перша_назва_за_сортуванням,
       MAX(title) AS остання_назва_за_сортуванням
FROM books;
-- Результат: MIN(title) = Захар Беркут; MAX(title) = Чорна рада.

SELECT MIN(loan_date) AS найраніша_видача,
       MAX(loan_date) AS найпізніша_видача
FROM loans;
-- Результат: MIN(loan_date) = 2026-10-01; MAX(loan_date) = 2026-10-17.

-- Завдання 4. Комбінований звіт по всіх видачах (5 агрегатів).
SELECT COUNT(*) AS total_loans,
       COUNT(return_date) AS returned_loans,
       MIN(loan_date) AS first_loan_date,
       MAX(loan_date) AS last_loan_date,
       AVG(julianday(return_date) - julianday(loan_date)) AS avg_loan_days
FROM loans;
-- Результат: (7, 4, '2026-10-01', '2026-10-17', 15.75).

-- Завдання 5. Агрегат з фільтром за виміром books.genre.
SELECT COUNT(*) AS loan_count,
       COUNT(l.return_date) AS returned_count
FROM loans AS l
INNER JOIN books AS b ON l.book_id = b.id
WHERE b.genre = 'Роман';
-- Результат для жанру "Роман": (2, 2).

-- Контрольне питання 3: SUM повертає NULL, якщо всі вхідні значення NULL.
-- NULLIF(x,x) дає NULL для кожного рядка, не змінюючи таблицю.
SELECT SUM(NULLIF(copies_count, copies_count)) AS sum_of_all_nulls
FROM books;
-- Результат: None.
