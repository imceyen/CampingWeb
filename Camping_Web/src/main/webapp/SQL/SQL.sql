CREATE TABLE cam_category (                     -- [카테고리 테이블]
    category_no NUMBER PRIMARY KEY,             -- 카테고리 번호
    category_name VARCHAR2(50) NOT NULL         -- 카테고리명
);

CREATE TABLE cam_product (                                  -- [상품 테이블]
    product_no NUMBER PRIMARY KEY,                          -- 상품 번호
    category_no NUMBER REFERENCES cam_category(category_no),-- 카테고리 번호
    product_name VARCHAR2(100) NOT NULL,                    -- 상품명
    input_price NUMBER NOT NULL,                            -- 입고액
    output_price NUMBER NOT NULL,                           -- 출고액
    stock_qty NUMBER DEFAULT 0,                             -- 재고수량
    sold_qty NUMBER DEFAULT 0,                              -- 판매수량
    is_sold_out CHAR(1) DEFAULT 'N'                         -- 품절여부 'Y' or 'N'
);

CREATE TABLE customer (                         -- [고객 테이블]
    customer_no NUMBER PRIMARY KEY,             -- 고객 번호
    customer_id VARCHAR2(30) UNIQUE NOT NULL,   -- 고객 아이디 (아이디 중복 방지)
    password VARCHAR2(100) NOT NULL,            -- 고객 비밀번호
    name VARCHAR2(50) NOT NULL,                 -- 고객 이름
    birth_date DATE,                            -- 고객 생년월일
    gender CHAR(1),                             -- 고객 성별 'M' or 'F'         
    phone VARCHAR2(20),                         -- 고객 전화번호
    address VARCHAR2(200)                       -- 고객 주소
);

CREATE TABLE cart (                                             -- [장바구니 테이블]
    customer_no NUMBER,                                         -- 고객 번호
    product_no NUMBER,                                          -- 상품 번호
    quantity NUMBER DEFAULT 1,                                  -- 상품 수량 (기본 1개)
    PRIMARY KEY (customer_no, product_no),                      -- 같은 상품 중복 방지, 수량만 올라가게 해줌
    FOREIGN KEY (customer_no) REFERENCES customer(customer_no), -- 고객 테이블의 고객 번호와 연결
    FOREIGN KEY (product_no) REFERENCES cam_product(product_no) -- 상품 테이블의 상품 번호와 연결
);

CREATE TABLE orders (                                       -- [주문 테이블]
    order_no NUMBER PRIMARY KEY,                            -- 주문 번호
    customer_no NUMBER REFERENCES customer(customer_no),    -- 고객 번호
    order_date DATE DEFAULT SYSDATE,                        -- 주문 날짜
    order_status VARCHAR2(20) DEFAULT '주문완료'              -- 주문 상태
);

CREATE TABLE order_detail (                                     -- [주문 상세 정보 테이블]
    order_no NUMBER,                                            -- 주문 번호
    product_no NUMBER,                                          -- 상품 번호
    quantity NUMBER NOT NULL,                                   -- 상품 수량
    price NUMBER NOT NULL,                                      -- 구매 가격
    PRIMARY KEY (order_no, product_no),                         -- 상품 중복 방지, 수량만 올라가게 함
    FOREIGN KEY (order_no) REFERENCES orders(order_no),         -- 주문 테이블의 주문 번호와 연결
    FOREIGN KEY (product_no) REFERENCES cam_product(product_no) -- 상품 테이블의 상품 번호와 연결
);

CREATE TABLE product_review (                               -- [상품 후기 테이블]
    review_no NUMBER PRIMARY KEY,                           -- 후기 번호
    customer_no NUMBER REFERENCES customer(customer_no),    -- 고객 번호
    product_no NUMBER REFERENCES cam_product(product_no),   -- 상품 번호
    content VARCHAR2(1000),                                 -- 후기 내용
    review_date DATE DEFAULT SYSDATE                        -- 후기 작성 날짜
);

CREATE TABLE product_inquiry (                              -- [상품 문의 테이블]
    inquiry_no NUMBER PRIMARY KEY,                          -- 문의 번호
    customer_no NUMBER REFERENCES customer(customer_no),    -- 고객 번호
    product_no NUMBER REFERENCES cam_product(product_no),   -- 상품 번호
    content VARCHAR2(1000),                                 -- 문의 내용
    inquiry_date DATE DEFAULT SYSDATE,                      -- 문의 작성 날짜
    answer_content VARCHAR2(1000),                          -- 문의 답변 내용
    answer_date DATE                                        -- 문의 답변 작성 날짜
);

CREATE TABLE sales_statistics (         -- [관리자 테이블]
    product_no NUMBER PRIMARY KEY,      -- 상품 번호
    total_sales NUMBER,                 -- 매출액
    total_cost NUMBER,                  -- 매입액
    total_profit NUMBER,                -- 순수익
    FOREIGN KEY (product_no) REFERENCES cam_product(product_no) -- 상품 테이블의 상품 번호와 연결
);



