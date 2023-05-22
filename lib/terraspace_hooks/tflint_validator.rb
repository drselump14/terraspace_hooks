# frozen_string_literal: true

module TerraspaceHooks
  # validate the terraform code with tflint
  class TflintValidator
    # rubocop:disable Metrics/MethodLength
    def call(runner)
      raise 'Tflint not available' unless tflint_available?

      mod = runner.mod
      command = <<-COMMAND
        YELLOW='\033[0;33m'
        NC='\033[0m'
        cd #{mod.cache_dir} && \
        echo "${YELLOW}[INFO #{mod.name}]${NC} Run tflint for #{mod.name}..." && \
        tflint . --disable-rule=terraform_required_version --module
      COMMAND

      return if ENV['SKIP_TERRASPACE_HOOKS_ALL']
      return if ENV['SKIP_TERRASPACE_HOOKS_TFLINT_VALIDATOR']

      system(command, exception: true)
    end
    # rubocop:enable Metrics/MethodLength

    def tflint_available?
      system('which tflint')
    end
  end
end
