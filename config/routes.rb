Rails.application.routes.draw do

  rutarel = ENV.fetch('RUTA_RELATIVA', 'somosdefensores/siaddhh')
  scope rutarel do 
    devise_scope :usuario do
      get 'sign_out' => 'devise/sessions#destroy'
      get 'salir' => 'devise/sessions#destroy',
        as: :terminar_sesion

      post 'usuarios/iniciar_sesion', to: 'devise/sessions#create'
      get 'usuarios/iniciar_sesion', to: 'devise/sessions#new',
        as: :iniciar_sesion


      # El siguiente para superar mala generación del action en el formulario
      # cuando se monta en sitio diferente a / y se autentica mal (genera 
      # /puntomontaje/puntomontaje/usuarios/sign_in )
      if (Rails.configuration.relative_url_root != '/') 
        ruta = File.join(Rails.configuration.relative_url_root, 
                         'usuarios/sign_in')
        post ruta, to: 'devise/sessions#create'
        get  ruta, to: 'devise/sessions#new'
      end
    end

    devise_for :usuarios, :skip => [:registrations], module: :devise
    as :usuario do
      get 'usuarios/edit' => 'devise/registrations#edit', 
        :as => 'editar_registro_usuario'    
      put 'usuarios/:id' => 'devise/registrations#update', 
        :as => 'registro_usuario'            
    end
    resources :usuarios, path_names: { new: 'nuevo', edit: 'edita' } 

    namespace :admin do
      ab = ::Ability.new
      ab.tablasbasicas.each do |t|
        if (t[0] == "") 
          c = t[1].pluralize
          resources c.to_sym, 
            path_names: { new: 'nueva', edit: 'edita' }
        end
      end
    end


    get '/casos/mapaosm' => 'sivel2_gen/casos#mapaosm'
#    match '/casos.csv' => 'sivel2_gen/casos#index', via: :get, 
#      defaults: { format: :csv }
    root 'sivel2_gen/hogar#index'

  end

  mount Msip::Engine => rutarel, as: 'msip'
  mount Mr519Gen::Engine => rutarel, as: 'mr519_gen'
  mount Heb412Gen::Engine => rutarel, as: 'heb412_gen'
  mount Sivel2Gen::Engine => rutarel, as: 'sivel2_gen'

end
