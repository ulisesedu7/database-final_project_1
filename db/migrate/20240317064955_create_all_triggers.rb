class CreateAllTriggers < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
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
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS create_agent ON agents;
      DROP TRIGGER IF EXISTS update_agent ON agents;
      DROP TRIGGER IF EXISTS delete_agent ON agents;

      DROP TRIGGER IF EXISTS create_buyer ON buyers;
      DROP TRIGGER IF EXISTS update_buyer ON buyers;
      DROP TRIGGER IF EXISTS delete_buyer ON buyers;

      DROP TRIGGER IF EXISTS create_seller ON sellers;
      DROP TRIGGER IF EXISTS update_seller ON sellers;
      DROP TRIGGER IF EXISTS delete_seller ON sellers;

      DROP TRIGGER IF EXISTS create_available_property ON available_properties;
      DROP TRIGGER IF EXISTS update_available_property ON available_properties;
      DROP TRIGGER IF EXISTS delete_available_property ON available_properties;

      DROP TRIGGER IF EXISTS create_sold_property ON sold_properties;
      DROP TRIGGER IF EXISTS update_sold_property ON sold_properties;
      DROP TRIGGER IF EXISTS delete_sold_property ON sold_properties;
    SQL
  end
end
