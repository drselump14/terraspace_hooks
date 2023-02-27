module TerraspaceHooks
  class TfsecValidator
    def call(runner)
      raise "Tfsec not available" unless tfsec_available?

      mod = runner.mod
      command = <<-EOF
      YELLOW='\033[0;33m'
      NC='\033[0m'
      cd #{mod.cache_dir} && \
      echo "${YELLOW}[INFO #{mod.name}]${NC} Run tfsec for #{mod.name}..." && \
      tfsec --concise-output
      EOF

      return if ENV["SKIP_TERRASPACE_HOOKS_TFSEC_VALIDATOR"]

      system(command)
    end

    def tfsec_available?
      system("which tfsec")
    end
  end
end
