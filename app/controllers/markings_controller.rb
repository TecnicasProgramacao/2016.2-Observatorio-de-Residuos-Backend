# Markings controller
class MarkingsController < ApplicationController
  # Keep user name and email in a marking that user marked and search for users marked markings
  def index
    markings = Marking.all
    markings.each do |m|
      user = User.find_by_id_usuario(m.id_usuario);
      m.author_name =  (user!=nil) ? user.nome_completo : "anonimo"
      m.author_email = (user!=nil) ? user.email : "anonimo"
    end
    render json: markings, methods:[:author_name, :author_email]
  end

  def new
    marking = Marking.new
  end
 
  def increment
    user = User.find_by_id_user(params[:id_user]);

    marking = Marking.find_by_id_incident(params[:id_incident])
    marking.total_existent_confirmations = params[:total_existent_confirmations]
    marking.total_confirmations_solved = params[:total_confirmations_solved]

    user.markings << marking
    marking.save

    render json: marking;
  end

  # Create marking with success if has complete information and failed if has lack information
  def create

    incident_title = params[:incident_title]
    incident_description = params[:incident_description]
    incident_type_id = params[:incident_type_id]

    incident_image = 'image'
    latitude = params[:latitude]
    longitude = params[:longitude]

    state = 'GO'
    city = 'Luziania'

    total_confirmations_existent = params[:total_confirmations_existent]
    total_confirmations_solved = params[:total_confirmations_solved]

    user_id = User.find_by_email(params[:author_email]).user_id;

    marking = Marking.new(incident_title: incident_title, incident_type_id: incident_type_id, 
                          incident_description: incident_description, incident_type_id: incident_type_id,
                          incident_image: iincident_image, latitude: latitude, longitude: longitude, 
                          state: state, city: city, user_id: user_id, total_confirmations_existent: total_confirmations_existent,
                          total_confirmations_solved: total_confirmations_solved)
    if marking.save
        render json: marking
    else
        render json: { error: 'Incorrect credentials' }, status: 401
        puts marking.errors.messages
    end
  end

  # Edit marking information changed
  def edit
    marking = Marking.find_by_id_incidente(params[:id_incidente])
    marking.titulo_incidente = params[:titulo_incidente]
    marking.descricao_incidente = params[:descricao_incidente]
    marking.id_tipo_incidente = params[:id_tipo_incidente]
    marking.save
    render json: marking;
  end
end
