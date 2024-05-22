# local 컴퓨터의 board db -> 마이그레이션 -> linux 이전
# 스키마 + 데이터 전체를 쿼리형태로 뽑음
create database board;
create table author()..;
create table post()..;
insert into ...

-- 리눅스에 db 설치 -> local에 dump 작업 후 sql 쿼리 생성 -> linux에서 해당 쿼리 실행 
-- ->github에 upload -> git clone -> linux에서 해당쿼리 실행

#local에서 sql 덤프파일 생성
mysqldump -u root -p --defalut-character-set=utf8mb4 board > dumpfile.sql
# 한글 깨질 때
mysqldump -uroot -p board -r dumpfile.sql
# dump 파일을 github에 업로드
git add . 
git commit -m "mariadb syntax"
git push origin main

# docker ps
# docker exec -it my_mariadb /bin/bash
# mariadb-dump -u root -p board > dumpfile.sql
# >비밀번호 입력
# >docker > my_mariadb > files > dumpfile.sql 다운로드
# 리눅스에서 mariadb 서버 설치
# sudo apt-get install mariadb-server;
# mariadb 서버 시작
# sudo systemctl start mariadb;

# #local에서 sql 덤프 파일 생성
# mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql
# #한글 깨질 때
# mysqldump -uroot -p board -r dumpfile.sql

# #dump파일을 github에 업로드

# #리눅스에서 mariadb 설치
# sudo apt-get install mariadb-server

# #mariadb 서버 시작
# sudo systemctl start mariadb

# #mariadb 접속 테스트
# sudo mariadb -u root -p

# #git 설치
# sudo apt install git

# #git을 통해 repo clone
# git clone 레파지토리

# mysql -u root -p board < dumpfile.sql

