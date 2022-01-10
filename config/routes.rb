Rails.application.routes.draw do

  namespace :api do
    namespace :robot do
      get '0/orders', to: "orders#command"
    end
  end

end
