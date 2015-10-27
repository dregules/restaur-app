require 'rails_helper'

Factory.define :user do
  email 'testing@email.com'
  password ''
  password_confirmation

end