-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from post inner join author on author.id=post.author_id;
select * from author a inner join post p on a.id=p.author_id;
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents, a.email from post p inner join author a on p.author_id=a.id;

-- 모든 글 목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력 (p 다 나오게 하고 시프면 p.* 하면 됨)
select p.id, p.title, p.contents, a.email from post p left outer join author a on p.author_id = a.id;

-- join된 상황에서 where 조건 : on뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상만
select p.title, a.email from post p inner join author a on p.author_id=a.id and a.age >=25;
-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력,2020-05-01 이후에 만들어진 글만 출력
select a.email from author a left join post p on p.title is not null and p.author_id is not null and p.created_time >='2020-05-01';


-- 조건에 맞는 도서와 저자 리스트 출력(programmers)
select b.BOOK_ID, a.AUTHOR_NAME, date_format(b.PUBLISHED_DATE, '%Y-%m-%d') as PUBLISHED_DATE from author a inner join book b on a.AUTHOR_ID = b.AUTHOR_ID WHERE b.CATEGORY ='경제' order by b.PUBLISHED_DATE;

-- union : 중복제외한 두 테이블의 select 결함
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 unoin select 컬럼1, 컬럼2 from table2;
-- author 테이블의 name, email 그리고 post 테이블의 title, contents unoin
select name, email from author union select title, contents from post;

-- 서브쿼리 : select문 안에 또다른 select문을 서브쿼리라 한다.
-- author email과 해당 author가 쓴 글의 개수를 출력
-- select절 안에 서브쿼리
select email, (select count(*) from post p where p.author_id = a.id) as count from author a;
-- 이렇게도 쓸 수 있음
-- select * from author a left join post p on a.id=p.author_id group by a.id;
-- select a.id, if(p.id is null, 0 count(a.id)) from author a left join post p on a.id = p.author_id group by a.id;

-- from절 안에 서브쿼리
-- 이렇게는 잘 안씀
select a.name from (select * from author) as a;


-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post); -- post table에 있는 author id 목록
-- 성능은 inner join이 서브 쿼리보다 좋음! 되도록 join 쓰기

-- 없어진 기록 찾기 문제 : join으로 풀 수 있는 문제, subquery로도 풀어보면 좋을것
SELECT ao.ANIMAL_ID, ao.name FROM ANIMAL_OUTS AO LEFT JOIN ANIMAL_INS AI on AO.ANIMAL_ID = AI.ANIMAL_ID Where ai.ANIMAL_ID is null order by ao.ANIMAL_ID;
-- out이 null인 경우는 없음
-- subquery
SELECT ao.ANIMAL_ID, ao.name FROM ANIMAL_OUTS AO WHERE ANIMAL_ID not in(select ANIMAL_ID from ANIMAL_INS) order by ANIMAL_ID;

SELECT region, count(*), sum(sales) from abc group by region; -> group by 한 컬럼으로 조회

-- 집계 함수
select count(*) from author; -- select count(id) from author; 와 같은 의미
select sum(price) from post;
select avg(price) from post; -- 평균
select round(avg(price,0)) from post; --round(대상,소수점 자리 개수)

-- group by 집계함수
-- select title from post group by author_id; 이렇게는 못함 group 지어버렸으니까
select author_id from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), avg(price),round(avg(price,0)), min(price), max(price) from post group by author_id;

-- 저자 email, 해당저자가 작성한 글 수를 출력
-- inner join ? left join? inner 글 안쓴 저자는 완전 빠져버림 
select a.id, if(p.id is null, 0, count(*)) from author a left join post p on a.id = p.author_id group by a.id;

-- where와 group by
-- 연도별 post 글 출력, where(연도가 null인 data는 제외)
select 연도, count(*) from where xxx group by 연도;
select date_format(created_time,'%y'),count(*) from post where created_time is not null group by date_format(created_time,'%y');
select date_format(created_time,'%y') as year ,count(*) from post where created_time is not null group by year;
-- 연도와 월별 Post 글 출력
select date_format(created_time,'%y-%m') as yearmonth ,count(*) from post where created_time is not null group by yearmonth;

-- 문제 : 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, COUNT(*) AS CARS FROM CAR_RENTAL_COMPANY_CAR WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%' GROUP BY CAR_TYPE ORDER BY CAR_TYPE;
-- 입양 시각 구하기
SELECT DATE_FORMAT(DATETIME,'%H') AS HOUR, COUNT(*) FROM ANIMAL_OUTS WHERE DATE_FORMAT(DATETIME,'%H:%I') BETWEEN "09:00" AND "19:59" GROUP BY HOUR ORDER BY HOUR; 
-- 실행 되고 order by
SELECT CAST(DATE_FORMAT(DATETIME,'%H')AS UNSIGNED) AS HOUR, COUNT(*) FROM ANIMAL_OUTS WHERE DATE_FORMAT(DATETIME,'%H:%I') BETWEEN "09:00" AND "19:59" GROUP BY HOUR ORDER BY HOU

-- HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;
-- 글을 2개 이상 쓴 사람에 대한 통계 정보
select author_id, count(*) as count from post group by author_id HAVING count >=2;

-- 실습 : 포스팅 price가 2000원 이상인 글을 대상으로, 작성자 별로 몇건인지와 평균 price를 구하되, 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
select author_id, avg(price) as avg_price from post where price >= 2000 group by author_id HAVING avg_price >= 3000;

-- 문제 : 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT FROM ANIMAL_INS WHERE NAME IS NOT NULL GROUP BY NAME HAVING COUNT>=2 ORDER BY NAME; 
-- 집계제외 : WHERE NAME IS NOT NULL
-- 결과는 이름 순으로 조회 : ORDER BY NAME
-- select name, count from animal_ins group by 

-- 실습 :  2건 이상의 글을 쓴 사람의 email, count값 구할건데 나이는 25세 이상인 사람만 통계에 사용, 가장 나이 많은 사람 1명의 통계만 출력하시오
SELECT a. id, count(a.id) AS count FROM author a INNER JOIN post p 
ON a.id = p.author_id WHERE a.age >= 25 group by a.id HAVING count>=2 ORDER BY max(a.age) DESC LIMIT 1;


-- 다중열 group by
select author_id, title, count(*) from post group by author_id, title; -- * -> grouping 한 거의 all

-- 문제 : 재구매가 일어난 상품과 회원리스트
SELECT user_id, product_id from ONLINE_SALE group by user_id, product_id having count(*) >=2 order by user_id, product_id desc;