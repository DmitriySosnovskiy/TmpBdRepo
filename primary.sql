create table users
(
    id         uuid not null
        primary key,
    email      text not null
        constraint users_pk
            unique,
    name       text not null,
    birth_date date not null
);

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

comment on column dating_profile.status is 'на модерации / аппрувнута или что-то еще';

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

create table password_recovery
(
    user_id        uuid not null
        constraint password_recovery_pk_2
            primary key
        constraint password_recovery_users_id_fk
            references users
            on delete cascade,
    recovery_token text not null
        constraint password_recovery_pk
            unique,
    created_at     date not null,
    expired_at     date not null
);

comment on column password_recovery.recovery_token is 'если пользователь запросит новый сброс пароля, эту запись надо удалить и создать новую';

alter table password_recovery
    owner to postgres;

create table registration_pending_users
(
    email      text not null
        constraint registration_pending_users_pk
            primary key,
    name       text not null,
    birth_date date not null,
    gender     text not null
);

alter table registration_pending_users
    owner to postgres;

create table registration_confirm
(
    email             text not null
        constraint registration_confirm_email_pk
            primary key
        constraint registration_confirm_registration_pending_users_email_fk
            references registration_pending_users
            on delete cascade,
    confirmation_code text not null,
    last_updated_at   date not null
);

alter table registration_confirm
    owner to postgres;

create table user_auth
(
    user_id       uuid not null
        constraint user_auth_pk
            primary key
        constraint user_auth_users_id_fk
            references users
            on delete cascade,
    session_token text not null
        constraint user_auth_pk_2
            unique,
    created_at    date not null,
    expired_at    date not null
);

alter table user_auth
    owner to postgres;

