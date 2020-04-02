class ApplicationController < Sinatra::Base
  set :views, "app/views"

  get('/tenant/new') do
    erb(:new)
  end

  post ('/tenant') do
    @tenant = Tenant.create({
      name: params[:name],
      apartment_id: params[:apartment_id]
    })
    redirect '/tenant/list'
  end

  get ('/tenant/list') do 
    @tenants = Tenant.all
    erb(:list)
  end
  
  get('/apartment/list') do 
    @apartments = Apartment.all 
    erb(:apartment_list)

  end

  get('/apartment/new') do
    erb(:new_apartment)
  end

  post('/apartment') do 
    @apartment = Apartment.create({
      address: params[:address]
    })
    redirect '/apartment/list'
  end

  get('/apartment/:id') do 
    @apartment = Apartment.find_by(id: params[:id])
    @tenants = @apartment.tenants
    erb(:apartment_details)
  end

  
  get('/tenant/:id') do
    @tenant = Tenant.find_by(id: params[:id])
    @apartments = Apartment.all
    erb(:edit)

  end

  patch('/tenant/:id') do 
    @tenant = Tenant.find_by(id: params[:id])
    @tenant.update({
      name: params[:new_name],
      apartment_id: params[:new_address]
    })
      redirect '/tenant/list'
  end

  delete ('/tenant/:id') do
    @tenant = Tenant.find_by(id: params[:id])
    @tenant.delete
    redirect '/tenant/list'
  end

  delete ('/apartment/:id')do
  @apartment = Apartment.find_by(id: params[:id])
  @apartment.destroy
  redirect '/apartment/list'
  end
end
