-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
create user 'test1'@'localhost' identified by '4321';

-- %는 원격 접속을 포함한 anywhere 접속
create user 'test1'@'%' identified by '4321';

-- 터미널로 할 때 확인방법
mariadb -u test1 -p

-- 사용자에게 select 권한 부여
grant select on board.author to 'test1'@'localhost';

-- test1으로 로그인 후에
select * from board.author;

-- 권한조회
show grants for 'test1'@'localhost'; 

-- 사용자 권한 회수
revoke select on board.author to 'test'@'localhost';

-- 환경설정을 변경후 확정
flush privileges;

-- 사용자 권한 삭제
drop user 'test1'@'localhost';

-- view 
-- view 생성
create view author_for_marketing_team as select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- test계정 view의 select 권한부여
grant select on author_for_marketing_team to 계정;

-- view 변경 (대체)
create or replace view author_for_marketing_team as select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;

-- 프로시저 생성
DELIMITER //
원하는 쿼리 넣음


//DELIMITER;


DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN
    select 'hello world';
END
//DELIMITER ;
-- 프로시저 호출
call test_procedure();
-- 프로시저 삭제
DROP PROCEDURE test_procedure;

-- 게시글 목록 조회 프로시저 생성
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    select * from post;
END
//DELIMITER ;
call 게시글목록조회();

-- 게시글 단건 조회
-- 정적 프로그램
DELIMITER //
CREATE PROCEDURE 게시글단건조회()
BEGIN
    select * from post WHERE id = 1; 
END
//DELIMITER ;
call 게시글단건조회();

-- 동적 프로그램
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in postId int)
BEGIN
    select * from post WHERE id = postId; 
END
//DELIMITER ;
call 게시글단건조회(3);

--같은 이름의 프로시저, 매개변수 다르게 해서 사용하고 싶다면 프로시저 삭제후 다시 생성
DROP PROCEDURE 게시글단건조회; -> 프로시저 생성

-- 동적 프로그램 2
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 저자id int, in 제목 varchar(255))
BEGIN
    select * from post WHERE author_id = 저자id and title = 제목; 
END
//DELIMITER ;
call 게시글단건조회(4,'title');

-- 글쓰기
DELIMITER //
CREATE PROCEDURE 글쓰기(in title varchar(255), in contents varchar(255), in author_id int)
BEGIN
    INSERT INTO post(title, contents, author_id) VALUES(title, contents, author_id);
END
//DELIMITER ;
call 글쓰기('title', 'contents', 12);

-- 글쓰기 : title, contents, email
DELIMITER //
CREATE PROCEDURE 글쓰기2(in titleInput varchar(255), in contentsInput varchar(255), emailInput varchar(255))
BEGIN
    declare authorId int;
    SELECT id into authorId from author where email = emailInput;
    INSERT INTO post(title, contents, author_id) VALUES(titleInput, contentsInput, authorId);
END
//DELIMITER ;
call 글쓰기2('test', 'contents','test@test.com');

-- sql에서 문자열 합치는 concat('hello','world');
-- 글 상세 조회 : input값 : postId
-- title, contents, '홍길동' + '님'

DELIMITER //
CREATE PROCEDURE 글상세조회(in postID int)
BEGIN
    declare authorName varchar(255);
    select name into authorName from author where id = (select author_id from post where id = postID);
    set authorName = concat(authorName, '님');
    select title, contens, authorName from post where author_id = postID;
END
//DELIMITER ;
call 글상세조회(14);

-- 등급조회 글을 100개이상 쓴 사용자는 고수입니다.
-- 10개 이상 100개 미만이면 중수입니다.
-- 그외는 초보입니다.
-- input 값 : email

DELIMITER //
CREATE PROCEDURE 등급조회(in email varchar(255))
BEGIN
    declare authorId int;
    declare count int;
    select name into authorId from author where email = email;
    select count(*) into count from post where author_id = author_id;

    if count >= 100 then
        select '고수입니다.';
    elseif count >=10 and count <100 then
        select '중수입니다.';
    else
        select '초보입니다.';
    end if;
    
END
//DELIMITER ;

-- 반복문을 통해 post 대량생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배 되는데 title : '안녕하세요'

DELIMITER //
CREATE PROCEDURE 글도배(in count int)
BEGIN
    declare countValue int;
    set countValue = 0;
    -- declare countValue int DEFAULT 0;
    WHILE countValue < count  DO
        INSERT INTO post (title) VALUES('안녕하세요');
        set countValue = countValue+1;
    END WHILE;
    select * from post;
END
//DELIMITER ;

call 글도배(10);

-- 프로시저 생성문 조회
show create procedure 프로시저명;

-- 프로시저 권한 부여
-- excute 실행권한 부여
grant excute on board.글도배 to 'test1'@'localhost';
