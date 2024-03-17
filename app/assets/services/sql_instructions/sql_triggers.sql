-- TRIGGERS FOR THE AUDIT LOG
-- Trigger for the agents table
-- Log Agent creation
-- Add Admins
CREATE OR REPLACE FUNCTION log_agent_creation()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('create', 'Agent', NEW.id, 'Agent created');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_agent_creation
AFTER INSERT ON agents
FOR EACH ROW EXECUTE FUNCTION log_agent_creation();

-- Log Agent update
CREATE OR REPLACE FUNCTION log_agent_update()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('update', 'Agent', NEW.id, 'Agent updated');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_agent_update
AFTER UPDATE ON agents
FOR EACH ROW EXECUTE FUNCTION log_agent_update();

-- Log Agent deletion
CREATE OR REPLACE FUNCTION log_agent_deletion()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('delete', 'Agent', OLD.id, 'Agent deleted');
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_agent_deletion
AFTER DELETE ON agents
FOR EACH ROW EXECUTE FUNCTION log_agent_deletion();

-- Trigger for the buyers table
-- Log Buyer creation
CREATE OR REPLACE FUNCTION log_buyer_creation()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('create', 'Buyer', NEW.id, 'Buyer created');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_buyer_creation
AFTER INSERT ON buyers
FOR EACH ROW EXECUTE FUNCTION log_buyer_creation();

-- Log Buyer update
CREATE OR REPLACE FUNCTION log_buyer_update()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('update', 'Buyer', NEW.id, 'Buyer updated');
  RETURN NEW;
END;

CREATE TRIGGER trigger_buyer_update
AFTER UPDATE ON buyers
FOR EACH ROW EXECUTE FUNCTION log_buyer_update();

-- Log Buyer deletion
CREATE OR REPLACE FUNCTION log_buyer_deletion()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('delete', 'Buyer', OLD.id, 'Buyer deleted');
  RETURN OLD;
END;

CREATE TRIGGER trigger_buyer_deletion
AFTER DELETE ON buyers
FOR EACH ROW EXECUTE FUNCTION log_buyer_deletion();

-- Trigger for the sellers table
-- Log Seller creation
CREATE OR REPLACE FUNCTION log_seller_creation()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('create', 'Seller', NEW.id, 'Seller created');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_seller_creation
AFTER INSERT ON sellers
FOR EACH ROW EXECUTE FUNCTION log_seller_creation();

-- Log Seller update
CREATE OR REPLACE FUNCTION log_seller_update()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('update', 'Seller', NEW.id, 'Seller updated');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_seller_update
AFTER UPDATE ON sellers
FOR EACH ROW EXECUTE FUNCTION log_seller_update();

-- Log Seller deletion
CREATE OR REPLACE FUNCTION log_seller_deletion()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('delete', 'Seller', OLD.id, 'Seller deleted');
  RETURN OLD;
END;

CREATE TRIGGER trigger_seller_deletion
AFTER DELETE ON sellers
FOR EACH ROW EXECUTE FUNCTION log_seller_deletion();

-- Trigger for the properties table
-- Log Property creation
CREATE OR REPLACE FUNCTION log_property_creation()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('create', 'Property', NEW.id, 'Property created');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_property_creation
AFTER INSERT ON properties
FOR EACH ROW EXECUTE FUNCTION log_property_creation();

-- Log Property update
CREATE OR REPLACE FUNCTION log_property_update()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('update', 'Property', NEW.id, 'Property updated');
  RETURN NEW;
END;
$$ Language plpgsql;

CREATE TRIGGER trigger_property_update
AFTER UPDATE ON properties
FOR EACH ROW EXECUTE FUNCTION log_property_update();

-- Log Property deletion
CREATE OR REPLACE FUNCTION log_property_deletion()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_logs(action, record_type, record_id, details)
  VALUES ('delete', 'Property', OLD.id, 'Property deleted');
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_property_deletion
AFTER DELETE ON properties
FOR EACH ROW EXECUTE FUNCTION log_property_deletion();

-- Execute the triggers in rails
-- ActiveRecord::Base.connection.execute("SELECT create_agent('Nombre', 'Correo', 'FechaContrato', 'ComisionBase')")
