--/********* A. BASIC QUERY *********/
-- 1. Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t?:
--      a. id t?ng d?n
--select * from Student 
--order by id
--      b. gi?i t�nh
--select * from Student 
--order by gender  

--      c. ng�y sinh T?NG D?N v� h?c b?ng GI?M D?N
--select * from Student 
--order by birthday asc , scholarship desc

-- 2. M�n h?c c� t�n b?t ??u b?ng ch? 'T'
--select * from subject 
--where name like 'T%'
-- 3. Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'
--SELECT
--    * FROM subject
--    where name like '%i'
-- 4. Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'
--select * from faculty
--where name like '_n%'

-- 5. Sinh vi�n trong t�n c� t? 'Th?'
--select * from student
--where name like '%Th?%'
-- 6. Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n
--select * from student
--where  REGEXP_LIKE (name, '^[A-Z]')
--order by name 

-- 7. Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n
--SELECT
--    * FROM student
--    where scholarship >100000
--    ORDER BY faculty_id desc

-- 8. Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i
--SELECT
--    * FROM student
--    where scholarship >=150000
--            and hometown like 'H� N?i'

-- 9. Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992
--SELECT
--    * FROM student
--    where birthday BETWEEN TO_DATE('01/01/1991', 'DD/MM/YYYY') AND TO_DATE('05/06/1992', 'DD/MM/YYYY')

-- 10. Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000
--SELECT
--    * FROM student
--    where scholarship BETWEEN 80000 and 150000

-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45
--select * from subject
--where lesson_quantity  > 30 and lesson_quantity < 45

--/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
		-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr? 
		-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.
        
--        select s.id, s.gender,f.id, s.scholarship , 
--        CASE        
--            WHEN s.scholarship IS NULL THEN 'Kh�ng c� h?c b?ng'
--            WHEN s.scholarship >=  180000 THEN 'H?c b?ng cao'
--            ELSE 'M?c trung b�nh'
--        END as loaiHb
--        from student s
--        INNER JOIN faculty f ON s.faculty_id = f.id
        

--2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng
--select count(id) as Total_Student FROM STUDENT 

-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.
--select gender,  count(id) as Total_Student FROM STUDENT
--GROUP BY gender

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa (ch?a c?n JOIN)
--select faculty_id , count(faculty_id) as Total_Student from student
--group by faculty_id
--order by faculty_id

-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c
--select subject.id, subject.name, count(exam_management.student_id) as total from subject 
--LEFT JOIN exam_management on subject.id = exam_management.subject_id
--GROUP by subject.id,  subject.name
--order by subject.id asc
 
 -- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c
-- select count(DISTINCT subject_id ) as total_subject from exam_management 

-- 7. T?ng s? h?c b?ng c?a m?i khoa	
--select f.id, f.name, count(s.scholarship) as total_scholarship from faculty f
--LEFT JOIN student s ON f.id = s.faculty_id
--GROUP by f.id, f.name
 
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
--select f.id, f.name, max(s.scholarship)   
--from faculty f
--LEFT JOIN student s ON f.id = s.faculty_id
--where s.scholarship is not null
--GROUP by f.id, f.name

-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa
--select f.id, f.name,s.gender, count(s.id) as total_Student
--from faculty f
--LEFT JOIN student s ON f.id = s.faculty_id
--GROUP by  f.id, f.name ,s.gender
--order by f.id

-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i
--select distinct EXTRACT(YEAR FROM s.birthday) as years, count(s.id) as total_sv from student s
--group by EXTRACT(YEAR FROM s.birthday)

-- 11. Cho bi?t nh?ng n?i n�o c� h?n 2 sinh vi�n ?ang theo h?c t?i tr??ng
--select s.hometown,  count(s.id)  from student s
--GROUP by s.hometown
--HAVING count(s.id)>2

-- 12. cho biet nhung sinh vien thi lai it nhat 2 lan
--SELECT
--    id,
--    name
--FROM
--         student
--    INNER JOIN (
--        SELECT
--            student_id,
--            COUNT(student_id)
--        FROM
--            exam_management
--        WHERE
--            number_of_exam_taking = 2
--        GROUP BY
--            student_id
--        HAVING
--            COUNT(student_id) >= 2
--    ) ON student.id = student_id

--13. Cho biet nhung sinh vien nam co diem trung binh lan 1 tr�n 7.0 
--SELECT
--   s.id, s.name, s.gender
--FROM
--         student s
--    INNER JOIN (
--        SELECT
--            student_id,
--            AVG(mark)
--        FROM
--            exam_management
--        WHERE
--            number_of_exam_taking = 1
--        GROUP BY
--            student_id
--        HAVING
--            AVG(mark) > 7
--    ) ON s.id = student_id
--WHERE
--    gender LIKE 'Nam'
-- 14. Cho bi?t danh s�ch c�c sinh vi�n r?t tr�n 2 m�n ? l?n thi 1 (r?t m�n l� ?i?m thi c?a m�n kh�ng qu� 4 ?i?m)


-- 15. Cho bi?t danh s�ch nh?ng khoa c� nhi?u h?n 2 sinh vi�n nam (ch?a c?n JOIN)
--select student.faculty_id, count(student.id) from student 
--where student.gender like 'Nam'
--group by student.faculty_id
--having count(student.id) > 2


-- 16. Cho bi?t nh?ng khoa c� 2 sinh vi�n ??t h?c b?ng t? 200000 ??n 300000
--select f.id, f.name from faculty f
--left JOIN student s on f.id = s.faculty_id
--where s.scholarship BETWEEN 200000 and 300000 
--GROUP by f.id , f.name
--having count(s.id)>=2

