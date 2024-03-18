-- PROCEDURES FOR THE AGENTS CRUD OPERATIONS
-- Create a new agent
CREATE OR REPLACE PROCEDURE create_agent(name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC)
AS $$
BEGIN
  INSERT INTO agents (name, email, contract_date, base_commission)
  VALUES (name, email, contract_date, base_commission);
END;
$$ LANGUAGE plpgsql;

-- Update an agent
CREATE OR REPLACE PROCEDURE update_agent(agent_id INTEGER, name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC)
AS $$
BEGIN
  UPDATE agents SET name = name, email = email, contract_date = contract_date, base_commission = base_commission WHERE id = agent_id;
END;
$$ LANGUAGE plpgsql;

-- Delete an agent
CREATE OR REPLACE PROCEDURE delete_agent(agent_id INTEGER)
AS $$
BEGIN
  DELETE FROM agents WHERE id = agent_id;
END;
$$ LANGUAGE plpgsql;

-- Get all agents
CREATE OR REPLACE PROCEDURE get_all_agents()
RETURNS TABLE (id INTEGER, name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC) AS $$
BEGIN
  RETURN QUERY SELECT * FROM agents;
END;
$$ LANGUAGE plpgsql;

-- Get an agent by id
CREATE OR REPLACE PROCEDURE get_agent_by_id(agent_id INTEGER)
RETURNS TABLE (id INTEGER, name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC) AS $$
BEGIN
  RETURN QUERY SELECT * FROM agents WHERE id = agent_id;
END;
$$ LANGUAGE plpgsql;

-- PROCEDURES FOR THE BUYER CRUD OPERATIONS
-- Create a new buyer
CREATE OR REPLACE PROCEDURE create_buyer(name VARCHAR, email VARCHAR)
AS $$
BEGIN
  INSERT INTO buyers (name, email)
  VALUES (name, email);
END;
$$ LANGUAGE plpgsql;

-- Update a buyer
CREATE OR REPLACE PROCEDURE update_buyer(buyer_id INTEGER, name VARCHAR, email VARCHAR)
AS $$
BEGIN
  UPDATE buyers SET name = name, email = email WHERE id = buyer_id;
END;
$$ LANGUAGE plpgsql;

-- Delete a buyer
CREATE OR REPLACE PROCEDURE delete_buyer(buyer_id INTEGER)
AS $$
BEGIN
  DELETE FROM buyers WHERE id = buyer_id;
END;
$$ LANGUAGE plpgsql;

-- Get all buyers
CREATE OR REPLACE PROCEDURE get_all_buyers()
RETURNS TABLE (id INTEGER, name VARCHAR, email VARCHAR) AS $$
BEGIN
  RETURN QUERY SELECT * FROM buyers;
END;
$$ LANGUAGE plpgsql;

-- Get a buyer by id
CREATE OR REPLACE PROCEDURE get_buyer_by_id(buyer_id INTEGER)
RETURNS TABLE (id INTEGER, name VARCHAR, email VARCHAR) AS $$
BEGIN
  RETURN QUERY SELECT * FROM buyers WHERE id = buyer_id;
END;
$$ LANGUAGE plpgsql;

-- PROCEDURES FOR THE SELLER CRUD OPERATIONS
-- Create a new seller
CREATE OR REPLACE PROCEDURE create_seller(name VARCHAR, email VARCHAR)
AS $$
BEGIN
  INSERT INTO sellers (name, email)
  VALUES (name, email);
END;
$$ LANGUAGE plpgsql;

-- Update a seller
CREATE OR REPLACE PROCEDURE update_seller(seller_id INTEGER, name VARCHAR, email VARCHAR)
AS $$
BEGIN
  UPDATE sellers SET name = name, email = email WHERE id = seller_id;
END;
$$ LANGUAGE plpgsql;

-- Delete a seller
CREATE OR REPLACE PROCEDURE delete_seller(seller_id INTEGER)
AS $$
BEGIN
  DELETE FROM sellers WHERE id = seller_id;
END;
$$ LANGUAGE plpgsql;

-- Get all sellers
CREATE OR REPLACE PROCEDURE get_all_sellers()
RETURNS TABLE (id INTEGER, name VARCHAR, email VARCHAR) AS $$
BEGIN
  RETURN QUERY SELECT * FROM sellers;
END;

