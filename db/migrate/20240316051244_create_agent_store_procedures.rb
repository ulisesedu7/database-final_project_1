class CreateAgentStoreProcedures < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE PROCEDURE create_agent(name VARCHAR, email VARCHAR, contract_date DATE, base_commission NUMERIC)
      AS $$
      BEGIN
        INSERT INTO agents (name, email, contract_date, base_commission, created_at, updated_at)
        VALUES (name, email, contract_date, base_commission, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      END;
      $$ LANGUAGE plpgsql;

      CREATE OR REPLACE PROCEDURE update_agent(agent_id INTEGER, agent_name VARCHAR, agent_email VARCHAR, agent_contract_date DATE, agent_base_commission NUMERIC)
      AS $$
      BEGIN
      UPDATE agents
        SET name = agent_name,
            email = agent_email,
            contract_date = agent_contract_date,
            base_commission = agent_base_commission,
            updated_at = CURRENT_TIMESTAMP
        WHERE id = agent_id;
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

      drop PROCEDURE if exists update_agent(agent_id INTEGER, agent_name VARCHAR, agent_email VARCHAR, agent_contract_date DATE, agent_base_commission NUMERIC);

      drop PROCEDURE if exists delete_agent(agent_id INTEGER);
    SQL
  end
end
