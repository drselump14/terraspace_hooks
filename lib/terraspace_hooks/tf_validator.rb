# frozen_string_literal: true

module TerraspaceHooks
  # validate the terraform code with terraform validate
  class TfValidator
    # rubocop:disable Metrics/MethodLength
    def call(runner)
      return if ENV['SKIP_TERRASPACE_HOOKS_ALL']
      return if ENV['SKIP_TERRASPACE_HOOKS_TF_VALIDATOR']

      raise 'Terraform not available' unless opentofu_available?

      mod = runner.mod
      command = <<-COMMAND
        YELLOW='\033[0;33m'
        NC='\033[0m'
        cd #{mod.cache_dir} && \
        echo "${YELLOW}[INFO #{mod.name}]${NC} Run #{terraform_bin} validate for #{mod.name}..." && \
        #{terraform_bin} validate
      COMMAND

      system(command, exception: true)
    end
    # rubocop:enable Metrics/MethodLength

    def terraform_bin
      ENV['TERRASPACE_HOOKS_BIN'] || 'tofu'
    end

    def opentofu_available?
      system("which #{terraform_bin}")
    end
  end
end
