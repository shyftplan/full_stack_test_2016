# Contains common methods for commands
class Core::Command
  include ActiveModel::Validations

  # Fills a command with attributes
  # @param [Hash] attributes
  # @raise Core::Errors::ValidationError
  def initialize(attributes = {})
    attributes.each do |name, value|
      if methods.include? "#{name}=".to_sym
        method("#{name}=".to_sym).call(value)
      end
    end
  end

  # Runs command
  def execute
  end

  # Checks that all params are correct
  def check_validation
    raise(Core::Errors::ValidationError, self) if self.invalid?
  end
end
