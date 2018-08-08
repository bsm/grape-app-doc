module Grape::App::Doc::Config

  # Fail on documentation errors, instead of just warning. Default: false
  mattr_accessor :fail_on_errors
  self.fail_on_errors = false

end
