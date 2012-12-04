require 'librarian/puppet/environment'
require 'librarian/puppet/version_mapper'

module Librarian
  module Puppet
    extend self
    extend Librarian

  end
end

module Librarian
  class Dependency
    class Requirement
      def initialize(*args)
        args = initialize_normalize_args(args)
        versions = Librarian::Puppet::VersionMapper.new.puppet_to_gem_versions(args)
        self.backing = Gem::Requirement.create(versions)
      end
    end
  end
end

module Librarian
  class Manifest
    class Version
      def initialize(*args)
        args = initialize_normalize_args(args)
        versions = Librarian::Puppet::VersionMapper.new.puppet_to_gem_versions(args)
        self.backing = Gem::Version.new(*versions)
      end

      def to_puppet_version
        Librarian::Puppet::VersionMapper.new.gem_to_puppet_version(backing)
      end
    end
  end
end
