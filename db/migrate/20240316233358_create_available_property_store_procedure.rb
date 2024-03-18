class CreateAvailablePropertyStoreProcedure < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_available_property(name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER)
      AS $$
      BEGIN
        INSERT INTO available_properties (name, city, address, listed_price, bedrooms, has_pool, publication_date, agent_id, seller_id, created_at, updated_at)
        VALUES (name, city, address, listed_price, bedrooms, has_pool, publication_date, agent_id, seller_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_available_property(property_id INTEGER, new_name VARCHAR, new_city VARCHAR, new_address VARCHAR, new_listed_price NUMERIC, new_bedrooms INTEGER, new_has_pool BOOLEAN, new_publication_date DATE, agent_id INTEGER, seller_id INTEGER)
      AS $$
      BEGIN
        UPDATE available_properties SET name = new_name, city = new_city, address = new_address, listed_price = new_listed_price, bedrooms = new_bedrooms, has_pool = new_has_pool, publication_date = new_publication_date, agent_id = agent_id, seller_id = seller_id, updated_at = CURRENT_TIMESTAMP
        WHERE id = property_id;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE delete_available_property(property_id INTEGER)
      AS $$
      BEGIN
        DELETE FROM available_properties WHERE id = property_id;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS create_available_property(name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER);

      DROP PROCEDURE IF EXISTS update_available_property(property_id INTEGER, new_name VARCHAR, new_city VARCHAR, new_address VARCHAR, new_listed_price NUMERIC, new_bedrooms INTEGER, new_has_pool BOOLEAN, new_publication_date DATE, agent_id INTEGER, seller_id INTEGER);

      DROP PROCEDURE IF EXISTS delete_available_property(property_id INTEGER);
    SQL
  end
end
