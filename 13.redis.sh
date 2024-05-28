sudo apt-get update
sudo apt-get install redis-server
redis-server --version

# 레디스 서버 접속
# cli : command line interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택
select 번호(0번이 디폴트)

# 데이터베이스내 모든 키 조회
keys *

# 일반 string 자료구조
# key:value값 세팅
# key값은 중복되면 안됨(덮어씌워짐)
SET key(키) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set할 때 key값이 이미 존재하면 덮어쓰기 되는 것이 기본
# 맵저장소에서 key값은 유일하게 관리가 되므로
# nx : not exist <- 이미 있는 경우는 덮어쓰지 말라는 명령어
set user:email:1 hongildong2@naver.com nx
# ex(만료시간-초단위) - ttl(time to live)   --> 시간 지나면 사라져야하는 서비스(ex. 세션)에 사용하면 좋음
set user:email:2 hong2@naver.com ex 20


# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1
# 현재 데이터베이스 모든 key값 삭제
flushdb

# 인스타 좋아요 기능 구현(아래는 rdb)
select likes from posting where email="ronaldo";
update posting set likes = likes+1 where ...;
# 동시성 이슈->for update등으로 rock을 건다 -> 엄청 느려진다
# redis는 싱글스레드&&인메모리기반(성능)이어서 redis로 구현되었을 것
# 인스타 좋아요 기능 구현 (redis 기반)
set likes:posting:1 0
incr likes:posting:1 # 특정 key값의 value를 1만큼 증가
decr likes:posting:1
get likes:posting:1

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock
# bash쉘을 활용하여 재고 감소 프로그램 작성

#캐싱 기능 구현
#1번 author 회원 정보 조회
#select name, email, age from author where id=1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
# "{"name":~}"  이렇게 하면 "{" 이것만 들어가므로 \이거 escape 해줘얗

set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

#레디스 나가기
exit

# list
# redis의 list는 java의 deque와 같은 구조, 즉 double-ended queue 구조

# 데이터 왼쪽 삽입
LPUSH 키 값
# 데이터 오른쪽 삽입
RPUSH 키 값
# 데이터 왼쪽부터 꺼내기
LPOP 키
#데이터 오른쪽부터 꺼내기
RPOP 키
# 어떤 목적으로 사용할 수 있을까
# hogildongs가 이제 list 변수명 되는 거
lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3
lpop hongildongs
# 결과값 hong3

# 꺼내서 없애는 게 아니라, 꺼내서 보기만
lrange hongildongs -1 -1 # 오른쪽 거 보고 싶ㅇ면
lrange hogildongs 0 0 # 왼쪽 거 보고 싶으면

# 데이터 개수 조회
llen 키
llen hongildongs
# list의 요소 조회시에는 범위 지정
lrange hongildongs 0 -1 # 처음부터 끝까지
# 스타트부터 엔드까지 조회
lrange hongildongs 스타트 엔드
# TTL 적용
expire 키(리스트 전체) 시간
expire hongildongs 30
# TTL 조회
ttl hongildongs

# pop과 push 동시
#A리스트에서 RPOP하고 B리스트에 LPUSH됨
RPOPLPUSH A리스트 B리스트 

# 최근 방문한 페이지 등에 사용할 수 있음
# 10개 정도 데이터 push
# 최근 방문한 페이지 5개 정도만 보여주는
rpush mypages www.google.com
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.com
rpush mypages www.naver.com
lrange mypages 2 -1 또는
rpop mypages 3번

# 위 방문 페이지 5개에서 뒤로가기 앞으로 가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로가기 누르면 앞으로간 페이지가 뭔지 출력
rpush forwards www.google.com
rpush forwards www.naver.com
rpush forwards www.yahoo.com
rpush forwards www.daum.com
lrange forwards -1 -1
rpoplpush forwards backwards

# SET 자료구조
# SET 자료구조에 멤버 추가
sadd members member1
sadd members member2
sadd members member1

# SET 조회
smembers members

# SET에서 멤버 삭제
srem members member2
# SET 멤버 개수 반환
scard members
# 특정 멤버가 set안에 있는지 존재 여부 확인, 있으면 1 반환 없으면 0
sismember members member3

# SET은 매일 방문자수 계산 같은 곳에 쓰면 적절
sadd visit:2024-05-27 hong1@naver.com



# 최근 본 상품 목록은 list로 구현 별로임 나중에 sorted set(zset)을 활용하는 것이 적절 
rpush 사과
rpush 배
rpush 사과 # list로 넣었을 경우 봤던 거 또 보는 게 문제가 됨 -> Set으로 해결 -> 중복 제거&&순서 : sorted set (자바에는 tree set이 있음)
RPOP
rpop
# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1
#score 기준 내름차순 정렬
zrevrange zmembers 0 -1

# 최근 본 상품 목록
sadd => 정렬 x
list => 중복 제거 x
zset => 중복 제거, score통해서 기준

# zset 삭제
zrem zmembers member2

# zrank는 해당 멤버가 index 몇번째인지 출력
zrank zmembers memeber2

#최근 본 상픔목록 => sorted set(zset)을 활용하는 것이 적절
zadd recent:products 현재시간(초로 환산함)
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192417 orange
zadd recent:products 192425 apple
zadd recent:products 192430 apple

# 최근본 상품 3개 말하셈 (zrevrange)-> apple orange banana 오래된 apple 최근의 apple만 남음
zrevrange recent:products 0 2

# hashes
# 객체 스타일로 stock 저장
hset product:1 name "apple" price 1000 stock 50

hget product:1 name
hget product:1 price
hget product:1 stock
# 모든 객체값 get
hgetall pruduct:1
# 특정 요소 값 수정
hset product:1 stock 40
# 특정 요소 값 증가/감소
hincrby product:1 stock 5
hincrby product:1 stock -5
# 확인
hget product:1 stock

String:key:value => 좋아요, 재고관리
list => key:value, value가 list형식인데, deque형식 => 최근방문페이지
set => 중복제거, 순서없음 => 오늘 방문자 수
zset => set은 set인데, 순서 있는 set => score:시간으로 가장많이 사용 => 최근 본 상품 목록
hset(hashes) => 객체형식으로 value값, 숫자 연산의 편의. hincrby

redis => pub/sub 구조
메세지의 pub/sub 구조 => rabbitmq, redis, kafka

#kafka
메세지가 유실되지 않을 가능성 높아짐