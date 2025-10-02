# frozen_string_literal: true

module TerraspaceHooks
  # generate infracost breakdown
  class InfracostGenerator
    # rubocop:disable Metrics/MethodLength
    def call(runner)
      return if ENV['SKIP_TERRASPACE_HOOKS_ALL']
      return if ENV['SKIP_TERRASPACE_HOOKS_INFRACOST_GENERATOR']

      raise 'Infracost not available' unless infracost_available?
      raise 'Terraform not available' unless opentofu_available?

      mod = runner.mod
      command = <<-COMMAND
        YELLOW='\033[0;33m'
        NC='\033[0m'
        cd #{mod.cache_dir} && \
        echo "${YELLOW}[INFO #{mod.name}]${NC} Convert to plan.json..." && \
        #{terraform_bin} show -json tfplan.binary > plan.json && \

        echo "${YELLOW}[INFO #{mod.name}]${NC} Infracost breakdown for #{mod.name}..." && \
        infracost breakdown --project-name #{mod.name} --path plan.json --format json --out-file infracost_breakdown.json && \
        infracost output --path infracost_breakdown.json --format table --show-skipped
      COMMAND

      system(command, exception: true)
    end
    # rubocop:enable Metrics/MethodLength

    def infracost_available?
      system('which infracost')
    end

    def terraform_bin
      ENV['TERRASPACE_HOOKS_BIN'] || 'tofu'
    end

    def opentofu_available?
      system("which #{terraform_bin}")
    end
  end
end
