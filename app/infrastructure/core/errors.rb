# List of errors
class Core::Errors
  # Validation error
  class ValidationError < StandardError
    attr_accessor :command
    def initialize(command)
      self.command = command
    end
  end

  # Not found error
  class NotFoundError < StandardError
  end

  # Internal error
  class InternalError < StandardError
  end
end
