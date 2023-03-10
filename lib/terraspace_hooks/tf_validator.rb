module TerraspaceHooks
  class TfValidator
    def call(runner)
      raise "Terraform not available" unless terraform_available?

      mod = runner.mod
      command = <<-EOF
      YELLOW='\033[0;33m'
      NC='\033[0m'
      cd #{mod.cache_dir} && \
      echo "${YELLOW}[INFO #{mod.name}]${NC} Run terraform validate for #{mod.name}..." && \
      terraform validate
      EOF

      return if ENV["SKIP_TERRASPACE_HOOKS_ALL"]
      return if ENV["SKIP_TERRASPACE_HOOKS_TF_VALIDATOR"]

      system(command)
    end

    def terraform_available?
      system("which terraform")
    end
  end
end
