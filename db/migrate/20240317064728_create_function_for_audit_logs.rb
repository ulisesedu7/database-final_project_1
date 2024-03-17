class CreateFunctionForAuditLogs < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      -- Function to create a trigger and log the action in the audit_logs table
      CREATE OR REPLACE FUNCTION log_action()
      RETURNS TRIGGER AS $$
      DECLARE
        user_id INT;
      BEGIN
        -- Attempt to retrieve the current user ID from a session variable
        user_id := current_setting('myapp.current_user_id', true)::INTEGER;

        INSERT INTO audit_logs(action, record_type, record_id, details, user_id, created_at, updated_at)
        VALUES (TG_ARGV[0], TG_ARGV[1], COALESCE(NEW.id, OLD.id), TG_ARGV[2], user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        RETURN COALESCE(NEW, OLD);
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS log_action();
    SQL
  end
end
