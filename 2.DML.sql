--dml drud 는 외우기

-- insert into : 데이터 삽입
INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES(데이터1, 데이터2, 데이터3);

--author 테이블에 데이터 삽입
INSERT INTO author(id, name, email) VALUES(1, 'hongildong', 'hong@naver.com');

-- select : 데이터 조회
--모든 컬럼 조회
SELECT * FROM author;

--id, title, content, author_id -> post에 추가
INSERT INTO posts(id, title, content, author_id) VALUES (1,'title1','contents',1);
SELECT * FROM posts;


-- 테이블 제약조건 조회
SELECT * FROM information_schema.key_column_usage WHERE table_name = 'posts';

-- 실습 4
-- update 테이블명 set 컬럼명=데이터 where id = 1;
-- update 테이블명 set 컬럼명=데이터, 컬럼명1=데이터1 where id = 1; 도 가능

-- insert문을 통해 author 데이터 4개정도 추가, post 데이터 추가(1개는 익명)
INSERT INTO author(id, name, email) VALUES(2, 'user1', 'user1@naver.com');
INSERT INTO author(id, name, email) VALUES(3, 'user2', 'user2@naver.com');
INSERT INTO author(id, name, email) VALUES(4, 'user3', 'user3@naver.com');
INSERT INTO author(id, name, email) VALUES(5, 'user4', 'user4@naver.com');

INSERT INTO post(id, title, contents, author_id) VALUES (2,'title2','contents2',2);
INSERT INTO post(id, title, contents, author_id) VALUES (3,'title3','contents3',3);
INSERT INTO post(id, title, contents, author_id) VALUES (4,'title4','contents4',4);
INSERT INTO post(id, title, contents) VALUES (5,'title5','contents5');

-- use information_schema; 상태가 아니므로 -> 다른 스키마의 테이블 조회시 SELECT * FROM '스키마.테이블'로 써야함
-- 덮어쓰기 아님 -> 요소만 변경함
-- where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의.
UPDATE author SET name = 'abc', email = 'abc@test.com' WHERE id = 1;
UPDATE author SET email = 'abc2@test.com' WHERE id = 2;
-- 모든 요소의 이메일 바꿈
UPDATE author SET email = 'abc2@test.com';

-- delete from 테이블명 where 조건
-- where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의.
delete from author where id = 5;

-- 사실 delete 잘 안씀 -> 데이터 완전히 없애버리는거 -> 복구 어려움-> 리스크 너무큼
-- 삭제가 됐는지 안됐는지 column 추가 ex)DEL_YN 컬럼 추가 y-> 삭제됨 n-> 삭제안됨(defalut)


-- SELECT문의 다양한 조회방법
SELECT * FROM author;
SELECT * FROM author WHERE id = 1;

-- SELECT의 다양한 조회 방법
SELECT * FROM author;
SELECT * FROM author WHERE id = 1;
SELECT * FROM author WHERE id > 2;
SELECT * FROM author WHERE id > 2 and name = 'user3';

-- 특정 컬럼만을 조회할때
SELECT name, email FROM author WHERE id = 3;

-- 중복 제거하고 조회
SELECT title FROM post;
SELECT distinct title FROM post;
 
 -- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
 -- 아무런 정렬조건 없이 조회할 경우에는 pk기준으로 오름차순
 asc:오름차순 desc:내림차순
 SELECT * FROM author ORDER BY name asc;

 -- 멀티컬럼 order by : 여러컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬, 중복시 그다음 정렬 옵션 적용
 SELECT * FROM post ORDER BY title; //생략시 오름차순
 SELECT * FROM post ORDER BY title, id desc; //title asc ->만약 title 중복이면 id기준으로 desc

-- limit number : 특정숫자로 결과값 개수 제한
-- 중요중요
SELECT * FROM author ORDER BY id desc limit 1; //가장 최근에 가입한 사람 조회

-- alias(별칭)을 이용한 select : as 키워드 사용
SELECT name as 이름, email as 이메일 from author;
SELECT a.name, a.email FROM author as a; 
SELECT a.name as 이름, a.email as 이메일 FROM author as a; 

-- NULL을 조회 조건으로
SELECT * FROM post WHERE author_id IS NULL;
SELECT * FROM post WHERE author_id IS NOT NULL;

-- author id 2 삭제 불가 -> 글을 썼기 때문에
delete from post where id = 2;
-- post 삭제하기
delete from author where id = 2;
delete from post where id = 2;

프로그래머스
-- 여러 기준으로 정렬하기
SELECT ANIMAL_ID, NAME, DATETIME FROM ANIMAL_INS 

SELECT NAME FROM ANIMAL_INS ORDER BY datetime LIMIT 1;