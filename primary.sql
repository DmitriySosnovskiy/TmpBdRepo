create table users
(
    id     uuid    not null
        primary key,
    email  text    not null,
    name   text    not null,
    age    integer not null,
    status text    not null
);

comment on column users.status is 'статус подтверждения аккаунта';

alter table users
    owner to postgres;

create table users_likes
(
    like_from_user_id uuid not null
        constraint like_from_user_id_to_user_id
            references users
            on delete cascade,
    like_to_user_id   uuid not null
        constraint like_to_user_id_to_user_id
            references users
            on delete cascade,
    creation_date     date not null,
    primary key (like_from_user_id, like_to_user_id)
);

comment on column users_likes.like_to_user_id is 'массив значений';

alter table users_likes
    owner to postgres;

create table users_dislikes
(
    dislike_from_user_id uuid not null
        constraint dislike_from_user_id_to_user_id
            references users
            on delete cascade,
    dislike_to_user_id   uuid not null
        constraint dislike_to_user_id_to_user_id
            references users
            on delete cascade,
    creation_date        date not null,
    primary key (dislike_from_user_id, dislike_to_user_id)
);

alter table users_dislikes
    owner to postgres;

create table dating_profile
(
    user_id         uuid                       not null
        primary key,
    description     text                       not null,
    interests       text[],
    likes_amount    bigint default '0'::bigint not null,
    dislikes_amount bigint default '0'::bigint not null,
    location        bigint,
    photoes         bytea,
    status          text                       not null
);

alter table dating_profile
    owner to postgres;

create table users_matches
(
    first_user_id  uuid not null
        constraint first_user_id_to_user_id
            references users
            on delete cascade,
    second_user_id uuid not null
        constraint second_user_id_to_user_id
            references users
            on delete cascade,
    creation_date  date not null,
    primary key (first_user_id, second_user_id)
);

alter table users_matches
    owner to postgres;

create table user_passwords
(
    user_id       uuid not null
        primary key,
    password_hash text not null
);

alter table user_passwords
    owner to postgres;

create table registration_confirm
(
    user_id           uuid                  not null
        primary key,
    is_email_verified boolean default false not null
);

alter table registration_confirm
    owner to postgres;