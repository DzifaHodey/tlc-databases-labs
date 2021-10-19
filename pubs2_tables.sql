drop schema pubs2 cascade;
create schema if not exists pubs2;

CREATE TABLE pubs2.authors
(
                   au_id          varchar(11) CONSTRAINT UPKCL_auidind PRIMARY KEY ,
                   au_lname       varchar(40)       NOT NULL,
                   au_fname       varchar(20)       NOT NULL,
                   phone          char(12)          NOT NULL DEFAULT ('UNKNOWN'),
                   address        varchar(40)           NULL,
                   city           varchar(20)           NULL,
                   state          char(2)               NULL,
                   zip            char(5)               NULL,
                   contract       integer               NOT NULL
        );


        CREATE TABLE pubs2.publishers
        (
                   pub_id         char(4)           NOT NULL CONSTRAINT UPKCL_pubind PRIMARY KEY ,
                   pub_name       varchar(40)           NULL,
                   city           varchar(20)           NULL,
                   state          char(2)               NULL,
                   country        varchar(30)           NULL DEFAULT('USA')
        );

        CREATE TABLE pubs2.titles
        (
                   title_id       varchar(6) CONSTRAINT UPKCL_titleidind PRIMARY KEY ,
                   title          varchar(80)       NOT NULL,
                   type           char(12)          NOT NULL DEFAULT ('UNDECIDED'),
                   pub_id         char(4)               NULL REFERENCES pubs2.publishers(pub_id),
                   price          money                 NULL,
                   advance        money                 NULL,
                   royalty        int                   NULL,
                   ytd_sales      int                   NULL,
                   notes          varchar(200)          NULL,
                   pubdate        date                  NOT NULL DEFAULT current_timestamp
        );

        CREATE TABLE pubs2.titleauthor
        (
                   au_id          varchar(11) REFERENCES pubs2.authors(au_id),
                   title_id       varchar(6) REFERENCES pubs2.titles(title_id),
                   au_ord         integer               NULL,
                   royaltyper	  integer				NULL,
                   CONSTRAINT UPKCL_taind PRIMARY KEY (au_id, title_id)
        );

        CREATE TABLE pubs2.stores
        (
                   stor_id        char(4)           NOT NULL CONSTRAINT UPK_storeid PRIMARY KEY ,
                   stor_name      varchar(40)           NULL,
                   stor_address   varchar(40)           NULL,
                   city           varchar(20)           NULL,
                   state          char(2)               NULL,
                   zip            char(5)               NULL
        );

        CREATE TABLE pubs2.sales
        (
                   stor_id        char(4)           NOT NULL REFERENCES pubs2.stores(stor_id),
                   ord_num        varchar(20)       NOT NULL,
                   ord_date       date              NOT NULL,
                   qty            smallint          NOT NULL,
                   payterms       varchar(12)       NOT NULL,
                   title_id       varchar(6) REFERENCES pubs2.titles(title_id),
                   CONSTRAINT UPKCL_sales PRIMARY KEY (stor_id, ord_num, title_id)
        );

        create taBLE pubs2.roysched
        (
                   title_id       varchar(6) REFERENCES pubs2.titles(title_id),
                   lorange        int                   NULL,
                   hirange        int                   NULL,
                   royalty        int                   NULL
        );

        CREATE TABLE pubs2.discounts
        (
                   discounttype   varchar(40)       NOT NULL,
                   stor_id        char(4) NULL REFERENCES pubs2.stores(stor_id),
                   lowqty         smallint              NULL,
                   highqty        smallint              NULL,
                   discount       dec(4,2)          NOT NULL
        );


        CREATE TABLE pubs2.pub_info
        (
                   pub_id         char(4)           NOT NULL REFERENCES pubs2.publishers(pub_id) CONSTRAINT UPKCL_pubinfo PRIMARY KEY ,
                   logo           text                 NULL,
                   pr_info        text                  NULL
        );


