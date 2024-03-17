class CreateBuyerStoreProcedures < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_buyer(name VARCHAR, email VARCHAR)
      AS $$
      BEGIN
        INSERT INTO buyers (name, email)
        VALUES (name, email);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_buyer(buyer_id INTEGER, name VARCHAR, email VARCHAR)
      AS $$
      BEGIN
        UPDATE buyers SET name = name, email = email WHERE id = buyer_id;
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

      DROP PROCEDURE IF EXISTS update_buyer(buyer_id INTEGER, name VARCHAR, email VARCHAR);

      DROP PROCEDURE IF EXISTS delete_buyer(buyer_id INTEGER);
    SQL
  end
end
