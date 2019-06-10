class CreateConta < ActiveRecord::Migration[5.1]
  def change
    create_table :conta do |t|
      t.float :valor
      t.float :juros
      t.string :status
      t.string :dataCompra
      t.string :dataPagamento
      t.integer :funcionario
      t.integer :cliente
      t.string :descricao
      t.string :comprador
      t.string :parentesco

      t.timestamps
    end
  end
end
