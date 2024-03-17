class CreateAgentStoreProcedures < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_agent(name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC)
      AS $$
      BEGIN
        INSERT INTO agents (name, email, contract_date, base_commission)
        VALUES (name, email, contract_date, base_commission);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_agent(agent_id INTEGER, name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC)
      AS $$
      BEGIN
        UPDATE agents SET name = name, email = email, contract_date = contract_date, base_commission = base_commission WHERE id = agent_id;
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE delete_agent(agent_id INTEGER)
      AS $$
      BEGIN
        DELETE FROM agents WHERE id = agent_id;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL
      drop PROCEDURE if exists create_agent(name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC);

      drop PROCEDURE if exists update_agent(agent_id INTEGER, name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC);

      drop PROCEDURE if exists delete_agent(agent_id INTEGER);
    SQL
  end
end
