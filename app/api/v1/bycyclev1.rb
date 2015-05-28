module API
  class BycycleV1 < Grape::API
    prefix "v1"
    format :json

    http_basic do |username, password|
      user = User.where(username: username).first
      (user.authorized? password unless user.blank?) or error!("401 Unauthorized", 401)
    end
      #  if !user.blank? and user.authorized? password
      #   user.authorized? password
      # else
      #   error!("401 Unauthorized", 401)
      # end

    # before do
    #   error!("401 Unauthorized", 401) unless authenticated
    # end

    # helpers do
    #   def authenticated
    #     user = User.find_by_username(params[:username])
    #     user.authorized? params[:password] unless user.blank?
    #   end
    # end

    resource :bycycles do
      desc "Get all bycycles"
      get '/' do
        @bycycles = Bycycle.all
        {bycycles: @bycycles, total: @bycycles.count, status: 200}
      end

      desc "Add new bycycle"
      post '/' do
        @bycycle = Bycycle.create!({name: params[:name], series: params[:series]})
         {bycycles: @bycycle, status: 200}
      end

      desc "Show a bycycle"
      get '/:id' do
        @bycycle = Bycycle.find_by_id params[:id]
        {bycycles: @bycycle, status: 200}
      end

      desc "Update a bycycle"
      put '/:id' do
        Bycycle.find_by_id(params[:id]).update({name: params[:name], series: params[:series]})
      end

      desc "Delete a data"
      delete '/:id' do
        Bycycle.find_by_id(params[:id]).destroy
      end
    end
  end
end