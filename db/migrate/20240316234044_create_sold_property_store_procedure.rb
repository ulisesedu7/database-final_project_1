class CreateSoldPropertyStoreProcedure < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_sold_property(name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER)
      AS $$
      BEGIN
        INSERT INTO sold_properties (name, city, address, sale_price, bedrooms, has_pool, sale_date, buyer_id, seller_id, agent_id) VALUES (name, city, address, sale_price, bedrooms, has_pool, sale_date, buyer_id, seller_id, agent_id);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_sold_property(property_id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER)
      AS $$
      BEGIN
        UPDATE sold_properties SET name = name, city = city, address = address, sale_price = sale_price, bedrooms = bedrooms, has_pool = has_pool, sale_date = sale_date, buyer_id = buyer_id, seller_id = seller_id, agent_id = agent_id WHERE id = property_id;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE delete_sold_property(property_id INTEGER)
      AS $$
      BEGIN
        DELETE FROM sold_properties WHERE id = property_id;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS create_sold_property(name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER);

      DROP PROCEDURE IF EXISTS update_sold_property(property_id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER);

      DROP PROCEDURE IF EXISTS delete_sold_property(property_id INTEGER);
    SQL
  end
end
