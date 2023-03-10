module TerraspaceHooks
  class InfracostGenerator
    def call(runner)
      raise "Infracost not available" unless infracost_available?
      raise "Terraform not available" unless terraform_available?

      mod = runner.mod
      command = <<-EOF
      YELLOW='\033[0;33m'
      NC='\033[0m'
      cd #{mod.cache_dir} && \
      echo "${YELLOW}[INFO #{mod.name}]${NC} Convert to plan.json..." && \
      terraform show -json tfplan.binary > plan.json && \

      echo "${YELLOW}[INFO #{mod.name}]${NC} Infracost breakdown for #{mod.name}..." && \
      infracost breakdown --project-name #{mod.name} --path plan.json --format json --out-file infracost_breakdown.json && \
      infracost output --path infracost_breakdown.json --format table --show-skipped
      EOF

      return if ENV["SKIP_TERRASPACE_HOOKS_ALL"]
      return if ENV["SKIP_TERRASPACE_HOOKS_INFRACOST_GENERATOR"]

      system(command)
    end

    def infracost_available?
      system("which infracost")
    end

    def terraform_available?
      system("which terraform")
    end
  end
end
