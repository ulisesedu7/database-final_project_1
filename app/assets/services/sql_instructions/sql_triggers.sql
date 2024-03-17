-- Function to create a trigger and log the action in the audit_logs table
CREATE OR REPLACE FUNCTION log_action()
RETURNS TRIGGER AS $$
DECLARE
  user_id INT;
BEGIN
  -- Attempt to retrieve the current user ID from a session variable
  user_id := current_setting('myapp.current_user_id', true)::INTEGER;

  INSERT INTO audit_logs(action, record_type, record_id, details, user_id)
  VALUES (TG_ARGV[0], TG_ARGV[1], COALESCE(NEW.id, OLD.id), TG_ARGV[2], user_id);
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- TRIGGERS FOR THE AGENT CRUD OPERATIONS
-- Create a new agent
CREATE TRIGGER create_agent
AFTER INSERT ON agents
FOR EACH ROW EXECUTE FUNCTION log_action('CREATE', 'Agent', 'New agent created');

-- Update an agent
CREATE TRIGGER update_agent
AFTER UPDATE ON agents
FOR EACH ROW EXECUTE FUNCTION log_action('UPDATE', 'Agent', 'Agent updated');

-- Delete an agent
CREATE TRIGGER delete_agent
AFTER DELETE ON agents
FOR EACH ROW EXECUTE FUNCTION log_action('DELETE', 'Agent', 'Agent deleted');

-- TRIGGERS FOR THE BUYER CRUD OPERATIONS
-- Create a new buyer
CREATE TRIGGER create_buyer
AFTER INSERT ON buyers
FOR EACH ROW EXECUTE FUNCTION log_action('CREATE', 'Buyer', 'New buyer created');

-- Update a buyer
CREATE TRIGGER update_buyer
AFTER UPDATE ON buyers
FOR EACH ROW EXECUTE FUNCTION log_action('UPDATE', 'Buyer', 'Buyer updated');

-- Delete a buyer
CREATE TRIGGER delete_buyer
AFTER DELETE ON buyers
FOR EACH ROW EXECUTE FUNCTION log_action('DELETE', 'Buyer', 'Buyer deleted');

-- TRIGGERS FOR THE SELLER CRUD OPERATIONS
-- Create a new seller
CREATE TRIGGER create_seller
AFTER INSERT ON sellers
FOR EACH ROW EXECUTE FUNCTION log_action('CREATE', 'Seller', 'New seller created');

-- Update a seller
CREATE TRIGGER update_seller
AFTER UPDATE ON sellers
FOR EACH ROW EXECUTE FUNCTION log_action('UPDATE', 'Seller', 'Seller updated');

-- Delete a seller
CREATE TRIGGER delete_seller
AFTER DELETE ON sellers
FOR EACH ROW EXECUTE FUNCTION log_action('DELETE', 'Seller', 'Seller deleted');

-- TRIGGERS FOR THE AVAILABLE PROPERTY CRUD OPERATIONS
-- Create a new available property
CREATE TRIGGER create_available_property
AFTER INSERT ON available_properties
FOR EACH ROW EXECUTE FUNCTION log_action('CREATE', 'AvailableProperty', 'New available property created');

-- Update an available property
CREATE TRIGGER update_available_property
AFTER UPDATE ON available_properties
FOR EACH ROW EXECUTE FUNCTION log_action('UPDATE', 'AvailableProperty', 'Available property updated');

-- Delete an available property
CREATE TRIGGER delete_available_property
AFTER DELETE ON available_properties
FOR EACH ROW EXECUTE FUNCTION log_action('DELETE', 'AvailableProperty', 'Available property deleted');

-- TRIGGERS FOR THE SOLD PROPERTY CRUD OPERATIONS
-- Create a new sold property
CREATE TRIGGER create_sold_property
AFTER INSERT ON sold_properties
FOR EACH ROW EXECUTE FUNCTION log_action('CREATE', 'SoldProperty', 'New sold property created');

-- Update a sold property
CREATE TRIGGER update_sold_property
AFTER UPDATE ON sold_properties
FOR EACH ROW EXECUTE FUNCTION log_action('UPDATE', 'SoldProperty', 'Sold property updated');

-- Delete a sold property
CREATE TRIGGER delete_sold_property
AFTER DELETE ON sold_properties
FOR EACH ROW EXECUTE FUNCTION log_action('DELETE', 'SoldProperty', 'Sold property deleted');

-- Execute the triggers in rails
-- ActiveRecord::Base.connection.execute("SELECT create_agent('Nombre', 'Correo', 'FechaContrato', 'ComisionBase')")
