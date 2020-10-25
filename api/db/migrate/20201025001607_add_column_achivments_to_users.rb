class AddColumnAchivmentsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :achivments, :jsonb, default: {"fin": 0, 
                                                      "lead": 0, 
                                                      "proforient": 0, 
                                                      "family": 0, 
                                                      "projactiv": 0, 
                                                      "networking": 0
                                                    }
  end
end
