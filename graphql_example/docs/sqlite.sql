CREATE TABLE `project` (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    start_date TEXT NOT NULL,
    end_date TEXT,
    shortname TEXT NOT NULL,
    abbreviation TEXT NOT NULL,
    description TEXT,
    projectnumber TEXT NOT NULL
);


CREATE TABLE `contacts` (
    contact_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    contact_name TEXT NOT NULL,
    address TEXT,
    phone TEXT,
    email TEXT,
    mobile TEXT
);


CREATE TABLE `project_contacts` (
    project_id INTEGER NOT NULL,
    contact_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, contact_id)
);
