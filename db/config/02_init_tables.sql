CREATE TABLE Infos (
    /* primary id that is always generated when adding a new entity */
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    info TEXT
);