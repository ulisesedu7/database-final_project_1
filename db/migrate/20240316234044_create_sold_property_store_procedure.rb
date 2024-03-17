class CreateSoldPropertyStoreProcedure < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_sold_property(name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, agent_comission NUMERIC, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER)
      AS $$
      BEGIN
        INSERT INTO sold_properties (name, city, address, sale_price, bedrooms, has_pool, sale_date, agent_comission, buyer_id, seller_id, agent_id, created_at, updated_at)
        VALUES (name, city, address, sale_price, bedrooms, has_pool, sale_date, agent_comission, buyer_id, seller_id, agent_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_sold_property(property_id INTEGER, new_name VARCHAR, new_city VARCHAR, new_address VARCHAR, new_sale_price NUMERIC, new_bedrooms INTEGER, new_has_pool BOOLEAN, new_sale_date DATE, new_agent_comission NUMERIC,buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER)
      AS $$
      BEGIN
        UPDATE sold_properties SET name = new_name, city = new_city, address = new_address, sale_price = new_sale_price, bedrooms = new_bedrooms, has_pool = new_has_pool, sale_date = new_sale_date, agent_comission = new_agent_comission, buyer_id = buyer_id, seller_id = seller_id, agent_id = agent_id, updated_at = CURRENT_TIMESTAMP
        WHERE id = property_id;
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
      DROP PROCEDURE IF EXISTS ccreate_sold_property(name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, agent_comission NUMERIC, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER);

      DROP PROCEDURE IF EXISTS update_sold_property(property_id INTEGER, new_name VARCHAR, new_city VARCHAR, new_address VARCHAR, new_sale_price NUMERIC, new_bedrooms INTEGER, new_has_pool BOOLEAN, new_sale_date DATE, new_agent_comission NUMERIC,buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER);

      DROP PROCEDURE IF EXISTS delete_sold_property(property_id INTEGER);
    SQL
  end
end
