class Ability  < Sivel2Gen::Ability

  def organizacion_responable 
    'Somos Defensores'
  end

  def derechos 
    'Terminos'
  end

  BASICAS_PROPIAS = [
    ['Sip', 'tipoanexo'],
    ['', 'tipoamenaza']
  ]

  def tablasbasicas 
    Sip::Ability::BASICAS_PROPIAS + 
      Sivel2Gen::Ability::BASICAS_PROPIAS - [
        ['Sip', 'oficina'],
        ['Sip', 'sectororgsocial'],
        ['Sivel2Gen', 'actividadoficio'],
        ['Sivel2Gen', 'escolaridad'],
        ['Sivel2Gen', 'estadocivil'],
        ['Sivel2Gen', 'iglesia'],
        ['Sivel2Gen', 'maternidad'],
        ['Sivel2Gen', 'resagresion']
      ] + 
      BASICAS_PROPIAS
  end

  def campos_plantillas
      n = Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.
        clone.merge(Sivel2Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.clone)
      c= n['Victima'][:campos] 
      if c.index(:profesion)
        c[c.index(:profesion)] = :perfilliderazgo
      end
      c+=
      [ :colectivohumano,
        :tamenaza1, 
        :tamenaza2, 
        :tamenaza3, 
        :tamenaza4, 
        :tamenaza5, 
        :tamenaza6, 
        :tamenaza7, 
        :tamenaza8, 
        :tamenaza9, 
        :tamenaza10, 
        :tamenaza11, 
        :tamenaza12, 
        :tamenaza13, 
        :tamenaza14, 
        :tamenaza15, 
        :tamenaza16, 
        :tamenaza17, 
        :tamenaza18, 
        :tamenaza19, 
        :tamenaza20, 
        :tamenaza21]

      n['Victima'][:campos] = c
      return n
    end

  # Establece autorizaciones con CanCanCan
  def initialize(usuario = nil)
    initialize_sivel2_gen(usuario)
    if usuario
      can :read, ::Tipoamenaza
    end
  end

  def initialize_sivel2_gen(usuario = nil)
    Sivel2Gen::Ability.initialize_sivel2_gen(self, usuario)
    if !usuario && Rails.application.config.x.sivel2_consulta_web_publica
      self.can :fotopublica, Sivel2Gen::Caso
    end
  end
end

