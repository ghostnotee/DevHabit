﻿    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM pg_namespace WHERE nspname = 'dev_habit') THEN
            CREATE SCHEMA dev_habit;
        END IF;
    END $EF$;
    CREATE TABLE IF NOT EXISTS dev_habit."__EFMigrationsHistory" (
        migration_id character varying(150) NOT NULL,
        product_version character varying(32) NOT NULL,
        CONSTRAINT pk___ef_migrations_history PRIMARY KEY (migration_id)
    );
    
    START TRANSACTION;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250320225004_Add_Habits') THEN
            IF NOT EXISTS(SELECT 1 FROM pg_namespace WHERE nspname = 'dev_habit') THEN
                CREATE SCHEMA dev_habit;
            END IF;
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250320225004_Add_Habits') THEN
        CREATE TABLE dev_habit.habits (
            id character varying(500) NOT NULL,
            name character varying(100) NOT NULL,
            description character varying(500),
            type integer NOT NULL,
            frequency_type integer NOT NULL,
            frequency_times_per_period integer NOT NULL,
            target_value integer NOT NULL,
            target_unit character varying(100) NOT NULL,
            status integer NOT NULL,
            is_archived boolean NOT NULL,
            end_date date,
            milestone_target integer,
            milestone_current integer,
            created_at_utc timestamp with time zone NOT NULL,
            updated_at_utc timestamp with time zone,
            last_completed_at_utc timestamp with time zone,
            CONSTRAINT pk_habits PRIMARY KEY (id)
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250320225004_Add_Habits') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250320225004_Add_Habits', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250325083404_Add_Tags') THEN
        CREATE TABLE dev_habit.tags (
            id character varying(500) NOT NULL,
            name character varying(50) NOT NULL,
            description character varying(500),
            created_at_utc timestamp with time zone NOT NULL,
            updated_at_utc timestamp with time zone,
            CONSTRAINT pk_tags PRIMARY KEY (id)
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250325083404_Add_Tags') THEN
        CREATE UNIQUE INDEX ix_tags_name ON dev_habit.tags (name);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250325083404_Add_Tags') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250325083404_Add_Tags', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250325105021_Add_HabitTags') THEN
        CREATE TABLE dev_habit.habit_tags (
            habit_id character varying(500) NOT NULL,
            tag_id character varying(500) NOT NULL,
            created_at_utc timestamp with time zone NOT NULL,
            CONSTRAINT pk_habit_tags PRIMARY KEY (habit_id, tag_id),
            CONSTRAINT fk_habit_tags_habits_habit_id FOREIGN KEY (habit_id) REFERENCES dev_habit.habits (id) ON DELETE CASCADE,
            CONSTRAINT fk_habit_tags_tags_tag_id FOREIGN KEY (tag_id) REFERENCES dev_habit.tags (id) ON DELETE CASCADE
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250325105021_Add_HabitTags') THEN
        CREATE INDEX ix_habit_tags_tag_id ON dev_habit.habit_tags (tag_id);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250325105021_Add_HabitTags') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250325105021_Add_HabitTags', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250402215350_Add_Users') THEN
        CREATE TABLE dev_habit.users (
            id character varying(500) NOT NULL,
            email character varying(300) NOT NULL,
            name character varying(100) NOT NULL,
            created_at_utc timestamp with time zone NOT NULL,
            updated_at_utc timestamp with time zone,
            identity_id character varying(500) NOT NULL,
            CONSTRAINT pk_users PRIMARY KEY (id)
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250402215350_Add_Users') THEN
        CREATE UNIQUE INDEX ix_users_email ON dev_habit.users (email);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250402215350_Add_Users') THEN
        CREATE UNIQUE INDEX ix_users_identity_id ON dev_habit.users (identity_id);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250402215350_Add_Users') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250402215350_Add_Users', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        DELETE FROM dev_habit.habit_tags;
        DELETE FROM dev_habit.habits;
        DELETE FROM dev_habit.tags; 
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        DROP INDEX dev_habit.ix_tags_name;
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        ALTER TABLE dev_habit.tags ADD user_id character varying(500) NOT NULL DEFAULT '';
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        ALTER TABLE dev_habit.habits ADD user_id character varying(500) NOT NULL DEFAULT '';
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        CREATE UNIQUE INDEX ix_tags_user_id_name ON dev_habit.tags (user_id, name);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        CREATE INDEX ix_habits_user_id ON dev_habit.habits (user_id);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        ALTER TABLE dev_habit.habits ADD CONSTRAINT fk_habits_users_user_id FOREIGN KEY (user_id) REFERENCES dev_habit.users (id) ON DELETE CASCADE;
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        ALTER TABLE dev_habit.tags ADD CONSTRAINT fk_tags_users_user_id FOREIGN KEY (user_id) REFERENCES dev_habit.users (id) ON DELETE CASCADE;
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404151359_Add_UserId_Reference') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250404151359_Add_UserId_Reference', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404215708_Add_GitHubAccessTokens') THEN
        CREATE TABLE dev_habit.git_hub_access_tokens (
            id character varying(500) NOT NULL,
            user_id character varying(500) NOT NULL,
            token character varying(1000) NOT NULL,
            expires_at_utc timestamp with time zone NOT NULL,
            created_at_utc timestamp with time zone NOT NULL,
            CONSTRAINT pk_git_hub_access_tokens PRIMARY KEY (id),
            CONSTRAINT fk_git_hub_access_tokens_users_user_id FOREIGN KEY (user_id) REFERENCES dev_habit.users (id) ON DELETE CASCADE
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404215708_Add_GitHubAccessTokens') THEN
        CREATE UNIQUE INDEX ix_git_hub_access_tokens_user_id ON dev_habit.git_hub_access_tokens (user_id);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250404215708_Add_GitHubAccessTokens') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250404215708_Add_GitHubAccessTokens', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250406204657_Add_Entry') THEN
        ALTER TABLE dev_habit.habits ADD automation_source integer;
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250406204657_Add_Entry') THEN
        CREATE TABLE dev_habit.entries (
            id character varying(500) NOT NULL,
            habit_id character varying(500) NOT NULL,
            user_id character varying(500) NOT NULL,
            value integer NOT NULL,
            notes character varying(1000),
            source integer NOT NULL,
            external_id character varying(1000),
            is_archived boolean NOT NULL,
            date date NOT NULL,
            created_at_utc timestamp with time zone NOT NULL,
            updated_at_utc timestamp with time zone,
            CONSTRAINT pk_entries PRIMARY KEY (id),
            CONSTRAINT fk_entries_habits_habit_id FOREIGN KEY (habit_id) REFERENCES dev_habit.habits (id) ON DELETE CASCADE,
            CONSTRAINT fk_entries_users_user_id FOREIGN KEY (user_id) REFERENCES dev_habit.users (id) ON DELETE CASCADE
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250406204657_Add_Entry') THEN
        CREATE UNIQUE INDEX ix_entries_external_id ON dev_habit.entries (external_id) WHERE external_id IS NOT NULL;
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250406204657_Add_Entry') THEN
        CREATE INDEX ix_entries_habit_id ON dev_habit.entries (habit_id);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250406204657_Add_Entry') THEN
        CREATE INDEX ix_entries_user_id ON dev_habit.entries (user_id);
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250406204657_Add_Entry') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250406204657_Add_Entry', '9.0.4');
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250412145353_Add_EntryImportJobs') THEN
        CREATE TABLE dev_habit.entry_import_jobs (
            id text NOT NULL,
            user_id text NOT NULL,
            status integer NOT NULL,
            file_name text NOT NULL,
            file_content bytea NOT NULL,
            total_records integer NOT NULL,
            processed_records integer NOT NULL,
            successful_records integer NOT NULL,
            failed_records integer NOT NULL,
            errors text[] NOT NULL,
            created_at_utc timestamp with time zone NOT NULL,
            completed_at_utc timestamp with time zone,
            CONSTRAINT pk_entry_import_jobs PRIMARY KEY (id)
        );
        END IF;
    END $EF$;
    
    DO $EF$
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM dev_habit."__EFMigrationsHistory" WHERE "migration_id" = '20250412145353_Add_EntryImportJobs') THEN
        INSERT INTO dev_habit."__EFMigrationsHistory" (migration_id, product_version)
        VALUES ('20250412145353_Add_EntryImportJobs', '9.0.4');
        END IF;
    END $EF$;
    COMMIT;
    
