# frozen_string_literal: true

module TerraspaceHooks
  # validate the terraform code with tfsec
  class TfsecValidator
    # rubocop:disable Metrics/MethodLength
    def call(runner)
      return if ENV['SKIP_TERRASPACE_HOOKS_ALL']
      return if ENV['SKIP_TERRASPACE_HOOKS_TFSEC_VALIDATOR']

      raise 'Tfsec not available' unless tfsec_available?

      mod = runner.mod
      command = <<-COMMAND
        YELLOW='\033[0;33m'
        NC='\033[0m'
        cd #{mod.cache_dir} && \
        echo "${YELLOW}[INFO #{mod.name}]${NC} Run tfsec for #{mod.name}..." && \
        tfsec --concise-output
      COMMAND

      system(command, exception: true)
    end
    # rubocop:enable Metrics/MethodLength

    def tfsec_available?
      system('which tfsec')
    end
  end
end
