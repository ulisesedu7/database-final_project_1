class CreateBuyerStoreProcedures < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_buyer(name VARCHAR, email VARCHAR)
      AS $$
      BEGIN
        INSERT INTO buyers (name, email, created_at, updated_at)
        VALUES (name, email, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_buyer(buyer_id INTEGER, buyer_name VARCHAR, buyer_email VARCHAR)
      AS $$
      BEGIN
        UPDATE buyers SET name = buyer_name, email = buyer_email, updated_at = CURRENT_TIMESTAMP
        WHERE id = buyer_id;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE delete_buyer(buyer_id INTEGER)
      AS $$
      BEGIN
        DELETE FROM buyers WHERE id = buyer_id;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS create_buyer(name VARCHAR, email VARCHAR);

      DROP PROCEDURE IF EXISTS update_buyer(buyer_id INTEGER, buyer_name VARCHAR, buyer_email VARCHAR);

      DROP PROCEDURE IF EXISTS delete_buyer(buyer_id INTEGER);
    SQL
  end
end