-- 17. Cho bi?t sinh vi�n n�o c� h?c b?ng cao nh?t
--select  student.id, student.name,  student.scholarship from student
--group by student.id , student.name, student.scholarship
--having scholarship >= (select max(scholarship) from student)

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh vi�n c� n?i sinh ? H� N?i v� sinh v�o th�ng 02
--select * from student 
--where  hometown like 'H� N?i' and EXTRACT(Month FROM birthday) = 2

-- 2. Sinh vi�n c� tu?i l?n h?n 20
--select * from student
--where months_between(sysdate, birthday) / 12 > 20

-- 3. Sinh vi�n sinh v�o m�a xu�n n?m 1990
--select * from student
--where  EXTRACT(year FROM birthday) like '1990' and EXTRACT(month FROM birthday)
--BETWEEN 1 and 3

/********* D. JOIN QUERY *********/

-- 1. Danh s�ch c�c sinh vi�n c?a khoa ANH V?N v� khoa V?T L�
--select f.name , count(s.id) from faculty f
--inner join student s on s.faculty_id = f.id 
--where f.id = 1 or f.id =4
--group by f.name 

-- 2. Nh?ng sinh vi�n nam c?a khoa ANH V?N v� khoa TIN H?C
--select * from student
--where faculty_id = 1 or faculty_id = 2 and s.gender like 'Nam'


-- 3. Cho biet sinh vi�n n�o c� diem  thi lan 1 m�n co so du lieu cao nhat
SELECT
    e1.student_id,
    e1.mark
FROM
    exam_management e1
WHERE
        e1.subject_id = 1
    AND e1.number_of_exam_taking = 1
GROUP BY
    e1.student_id,
    e1.mark
HAVING
    e1.mark = (
        SELECT
            MAX(mark)
        FROM
            exam_management e2
        WHERE
                e2.subject_id = 1
            AND e2.number_of_exam_taking = 1
    )

-- 4. Cho bi?t sinh vi�n khoa anh v?n c� tu?i l?n nh?t.
--select * from  student 
--where months_between(sysdate, birthday) / 12 =
--         (select  max(months_between(sysdate, birthday) / 12) 
--        from  student where faculty_id = 1 )



-- 5. Cho bi?t khoa n�o c� d�ng sinh vi�n nh?t




-- 6. Cho bi?t khoa n�o c� ?�ng n? nh?t
--SELECT
--    f.id,
--    f.name,
--    COUNT(s.id) AS count
--FROM
--         faculty f
--    INNER JOIN student s ON s.faculty_id = f.id
--GROUP BY
--    f.id,
--    f.name
--HAVING
--    COUNT(s.id) = (
--        SELECT
--            MAX(countsv)
--        FROM
--            (
--                SELECT
--                    student.faculty_id,
--                    COUNT(student.id) AS countsv
--                FROM
--                    student
--                WHERE
--                    student.gender LIKE 'N?'
--                GROUP BY
--                    student.faculty_id
--            )
--    )

-- 7. Cho bi?t nh?ng sinh vi�n ??t ?i?m cao nh?t trong t?ng m�n
--SELECT
--    student.id,
--    student.name,
--    subject.name,
--    tempmax.mark
--FROM
--         student
--    INNER JOIN (
--        SELECT
--            exam_management.student_id,
--            exam_management.subject_id,
--            exam_management.mark
--        FROM
--                 exam_management
--            INNER JOIN (
--                SELECT
--                    e.subject_id,
--                    MAX(e.mark) AS mark
--                FROM
--                    exam_management e
--                GROUP BY
--                    e.subject_id
--                ORDER BY
--                    e.subject_id
--            ) maxmarksubject ON exam_management.subject_id = maxmarksubject.subject_id
--        WHERE
--            exam_management.mark = maxmarksubject.mark
--    ) tempmax ON student.id = tempmax.student_id
--    INNER JOIN subject ON subject.id = tempmax.subject_id

-- 8. Cho bi?t nh?ng khoa kh�ng c� sinh vi�n h?c
--select f.* from faculty f
--left join student s on s.faculty_id = f.id
--WHERE s.id is null


-- 9. Cho bi?t sinh vi�n ch?a thi m�n c? s? d? li?u
--SELECT
--    s.id,
--    s.name
--FROM
--    student s
--    LEFT JOIN (
--        SELECT
--            e.student_id,
--            e.subject_id,
--            sb.name
--        FROM
--                 exam_management e
--            INNER JOIN subject sb ON sb.id = e.subject_id
--    )   ON student_id = s.id
--WHERE
--    student_id IS NULL

-- 10. Cho biet sinh vi�n n�o kh�ng thi lan 1 m� c� da thi lan 2
--SELECT
--    s.id,
--    s.name,
--    sb.name
--FROM
--         student s
--    INNER JOIN (
--        SELECT
--            st2,
--            sb2
--        FROM
--            (
--                SELECT
--                    e2.student_id AS st2,
--                    e2.subject_id AS sb2
--                FROM
--                    exam_management e2
--                WHERE
--                    e2.number_of_exam_taking = 2
--            )
--            LEFT JOIN (
--                SELECT
--                    e1.student_id AS st1,
--                    e1.subject_id
--                FROM
--                    exam_management e1
--                WHERE
--                    e1.number_of_exam_taking = 1
--            ) ON st1 = st2
--        WHERE
--            st1 IS NULL
--    )       temp ON temp.st2 = s.id
--    INNER JOIN subject sb ON sb.id = temp.sb2