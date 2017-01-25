
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE "campaigns" ADD COLUMN "is_proxy" INTEGER DEFAULT 0;

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
BEGIN TRANSACTION;
ALTER TABLE "campaigns" RENAME TO "temp_campaigns";

CREATE TABLE IF NOT EXISTS "campaigns" ("id" integer primary key autoincrement,"user_id" bigint,"name" varchar(255) NOT NULL ,"created_date" datetime,"completed_date" datetime,"template_id" bigint,"page_id" bigint,"status" varchar(255),"url" varchar(255) );

INSERT INTO "campaigns"
SELECT 
	"id", "user_id", "name", "created_date", "completed_date", "template_id", "page_id", "status", "url"
FROM
	"temp_campaigns";

DROP TABLE "temp_campaigns";