CREATE TABLE IF NOT EXISTS public.attachment
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    create_time timestamp(6) without time zone NOT NULL,
    update_time timestamp(6) without time zone,
    file_key uuid NOT NULL,
    height integer NOT NULL,
    media_type character(127) NOT NULL DEFAULT '',
    name character(255) NOT NULL,
    path character(1023) NOT NULL,
    size bigint NOT NULL,
    "suffix " character(50) NOT NULL DEFAULT '',
    thumb_path character(1023) NOT NULL DEFAULT '',
    type integer NOT NULL DEFAULT 0,
    width integer NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);
CREATE INDEX attachment_create_time ON attachment USING BTREE (create_time);
CREATE INDEX attachment_media_type ON attachment USING BTREE (media_type);

create table if not exists category
(
    id          int primary key GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    create_time timestamp(6)              not null,
    update_time timestamp(6)              null,
    description varchar(100)  default '' not null,
    type        integer      default 0  not null,
    name        varchar(255)             not null,
    parent_id   integer          default 0  not null,
    password    varchar(255)  default '' not null,
    slug        varchar(255)  default '' not null,
    thumbnail   varchar(1023) default '' not null,
    priority    int           default 0  not null
    );
CREATE INDEX category_name ON category USING BTREE (name);
CREATE INDEX category_parent_id ON category USING BTREE (parent_id);
CREATE  UNIQUE INDEX uniq_category_slug ON category USING  BTREE(slug);

create table if not exists comment_black
(
    id          int primary key GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    create_time timestamp(6)  not null,
    update_time timestamp(6)  null,
    ban_time    timestamp(6)  not null,
    ip_address  varchar(127) not null
    );

create table if not exists comment
(
    id                 int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    type               int          default 0  not null,
    create_time        timestamp(6)             not null,
    update_time        timestamp(6)             null,
    allow_notification bool   default 1  not null,
    author             varchar(50)             not null,
    author_url         varchar(511) default '' not null,
    content            varchar(1023)           not null,
    email              varchar(255)            not null,
    gravatar_md5       varchar(127) default '' not null,
    ip_address         varchar(127) default '' not null,
    is_admin           bool   default 0  not null,
    parent_id          int       default 0  not null,
    post_id            int                     not null,
    status             int          default 0  not null,
    top_priority       int          default 0  not null,
    user_agent         varchar(511) default '' not null,
    likes              int          default 0 not null
    );
create index comment_parent_id on comment using btree (parent_id);
create index comment_post_id on comment using btree (post_id);
create index comment_type_status on comment using btree (type, status);

create table if not exists flyway_schema_history
(
    installed_rank int                                 not null
    primary key,
    version        varchar(50)                         null,
    description    varchar(200)                        not null,
    type           varchar(20)                         not null,
    script         varchar(1000)                       not null,
    checksum       int                                 null,
    installed_by   varchar(100)                        not null,
    installed_on   timestamp default CURRENT_TIMESTAMP not null,
    execution_time int                                 not null,
    success        bool                          not null
    );
create index flyway_schema_history_s_idx on flyway_schema_history using btree (success);

create table if not exists journal
(
    id             int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time    timestamp(6)      not null,
    update_time   timestamp(6)      null,
    content        text             not null,
    likes          bigint default 0 not null,
    source_content text         not null,
    type           int    default 0 not null
    );

create table if not exists link
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6)              not null,
    update_time timestamp(6)              null,
    description varchar(255)  default '' not null,
    logo        varchar(1023) default '' not null,
    name        varchar(255)             not null,
    priority    int           default 0  not null,
    team        varchar(255)  default '' not null,
    url         varchar(1023)            not null
    );
create index link_team on link using btree (team);

create table if not exists log
(
    id          bigint GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6)             not null,
    update_time timestamp(6)             null,
    content     varchar(1023)           not null,
    ip_address  varchar(127) default '' not null,
    log_key     varchar(1023)           not null,
    type        int                     not null
    );
create index log_create_time on log using btree (create_time);

