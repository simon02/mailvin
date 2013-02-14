module Mailvin
  module Web

    class Account
      include DataMapper::Resource
      storage_names[:default] = 'accounts'

      property :id, Serial
      property :email, String
    end
  end
end
