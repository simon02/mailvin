module Mailvin
  module Web

    class User
      include DataMapper::Resource
      storage_names[:default] = 'users'

      has n, :projects

      property :id, Serial
      property :login, String
      property :password, String

    end
  end
end
