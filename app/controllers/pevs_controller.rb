# PEVs controller
class PevsController < ApplicationController
  # Keep user name and email in a pev that user marked and search for users marked pevs
  def index
    pevs = Pev.all
    pevs.each do |m|
      user = User.find_by_id_usuario(m.id_usuario);
      m.author_name =  (user!=nil) ? user.nome_completo : "anonimo"
      m.author_email = (user!=nil) ? user.email : "anonimo"
    end
    render json: pevs, methods:[:author_name, :author_email]
  end

  # get first pev of database
  def getOnePev
    pev = Pev.first
    render json: pev;
  end

  # Edit pev information changed
  def edit
    pev = Pev.find_by_id_pev(params[:pev][:id_pev])
    pev.update(titulo_pev: params[:titulo_pev], descricao_pev: params[:descricao_pev],
      paper: params[:paper], metal: params[:metal], plastic: params[:plastic], 
      glass: params[:glass]);
    render json: pev;
  end

  # Method of evaluation pev
  def increment
    user = User.find_user_by_id(params[:user_id])
    pev = Pev.find_pev_by_id(params[:pev_id])

    pev.total_working_confirmations = params[:total_working_confirmations]
    pev.total_done_confirmations = params[:total_done_confirmations]
    user.pevs << pev
    pev.save
    render json: pev;
  end

  # Create pev with success if has complete information and failed if has lack information
  def create
    pev_title = params[:pev_title]
    pev_description = params[:pev_description]

    pev_id_type = PevType.last.id

    latitude = params[:latitude]
    longitude = params[:longitude]

    state = 'XX'
    city = 'to do pegarCidade'

    paper = params[:paper]
    metal = params[:metal]
    plastic = params[:plastic]
    glass = params[:glass]

    pev.total_working_confirmations = params[:total_working_confirmations]
    pev.total_done_confirmations = params[:total_done_confirmations]
    
    user = User.find_by_email(params[:author_email])

    if !user.nil?
      user_id = user.user_id      
      pev = Pev.new(pev_title: pev_title, pev_description: pev_description,
                    pev_id_type: pev_id_type, latitude: latitude,
                    longitude: longitude, state: state, city: city,
                    user_id: user_id,paper: paper, metal: metal,
                    plastic: plastic, glass: glass,
                    total_working_confirmations: total_working_confirmations,
                    total_done_confirmations: total_done_confirmations]
      if pev.save
        render json: pev
      else
          render json: { error: 'Invalid parameters' }, status: 401
      end   
    else
          render json: { error: 'Invalid parameters' }, status: 401
    end      

    
    
  end
end
