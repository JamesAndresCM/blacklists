Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #blacklist
  
  get '/', to: redirect('v1/abuse_ips')
  namespace :v1 do
      scope controller: :blacklistips do
        get 'blacklist' => :index
        get 'blacklist/search_blacklist' => :search_blacklist
        post 'blacklist/new' => :create
        delete 'blacklist/delete/:id' => :destroy
      end
      scope controller: :reports do
          get '/', to: redirect('v1/abuse_ips')
          get 'abuse_ips' => :index
          get 'abuse_ip/:id' => :show
          post 'abuse_ip/new' => :create
          delete 'abuse_ip/delete/:id' => :destroy
          put 'abuse_ip/update/:id' => :update
          get '/abuse_ips/search_ip' => :search_ip
          get "*path" , :to => 'errors#routing', via: [:all]
      end
  end
  match '*unmatched_route', :to => 'v1/errors#routing', via: [:all]
end

