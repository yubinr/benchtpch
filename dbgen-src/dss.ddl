-- sccsid:     @(#)dss.ddl	2.1.8.1

DROP TABLE IF EXISTS nation;

CREATE TABLE nation  ( N_NATIONKEY  INTEGER NOT NULL,
                            N_NAME       CHAR(25) NOT NULL,
                            N_REGIONKEY  INTEGER NOT NULL,
                            N_COMMENT    VARCHAR(152),
primary key (N_NATIONKEY)
);

DROP TABLE IF EXISTS region;
CREATE TABLE region  ( R_REGIONKEY  INTEGER NOT NULL,
                            R_NAME       CHAR(25) NOT NULL,
                            R_COMMENT    VARCHAR(152),
  PRIMARY KEY (R_REGIONKEY)
);

DROP TABLE IF EXISTS part;
CREATE TABLE part  ( P_PARTKEY     INTEGER NOT NULL,
                          P_NAME        VARCHAR(55) NOT NULL,
                          P_MFGR        CHAR(25) NOT NULL,
                          P_BRAND       CHAR(10) NOT NULL,
                          P_TYPE        VARCHAR(25) NOT NULL,
                          P_SIZE        INTEGER NOT NULL,
                          P_CONTAINER   CHAR(10) NOT NULL,
                          P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                          P_COMMENT     VARCHAR(23) NOT NULL ,
  PRIMARY KEY (P_PARTKEY)
);

DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier  ( S_SUPPKEY     INTEGER NOT NULL,
                             S_NAME        CHAR(25) NOT NULL,
                             S_ADDRESS     VARCHAR(40) NOT NULL,
                             S_NATIONKEY   INTEGER NOT NULL,
                             S_PHONE       CHAR(15) NOT NULL,
                             S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                             S_COMMENT     VARCHAR(101) NOT NULL,
  PRIMARY KEY (S_SUPPKEY)
);

DROP TABLE IF EXISTS partsupp;
CREATE TABLE partsupp  ( PS_PARTKEY     INTEGER NOT NULL,
                             PS_SUPPKEY     INTEGER NOT NULL,
                             PS_AVAILQTY    INTEGER NOT NULL,
                             PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                             PS_COMMENT     VARCHAR(199) NOT NULL ,
  PRIMARY KEY (`PS_PARTKEY`,`PS_SUPPKEY`)
);
DROP TABLE IF EXISTS customer;
CREATE TABLE customer  ( C_CUSTKEY     INTEGER NOT NULL,
                             C_NAME        VARCHAR(25) NOT NULL,
                             C_ADDRESS     VARCHAR(40) NOT NULL,
                             C_NATIONKEY   INTEGER NOT NULL,
                             C_PHONE       CHAR(15) NOT NULL,
                             C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                             C_MKTSEGMENT  CHAR(10) NOT NULL,
                             C_COMMENT     VARCHAR(117) NOT NULL,
  PRIMARY KEY (`C_CUSTKEY`)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders  ( O_ORDERKEY       INTEGER NOT NULL,
                           O_CUSTKEY        INTEGER NOT NULL,
                           O_ORDERSTATUS    CHAR(1) NOT NULL,
                           O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                           O_ORDERDATE      DATE NOT NULL,
                           O_ORDERPRIORITY  CHAR(15) NOT NULL,  
                           O_CLERK          CHAR(15) NOT NULL, 
                           O_SHIPPRIORITY   INTEGER NOT NULL,
                           O_COMMENT        VARCHAR(79) NOT NULL,
  PRIMARY KEY (`O_ORDERKEY`,`O_ORDERDATE`)
);
DROP TABLE IF EXISTS lineitem;
CREATE TABLE lineitem ( L_ORDERKEY    INTEGER NOT NULL,
                             L_PARTKEY     INTEGER NOT NULL,
                             L_SUPPKEY     INTEGER NOT NULL,
                             L_LINENUMBER  INTEGER NOT NULL,
                             L_QUANTITY    DECIMAL(15,2) NOT NULL,
                             L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                             L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                             L_TAX         DECIMAL(15,2) NOT NULL,
                             L_RETURNFLAG  CHAR(1) NOT NULL,
                             L_LINESTATUS  CHAR(1) NOT NULL,
                             L_SHIPDATE    DATE NOT NULL,
                             L_COMMITDATE  DATE NOT NULL,
                             L_RECEIPTDATE DATE NOT NULL,
                             L_SHIPINSTRUCT CHAR(25) NOT NULL,
                             L_SHIPMODE     CHAR(10) NOT NULL,
                             L_COMMENT      VARCHAR(44) NOT NULL,
  PRIMARY KEY (`L_ORDERKEY`,`L_LINENUMBER`,`L_SHIPDATE`));

create index idx_c_mk on customer(c_mktsegment);
create index idx_c_ck on customer(c_custkey);
create index idx_c_nk on customer(c_nationkey);

create index idx_o_ck on orders(o_custkey);
create index idx_o_ok on orders(o_orderkey);
create index idx_o_od on orders(o_orderdate);
create index idx_o_op on orders(o_orderpriority);
create index idx_o_os on orders(o_orderstatus);


create index idx_n_nk on nation(n_nationkey);
create index idx_n_rk on nation(n_regionkey);
create index idx_n_n on nation(n_name);

create index idx_r_rk on region(r_regionkey);
create index idx_r_n on region(r_name);


create index idx_p_s on part(p_size);
create index idx_p_t on part(p_type);
create index idx_p_pk on part(p_partkey);
create index idx_p_b on part(p_brand);
create index idx_p_c on part(p_container);

create index idx_ps_pk on partsupp(ps_partkey);
create index idx_ps_sc on partsupp(ps_supplycost);
create index idx_ps_sk on partsupp(ps_suppkey);

create index idx_s_sk on supplier(s_suppkey);
create index idx_s_nk on supplier(s_nationkey);

create index idx_li_sd on lineitem(l_shipdate);
create index idx_li_rf on lineitem(l_returnflag);
create index idx_li_sm on lineitem(l_shipmode);
create index idx_li_cd on lineitem(l_commitdate);
create index idx_li_rd on lineitem(l_receiptdate);
create index idx_li_pk on lineitem(l_partkey);
create index idx_li_sk on lineitem(l_suppkey);
create index idx_li_ok on lineitem(l_orderkey);
create index idx_li_dc on lineitem(l_discount);
create index idx_li_q on lineitem(l_quantity);
create index idx_li_rf_ls on lineitem(l_returnflag,l_linestatus);

alter table nation comment 'columnar=1';
alter table region comment 'columnar=1';
alter table part comment 'columnar=1';
alter table supplier comment 'columnar=1';
alter table partsupp comment 'columnar=1';
alter table customer comment 'columnar=1';
alter table orders comment 'columnar=1';
alter table lineitem comment 'columnar=1';

