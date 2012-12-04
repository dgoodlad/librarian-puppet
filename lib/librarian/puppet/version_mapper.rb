module Librarian
  module Puppet
    class VersionMapper
      def puppet_to_gem_versions(args)
        args.map do |arg|
          case arg
          when Array
            arg.map { |v| puppet_to_gem_version(v) }
          when String
            puppet_to_gem_version(arg)
          else
            # Gem::Requirement, do nothing
            arg
          end
        end
      end

      def puppet_to_gem_version(version)
        puppet_semver_to_gem_version(puppet_rc_to_gem_version(version))
      end

      # convert Puppet '1.x' versions to gem supported versions '~>1.0'
      # http://docs.puppetlabs.com/puppet/2.7/reference/modules_publishing.html
      def puppet_semver_to_gem_version(version)
        matched = /(.*)\.x/.match(version)
        matched.nil? ? version : "~>#{matched[1]}.0"
      end

      # convert Puppet '1.0-rc1' style versions to gem supported versions '1.0.rc1'
      def puppet_rc_to_gem_version(version)
        #raise version if version == '0.5.0-rc1'
        matched = /(.*)-([A-Za-z]*[0-9]*)$/.match(version)
        matched.nil? ? version : "#{matched[1]}.#{matched[2]}"
      end

      def gem_to_puppet_version(version)
        matched = /(.*).(rc[0-9]*)$/.match(version.to_s)
        matched.nil? ? version.to_s : "#{matched[1]}-#{matched[2]}"
      end
    end
  end
end
