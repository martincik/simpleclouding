module SC
  module Instance

    class Linode < Base

      class << self

        # @param [Hash] of options
        #   :api_url - API URL (https://api.linode.com/)
        #   :api_key - Your key to access API
        def connect(options={})
          require 'linode'
          @@api = ::Linode.new(options)
        end

        def api
          @@api
        end

        # @return [Array] of Instance objects which is unified API for representing running instances on particular cloud.
        def list
          api.linode.list.map do |node|
            self.new(:instance_id => node.linodeid, :origin => node.to_hash)
          end
        end

        # Creates new server instance on particular cloud
        # @param [Hash] of options
        #   :DatacenterID - numeric (required)
        #     - The DatacenterID from avail.datacenters() where you wish to place this new Linode
        #   :PlanID - numeric (required)
        #     - The desired PlanID available from avail.LinodePlans()
        #   :PaymentTerm - numeric (required)
        #     - Subscription term in months. One of: 1, 12, or 24
        # @exceptions - NOACCESS,CCFAILED,VALIDATION
        # @returns [Bool]
        def create(options = {})
          api.linode.create(options)
        end

      end

      # Destroys server instance on particular cloud
      # @param [Hash] of options
      #   :LinodeID - numeric (required)
      #     - The LinodeID to delete
      #   :skipChecks - boolean (optional)
      #     - Skips the safety checks and will always delete the Linode
      # @exceptions - NOTFOUND,LINODENOTEMPTY
      # @returns [Bool]
      def destroy(options = {})
        self.class.api.linode.delete(options.merge(:LinodeID => instance_id))
      end

      # Reboots server instance
      # @param [Hash] of options
      #   :LinodeID - numeric (required)
      #   :ConfigID - numeric (optional)
      # @exceptions - NOTFOUND
      # @returns [Bool]
      def reboot(options = {})
        self.class.api.linode.reboot(options.merge(:LinodeID => instance_id))
      end

    end
  end
end