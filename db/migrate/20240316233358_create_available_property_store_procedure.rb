class CreateAvailablePropertyStoreProcedure < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_available_property(name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER)
      AS $$
      BEGIN
        INSERT INTO available_properties (name, city, address, listed_price, bedrooms, has_pool, publication_date, agent_id, seller_id) VALUES (name, city, address, listed_price, bedrooms, has_pool, publication_date, agent_id, seller_id);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_available_property(property_id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER)
      AS $$
      BEGIN
        UPDATE available_properties SET name = name, city = city, address = address, listed_price = listed_price, bedrooms = bedrooms, has_pool = has_pool, publication_date = publication_date, agent_id = agent_id, seller_id = seller_id WHERE id = property_id;
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

      DROP PROCEDURE IF EXISTS update_available_property(property_id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER);

      DROP PROCEDURE IF EXISTS delete_available_property(property_id INTEGER);
    SQL
  end
end
