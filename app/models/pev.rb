class Pev < ActiveRecord::Base
  self.table_name = "pevs"
  validates :descricao_pev, length: {maximum:140}
  validates :titulo_pev, presence:true
  #existe um Id_user ao invés de email.
  #validates :author_email, presence:true
end
