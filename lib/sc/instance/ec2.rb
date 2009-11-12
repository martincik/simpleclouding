module SC
  module Instance

    class EC2 < Base

      class << self

        # @param [Hash] of options
        #   :access_key_id - Access Key ID
        #   :secret_access_key - Secret Access Key
        def connect(options={})
          require 'right_aws'
          #RightAws::RightAWSParser.xml_lib = 'libxml'

          @@api ||= ::RightAws::Ec2.new(options[:access_key_id], options[:secret_access_key])
        end

        def api
          @@api
        end

        # @return [Array] of Instance objects which is unified API for representing running instances on particular cloud.
        def list
          api.describe_instances.map do |node|
            self.new(:instance_id => node[:aws_instance_id], :origin => node.to_hash)
          end
        end

        # Creates new server instance on particular cloud
        # @param [Hash] of options
        #   - viz. RightAws gem
        # @exceptions -
        # @returns [Hash] - of attributes of new instance
        def create(options = {})
          ami_id = options.delete(:ami_id)
          api.launch_instances(ami_id, options)
        end

      end

      # Destroys server instance on particular cloud
      # @param [Hash] of options
      #   - for now nothing is passed through
      # @exceptions -
      # @returns [Bool]
      def destroy(options = {})
        self.class.api.terminate_instances(instance_id)
      end

      # Reboots server instance
      # @param [Hash] of options
      #   - for now nothing is passed through
      # @exceptions -
      # @returns [Bool]
      def reboot(options = {})
        self.class.api.reboot_instances(instance_id)
      end

    end
  end
end