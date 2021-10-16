--/********* A. BASIC QUERY *********/
-- 1. Li?t kê danh sách sinh viên s?p x?p theo th? t?:
--      a. id t?ng d?n
--select * from Student 
--order by id
--      b. gi?i tính
--select * from Student 
--order by gender  

--      c. ngày sinh T?NG D?N và h?c b?ng GI?M D?N
--select * from Student 
--order by birthday asc , scholarship desc

-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
--select * from subject 
--where name like 'T%'
-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
--SELECT
--    * FROM subject
--    where name like '%i'
-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
--select * from faculty
--where name like '_n%'

-- 5. Sinh viên trong tên có t? 'Th?'
--select * from student
--where name like '%Th?%'
-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
--select * from student
--where  REGEXP_LIKE (name, '^[A-Z]')
--order by name 

-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
--SELECT
--    * FROM student
--    where scholarship >100000
--    ORDER BY faculty_id desc

-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
--SELECT
--    * FROM student
--    where scholarship >=150000
--            and hometown like 'Hà N?i'

-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
--SELECT
--    * FROM student
--    where birthday BETWEEN TO_DATE('01/01/1991', 'DD/MM/YYYY') AND TO_DATE('05/06/1992', 'DD/MM/YYYY')

-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
--SELECT
--    * FROM student
--    where scholarship BETWEEN 80000 and 150000

-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
--select * from subject
--where lesson_quantity  > 30 and lesson_quantity < 45

--/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.
        
--        select s.id, s.gender,f.id, s.scholarship , 
--        CASE        
--            WHEN s.scholarship IS NULL THEN 'Không có h?c b?ng'
--            WHEN s.scholarship >=  180000 THEN 'H?c b?ng cao'
--            ELSE 'M?c trung bình'
--        END as loaiHb
--        from student s
--        INNER JOIN faculty f ON s.faculty_id = f.id
        

--2. Tính t?ng s? sinh viên c?a toàn tr??ng
--select count(id) as Total_Student FROM STUDENT 

-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
--select gender,  count(id) as Total_Student FROM STUDENT
--GROUP BY gender

-- 4. Tính t?ng s? sinh viên t?ng khoa (ch?a c?n JOIN)
--select faculty_id , count(faculty_id) as Total_Student from student
--group by faculty_id
--order by faculty_id

-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
--select subject.id, subject.name, count(exam_management.student_id) as total from subject 
--LEFT JOIN exam_management on subject.id = exam_management.subject_id
--GROUP by subject.id,  subject.name
--order by subject.id asc
 
 -- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
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

-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
--select f.id, f.name,s.gender, count(s.id) as total_Student
--from faculty f
--LEFT JOIN student s ON f.id = s.faculty_id
--GROUP by  f.id, f.name ,s.gender
--order by f.id

-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
--select distinct EXTRACT(YEAR FROM s.birthday) as years, count(s.id) as total_sv from student s
--group by EXTRACT(YEAR FROM s.birthday)

-- 11. Cho bi?t nh?ng n?i nào có h?n 2 sinh viên ?ang theo h?c t?i tr??ng
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

--13. Cho biet nhung sinh vien nam co diem trung binh lan 1 trên 7.0 
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
-- 14. Cho bi?t danh sách các sinh viên r?t trên 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)


-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam (ch?a c?n JOIN)
--select student.faculty_id, count(student.id) from student 
--where student.gender like 'Nam'
--group by student.faculty_id
--having count(student.id) > 2


-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
--select f.id, f.name from faculty f
--left JOIN student s on f.id = s.faculty_id
--where s.scholarship BETWEEN 200000 and 300000 
--GROUP by f.id , f.name
--having count(s.id)>=2

-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
--select  student.id, student.name,  student.scholarship from student
--group by student.id , student.name, student.scholarship
--having scholarship >= (select max(scholarship) from student)

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
--select * from student 
--where  hometown like 'Hà N?i' and EXTRACT(Month FROM birthday) = 2

-- 2. Sinh viên có tu?i l?n h?n 20
--select * from student
--where months_between(sysdate, birthday) / 12 > 20

-- 3. Sinh viên sinh vào mùa xuân n?m 1990
--select * from student
--where  EXTRACT(year FROM birthday) like '1990' and EXTRACT(month FROM birthday)
--BETWEEN 1 and 3

/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
--select f.name , count(s.id) from faculty f
--inner join student s on s.faculty_id = f.id 
--where f.id = 1 or f.id =4
--group by f.name 

-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
--select * from student
--where faculty_id = 1 or faculty_id = 2 and s.gender like 'Nam'


-- 3. Cho biet sinh viên nào có diem  thi lan 1 môn co so du lieu cao nhat
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

-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.
--select * from  student 
--where months_between(sysdate, birthday) / 12 =
--         (select  max(months_between(sysdate, birthday) / 12) 
--        from  student where faculty_id = 1 )



-- 5. Cho bi?t khoa nào có dông sinh viên nh?t




-- 6. Cho bi?t khoa nào có ?ông n? nh?t
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

-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn
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

-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c
--select f.* from faculty f
--left join student s on s.faculty_id = f.id
--WHERE s.id is null


-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u
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

-- 10. Cho biet sinh viên nào không thi lan 1 mà có da thi lan 2
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