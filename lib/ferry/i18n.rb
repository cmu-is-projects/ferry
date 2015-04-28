require 'i18n'

en = {
  starting: 'Starting',
  installing: 'Installing',
  moving: 'Moving',
  completed: 'Completed'
  },
  error: 'Some error'
  }
}

I18n.backend.store_translations(:en, { ferry: en })

if I18n.respond_to?(:enforce_available_locales=)
  I18n.enforce_available_locales = true
end
