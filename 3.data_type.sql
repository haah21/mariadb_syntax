-- tinyint는 -128~127까지 표현
-- author 테이블에 age컬럼 추가

--insert시에 age : 200 -> 125
ALTER table author add column age tinyint;
-- tinyint 범위 벗어남 (age)
INSERT INTO author(id, name, email, age) VALUES(5,'new user','user5@mail.com',200);
-- tinyint 범위 안에 들어옴 (age)
INSERT INTO author(id, name, email, age) VALUES(5,'new user','user5@mail.com',125);

-- 부호 안씀 그만큼 양수로 범위 늘어남
-- unsigned시에 255까지 표현범위 확대
ALTER table author modify column age tinyint unsigned;
INSERT INTO author(id, name, email, age) VALUES(6,'new user2','user6@mail.com',200);

-- decimal 실습
ALTER table post ADD column price decimal(10,3);
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(id, title, contents, price) VALUES (6,'hello.java','content6',3.123123);
-- update: price를 1234.1
update post set price=1234.1 where id=6;


-- blob 바이너리 데이터 실습
-- author 테이블에 profile_image컬럼을 blob형식으로 추가
alter table author add column profile_image blob;
-- type 바꿀 때
alter table author modify column profile_image longblob;

-- 사진 파일 넣기
insert into author(id, email, profile_image)VALUES(9,'abc@naver.com',LOAD_FILE('/Users/test_picture.JPG'));

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼 추가
-- null로 들어오면 defalut로 설정되므로 not null 조건 필요 ㄴ
---  NOT NULL DEFAULT 'user' 등의 옵션도 추가 가능
-- ALTER TABLE author MODIFY column role enum('admin','user') NOT NULL DEFAULT 'user';
ALTER TABLE author MODIFY column role enum('admin','user') DEFAULT 'user';

-- enum 컬럼 실습
-- 많이 사용함 중요!
-- user1 insert -> error
INSERT INTO author(id, email, role) ADD column role enum(7,'abc@naver.com','user1','admin') NOT NULL;

-- user / admin insert -> 생성
INSERT INTO author(id, email, role) ADD column role enum(8,'abc@naver.com','user','admin') NOT NULL;

-- 실습 author table : 생년월일(date) , 가입일시(datetime)
-- date타입 : author table에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
ALTER TABLE author ADD column birth_day DATE;
INSERT INTO author(id, email, birth_day) VALUES (8, 'hello@naver.com','1999-01-01');

-- datetime 타입 mircro sec 쓰고 싶을 땐- datetime(4)
-- author, post 둘다 datetime으로 created_time 컬럼 추가
ALTER TABLE author ADD column created_time DATETIME;
ALTER TABLE post ADD column created_time DATETIME;

-- 시분초 입력 1999-01-01 12:01:00
INSERT INTO post (id, title, contents, created_time) VALUES(7, 'user9@naver.com','contents','2024-05-17 12:00:00');

-- 현재시간 넣을 필요 없이 defalut로 넣기
ALTER TABLE author MODIFY column created_time DATETIME DEFAULT CURRENT_TIMESTAMP;
INSERT INTO author(id, email) VALUES(9,'abc@naver.com');
ALTER TABLE post MODIFY column created_time DATETIME DEFAULT CURRENT_TIMESTAMP;
INSERT INTO post (id, title, contents) VALUES(8, 'user8@naver.com','contents');

-- 비교연산자
-- and 또는 &&
SELECT * FROM post WHERE id >= 2 AND id <= 4;
SELECT * FROM post WHERE id BETWEEN 2 AND 4;
-- or 또는  ||
SELECT * FROM post WHERE id < 2 OR id > 4;
-- not 또는 !
SELECT * FROM post WHERE NOT (id < 2 OR id > 4);
SELECT * FROM post WHERE !(id < 2 OR id > 4);

-- NULL인지 아닌지
select * from post where contents is null;
select * from post where contents is not null;

-- in(리스트형태), not in(리스트 형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
-- o로 끝나는 title 검색
select * from post where title like '%m';
-- h로 시작하는 title 검색
select * from post where title like 'h%';
-- 중간에 n이 들어가는 contents 검색
select * from post WHERE contents LIKE '%n%';

-- not like
-- m으로 끝나는 title 아닌 title 검색
select * from post where title not like '%m';

-- IFNULL(a,b) 흐름제어문 : 만약 a가 null이면 b반환, null이 아니면 a 반환
select title, contents author_id form post;
select title, contents, IFNULL(author_id, '익명') as 저자 FROM post;

-- 문제풀기 programmers 
-- 경기도에 위치한 식품창고 목록 출력하기
https://school.programmers.co.kr/learn/courses/30/lessons/131114

-- REGEXP : 정규표현식을 활용한 조회
-- NOT REGEXP도 있음
-- 영어로만 이루어져 있는 name 정규표현식을 만족하는 값만 찾기
select * FROM author where name REGEXP '[a-z]';

-- 한글로만 이루어져 있는 name 정규표현식을 만족하는 값만 찾기
select * FROM author where name REGEXP '[가-힣]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- CAST 와 CONVERT (cast를 주로 사용함)
-- CAST
select cast(20200101 as date);
-- 문자열도 사용가능
select cast('20200101' as date);
-- CONVERT
select CONVERT(20200101,date);
-- 문자열도 사용가능
select CONVERT('20200101',date);

-- datetime 조회 방법 (원하는 날짜조회)
select * from post where created_time like '2024-05%';

select * from post where created_time <= '2024-12-31' and created_time >= '2024-01-01';
select * from post where created_time between '2024-01-01' and '2024-12-31';

-- date format
-- Y, m, d -> Y만 대문자
select date_format(created_time, '%Y-%m') as `date` from post; -- 년과 월만 조회
select * from post where date_format(created_time, '%Y') = '2024'; -- 2024년에 쓰여진 데이터를 조회

-- 오늘 날짜 출력, now()
select now(); -- 현재 날짜 시간을 출력한다.
select date_format(now(), '%Y-%m-%d %H-%i-%s');

-- 제약 조건(constraint)
-- on delete restrict
-- on update restrict
-- 위의 2개가 디폴트이다.

-- 문제 : 흉부외과 또는 일반외과 의사 목록 출력하기
-- HIRE_YMD datetime으로 되어있음 -> date로 받아야함

SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD, '%Y-%m-%d') as hire_ymd from DOCTOR Where MCDP_CD IN('CS','GS') ORDER BY HIRE_YMD DESC, DR_NAME;

-- 제약조건
- NOT NULL
- FOREIGN KEY - on update/on delete 상황
- UNIQUE - 이메일
- PRIMARY key


-- 오늘날짜
select now();