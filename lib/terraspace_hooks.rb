# frozen_string_literal: true

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

# TerraspaceHooks is the namespace for all Terraspace Hooks
module TerraspaceHooks
end

loader.eager_load
