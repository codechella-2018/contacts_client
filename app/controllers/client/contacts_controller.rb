class Client::ContactsController < ApplicationController
  def index
    response = Unirest.get("http://localhost:3000/api/contacts")
    @contacts = response.body
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
    }

    response = Unirest.post(
	    "http://localhost:3000/api/contacts",
	    parameters: client_params
	    )

    flash[:success] = "Successfully created contact"
    redirect_to "/client/contacts/"
  end

  def show
    contact_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/contacts/#{contact_id}")
    @contact = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/contacts/#{params[:id]}")
    @contact = response.body
    render 'edit.html.erb'
  end

  def update
    client_params = {
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
    }

    response = Unirest.patch(
      "http://localhost:3000/api/contacts/#{params[:id]}",
      parameters: client_params
      )

    flash[:success] = "Successfully updated contact"
    redirect_to "/client/contacts/#{params[:id]}"
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/contacts/#{params['id']}")
    flash[:success] = "Successfully destroyed contact"
    redirect_to "/client/contacts"
  end
end