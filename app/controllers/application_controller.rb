class ApplicationController < Msip::ApplicationController
  protect_from_forgery with: :exception

  # No define control de acceso por ser utilidad
end

