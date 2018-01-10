CREATE TABLE app_users (
    username VARCHAR NOT NULL,
    password VARCHAR NOT NULL,
    PRIMARY KEY username
);

CREATE TABLE events (
    uuid VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    username VARCHAR NOT NULL,
    date_from VARCHAR NOT NULL,
    date_to VARCHAR NOT NULL,
    PRIMARY KEY uuid
);

CREATE TABLE talks (
    uuid VARCHAR NOT NULL,
    talk_title VARCHAR NOT NULL,
    event_id VARCHAR NOT NULL,
    talk_date VARCHAR NOT NULL,
    PRIMARY KEY uuid
);
