-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록조회
SHOW DATABASE;

-- board (스키마)데이터베이스 생성
CREATE DATABASE board;

-- 데이터베이스 선택
USE board;

-- 테이블 조회
SHOW tables;

-- author 테이블 생성
-- coulumm의 타입까지 넣어줘야함
-- pk설정 PRIMARY KEY
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 column 조회
describe author;
-- column 상세 조회
SHOW FULL COLUMNS FROM author;

-- 테이블 생성문 조회
SHOW create table author;
-- utf8mb4 이모티콘까지 포함

-- posts 테이블 신규 생성 (id, title, content, author_id)
CREATE table posts(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, FOREIGN KEY(author_id) references author(id) )
-- 이렇게 해도됨, forenig key : 테이블 차원에서의 제약조건
CREATE table posts(id INT, title VARCHAR(255), content VARCHAR(255), author_id INT,  PRIMARY KEY(id))


-- 테스트 스키마 생성후 삭제
CREATE DATABASE test1;
SHOW DATABASE;
DROP DATABASE test1;

-- table 인덱스 조회
SHOW index FROM author;
SHOW index FROM posts;

-- ALTER : 테이블의 구조를 변경
-- 테이블 이름 변경
ALTER TABLE posts RENAME post;

-- table column 추가
ALTER TABLE author ADD column test1 VARCHAR(50);

-- table 컬럼 삭제
ALTER TABLE author DROP column test1;
-- table column명 변경
ALTER TABLE post change column content contents varchar(255);
-- table column 타입과 제약조건 변경
ALTER TABLE author MODIFY column email VARCHAR(255) NOT NULL;

-- 실습 1 author table에 address 컬럼 추가 varchar(255)로 추가
alter table author add column address varchar(255) not null;
-- 실습 2 post table에 title not null 제약조건 추가
alter table post modify column title varchar(255) not null;
-- 실습 3 post table에 contents 3000자로 변경
alter table post modify column contents varchar(3000) not null;

-- 테이블 삭제
drop 테이블명;