create table if not exists menu
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6)                  not null,
    update_time timestamp(6)                  null,
    icon        varchar(50)  default ''      not null,
    name        varchar(50)                  not null,
    parent_id   int          default 0       not null,
    priority    int          default 0       not null,
    target      varchar(20)  default '_self' not null,
    team        varchar(255) default ''      not null,
    url         varchar(1023)                not null
    );
create index menu_name on menu using btree (name);
create index menu_parent_id on menu using btree (parent_id);

create table if not exists meta
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    type        int default 0 not null,
    create_time timestamp(6)   not null,
    update_time timestamp(6)   null,
    meta_key    varchar(255)  not null,
    post_id     int           not null,
    meta_value  varchar(1023) not null
    );

create table if not exists option
(
    id           int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 )  primary key,
    create_time  timestamp(6)   not null,
    update_time  timestamp(6)   null,
    option_key   varchar(100)  not null,
    type         int default 0 not null,
    option_value text      not null
    );

create table if not exists photo
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6)              not null,
    update_time timestamp(6)              null,
    description varchar(255)  default '' not null,
    location    varchar(255)  default '' not null,
    name        varchar(255)             not null,
    take_time   timestamp(6)              null,
    team        varchar(255)  default '' not null,
    thumbnail   varchar(1023) default '' not null,
    url         varchar(1023)            not null,
    likes       bigint        default 0  not null
    ) ;
create index photo_create_time on photo using btree (create_time);
create index photo_team on photo using btree (team);


create table if not exists post_category
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6) not null,
    update_time timestamp(6) null,
    category_id int         not null,
    post_id     int         not null
    );
create index post_category_category_id on post_category using btree(category_id);
create index post_category_post_id on post_category using btree (post_id);

create table if not exists post_tag
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6) not null,
    update_time timestamp(6) null,
    post_id     int         not null,
    tag_id      int         not null
    );
create index post_tag_post_id on post_tag using btree (post_id);
create index post_tag_tag_id on post_tag using btree (tag_id);

create table if not exists post
(
    id               int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    type             int           default 0  not null,
    create_time      timestamp(6)              not null,
    update_time      timestamp(6)              null,
    disallow_comment bool  default 0  not null,
    edit_time        timestamp(6)              null,
    editor_type      int           default 0  not null,
    format_content   text                 not null,
    likes            bigint        default 0  not null,
    meta_description varchar(1023) default '' not null,
    meta_keywords    varchar(511)  default '' not null,
    original_content text                 not null,
    password         varchar(255)  default '' not null,
    slug             varchar(255)             not null,
    status           int           default 1  not null,
    summary          text                 not null,
    template         varchar(255)  default '' not null,
    thumbnail        varchar(1023) default '' not null,
    title            varchar(255)             not null,
    top_priority     int           default 0  not null,
    visits           bigint        default 0  not null,
    word_count       bigint        default 0  not null
    );
create unique index uniq_post_slug on post using btree (slug);
create index post_create_time on post using btree (create_time);
create index post_type_status on post using btree (type, status);


create table if not exists tag
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6)              not null,
    update_time timestamp(6)              null,
    name        varchar(255)             not null,
    slug        varchar(50)              not null,
    thumbnail   varchar(1023) default '' not null,
    color       varchar(25)   default '' not null
    );
create unique index uniq_tag_slug on tag using btree (slug);
create index tag_name on tag using btree (name);

create table if not exists theme_setting
(
    id            int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time   timestamp(6)  not null,
    update_time   timestamp(6)  null,
    setting_key   varchar(255) not null,
    theme_id      varchar(255) not null,
    setting_value text     not null
    );
create index theme_setting_setting_key on theme_setting using btree(setting_key);
create index theme_setting_theme_id on theme_setting using btree(theme_id);

create table if not exists "user"
(
    id          int GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ) primary key,
    create_time timestamp(6)              not null,
    update_time timestamp(6)              null,
    avatar      varchar(1023) default '' not null,
    description varchar(1023) default '' not null,
    email       varchar(127)  default '' not null,
    expire_time timestamp(6)              null,
    mfa_key     varchar(64)   default '' not null,
    mfa_type    int           default 0  not null,
    nickname    varchar(255)             not null,
    password    varchar(255)             not null,
    username    varchar(50)              not null
    );

