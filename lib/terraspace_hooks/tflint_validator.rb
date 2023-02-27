module TerraspaceHooks
  class TflintValidator
    def call(runner)
      raise "Tflint not available" unless tflint_available?

      mod = runner.mod
      command = <<-EOF
      YELLOW='\033[0;33m'
      NC='\033[0m'
      cd #{mod.cache_dir} && \
      echo "${YELLOW}[INFO #{mod.name}]${NC} Run tflint for #{mod.name}..." && \
      tflint . --disable-rule=terraform_required_version --module
      EOF

      return if ENV["SKIP_TERRASPACE_HOOKS_TFLINT_VALIDATOR"]

      system(command)
    end

    def tflint_available?
      system("which tflint")
    end
  end
end
