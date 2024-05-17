-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- AUTO_INCREMENT id -> 자동으로 증가
ALTER table author modify column id BIGINT AUTO_INCREMENT;
ALTER table post modify column id BIGINT AUTO_INCREMENT; -- > 에러
--post에서 값을 가지고 있다보니 author 제약조건 변경 불가

-- 해결방법
-- post에서 author_id에 제약조건을 가지고 있다보니 
-- author_id에 새로운 제약조건을 추가하는 부분에서 문제발생

-- author.id에 제약조건 추가시 fk로 인해 문제발생 시
-- fk 먼저 제거 이후에 author.id에 제약조건 추가
-- 제약조건 조회
SELECT * FROM information_schema.key_column_usage WHERE table_name = 'posts';
-- 삭제
ALTER TABLE post DROP FOREIGN KEY post_ibfk_1;

-- post에 있는  author_id post_ibfk_1;로 변경
ALTER table post modify column author_id BIGINT;

-- 삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk FOREIGN key(author_id) references author(id);

-- 추가해서 auto_increment 확인
select * from author;
insert into author(email) VALUES('hello@naver.com');

-- uuid 중요! 스터디 굳 프로젝트때 써도 굳

ALTER TABLE post ADD COLUMN user_id CHAR(36) DEFAULT (UUID()); -- 새로 생성될때마다 서로 다른 아이디 생성, 중복이 안되는 유일한 키값
insert into post(title) VALUES

-- pk,fk, unique :  자동으로 index 생성됨 -> 목차페이지 생성됨 -> 검색 성능 높일 수 있음
-- unique 제약조건
alter table author modify column email varchar(255) unique;
-- 확인
show index from author;

-- on delete cascade 테스트 -> 부모 테이블의 id를 수정하면? -> 수정 안됨
제약조건삭제

SELECT * FROM information_schema.key_column_usage WHERE table_name = 'post';
-- 삭제
ALTER TABLE post DROP FOREIGN KEY post_author_fk;

-- post에 있는  author_id post_ibfk_1;로 변경
ALTER table post modify column author_id BIGINT;

-- 삭제된 제약조건 다시 추가
alter table post add constraint post_author_fk FOREIGN key(author_id) references author(id) on delete cascade on update cascade;

SELECT * FROM information_schema.key_column_usage WHERE table_name = 'post';
ALTER TABLE post DROP FOREIGN KEY post_author_fk;
alter table post add constraint post_author_fk FOREIGN key(author_id) references author(id) on delete cascade on update cascade;
-- test 해보기 글쓴 사람 확인 -> post

-- 실습 delete = set null, update cascade
ALTER TABLE post DROP FOREIGN KEY post_author_fk;
ALTER TABLE post add constraint post_author_fk FOREIGN key(author_id) references author(id) on delete set null on update cascade;
