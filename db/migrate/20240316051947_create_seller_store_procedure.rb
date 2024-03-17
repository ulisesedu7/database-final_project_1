class CreateSellerStoreProcedure < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_seller(name VARCHAR, email VARCHAR)
      AS $$
      BEGIN
        INSERT INTO sellers (name, email)
        VALUES (name, email);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_seller(seller_id INTEGER, name VARCHAR, email VARCHAR)
      AS $$
      BEGIN
        UPDATE sellers SET name = name, email = email WHERE id = seller_id;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE delete_seller(seller_id INTEGER)
      AS $$
      BEGIN
        DELETE FROM sellers WHERE id = seller_id;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS create_seller(name VARCHAR, email VARCHAR);

      DROP PROCEDURE IF EXISTS update_seller(seller_id INTEGER, name VARCHAR, email VARCHAR);

      DROP PROCEDURE IF EXISTS delete_seller(seller_id INTEGER);
    SQL
  end
end