-- Get a seller by id
CREATE OR REPLACE PROCEDURE get_seller_by_id(seller_id INTEGER)
RETURNS TABLE (id INTEGER, name VARCHAR, email VARCHAR) AS $$
BEGIN
  RETURN QUERY SELECT * FROM sellers WHERE id = seller_id;
END;

-- PROCEDURES FOR THE AVAILABLE PROPERTY CRUD OPERATIONS
-- Create a new available property
CREATE OR REPLACE PROCEDURE create_available_property(name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER)
AS $$
BEGIN
  INSERT INTO available_properties (name, city, address, listed_price, bedrooms, has_pool, publication_date, agent_id, seller_id) VALUES (name, city, address, listed_price, bedrooms, has_pool, publication_date, agent_id, seller_id);
END;
$$ LANGUAGE plpgsql;

-- Update an available property
CREATE OR REPLACE PROCEDURE update_available_property(property_id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER)
AS $$
BEGIN
  UPDATE available_properties SET name = name, city = city, address = address, listed_price = listed_price, bedrooms = bedrooms, has_pool = has_pool, publication_date = publication_date, agent_id = agent_id, seller_id = seller_id WHERE id = property_id;
END;
$$ LANGUAGE plpgsql;

-- Delete an available property
CREATE OR REPLACE PROCEDURE delete_available_property(property_id INTEGER)
AS $$
BEGIN
  DELETE FROM available_properties WHERE id = property_id;
END;

-- Get all available properties
CREATE OR REPLACE PROCEDURE get_all_available_properties()
RETURNS TABLE (id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER) AS $$
BEGIN
  RETURN QUERY SELECT * FROM available_properties;
END;
$$ LANGUAGE plpgsql;

-- Get an available property by id
CREATE OR REPLACE PROCEDURE get_available_property_by_id(property_id INTEGER)
RETURNS TABLE (id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, listed_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, publication_date DATE, agent_id INTEGER, seller_id INTEGER) AS $$
BEGIN
  RETURN QUERY SELECT * FROM available_properties WHERE id = property_id;
END;
$$ LANGUAGE plpgsql;

-- PROCEDURES FOR THE SOLD PROPERTY CRUD OPERATIONS
-- Create a new sold property
CREATE OR REPLACE PROCEDURE create_sold_property(name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, agent_commission NUMERIC, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER)
AS $$
BEGIN
  INSERT INTO sold_properties (name, city, address, sale_price, bedrooms, has_pool, sale_date, agent_commission, buyer_id, seller_id, agent_id, created_at, updated_at)
  VALUES (name, city, address, sale_price, bedrooms, has_pool, sale_date, agent_commission, buyer_id, seller_id, agent_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE update_sold_property(property_id INTEGER, new_name VARCHAR, new_city VARCHAR, new_address VARCHAR, new_sale_price NUMERIC, new_bedrooms INTEGER, new_has_pool BOOLEAN, new_sale_date DATE, new_agent_commission NUMERIC,buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER)
AS $$
BEGIN
  UPDATE sold_properties SET name = new_name, city = new_city, address = new_address, sale_price = new_sale_price, bedrooms = new_bedrooms, has_pool = new_has_pool, sale_date = new_sale_date, agent_commission = new_agent_commission, buyer_id = buyer_id, seller_id = seller_id, agent_id = agent_id, updated_at = CURRENT_TIMESTAMP
  WHERE id = property_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE delete_sold_property(property_id INTEGER)
AS $$
BEGIN
  DELETE FROM sold_properties WHERE id = property_id;
END;
$$ LANGUAGE plpgsql;

-- Get all sold properties
CREATE OR REPLACE PROCEDURE get_all_sold_properties()
RETURNS TABLE (id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER) AS $$
BEGIN
  RETURN QUERY SELECT * FROM sold_properties;
END;
$$ LANGUAGE plpgsql;

-- Get a sold property by id
CREATE OR REPLACE PROCEDURE get_sold_property_by_id(property_id INTEGER)
RETURNS TABLE (id INTEGER, name VARCHAR, city VARCHAR, address VARCHAR, sale_price NUMERIC, bedrooms INTEGER, has_pool BOOLEAN, sale_date DATE, buyer_id INTEGER, seller_id INTEGER, agent_id INTEGER) AS $$
BEGIN
  RETURN QUERY SELECT * FROM sold_properties WHERE id = property_id;
END;
$$ LANGUAGE plpgsql;
