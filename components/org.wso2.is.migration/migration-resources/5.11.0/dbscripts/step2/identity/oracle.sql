INSERT INTO IDN_CONFIG_TYPE (ID, NAME, DESCRIPTION) VALUES
('8ec6dbf1-218a-49bf-bc34-0d2db52d151c', 'CORS_CONFIGURATION', 'A resource type to keep the tenant CORS configurations')
/

CREATE TABLE IDN_CORS_ORIGIN (
ID                INTEGER           NOT NULL,
TENANT_ID         INTEGER           NOT NULL,
ORIGIN            VARCHAR(2048) NOT NULL,
UUID              CHAR(36)      NOT NULL,
PRIMARY KEY (ID),
UNIQUE (TENANT_ID, ORIGIN),
UNIQUE (UUID)
)
/

CREATE SEQUENCE IDN_CORS_ORIGIN_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_CORS_ORIGIN_TRIG
    BEFORE INSERT
        ON IDN_CORS_ORIGIN
           REFERENCING NEW AS NEW
           FOR EACH ROW
BEGIN
    SELECT IDN_CORS_ORIGIN_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE TABLE  IDN_CORS_ASSOCIATION (
IDN_CORS_ORIGIN_ID  INT NOT NULL,
SP_APP_ID           INT NOT NULL,

PRIMARY KEY (IDN_CORS_ORIGIN_ID, SP_APP_ID),
FOREIGN KEY (IDN_CORS_ORIGIN_ID) REFERENCES IDN_CORS_ORIGIN (ID) ON DELETE CASCADE,
FOREIGN KEY (SP_APP_ID) REFERENCES SP_APP (ID) ON DELETE CASCADE
)
/

CREATE INDEX IDX_CORS_SP_APP_ID ON IDN_CORS_ASSOCIATION (SP_APP_ID)
/
CREATE INDEX IDX_CORS_ORIGIN_ID ON IDN_CORS_ASSOCIATION (IDN_CORS_ORIGIN_ID)
/
