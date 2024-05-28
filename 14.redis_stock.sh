# !/bin/bash : 이렇게 시작하는 게 bash shell의 기본

# 정확한 문법 외우려는 거보다 이해하는 게 중요
# 200번 반복하면서 재고 확인 및 감소
for i in {1..200}; do
    quantity=${redis-cli -h localhost -p 6379 get apple:1:quantity}
    if  ["$quantity" -lt 1 ]; then
        echo "재고가 부족합니다. 현재 재고:$quantity"
        break;
    fi  
    # 재고 감소 
    redis-cli -h localhost -p 6379 decr apple:1:quantity
    echo "현재 재고 : $quantity"

done

# 캐싱 기능 구현