# frozen_string_literal: true

module TerraspaceHooks
  # validate the terraform code with terraform fmt
  class TfFmtValidator
    # rubocop:disable Metrics/MethodLength
    def call(runner)
      raise 'Terraform not available' unless terraform_available?

      mod = runner.mod
      command = <<-COMMAND
        YELLOW='\033[0;33m'
        NC='\033[0m'
        cd #{mod.cache_dir} && \
        echo "${YELLOW}[INFO #{mod.name}]${NC} Run terraform fmt for #{mod.name}..." && \
        terraform fmt
      COMMAND

      return if ENV['SKIP_TERRASPACE_HOOKS_ALL']
      return if ENV['SKIP_TERRASPACE_HOOKS_TF_FMT_VALIDATOR']

      system(command, exception: true)
    end
    # rubocop:enable Metrics/MethodLength

    def terraform_available?
      system('which terraform')
    end
  end
end
